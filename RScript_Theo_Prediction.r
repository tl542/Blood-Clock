
#!/usr/bin/env Rscript
source("RScript_Theo_Explanatory.r")




# Use 3-fold cross validation to estimate the "best" lambda parameter
# i.e. that gives lowest mean MSE
library(glmnet)
train1 <- train1[,-809499]
test1 <- test1[,-809499]
alpha <- 0.5
cv_fit_train <- cv.glmnet(as.matrix(train1), train1$Age, nfolds=3, alpha=alpha, family="gaussian")
best_lambda <- cv_fit_train$lambda.min


# Extract all the necessary probes for probes clock
#l_probes <- list()
#l_rmse <- list()
#l_cor <- list()
#corr = 1
#RMSE = 0
#stop = FALSE
#while (RMSE < 3.6 & corr > 0.6){
    #fit_train <- glmnet(as.matrix(train1), train1$Age, alpha=0.5, nlambda=10)
    #pred_test <- predict(fit_train, as.matrix(test1),s=best_lambda)
    #RMSE <- rmse(test1$Age, pred_test)
    #corr <- cor(test1$Age, pred_test)
    #if (RMSE > 3.6 | corr < 0.6){
        #stop = TRUE
        #break
     }
    #if (stop){break}
    #coefs <- coef(fit_train, s=best_lambda)
    #coefs_nz <- coefs[which(coefs != 0),]
    #coefs_nz_df <- as.data.frame(coefs_nz)
    #l_probes <- c(l_probes, list(rownames(coefs_nz_df)[2:(nrow(coefs_nz_df)-1)]))
    #l_rmse <- as.data.frame(c(l_rmse,RMSE)) 
    #l_corr <- as.data.frame(c(l_cor, corr))
    #ix <- which(colnames(train1) %in% rownames(coefs_nz_df)[2:(nrow(coefs_nz_df)-1)])
    #train1 <- train1[,-ix]
    #test1 <- test1[,-ix]
#}

