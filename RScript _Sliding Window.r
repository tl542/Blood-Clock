#!/usr/bin/env Rscript

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



library(glmnet)
library(Metrics)
l_probes <- list()
l_probes_coef <- list()
l_rmse <- list()
l_cor <- list()
start_window <- list()
nprobes_window <- list()
l_chr <- list()
nmodels_chr <- list()
for (c in seq(1,22)){
  n_iter <- 0
  l_chr <- c(l_chr, c)
  probes_chr <- df_final[df_final$CHR == c,]
  probes_chr_ordered <- probes_chr[order(probes_chr$MAPINFO),]
  rownames(probes_chr_ordered) <- NULL
  v <- probes_chr_ordered$MAPINFO 
  for (i in v){
    l_p <- list()
    l_p <- which(v < i+500000 & v >= i) 
    start_window <- c(start_window, i)
    nprobes_window <- c(nprobes_window, length(l_p))
    probes_window <- probes_chr_ordered[l_p,]
    rownames(probes_window) <- probes_window$Name
    ix <- which(colnames(df_all)[-803377] %in% rownames(probes_window))
    if (length(ix) >= 2){
      n_iter <- n_iter + 1
      new_train <- train[,c(ix,ncol(train))]
      new_test <- test[,c(ix,ncol(test))]
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
  nmodels_chr <- c(nmodels_chr, n_iter)
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
colnames(len_probes_df) <- "nProbes_selected"
l_cor_rmse_nprobes_df <- cbind(cor_rmse_df, len_probes_df)


nprobes_window_unlist <- unlist(nprobes_window)
nprobes_window_unlist_df <- as.data.frame(nprobes_window_unlist)
colnames(nprobes_window_unlist_df) <- "nProbes_Window"

start_window_unlist <- unlist(start_window)
start_window_unlist_df <- as.data.frame(start_window_unlist)
colnames(start_window_unlist_df) <- "Start_Window"

nprobes_start_window_df <- cbind(nprobes_window_unlist_df, start_window_unlist_df)
final_df <- cbind(l_cor_rmse_nprobes_df, nprobes_start_window_df)

write.table(final_df, "cor_rmse_nprobes_models_window (Split 1).txt", row.names=T, col.names=T, quote=F)


l_chr_unlist <- unlist(l_chr)
l_chr_unlist_df <- as.data.frame(l_chr_unlist)
colnames(l_chr_unlist_df) <- "Chr"

nmodels_chr_unlist <- unlist(nmodels_chr)
nmodels_chr_unlist_df <- as.data.frame(nmodels_chr_unlist)
colnames(nmodels_chr_unlist_df) <- "nmodels_chr"
nmodels_chr_unlist_df <- cbind(nmodels_chr_unlist_df, l_chr_unlist_df)

write.table(nmodels_chr_unlist_df,"nmodels_chr (Split 1).txt", row.names=T, col.names=T, quote=F)

#final_df$Chr <- 0
#final_df$Chr[1:nmodels_chr_unlist_df$nmodels_chr[1]] <- "Chr1"
#for (i in seq(1,22)){
  #final_df$Chr[nmodels_chr_unlist_df$nmodels_chr[i]+1:nmodels_chr_unlist_df$nmodels_chr[i+1]]
#final_df$Chr[nmodels_chr_unlist_df$nmodels_chr[2]+1:nmodels_chr_unlist_df$nmodels_chr[3]]
#final_df$Chr[nmodels_chr_unlist_df$nmodels_chr[3]+1:nmodels_chr_unlist_df$nmodels_chr[4]]
#final_df$Chr[nmodels_chr_unlist_df$nmodels_chr[4]+1:nmodels_chr_unlist_df$nmodels_chr[5]]
#final_df$Chr[nmodels_chr_unlist_df$nmodels_chr[4]+1:nmodels_chr_unlist_df$nmodels_chr[5]]
#final_df$Chr[nmodels_chr_unlist_df$nmodels_chr[5]+1:nmodels_chr_unlist_df$nmodels_chr[6]]




#for (i in 1:nrow(final_df)){
  #rownames(final_df)[i] <- paste("Model_500KB_",i, sep="")
#}




#probes_model <- data.frame()
#for (i in 1:length(l_probes)){
  #l_probes_i <- unlist(l_probes[[i]])
  #l_probes_i_df <- as.data.frame(l_probes_i)
  #colnames(l_probes_i_df) <- "Selected Probes"
  #l_probes_i_df["Probes_Model"] <- paste("Model_500KB_",i, sep="")
  #probes_model <- rbind(probes_model, l_probes_i_df)
#}
#write.table(probes_model, "probes_models_window (Split 1).txt", row.names=T, col.names=T, quote=F)


