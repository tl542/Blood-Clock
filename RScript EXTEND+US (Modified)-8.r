# Load in the RData
data <- load("/mnt/data1/EXTEND/Methylation/QC/EXTEND_batch1_2_merged/EXTEND_batches_1_2_normalised_together.rdat")


# Transpose + Cast the DNA methylation data into DF
# Transpose the pheno data into DF
DNAm <- t(betas)
DNAm_df <- as.data.frame(DNAm)
pheno_df <- as.data.frame(pheno)


# Combine DNAm df with phenotypic Sex variable
new_df <- cbind(DNAm_df, pheno_df[,"Age"])
colnames(new_df)[809499] <- "Age"



# Restrict the original dataset down to samples aged less than 70
new_df1 <- new_df[new_df$Age >= 40 & new_df$Age <= 70,]






load("/mnt/data1/EPICQC/UnderstandingSociety/US_Betas_Pheno.rda")
DNAm_us <- t(dat)
DNAm_df_us <- as.data.frame(DNAm_us)
pheno_df_us <- as.data.frame(pheno)
new_df_us <- cbind(DNAm_df_us, pheno_df_us[,"confage"])
colnames(new_df_us)[857131] <- "Age"
new_df_us$Age <- as.integer(new_df_us$Age)
new_df2_us <- new_df_us[new_df_us$Age >= 40 & new_df_us$Age <= 70,]




new_df <- intersect(colnames(new_df1), colnames(new_df2_us))
new_df1 <- new_df1[,new_df]
new_df2_us <- new_df2_us[,new_df]
df_all <- rbind(new_df1, new_df2_us)
dim(df_all)

# Train/Test split on the restricted EXTEND+US data (1762 samples)
# Training size: 1233 and Test size: 529
set.seed(96)
n <- nrow(df_all)
trainIndex <- sample(1:n, size=round(0.7*n), replace=FALSE)
train <- df_all[trainIndex,]
test <- df_all[-trainIndex,]
dim(train)
dim(test)



# Estimate lambda parameter on training data using 10 folds CV.
library(glmnet)
alpha <- 0.5
cv_fit_train <- cv.glmnet(as.matrix(train[,-ncol(train)]), train$Age, nfolds=10, alpha=alpha, family="gaussian")
best_lambda <- cv_fit_train$lambda.min



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
while (corr >= 0.6){
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
    l_probes_coef <- c(l_probes_coef, list(coefs_nz_df[,"coefs_nz"]))
    ix <- which(colnames(train) %in% rownames(coefs_nz_df)[2:nrow(coefs_nz_df)])
    train <- train[,-ix]
    test <- test[,-ix]
    if (corr < 0.6){
        stop = TRUE
        break
    }
    if (stop){break}
    
}

