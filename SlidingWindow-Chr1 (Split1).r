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
probes_chr <- df_final[df_final$CHR == 1,]
probes_chr_ordered <- probes_chr[order(probes_chr$MAPINFO),]
rownames(probes_chr_ordered) <- NULL
n_iter <- 0
v <- probes_chr_ordered$MAPINFO 
for (i in v){
    l_p <- list()
    l_p <- which(v < i+500000 & v >= i) 
    probes_window <- probes_chr_ordered[l_p,]
    rownames(probes_window) <- probes_window$Name
    ix <- which(colnames(df_all)[-803377] %in% rownames(probes_window))
    if (length(ix) >= 2){
      n_iter <- n_iter + 1
      start_window <- c(start_window, i)
      nprobes_window <- c(nprobes_window, length(ix))
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
    }
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
colnames(nprobes_window_unlist_df) <- "nProbes_Window_Model"

start_window_unlist <- unlist(start_window)
start_window_unlist_df <- as.data.frame(start_window_unlist)
colnames(start_window_unlist_df) <- "Start_Window"

nprobes_start_window_df <- cbind(nprobes_window_unlist_df, start_window_unlist_df)
final_df <- cbind(l_cor_rmse_nprobes_df, nprobes_start_window_df)

for (i in 1:nrow(final_df)){
final_df$Chr[i] <- "Chr1"
}

write.table(final_df, "summaryChr1 (Split 1).txt", row.names=T, col.names=T, quote=F)

chr1 <- read.table("/mnt/data1/EXTEND/Methylation/QC/Theo/SW-Chrs/summaryChr1 (Split 1).txt")
chr2 <- read.table("/mnt/data1/EXTEND/Methylation/QC/Theo/SW-Chrs/summaryChr2 (Split 1).txt")
df1 <- rbind(chr1,chr2)
chr3 <- read.table("/mnt/data1/EXTEND/Methylation/QC/Theo/SW-Chrs/summaryChr3 (Split 1).txt")
df2 <- rbind(df1,chr3)
chr4 <- read.table("/mnt/data1/EXTEND/Methylation/QC/Theo/SW-Chrs/summaryChr4 (Split 1).txt")
df3 <- rbind(df2,chr4)
chr5 <- read.table("/mnt/data1/EXTEND/Methylation/QC/Theo/SW-Chrs/summaryChr5 (Split 1).txt")
df4 <- rbind(df3,chr5)
chr6 <- read.table("/mnt/data1/EXTEND/Methylation/QC/Theo/SW-Chrs/summaryChr6 (Split 1).txt")
df5 <- rbind(df4,chr6)
chr7 <- read.table("/mnt/data1/EXTEND/Methylation/QC/Theo/SW-Chrs/summaryChr7 (Split 1).txt")
df6 <- rbind(df5,chr7)
chr8 <- read.table("/mnt/data1/EXTEND/Methylation/QC/Theo/SW-Chrs/summaryChr8 (Split 1).txt")
df6 <- rbind(df6,chr8)
chr9 <- read.table("/mnt/data1/EXTEND/Methylation/QC/Theo/SW-Chrs/summaryChr9 (Split 1).txt")
df7 <- rbind(df6,chr9)
chr10 <- read.table("/mnt/data1/EXTEND/Methylation/QC/Theo/SW-Chrs/summaryChr10 (Split 1).txt")
df8 <- rbind(df7,chr10)
chr11 <- read.table("/mnt/data1/EXTEND/Methylation/QC/Theo/SW-Chrs/summaryChr11 (Split 1).txt")
df9 <- rbind(df8,chr11)
chr12 <- read.table("/mnt/data1/EXTEND/Methylation/QC/Theo/SW-Chrs/summaryChr12 (Split 1).txt")
df10 <- rbind(df9,chr12)
chr13 <- read.table("/mnt/data1/EXTEND/Methylation/QC/Theo/SW-Chrs/summaryChr13 (Split 1).txt")
df11 <- rbind(df10,chr13)
chr14 <- read.table("/mnt/data1/EXTEND/Methylation/QC/Theo/SW-Chrs/summaryChr14 (Split 1).txt")
df12 <- rbind(df11,chr14)
chr15 <- read.table("/mnt/data1/EXTEND/Methylation/QC/Theo/SW-Chrs/summaryChr15 (Split 1).txt")
df13 <- rbind(df12,chr15)
chr16 <- read.table("/mnt/data1/EXTEND/Methylation/QC/Theo/SW-Chrs/summaryChr16 (Split 1).txt")
df14 <- rbind(df13,chr16)
chr17 <- read.table("/mnt/data1/EXTEND/Methylation/QC/Theo/SW-Chrs/summaryChr17 (Split 1).txt")
df15 <- rbind(df14,chr17)
chr18 <- read.table("/mnt/data1/EXTEND/Methylation/QC/Theo/SW-Chrs/summaryChr18 (Split 1).txt")
df16 <- rbind(df15,chr18)
chr19 <- read.table("/mnt/data1/EXTEND/Methylation/QC/Theo/SW-Chrs/summaryChr19 (Split 1).txt")
df17 <- rbind(df16,chr19)
chr20 <- read.table("/mnt/data1/EXTEND/Methylation/QC/Theo/SW-Chrs/summaryChr20 (Split 1).txt")
df18 <- rbind(df17,chr20)
chr21 <- read.table("/mnt/data1/EXTEND/Methylation/QC/Theo/SW-Chrs/summaryChr21 (Split 1).txt")
df19 <- rbind(df18,chr21)
chr22 <- read.table("/mnt/data1/EXTEND/Methylation/QC/Theo/SW-Chrs/summaryChr22 (Split 1).txt")
df20 <- rbind(df19,chr22)

df_final <- df20[!duplicated(df20$Correlation),]
rownames(df_final) <- NULL
df_final1 <- df_final[!duplicated(df_final$RMSE),]
write.table(df_final1,"Sliding_Window_Table.txt", row.names=T, col.names=T,quote=F)

library("vioplot")
par(bg="aliceblue")
vioplot(df_final1$Correlation, ylab="Test Set Correlation", main="Model Performance per 500 KB sub-region", col="steelblue", lineCol="white", rectCol="red", 
        colMed="green", border="white")
dev.copy(pdf,"Performance_vs_500KB.pdf")
dev.off()
