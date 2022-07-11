#!/usr/bin/env Rscript

source("/mnt/data1/EXTEND/Methylation/QC/Theo/script_forGA.r")

epicManifest<-read.csv("/mnt/data1/EPIC_reference/MethylationEPIC_v-1-0_B2.csv", skip = 7)

df_final <- data.frame()
for (i in seq(1,22)){
probes_i <- epicManifest[epicManifest$Chromosome_36 == i, c("Name","Chromosome_36")]
df_final <- rbind(df_final, probes_i)
}

library(Metrics)
l_rmse <- list()
l_cor <- list()
n_iter <- 0
for (i in 1:22){
  n_iter <- n_iter + 1
  probes_i <- df_final[df_final$Chromosome_36 == i,]
  rownames(probes_i) <- probes_i$Name
  ix <- which(colnames(df_all)[-803377] %in% rownames(probes_i))
  new_df <- cbind(df_all[,ix], df_all$Age)
  names(new_df)[names(new_df) == "df_all$Age"] <- "Age"
  set.seed(i)
  n <- nrow(new_df)
  trainIndex <- sample(1:n, size=round(0.7*n), replace=FALSE)
  train <- new_df[trainIndex,]
  test <- new_df[-trainIndex,]
  library(glmnet)
  alpha <- 0.5
  cv_fit_train <- cv.glmnet(as.matrix(train[,-ncol(train)]), train$Age, nfolds=10, alpha=alpha, family="gaussian")
  best_lambda <- cv_fit_train$lambda.min
  fit_train <- glmnet(as.matrix(train[,-ncol(train)]), train$Age, alpha=0.5, nlambda=10)
  pred_test <- predict(fit_train, as.matrix(test[,-ncol(test)]), s=best_lambda)
  RMSE <- rmse(test$Age, pred_test)
  corr <- cor(test$Age, pred_test)
  l_rmse <- c(l_rmse,RMSE)
  l_cor <- c(l_cor, corr)
 
}

  
  
