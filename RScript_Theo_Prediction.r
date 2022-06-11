
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


# Plot correlation change across the models making through the loop (n=105)
l_cor_unlist <- unlist(l_cor)
n_models <- unlist(list(1:n))
plot(n_models, l_cor_unlist, pch=19, xlab="Model (n=105)", ylab="Correlation")
#text(n_models, l_cor_unlist, paste("", round(l_cor_unlist,2)), pos=1)
dev.copy(pdf, "cor_per_model(plot).pdf")
dev.off()

# Plot number of weighted probes across the models making through the loop (n=105)
len_probes <- list()
for (i in 1:length(l_probes)){
    len_probes <- c(len_probes, length(l_probes[[i]]))
}
len_probes_unlist <- unlist(len_probes)
plot(n_models, len_probes_unlist, pch=19, xlab="Model (n=105)", ylab="Number of Probes")
#text(n_models, len_probes_unlist, paste("", len_probes_unlist), pos=1)
dev.copy(pdf, "nb_probes_per_model(plot).pdf")
dev.off()


# Save correlation + number of probes for each of the 105 models (with cor >= 0.6 on test data)
l_cor_df <- as.data.frame(l_cor_unlist)
colnames(l_cor_df) <- "Correlation"
len_probes_df <- as.data.frame(len_probes_unlist)
colnames(len_probes_df) <- "nProbes"
l_cor_nprobes_df <- cbind(len_probes_df, l_cor_df)
for (i in 1:nrow(l_cor_nprobes_df)){
    rownames(l_cor_nprobes_df)[i] <- paste("Model", i)
}
write.table(l_cor_nprobes_df, "nprobes+cor_per_model.txt", row.names=T, col.names=T, quote=F)




#Save all the probes with their respective beta coefficient
l_probes_coef_unlist <- unlist(l_probes_coef)
l_probes_coef_unlist_df <- as.data.frame(l_probes_coef_unlist)
colnames(l_probes_coef_unlist_df) <- "Coef"
l_probes_unlist <- unlist(l_probes)
l_probes_unlist_df <- as.data.frame(l_probes_unlist)
colnames(l_probes_unlist_df) <- "Probes"

df_new <- [l_probes_coef_unlist_df$coef <= 30,]
df_new <- as.data.frame(df_new)
df_final <- cbind(l_probes_unlist_df, df_new)
write.table(df_final, "probes_coef.txt", row.names=T, col.names=T, quote=F)




