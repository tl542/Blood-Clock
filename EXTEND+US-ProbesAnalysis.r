#!/usr/bin/env Rscript


#Load all the selected probes in Split 1 
probes_model1 <- read.csv("/mnt/data1/EXTEND/Methylation/QC/Theo/probes_model (Split 1).txt", sep=" ")
colnames(probes_model1)[1] <- "Selected_Probes"
probes_model1$Probes_Model <- paste(probes_model1$Probes, probes_model1$Probes_Model)
probes_model1 <- probes_model1[,c(1,3)]
head(probes_model1)


#Load all the selected probes in Split 2
probes_model2 <- read.csv("/mnt/data1/EXTEND/Methylation/QC/Theo/probes_model (Split 2).txt", sep=" ")
colnames(probes_model2)[1] <- "Selected_Probes"
probes_model2$Probes_Model <- paste(probes_model2$Probes, probes_model2$Probes_Model)
probes_model2 <- probes_model2[,c(1,3)]
head(probes_model2)

#Load all the selected probes in Split 3
probes_model3  <- read.csv("/mnt/data1/EXTEND/Methylation/QC/Theo/probes_model (Split 3).txt", sep=" ")
colnames(probes_model3)[1] <- "Selected_Probes"
probes_model3$Probes_Model <- paste(probes_model3$Probes, probes_model3$Probes_Model)
probes_model3 <- probes_model3[,c(1,3)]
head(probes_model3)

#Load all the selected probes in Split 4
probes_model4 <- read.csv("/mnt/data1/EXTEND/Methylation/QC/Theo/probes_model (Split 4).txt", sep=" ")
colnames(probes_model4)[1] <- "Selected_Probes"
probes_model4$Probes_Model <- paste(probes_model4$Probes, probes_model4$Probes_Model)
probes_model4 <- probes_model4[,c(1,3)]
head(probes_model4)

#Load all the selected probes in Split 5
probes_model5 <- read.csv("/mnt/data1/EXTEND/Methylation/QC/Theo/probes_model (Split 5).txt", sep=" ")
colnames(probes_model5)[1] <- "Selected_Probes"
probes_model5$Probes_Model <- paste(probes_model5$Probes, probes_model5$Probes_Model)
probes_model5 <- probes_model5[,c(1,3)]
head(probes_model5)


# All the probes from models across train/test splits with cor >= 0.9 on test data
probes1_0.9 <- probes_model1[1:11946,]
probes2_0.9 <- probes_model2[1:11883,]
probes3_0.9 <- probes_model3[1:13917,]
probes4_0.9 <- probes_model4[1:11526,]
probes5_0.9 <- probes_model5[1:14124,]

# Shared Probes between these models across train/test splits.
library(tidyverse)
shared_probes <- list(probes1_9["Selected_Probes"], probes2_0.9["Selected_Probes"],
 probes3_0.9["Selected_Probes"], probes4_0.9["Selected_Probes"], probes5_0.9["Selected_Probes"])
probes_0.9 <- shared_probes %>% reduce(inner_join, by='Selected_Probes')
probes_0.9_df <- as.data.frame(probes_0.9)
colnames(probes_0.9_df) <- "Shared_Probes"
write.table(probes_0.9_df, "Shared_Probes_0.9.txt", col.names=T, row.names=T, quote=F)

# All the probes from models across train/test splits with cor >= 0.8 on test data
table1 <- read.table("/mnt/data1/EXTEND/Methylation/QC/Theo/table (Split1) df.txt")
table2 <- read.table("/mnt/data1/EXTEND/Methylation/QC/Theo/table (Split2) df.txt")
table3 <- read.table("/mnt/data1/EXTEND/Methylation/QC/Theo/table (Split3) df.txt")
table4 <- read.table("/mnt/data1/EXTEND/Methylation/QC/Theo/table (Split4) df.txt")
table5 <- read.table("/mnt/data1/EXTEND/Methylation/QC/Theo/table (Split5) df.txt")

#1st Split
models1_0.8 <- table1[table1$Correlation >= 0.8,]
for (i in 1:nrow(models1_0.8)){
rownames(models1_0.8)[i] <- paste("Model", rownames(models1_0.8)[i])
}
probes1_0.8 <- probes_model1[probes_model1$Probes_Model %in% rownames(models1_0.8),]

#2nd Split
models2_0.8 <- table2[table2$Correlation >= 0.8,]
for (i in 1:nrow(models2_0.8)){
rownames(models2_0.8)[i] <- paste("Model", rownames(models2_0.8)[i])
}
probes2_0.8 <- probes_model2[probes_model2$Probes_Model %in% rownames(models2_0.8),]

#3th Split
models3_0.8 <- table3[table3$Correlation >= 0.8,]
for (i in 1:nrow(models3_0.8)){
rownames(models3_0.8)[i] <- paste("Model", rownames(models3_0.8)[i])
}
probes3_0.8 <- probes_model3[probes_model3$Probes_Model %in% rownames(models3_0.8),]

#4th Split
models4_0.8 <- table4[table4$Correlation >= 0.8,]
for (i in 1:nrow(models4_0.8)){
rownames(models4_0.8)[i] <- paste("Model", rownames(models4_0.8)[i])
}
probes4_0.8 <- probes_model4[probes_model4$Probes_Model %in% rownames(models4_0.8),]

#5th Split
models5_0.8 <- table5[table5$Correlation >= 0.8,]
for (i in 1:nrow(models5_0.8)){
rownames(models5_0.8)[i] <- paste("Model", rownames(models5_0.8)[i])
}
probes5_0.8 <- probes_model5[probes_model5$Probes_Model %in% rownames(models5_0.8),]

# Shared Probes between these models across train/test splits.
shared_probes <- list(probes1_0.8["Selected_Probes"], probes2_0.8["Selected_Probes"],
 probes3_0.8["Selected_Probes"], probes4_0.8["Selected_Probes"], probes5_0.8["Selected_Probes"])
probes_0.8 <- shared_probes %>% reduce(inner_join, by='Selected_Probes')
probes_0.8_df <- as.data.frame(probes_0.8)
colnames(probes_0.8_df) <- "Shared_Probes"
write.table(probes_0.8_df, "Shared_Probes_0.8.txt", col.names=T, row.names=T, quote=F)



# All the probes from Model 1 ("best" model) across train/test splits
pbs_model1_best <- probes_model1[probes_model1$Probes_Model == "Model 1",]
pbs_model2_best <- probes_model2[probes_model2$Probes_Model == "Model 1",]
pbs_model3_best <- probes_model3[probes_model3$Probes_Model == "Model 1",]
pbs_model4_best <- probes_model4[probes_model4$Probes_Model == "Model 1",]
pbs_model5_best <- probes_model5[probes_model5$Probes_Model == "Model 1",]

# Shared Probes between these models across train/test splits.
shared_probes <- list(pbs_model1_best["Selected_Probes"], pbs_model2_best["Selected_Probes"],
 pbs_model3_best["Selected_Probes"], pbs_model4_best["Selected_Probes"], pbs_model5_best["Selected_Probes"])
probes_Mod1 <- shared_probes %>% reduce(inner_join, by='Selected_Probes')
probes_Mod1_df <- as.data.frame(probes_Mod1)
colnames(probes_Mod1_df) <- "Shared_Probes"
write.table(probes_Mod1_df, "Shared_Probes_mod1.txt", col.names=T, row.names=T, quote=F)

probes_summary <- data.frame(matrix(0,nrow=3, ncol=7))
rownames(probes_summary) <- c("nprobes_mod1", "nprobes_0.9", "nprobes_0.8")
colnames(probes_summary) <- c("Split1", "Split2", "Split3", "Split4", "Split5", "n_shared_probes", "prop_shared_probes")
probes_summary[1,] <- c("1005", "1049", "1021", "1010", "1029", "86", "0.01681658")
probes_summary[2,] <- c("11946", "11883", "13917", "11526", "14124", "2256", "0.03558584")
probes_summary[3,] <- c("123845", "131869", "135936", "116550", "131863", "35818", "0.05596012")
write.table(probes_summary, "shared_probes_summary.txt", col.names=T, row.names=T, quote=F)



