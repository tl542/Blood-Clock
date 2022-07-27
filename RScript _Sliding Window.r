source("/mnt/data1/EXTEND/Methylation/QC/Theo/script_forGA.r")

epicManifest<-read.csv("/mnt/data1/EPIC_reference/MethylationEPIC_v-1-0_B2.csv", skip = 7)




df_final <- data.frame()
for (i in seq(1,22)){
probes_i <- epicManifest[epicManifest$CHR == i, c("Name","CHR")]
df_final <- rbind(df_final, probes_i)
}

set.seed(65)
n <- nrow(df_all)
trainIndex <- sample(1:n, size=round(0.7*n), replace=FALSE)
train <- df_all[trainIndex,]
test <- df_all[-trainIndex,]
best_lambda <- 0.1313309

probes_3 <- df_final[df_final$CHR == 3,]
bv3 <- probes_3[order(probes_2$MAPINFO),]
rownames(bv3) <- NULL

df <- data.frame()
v <- bv3$MAPINFO  
for (i in v[1]:v[length(l)]){
  for (j in i:i+500000){
    if (j %in% v){
      df <- rbind(df,bv3)
    }
  }
}

df <- data.frame()
v <- bv3$MAPINFO  
for (i in v[1]:v[length(l)]){
  for (j in i:i+500000){
    bv3 <- bv3[j %in% v,]
    rownames(bv3) <- bv3$Name
    ix <- which(colnames(df_all)[-803377] %in% rownames(bv3))
    new_train <- cbind(train[,ix], train$Age)
    new_test <- cbind(test[,ix], test$Age)
    names(new_train)[names(new_train) == "train$Age"] <- "Age"
    names(new_test)[names(new_test) == "test$Age"] <- "Age"
    fit_train <- glmnet(as.matrix(new_train[,-ncol(new_train)]), new_train$Age, alpha=0.5, nlambda=10)
    pred_test <- predict(fit_train, as.matrix(new_test[,-ncol(new_test)]), s=best_lambda)
    }
  }
}


