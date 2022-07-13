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



# Restrict the original dataset down to samples aged less than 70
new_df1 <- new_df[new_df$Age >= 40 & new_df$Age <= 70,]






load("/mnt/data1/EPICQC/UnderstandingSociety/US_Betas_Pheno.rda")
DNAm_us <- t(dat)
DNAm_df_us <- as.data.frame(DNAm_us)
pheno_df_us <- as.data.frame(pheno)
new_df_us <- cbind(DNAm_df_us, pheno_df_us[,c("nsex","confage")])
colnames(new_df_us)[857131] <- "Sex"
colnames(new_df_us)[857132] <- "Age"
new_df2_us <- new_df_us[new_df_us$Age >= 40 & new_df_us$Age <= 70,]
new_df2_us$Age <- as.integer(new_df2_us$Age)



new_df <- intersect(colnames(new_df1), colnames(new_df2_us))
new_df1 <- new_df1[,new_df]
new_df2_us <- new_df2_us[,new_df]
df_all <- rbind(new_df1, new_df2_us)
dim(df_all)

# Train/Test split on the restricted EXTEND+US data (1762 samples)
# Training size: 1233 and Test size: 529
set.seed(32)
n <- nrow(df_all)
trainIndex <- sample(1:n, size=round(0.7*n), replace=FALSE)
train <- df_all[trainIndex,-803377]
test <- df_all[-trainIndex,-803377]
dim(train)
dim(test)



# Estimate lambda parameter on training data using 10 folds CV.
library(glmnet)
alpha <- 0.5
#cv_fit_train <- cv.glmnet(as.matrix(train[,-ncol(train)]), train$Age, nfolds=10, alpha=alpha, family="gaussian")
#best_lambda <- cv_fit_train$lambda.min
best_lambda <- 0.1309195
print(best_lambda)


# While loop on the 5 splits.
library(Metrics)
l_probes <- list()
l_probes_coef <- list()
l_rmse <- list()
l_cor <- list()
corr <-  1
RMSE <- 0
stop <- FALSE
n <- 0
while (corr >= 0.4){
    n <- n + 1 
    fit_train <- glmnet(as.matrix(train[,-ncol(train)]), train$Age, alpha=0.5, nlambda=10)
    pred_test <- predict(fit_train, as.matrix(test[,-ncol(test)]),s=best_lambda)
    RMSE <- rmse(test$Age, pred_test)
    corr <- cor(test$Age, pred_test)
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
    l_probes_coef <- c(l_probes_coef, list(coefs_nz_df[-1,"coefs_nz"]))
    ix <- which(colnames(train) %in% rownames(coefs_nz_df)[2:nrow(coefs_nz_df)])
    train <- train[,-ix]
    test <- test[,-ix]
    if (corr < 0.4){
        stop = TRUE
        break
    }
    if (stop){break}
    
}



# Save correlation + number of probes + cumulative number of probes for each of the models (with cor >= 0.6 on test data)
l_cor_unlist <- unlist(l_cor)
l_cor_df <- as.data.frame(l_cor_unlist)
colnames(l_cor_df) <- "Correlation"
len_probes <- list()
for (i in 1:length(l_probes)){
    len_probes <- c(len_probes, length(l_probes[[i]]))
}
len_probes_unlist <- unlist(len_probes)
len_probes_df <- as.data.frame(len_probes_unlist)
colnames(len_probes_df) <- "nProbes"
l_cor_nprobes_df <- cbind(l_cor_df,len_probes_df)
l_cor_nprobes_df$Cum_nProbes <- cumsum(l_cor_nprobes_df$nProbes)
for (i in 1:nrow(l_cor_nprobes_df)){
    rownames(l_cor_nprobes_df)[i] <- paste("Model", i)
}
write.table(l_cor_nprobes_df, "table (Split 2).txt", row.names=T, col.names=T, quote=F)



# Plot (+Save) correlation against number of weighted probes
pdf("Plot (Split 1).pdf")
plot(l_cor_nprobes_df$Cum_nProbes, l_cor_nprobes_df$Correlation, pch=19, xlab="Cumulative number of Probes", ylab="Correlation", main="Correlation vs (Cumulative) number of probes")
dev.off()


#Save RMSE for each of the models (with cor >= 0.4 on test data)
l_rmse_unlist <- unlist(l_rmse)
l_rmse_df <- as.data.frame(l_rmse_unlist)
colnames(l_rmse_df) <- "RMSE"
for (i in 1:nrow(l_rmse_df)){
    rownames(l_rmse_df)[i] <- paste("Model", i)
}
write.table(l_rmse_df, "RMSE (Split 2).txt", row.names=T, col.names=T, quote=F)


#Save all the probes selected by each model
probes_model <- data.frame()
for (i in 1:length(l_probes)){
    l_probes_i <- unlist(l_probes[[i]])
    l_probes_i_df <- as.data.frame(l_probes_i)
    colnames(l_probes_i_df) <- "Selected Probes"
    l_probes_i_df["Probes_Model"] <- paste("Model", i)
    probes_model <- rbind(probes_model, l_probes_i_df)
}
write.table(probes_model, "probes_model (Split 2).txt", row.names=T, col.names=T, quote=F)


#Save all the probes with their respective beta coefficient
df_final <- data.frame()
for (i in 1:length(l_probes_coef)){
    l_probes_coef_unlist <- unlist(l_probes_coef[[i]])
    l_probes_coef_unlist_df <- as.data.frame(l_probes_coef_unlist)
    colnames(l_probes_coef_unlist_df) <- "Coef"
    l_probes_unlist <- unlist(l_probes[[i]])
    l_probes_unlist_df <- as.data.frame(l_probes_unlist)
    colnames(l_probes_unlist_df) <- "Selected Probes"
    l_probes_unlist_df["Probes_Model"] <- paste("Model", i)
    probes_coef_model <- cbind(l_probes_unlist_df, l_probes_coef_unlist_df)
    df_final <- rbind(df_final, probes_coef_model)

}
df_final <- df_final[c("Selected Probes", "Coef", "Probes_Model")]
write.table(df_final, "probes_coef (Split 2).txt", row.names=T, col.names=T, quote=F)


