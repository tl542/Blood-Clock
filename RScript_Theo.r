#!/usr/bin/env Rscript
args = commandArgs(trailingOnly = TRUE)


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


# Train/Test split on the original DNAm df (1234 samples)
# Training Size: 864 and Test Size: 370
set.seed(123)
n <- nrow(new_df)
trainIndex <- sample(1:n, size=round(0.7*n), replace=FALSE)
train <- new_df[trainIndex,]
test <- new_df[-trainIndex,]
dim(train)
dim(test)

# Age distribution on original set + on training data from original set: Table
table(new_df$Age)
table(train$Age)


# Two-sample t-test on Training data from original set
t.test(train$Age ~ train$Sex, mu=0, alt="two.sided", paired=FALSE, var.eq=FALSE)

# Two-sample t-test on original set
t.test(new_df$Age ~ new_df$Sex, mu=0, alt="two.sided", paired=FALSE, var.eq=FALSE)



# Restrict the original dataset down to samples aged less than 70 (1009)
new_df1 <- new_df[new_df$Age >= 40 & new_df$Age <= 70,]
# Train/Test split on the restricted data
# Training size: 864 and Test Size: 145
set.seed(123)
n <- nrow(new_df1)
trainIndex <- sample(1:n, size=round(0.7*n), replace=FALSE)
train1 <- new_df1[trainIndex,]
test1 <- new_df1[-trainIndex,]
dim(train1)
dim(test1)

# Age distribution on original set + training data from restricted set: Table
table(new_df1$Age)
table(train1$Age)

# Two-sample t-test on Training data from restricted set
t.test(train1$Age ~ train1$Sex, mu=0, alt="two.sided", paired=FALSE, var.eq=FALSE)

# Two-sample t-test on restricted set
t.test(new_df1$Age ~ new_df1$Sex, mu=0, alt="two.sided", paired=FALSE, var.eq=FALSE)


# Get rid of men older than 65 ? To reduce further the Sex/Age bias
table(new_df1$Sex == "Male", new_df1$Age)
table(train1$Sex == "Male", train1$Age)
 


# Restrict the original dataset down to samples aged less than 65 (868)
new_df2 <- new_df[new_df$Age >= 40 & new_df$Age <= 65,]
# Train/Test split on the restricted data
# Training size: 608 and Test Size: 260
set.seed(123)
n <- nrow(new_df2)
trainIndex <- sample(1:n, size=round(0.7*n), replace=FALSE)
train2 <- new_df2[trainIndex,]
test2 <- new_df2[-trainIndex,]
dim(train2)
dim(test2)


# Two-sample t-test on Training data from restricted set
t.test(train2$Age ~ train2$Sex, mu=0, alt="two.sided", paired=FALSE, var.eq=FALSE)

# Two-sample t-test on restricted set
t.test(new_df2$Age ~ new_df2$Sex, mu=0, alt="two.sided", paired=FALSE, var.eq=FALSE)


# Use 3-fold cross validation to estimate the "best" lambda parameter
# i.e. that gives lowest mean MSE
train1 <- train1[,-809499]
test1 <- test1[,-809499]
alpha <- 0.5
cv_fit_train <- cv.glmnet(as.matrix(train1), train1$Age, nfolds=3, alpha=alpha, family="gaussian")  
best_lambda <- cv_fit_train$lambda.min


# Extract all the necessary probes for probes clock
library(glmnet)
l <- list()
l_rmse <- list()
l_cor <- list()
corr = 0
rmse = 0
while (RMSE < 3.6 & cor > 0.6){
    fit_train <- glmnet(as.matrix(train1), train1$Age, alpha=0.5, nlambda=10)
    pred_test <- predict(fit_train, as.matrix(test1),s=best_lambda)
    coefs <- coef(fit_train, s=best_lambda)
    coefs_nz <- coefs[which(coefs != 0),]
    coefs_nz_df <- as.data.frame(coefs_nz)
    l <- as.data.frame(cbind(l, list(row_names(coefs_nz_df)[2:(nrow(coefs_nz_df)-1)])))
    RMSE <- rmse(test$Age, pred_test)
    corr <- cor(test$Age, pred_test)
    l_rmse <- as.data.frame(rbind(l_rmse,RMSE))
    l_corr <- as.data.frame(rbind(l_cor, corr))
    ix <- which(colnames(train1) %in% rownames(coefs_nz_df)[2:(nrow(coefs_nz_df)-1)])
    train1 <- train1[,-ix]
     
} 


