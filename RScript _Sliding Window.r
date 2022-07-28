source("/mnt/data1/EXTEND/Methylation/QC/Theo/script_forGA.r")

epicManifest<-read.csv("/mnt/data1/EPIC_reference/MethylationEPIC_v-1-0_B2.csv", skip = 7)




df_final <- data.frame()
for (i in seq(1,22)){
probes_i <- epicManifest[epicManifest$CHR == i, c("Name","CHR","MAPINFO")]
df_final <- rbind(df_final, probes_i)
}

set.seed(65)
n <- nrow(df_all)
trainIndex <- sample(1:n, size=round(0.7*n), replace=FALSE)
train <- df_all[trainIndex,]
test <- df_all[-trainIndex,]
best_lambda <- 0.1313309

probes_3 <- df_final[df_final$CHR == 3,]
bv3 <- probes_3[order(probes_3$MAPINFO),]
rownames(bv3) <- NULL

#df <- data.frame()
#v <- bv3$MAPINFO  
#for (i in v[1]:v[length(l)]){
  #for (j in seq(i:i+500000)){
    #if (j %in% v){
      #df <- rbind(df,bv3)
    #}
  #}
#}

n_iter <- 0
l_p <- list()
library(glmnet)
library(Metrics)
l_probes <- list()
l_probes_coef <- list()
l_rmse <- list()
l_cor <- list()
df <- data.frame()
v <- bv3$MAPINFO  
for (i in v){
  l_p <- list()
  for (j in seq(i:i+500000)){
    if (j %in% v){
      l_p <- c(l_p,j)
    }
  }
  bv <- bv3[bv3$MAPINFO %in% l_p,]
  n_iter <- n_iter + 1
  l_p <<- NULL
  rownames(bv) <- bv$Name
  ix <- which(colnames(df_all)[-803377] %in% rownames(bv))
  new_train <- cbind(train[,ix], train$Age)
  new_test <- cbind(test[,ix], test$Age)
  names(new_train)[names(new_train) == "train$Age"] <- "Age"
  names(new_test)[names(new_test) == "test$Age"] <- "Age"
  fit_train <- glmnet(as.matrix(new_train[,-ncol(new_train)]), new_train$Age, alpha=0.5, nlambda=10)
  pred_test <- predict(fit_train, as.matrix(new_test[,-ncol(new_test)]), s=best_lambda)
  RMSE <- rmse(new_test$Age, pred_test)
  corr <- cor(new_test$Age, pred_test)
  l_rmse <- c(l_rmse,RMSE)
  l_cor <- c(l_cor, corr)
  coefs <- coef(fit_train, s=best_lambda)
  coefs_nz <- coefs[which(coefs != 0),]
  coefs_nz_df <- as.data.frame(coefs_nz)
  l_probes <- c(l_probes, list(rownames(coefs_nz_df)[2:nrow(coefs_nz_df)]))
  l_probes_coef <- c(l_probes_coef, list(coefs_nz_df[-1,"coefs_nz"]))
    
}

l_cor_unlist <- unlist(l_cor)
l_cor_df <- as.data.frame(l_cor_unlist)
colnames(l_cor_df) <- "Correlation"

l_rmse_unlist <- unlist(l_rmse)
l_rmse_df <- as.data.frame(l_rmse_unlist)
colnames(l_rmse_df) <- "RMSE"

cor_rmse_df <- cbind(l_cor_df,l_rmse_df)

len_probes <- list()
for (i in 1:length(l_probes)){
    len_probes <- c(len_probes, length(l_probes[[i]]))
}
len_probes_unlist <- unlist(len_probes)
len_probes_df <- as.data.frame(len_probes_unlist)
colnames(len_probes_df) <- "nProbes"
l_cor_rmse_nprobes_df <- cbind(cor_rmse_df, len_probes_df)

for (i in 1:nrow(l_cor_rmse_nprobes_df)){
  rownames(l_cor_rmse_nprobes_df)[i] <- paste("Model_500KB_",i, sep="")
}

write.table(l_cor_rmse_nprobes_df, "cor_rmse_nprobes_models_window (Split 1).txt", row.names=T, col.names=T, quote=F)


probes_model <- data.frame()
for (i in 1:length(l_probes)){
  l_probes_i <- unlist(l_probes[[i]])
  l_probes_i_df <- as.data.frame(l_probes_i)
  colnames(l_probes_i_df) <- "Selected Probes"
  l_probes_i_df["Probes_Model"] <- paste("Model_500KB_",i, sep="")
  probes_model <- rbind(probes_model, l_probes_i_df)
}
write.table(probes_model, "probes_models_window (Split 1).txt", row.names=T, col.names=T, quote=F)


