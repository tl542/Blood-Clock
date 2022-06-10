
#!/usr/bin/env Rscript
source("RScript_Theo_Explanatory.r")




# Use 3-fold cross validation to estimate the "best" lambda parameter
# i.e. that gives lowest mean MSE
library(glmnet) 
train1 <- train1[,-809499]
test1 <- test1[,-809499]
alpha <- 0.5
cv_fit_train <- cv.glmnet(as.matrix(train1[,-ncol(train1)]), train1$Age, nfolds=3, alpha=alpha, family="gaussian")
best_lambda <- cv_fit_train$lambda.min


# Extract all the necessary probes for probes clock
library(Metrics)
l_probes <- list()
l_probes_coef <- list()
l_rmse <- list()
l_cor <- list()
corr <-  1
RMSE <- 0
stop <- FALSE
n <- 0
while (corr > 0.6){
    n <- n + 1 
    fit_train <- glmnet(as.matrix(train1[,-ncol(train1)]), train1$Age, alpha=0.5, nlambda=10)
    pred_test <- predict(fit_train, as.matrix(test1[,-ncol(test1)]),s=best_lambda)
    #RMSE <- rmse(test1$Age, pred_test)
    corr <- cor(test1$Age, pred_test)
    #l_rmse <- c(l_rmse,RMSE)
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
    ix <- which(colnames(train1) %in% rownames(coefs_nz_df)[2:nrow(coefs_nz_df)])
    train1 <- train1[,-ix]
    test1 <- test1[,-ix]
    if (corr < 0.6){
        stop = TRUE
        break
    }
    if (stop){break}
    
}

l_cor_unlist <- unlist(l_cor)
n_models <- unlist(list(1:n))
plot(n_models, l_cor_unlist, pch=19)
text(n_models, l_cor_unlist, paste("c =", l_cor_unlist), pos=1)
dev.copy(pdf, "cor_plot.pdf")
dev.off()

len_probes <- list()
for (i in l_probes){
    len_probes <- c(len_probes, length(l_probes[[i]]))
}
len_probes_unlist <- unlist(len_probes)
plot(n_models, len_probes_unlist, pch=19)
text(n_models, len_probes_unlist, paste("n =", len_probes_unlist), pos=1)
dev.copy(pdf, "probes_plot.pdf")
dev.off()


