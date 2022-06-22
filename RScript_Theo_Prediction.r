
#!/usr/bin/env Rscript
source("RScript_Theo_Explanatory.r")




# Use 10-folds cross validation to estimate the "best" lambda parameter
# i.e. that gives lowest mean MSE
library(glmnet) 
train1 <- train1[,-809499]
test1 <- test1[,-809499]
alpha <- 0.5
cv_fit_train <- cv.glmnet(as.matrix(train1[,-ncol(train1)]), train1$Age, nfolds=10, alpha=alpha, family="gaussian")
best_lambda <- cv_fit_train$lambda.min


# Store the correlation between DNAm age and actual on test data
# While cor >= 6 
# Save the selected probes with their weights
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
    fit_train <- glmnet(as.matrix(train1[,-ncol(train1)]), train1$Age, alpha=0.5, nlambda=10)
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
    ix <- which(colnames(train1) %in% rownames(coefs_nz_df)[2:nrow(coefs_nz_df)])
    train1 <- train1[,-ix]
    test1 <- test1[,-ix]
    if (corr < 0.6){
        stop = TRUE
        break
    }
    if (stop){break}
    
}

#Save RMSE for each of the models (with cor >= 0.6 on test data)
l_rmse_unlist <- unlist(l_rmse)
l_rmse_df <- as.data.frame(l_rmse)
colnames(l_rmse_df) <- "RMSE"
for (i in 1:nrow(l_rmse_df)){
    rownames(l_rmse_df)[i] <- paste("Model", i)
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
write.table(l_cor_nprobes_df, "nprobes+cum_nprobes+cor_per_model.txt", row.names=T, col.names=T, quote=F)


n_models <- unlist(list(1:n))

# Plot (+Save) change in correlation across the models making through the loop
pdf("cor_per_model(plot).pdf")
plot(n_models, l_cor_nprobes_df$Correlation, pch=19, xlab=paste("Model=",n), ylab="Correlation")
#text(n_models, l_cor_unlist, paste("", round(l_cor_unlist,2)), pos=1)
dev.off()

# Plot (+Save) change in number of weighted probes across the models making through the loop
pdf("cumnb_probes_models(plot).pdf")
plot(n_models, l_cor_nprobes_df$Cum_nProbes, pch=19, xlab=paste("Model=",n), ylab="Cumulative number of Probes")
#text(n_models, len_probes_unlist, paste("", len_probes_unlist), pos=1)
dev.off()


# Plot (+Save) correlation against number of weighted probes
pdf("cor_cumnb_probes_models(plot).pdf")
plot(l_cor_nprobes_df$Cum_nProbes, l_cor_nprobes_df$Correlation, pch=19, xlab="Cumulative number of Probes", ylab="Correlation")
dev.off()




#Save all the probes with their respective beta coefficient
for (i in 1:length(l_probes_coef)){
    l_probes_coef[[i]] <- l_probes_coef[[i]][-1]
}

l_probes_coef_unlist <- unlist(l_probes_coef)
l_probes_coef_unlist_df <- as.data.frame(l_probes_coef_unlist)
colnames(l_probes_coef_unlist_df) <- "Coef"
l_probes_unlist <- unlist(l_probes)
l_probes_unlist_df <- as.data.frame(l_probes_unlist)
colnames(l_probes_unlist_df) <- "Probes"

df_final <- cbind(l_probes_unlist_df, l_probes_coef_unlist_df)
write.table(df_final, "probes_coef.txt", row.names=T, col.names=T, quote=F)




