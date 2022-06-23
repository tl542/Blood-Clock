#!/usr/bin/env Rscript


# Load in the RData
data <- load("/mnt/data1/EXTEND/Methylation/QC/EXTEND_batch1_2_merged/EXTEND_batches_1_2_normalised_together.rdat")


# Transpose + Cast the DNA methylation data into DF
# Transpose the pheno data into DF
DNAm <- t(betas)
DNAm_df <- as.data.frame(DNAm)
pheno_df <- as.data.frame(pheno)


# Combine DNAm df with phenotypic Sex variable
new_df <- cbind(DNAm_df, pheno_df[,c("Sex","Age")])
colnames(new_df)[809499] <- "Sex"
colnames(new_df)[809500] <- "Age"


# Restrict the original dataset down to samples aged less than 70 (1009)
new_df1 <- new_df[new_df$Age >= 40 & new_df$Age <= 70,]


set.seed(123)
n <- nrow(new_df1)
trainIndex <- sample(1:n, size=round(0.7*n), replace=FALSE)
train1 <- new_df1[trainIndex,]
test1 <- new_df1[-trainIndex,]
dim(train1)
dim(test1)



train1 <- train1[,-809499]
test1 <- test1[,-809499]


setwd("/mnt/data1/EPICQC/UnderstandingSociety")
load("US_Betas_Pheno.rda")

DNAm_us <- t(dat)
DNAm_df_us <- as.data.frame(DNAm_us)
pheno_df_us <- as.data.frame(pheno)

new_df_us <- cbind(DNAm_df_us, pheno_df_us[,c("nsex","confage")])
colnames(new_df_us)[857131] <- "Sex"
colnames(new_df_us)[857132] <- "Age"


new_df2_us <- new_df_us[new_df_us$Age >= 40 & new_df_us$Age <= 70,]

set.seed(123)
n <- nrow(new_df2_us)
trainIndex <- sample(1:n, size=round(0.7*n), replace=FALSE)
train2 <- new_df2_us[trainIndex,]
tets2 <- new_df2_us[-trainIndex,]
dim(train2)
dim(test2)


train2 <- train2[,-857131]
test2 <- test2[,-857131]


new_train <- intersect(colnames(train1), colnames(train2))
train1 <-train1[,new_train]
train2 <-train2[,new_train]
train_all <- rbind(train1,train2)
train_all$Age <- as.integer(train_all$Age)
dim(train_all)
ix <- which(colnames(test1) %in% colnames(train_all))
test1 <- test1[,ix]


library(glmnet)
alpha <- 0.5
cv_fit_train <- cv.glmnet(as.matrix(train_all[,-ncol(train_all)]), train_all$Age, nfolds=10, alpha=alpha, family="gaussian")
best_lambda <- cv_fit_train$lambda.min


library(Metrics)
l_probes <- list()
l_probes_coef <- list()
l_rmse <- list()
l_cor <- list()
corr <-  1
RMSE <- 0
stop <- FALSE
n <- 0
while (corr >= 0.6){
    n <- n + 1 
    fit_train <- glmnet(as.matrix(train_all[,-ncol(train_all)]), train_all$Age, alpha=0.5, nlambda=10)
    pred_test <- predict(fit_train, as.matrix(test1[,-ncol(test1)]),s=best_lambda)
    RMSE <- rmse(test1$Age, pred_test)
    corr <- cor(test1$Age, pred_test)
    l_rmse <- c(l_rmse,RMSE)
    l_cor <- c(l_cor, corr)
    #plot(test1$Age, pred_test, xlab="Chronological Age (years)", ylab="Predicted Age (years)", main = paste("Model", n))
    #text(45,75, paste("RMSE =", round(RMSE,2)))
    #text(45,70, paste("r =", round(corr,2)))
    #dev.copy(pdf, "plot-cb.pdf")    
    #dev.off()     
    coefs <- coef(fit_train, s=best_lambda)
    coefs_nz <- coefs[which(coefs != 0),]
    coefs_nz_df <- as.data.frame(coefs_nz)
    l_probes <- c(l_probes, list(rownames(coefs_nz_df)[2:nrow(coefs_nz_df)]))
    l_probes_coef <- c(l_probes_coef, list(coefs_nz_df[,"coefs_nz"]))
    ix <- which(colnames(train_all) %in% rownames(coefs_nz_df)[2:nrow(coefs_nz_df)])
    train_all <- train_all[,-ix]
    test1 <- test1[,-ix]
    if (corr < 0.6){
        stop = TRUE
        break
    }
    if (stop){break}
    
}



# Save correlation + number of probes + cumulative number of probes for each of the models (with cor >= 0.6 on test data)
l_cor_unlist <- unlist(l_cor)
len_probes <- list()
for (i in 1:length(l_probes)){
    len_probes <- c(len_probes, length(l_probes[[i]]))
}
len_probes_unlist <- unlist(len_probes)
l_cor_df <- as.data.frame(l_cor_unlist)
colnames(l_cor_df) <- "Correlation"
len_probes_df <- as.data.frame(len_probes_unlist)
colnames(len_probes_df) <- "nProbes"
l_cor_nprobes_df <- cbind(l_cor_df,len_probes_df)
l_cor_nprobes_df$Cum_nProbes <- cumsum(l_cor_nprobes_df$nProbes)
for (i in 1:nrow(l_cor_nprobes_df)){
    rownames(l_cor_nprobes_df)[i] <- paste("Model", i)
}
write.table(l_cor_nprobes_df, "nprobes+cum_nprobes+cor_per_model - 1.txt", row.names=T, col.names=T, quote=F)



# Plot (+Save) correlation against number of weighted probes
pdf("cor_cumnb_probes_models(plot) - 1.pdf")
plot(l_cor_nprobes_df$Cum_nProbes, l_cor_nprobes_df$Correlation, pch=19, xlab="Cumulative number of Probes", ylab="Correlation")
dev.off()


#Save RMSE for each of the models (with cor >= 0.6 on test data)
l_rmse_unlist <- unlist(l_rmse)
l_rmse_df <- as.data.frame(l_rmse)
colnames(l_rmse_df) <- "RMSE"
for (i in 1:nrow(l_rmse_df)){
    rownames(l_rmse_df)[i] <- paste("Model", i)
}

