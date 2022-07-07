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


table1 <- read.table("/mnt/data1/EXTEND/Methylation/QC/Theo/table (Split1) df.txt")
table2 <- read.table("/mnt/data1/EXTEND/Methylation/QC/Theo/table (Split2) df.txt")
table3 <- read.table("/mnt/data1/EXTEND/Methylation/QC/Theo/table (Split3) df.txt")
table4 <- read.table("/mnt/data1/EXTEND/Methylation/QC/Theo/table (Split4) df.txt")
table5 <- read.table("/mnt/data1/EXTEND/Methylation/QC/Theo/table (Split5) df.txt")

# All the probes from models across train/test splits with cor >= 0.8 on test data

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



# All the probes from Model 1 ("best" model) across train/test splits
pbs_model1_best <- probes_model1[probes_model1$Probes_Model == "Model 1",]
pbs_model2_best <- probes_model2[probes_model2$Probes_Model == "Model 1",]
pbs_model3_best <- probes_model3[probes_model3$Probes_Model == "Model 1",]
pbs_model4_best <- probes_model4[probes_model4$Probes_Model == "Model 1",]
pbs_model5_best <- probes_model5[probes_model5$Probes_Model == "Model 1",]


# Model 1

shared_probes_Mod1_12 <- list(pbs_model1_best["Selected_Probes"], pbs_model2_best["Selected_Probes"])
probes_Mod1_12 <- shared_probes_Mod1_12 %>% reduce(inner_join, by='Selected_Probes')
probes_Mod1_12_df <- as.data.frame(probes_Mod1_12)
colnames(probes_Mod1_12_df) <- "Shared_Probes"
        
shared_probes_Mod1_13 <- list(pbs_model1_best["Selected_Probes"], pbs_model3_best["Selected_Probes"])
probes_Mod1_13 <- shared_probes_Mod1_13 %>% reduce(inner_join, by='Selected_Probes')
probes_Mod1_13_df <- as.data.frame(probes_Mod1_13)
colnames(probes_Mod1_13_df) <- "Shared_Probes"
                       
shared_probes_Mod1_14 <- list(pbs_model1_best["Selected_Probes"], pbs_model4_best["Selected_Probes"])
probes_Mod1_14 <- shared_probes_Mod1_14 %>% reduce(inner_join, by='Selected_Probes')
probes_Mod1_14_df <- as.data.frame(probes_Mod1_14)
colnames(probes_Mod1_14_df) <- "Shared_Probes"

shared_probes_Mod1_15 <- list(pbs_model1_best["Selected_Probes"], pbs_model5_best["Selected_Probes"])
probes_Mod1_15 <- shared_probes_Mod1_15 %>% reduce(inner_join, by='Selected_Probes')
probes_Mod1_15_df <- as.data.frame(probes_Mod1_15)
colnames(probes_Mod1_15_df) <- "Shared_Probes"

shared_probes_Mod1_23 <- list(pbs_model2_best["Selected_Probes"], pbs_model3_best["Selected_Probes"])
probes_Mod1_23 <- shared_probes_Mod1_23 %>% reduce(inner_join, by='Selected_Probes')
probes_Mod1_23_df <- as.data.frame(probes_Mod1_23)
colnames(probes_Mod1_23_df) <- "Shared_Probes"

shared_probes_Mod1_24 <- list(pbs_model2_best["Selected_Probes"], pbs_model4_best["Selected_Probes"])
probes_Mod1_24 <- shared_probes_Mod1_24 %>% reduce(inner_join, by='Selected_Probes')
probes_Mod1_24_df <- as.data.frame(probes_Mod1_24)
colnames(probes_Mod1_24_df) <- "Shared_Probes"

shared_probes_Mod1_25 <- list(pbs_model2_best["Selected_Probes"], pbs_model5_best["Selected_Probes"])
probes_Mod1_25 <- shared_probes_Mod1_25 %>% reduce(inner_join, by='Selected_Probes')
probes_Mod1_25_df <- as.data.frame(probes_Mod1_25)
colnames(probes_Mod1_25_df) <- "Shared_Probes"

shared_probes_Mod1_34 <- list(pbs_model3_best["Selected_Probes"], pbs_model4_best["Selected_Probes"])
probes_Mod1_34 <- shared_probes_Mod1_34 %>% reduce(inner_join, by='Selected_Probes')
probes_Mod1_34_df <- as.data.frame(probes_Mod1_34)
colnames(probes_Mod1_34_df) <- "Shared_Probes"

shared_probes_Mod1_35 <- list(pbs_model3_best["Selected_Probes"], pbs_model5_best["Selected_Probes"])
probes_Mod1_35 <- shared_probes_Mod1_35 %>% reduce(inner_join, by='Selected_Probes')
probes_Mod1_35_df <- as.data.frame(probes_Mod1_35)
colnames(probes_Mod1_35_df) <- "Shared_Probes"

shared_probes_Mod1_45 <- list(pbs_model4_best["Selected_Probes"], pbs_model5_best["Selected_Probes"])
probes_Mod1_45 <- shared_probes_Mod1_45 %>% reduce(inner_join, by='Selected_Probes')
probes_Mod1_45_df <- as.data.frame(probes_Mod1_45)
colnames(probes_Mod1_45_df) <- "Shared_Probes"


shared_probes_Mod1 <- data.frame(matrix(0, ncol=5, nrow=5))
rownames(shared_probes_Mod1) <- c("T1", "T2", "T3", "T4", "T5")
colnames(shared_probes_Mod1) <- c("T1", "T2", "T3", "T4", "T5")
shared_probes_Mod1[1,1] <- dim(pbs_model1_best)[1] / dim(pbs_model1_best)[1]
shared_probes_Mod1[2,2] <- dim(pbs_model2_best)[1] / dim(pbs_model2_best)[1]
shared_probes_Mod1[3,3] <- dim(pbs_model3_best)[1] / dim(pbs_model3_best)[1]
shared_probes_Mod1[4,4] <- dim(pbs_model4_best)[1] / dim(pbs_model4_best)[1]
shared_probes_Mod1[5,5] <- dim(pbs_model5_best)[1] / dim(pbs_model5_best)[1]
shared_probes_Mod1[1,2:5] <- c(dim(probes_Mod1_12_df)[1]/dim(pbs_model1_best)[1], dim(probes_Mod1_13_df)[1]/dim(pbs_model1_best)[1], dim(probes_Mod1_14_df)[1]/dim(pbs_model1_best)[1], 
                               dim(probes_Mod1_15_df)[1]/dim(pbs_model1_best)[1])
shared_probes_Mod1[2,3] <- dim(probes_Mod1_23_df)[1]/dim(pbs_model3_best)[1]
shared_probes_Mod1[2,4] <- dim(probes_Mod1_24_df)[1]/dim(pbs_model4_best)[1]
shared_probes_Mod1[2,5] <- dim(probes_Mod1_25_df)[1]/dim(pbs_model5_best)[1]
shared_probes_Mod1[3,4] <- dim(probes_Mod1_34_df)[1]/dim(pbs_model4_best)[1]
shared_probes_Mod1[3,5] <- dim(probes_Mod1_35_df)[1]/dim(pbs_model3_best)[1]
shared_probes_Mod1[4,5] <- dim(probes_Mod1_45_df)[1]/dim(pbs_model4_best)[1]

shared_probes_Mod1_matrix <- as.matrix(shared_probes_Mod1)
library(Matrix)
shared_probes_Mod1_matrix_sym <- forceSymmetric(shared_probes_Mod1_matrix)
shared_probes_Mod1_matrix_sym <- as.matrix(shared_probes_Mod1_matrix_sym)
df1 <- as.data.frame(shared_probes_Mod1_matrix_sym)
write.table(df1, "shared_probes_2x2_Mod1.txt", row.names=T, col.names=T, quote=F)



# Models with cor >= 0.9


shared_probes_0.9_12 <- list(probes1_0.9["Selected_Probes"], probes2_0.9["Selected_Probes"])
probes_0.9_12 <- shared_probes_0.9_12 %>% reduce(inner_join, by='Selected_Probes')
probes_0.9_12_df <- as.data.frame(probes_0.9_12)
colnames(probes_0.9_12_df) <- "Shared_Probes"

shared_probes_0.9_13 <- list(probes1_0.9["Selected_Probes"], probes3_0.9["Selected_Probes"])
probes_0.9_13 <- shared_probes_0.9_13 %>% reduce(inner_join, by='Selected_Probes')
probes_0.9_13_df <- as.data.frame(probes_0.9_13)
colnames(probes_0.9_13_df) <- "Shared_Probes"

shared_probes_0.9_14 <- list(probes1_0.9["Selected_Probes"], probes4_0.9["Selected_Probes"])
probes_0.9_14 <- shared_probes_0.9_14 %>% reduce(inner_join, by='Selected_Probes')
probes_0.9_14_df <- as.data.frame(probes_0.9_14)
colnames(probes_0.9_14_df) <- "Shared_Probes"

shared_probes_0.9_15 <- list(probes1_0.9["Selected_Probes"], probes5_0.9["Selected_Probes"])
probes_0.9_15 <- shared_probes_0.9_15 %>% reduce(inner_join, by='Selected_Probes')
probes_0.9_15_df <- as.data.frame(probes_0.9_15)
colnames(probes_0.9_15_df) <- "Shared_Probes"

shared_probes_0.9_23 <- list(probes2_0.9["Selected_Probes"], probes3_0.9["Selected_Probes"])
probes_0.9_23 <- shared_probes_0.9_23 %>% reduce(inner_join, by='Selected_Probes')
probes_0.9_23_df <- as.data.frame(probes_0.9_23)
colnames(probes_0.9_23_df) <- "Shared_Probes"

shared_probes_0.9_24 <- list(probes2_0.9["Selected_Probes"], probes4_0.9["Selected_Probes"])
probes_0.9_24 <- shared_probes_0.9_24 %>% reduce(inner_join, by='Selected_Probes')
probes_0.9_24_df <- as.data.frame(probes_0.9_24)
colnames(probes_0.9_24_df) <- "Shared_Probes"

shared_probes_0.9_25 <- list(probes2_0.9["Selected_Probes"], probes5_0.9["Selected_Probes"])
probes_0.9_25 <- shared_probes_0.9_25 %>% reduce(inner_join, by='Selected_Probes')
probes_0.9_25_df <- as.data.frame(probes_0.9_25)
colnames(probes_0.9_25_df) <- "Shared_Probes"

shared_probes_0.9_34 <- list(probes3_0.9["Selected_Probes"], probes4_0.9["Selected_Probes"])
probes_0.9_34 <- shared_probes_0.9_34 %>% reduce(inner_join, by='Selected_Probes')
probes_0.9_34_df <- as.data.frame(probes_0.9_34)
colnames(probes_0.9_34_df) <- "Shared_Probes"

shared_probes_0.9_35 <- list(probes3_0.9["Selected_Probes"], probes5_0.9["Selected_Probes"])
probes_0.9_35 <- shared_probes_0.9_35 %>% reduce(inner_join, by='Selected_Probes')
probes_0.9_35_df <- as.data.frame(probes_0.9_35)
colnames(probes_0.9_35_df) <- "Shared_Probes"

shared_probes_0.9_45 <- list(probes4_0.9["Selected_Probes"], probes5_0.9["Selected_Probes"])
probes_0.9_45 <- shared_probes_0.9_45 %>% reduce(inner_join, by='Selected_Probes')
probes_0.9_45_df <- as.data.frame(probes_0.9_45)
colnames(probes_0.9_45_df) <- "Shared_Probes"



shared_probes_0.9 <- data.frame(matrix(0, ncol=5, nrow=5))
rownames(shared_probes_0.9) <- c("T1", "T2", "T3", "T4", "T5")
colnames(shared_probes_0.9) <- c("T1", "T2", "T3", "T4", "T5")
shared_probes_0.9[1,1] <- dim(probes1_0.9)[1]/dim(probes1_0.9)[1]
shared_probes_0.9[2,2] <- dim(probes2_0.9)[1]/dim(probes2_0.9)[1]
shared_probes_0.9[3,3] <- dim(probes3_0.9)[1]/dim(probes3_0.9)[1]
shared_probes_0.9[4,4] <- dim(probes4_0.9)[1]/dim(probes4_0.9)[1]
shared_probes_0.9[5,5] <- dim(probes5_0.9)[1]/dim(probes5_0.9)[1]
shared_probes_0.9[1,2:5] <- c(dim(probes_0.9_12_df)[1]/dim(probes2_0.9)[1], dim(probes_0.9_13_df)[1]/dim(probes1_0.9)[1], dim(probes_0.9_14_df)[1]/dim(probes4_0.9)[1],
                              dim(probes_0.9_15_df)[1]/dim(probes1_0.9)[1])
shared_probes_0.9[2,3] <- dim(probes_0.9_23_df)[1]/dim(probes2_0.9)[1]
shared_probes_0.9[2,4] <- dim(probes_0.9_24_df)[1]/dim(probes4_0.9)[1]
shared_probes_0.9[2,5] <- dim(probes_0.9_25_df)[1]/dim(probes2_0.9)[1]
shared_probes_0.9[3,4] <- dim(probes_0.9_34_df)[1]/dim(probes4_0.9)[1]
shared_probes_0.9[3,5] <- dim(probes_0.9_35_df)[1]/dim(probes3_0.9)[1]
shared_probes_0.9[4,5] <- dim(probes_0.9_45_df)[1]/dim(probes4_0.9)[1]
                       
shared_probes_0.9_matrix <- as.matrix(shared_probes_0.9)
shared_probes_0.9_matrix_sym <- forceSymmetric(shared_probes_0.9_matrix)
shared_probes_0.9_matrix_sym <- as.matrix(shared_probes_0.9_matrix_sym)
df2 <- as.data.frame(shared_probes_0.9_matrix_sym)
write.table(df2, "shared_probes_2x2_0.9.txt", row.names=T, col.names=T, quote=F)
                
                        
# Models with cor >= 0.8


shared_probes_0.8_12 <- list(probes1_0.8["Selected_Probes"], probes2_0.8["Selected_Probes"])
probes_0.8_12 <- shared_probes_0.8_12 %>% reduce(inner_join, by='Selected_Probes')
probes_0.8_12_df <- as.data.frame(probes_0.8_12)
colnames(probes_0.8_12_df) <- "Shared_Probes"

shared_probes_0.8_13 <- list(probes1_0.8["Selected_Probes"], probes3_0.8["Selected_Probes"])
probes_0.8_13 <- shared_probes_0.8_13 %>% reduce(inner_join, by='Selected_Probes')
probes_0.8_13_df <- as.data.frame(probes_0.8_13)
colnames(probes_0.8_13_df) <- "Shared_Probes"

shared_probes_0.8_14 <- list(probes1_0.8["Selected_Probes"], probes4_0.8["Selected_Probes"])
probes_0.8_14 <- shared_probes_0.8_14 %>% reduce(inner_join, by='Selected_Probes')
probes_0.8_14_df <- as.data.frame(probes_0.8_14)
colnames(probes_0.8_14_df) <- "Shared_Probes"

shared_probes_0.8_15 <- list(probes1_0.8["Selected_Probes"], probes5_0.8["Selected_Probes"])
probes_0.8_15 <- shared_probes_0.8_15 %>% reduce(inner_join, by='Selected_Probes')
probes_0.8_15_df <- as.data.frame(probes_0.8_15)
colnames(probes_0.8_15_df) <- "Shared_Probes"

shared_probes_0.8_23 <- list(probes2_0.8["Selected_Probes"], probes3_0.8["Selected_Probes"])
probes_0.8_23 <- shared_probes_0.8_23 %>% reduce(inner_join, by='Selected_Probes')
probes_0.8_23_df <- as.data.frame(probes_0.8_23)
colnames(probes_0.8_23_df) <- "Shared_Probes"

shared_probes_0.8_24 <- list(probes2_0.8["Selected_Probes"], probes4_0.8["Selected_Probes"])
probes_0.8_24 <- shared_probes_0.8_24 %>% reduce(inner_join, by='Selected_Probes')
probes_0.8_24_df <- as.data.frame(probes_0.8_24)
colnames(probes_0.8_24_df) <- "Shared_Probes"

shared_probes_0.8_25 <- list(probes2_0.8["Selected_Probes"], probes5_0.8["Selected_Probes"])
probes_0.8_25 <- shared_probes_0.8_25 %>% reduce(inner_join, by='Selected_Probes')
probes_0.8_25_df <- as.data.frame(probes_0.8_25)
colnames(probes_0.8_25_df) <- "Shared_Probes"

shared_probes_0.8_34 <- list(probes3_0.8["Selected_Probes"], probes4_0.8["Selected_Probes"])
probes_0.8_34 <- shared_probes_0.8_34 %>% reduce(inner_join, by='Selected_Probes')
probes_0.8_34_df <- as.data.frame(probes_0.8_34)
colnames(probes_0.8_34_df) <- "Shared_Probes"

shared_probes_0.8_35 <- list(probes3_0.8["Selected_Probes"], probes5_0.8["Selected_Probes"])
probes_0.8_35 <- shared_probes_0.8_35 %>% reduce(inner_join, by='Selected_Probes')
probes_0.8_35_df <- as.data.frame(probes_0.8_35)
colnames(probes_0.8_35_df) <- "Shared_Probes"

shared_probes_0.8_45 <- list(probes4_0.8["Selected_Probes"], probes5_0.8["Selected_Probes"])
probes_0.8_45 <- shared_probes_0.8_45 %>% reduce(inner_join, by='Selected_Probes')
probes_0.8_45_df <- as.data.frame(probes_0.8_45)
colnames(probes_0.8_45_df) <- "Shared_Probes"

shared_probes_0.8 <- data.frame(matrix(0, ncol=5, nrow=5))
rownames(shared_probes_0.8) <- c("T1", "T2", "T3", "T4", "T5")
colnames(shared_probes_0.8) <- c("T1", "T2", "T3", "T4", "T5")
shared_probes_0.8[1,1] <- dim(probes1_0.8)[1]/dim(probes1_0.8)[1]
shared_probes_0.8[2,2] <- dim(probes2_0.8)[1]/dim(probes2_0.8)[1]
shared_probes_0.8[3,3] <- dim(probes3_0.8)[1]/dim(probes3_0.8)[1]
shared_probes_0.8[4,4] <- dim(probes4_0.8)[1]/dim(probes4_0.8)[1]
shared_probes_0.8[5,5] <- dim(probes5_0.8)[1]/dim(probes5_0.8)[1]
shared_probes_0.8[1,2:5] <- c(dim(probes_0.8_12_df)[1]/dim(probes1_0.8)[1], dim(probes_0.8_13_df)[1]/dim(probes1_0.8)[1], dim(probes_0.8_14_df)[1]/dim(probes4_0.8)[1], 
                              dim(probes_0.8_15_df)[1]/dim(probes1_0.8)[1])
shared_probes_0.8[2,3] <- dim(probes_0.8_23_df)[1]/dim(probes2_0.8)[1]
shared_probes_0.8[2,4] <- dim(probes_0.8_24_df)[1]/dim(probes4_0.8)[1]
shared_probes_0.8[2,5] <- dim(probes_0.8_25_df)[1]/dim(probes5_0.8)[1]
shared_probes_0.8[3,4] <- dim(probes_0.8_34_df)[1]/dim(probes4_0.8)[1]
shared_probes_0.8[3,5] <- dim(probes_0.8_35_df)[1]/dim(probes5_0.8)[1]
shared_probes_0.8[4,5] <- dim(probes_0.8_45_df)[1]/dim(probes4_0.8)[1]
                       
shared_probes_0.8_matrix <- as.matrix(shared_probes_0.8)
shared_probes_0.8_matrix_sym <- forceSymmetric(shared_probes_0.8_matrix)
shared_probes_0.8_matrix_sym <- as.matrix(shared_probes_0.8_matrix_sym)
df3 <- as.data.frame(shared_probes_0.8_matrix_sym)
write.table(df3, "shared_probes_2x2_0.8.txt", row.names=T, col.names=T, quote=F)


# All the probes from models across train/test splits with cor >= 0.7 on test data

#1st Split
models1_0.7 <- table1[table1$Correlation >= 0.7,]
for (i in 1:nrow(models1_0.7)){
rownames(models1_0.7)[i] <- paste("Model", rownames(models1_0.7)[i])
}
probes1_0.7 <- probes_model1[probes_model1$Probes_Model %in% rownames(models1_0.7),]

#2nd Split
models2_0.7 <- table2[table2$Correlation >= 0.7,]
for (i in 1:nrow(models2_0.7)){
rownames(models2_0.7)[i] <- paste("Model", rownames(models2_0.7)[i])
}
probes2_0.7 <- probes_model2[probes_model2$Probes_Model %in% rownames(models2_0.7),]

#3th Split
models3_0.7 <- table3[table3$Correlation >= 0.7,]
for (i in 1:nrow(models3_0.7)){
rownames(models3_0.7)[i] <- paste("Model", rownames(models3_0.7)[i])
}
probes3_0.7 <- probes_model3[probes_model3$Probes_Model %in% rownames(models3_0.7),]

#4th Split
models4_0.7 <- table4[table4$Correlation >= 0.7,]
for (i in 1:nrow(models4_0.7)){
rownames(models4_0.7)[i] <- paste("Model", rownames(models4_0.7)[i])
}
probes4_0.7 <- probes_model4[probes_model4$Probes_Model %in% rownames(models4_0.7),]

#5th Split
models5_0.7 <- table5[table5$Correlation >= 0.7,]
for (i in 1:nrow(models5_0.7)){
rownames(models5_0.7)[i] <- paste("Model", rownames(models5_0.7)[i])
}
probes5_0.7 <- probes_model5[probes_model5$Probes_Model %in% rownames(models5_0.7),]


# Models with cor >= 0.7


shared_probes_0.7_12 <- list(probes1_0.7["Selected_Probes"], probes2_0.7["Selected_Probes"])
probes_0.7_12 <- shared_probes_0.7_12 %>% reduce(inner_join, by='Selected_Probes')
probes_0.7_12_df <- as.data.frame(probes_0.7_12)
colnames(probes_0.7_12_df) <- "Shared_Probes"

shared_probes_0.7_13 <- list(probes1_0.7["Selected_Probes"], probes3_0.7["Selected_Probes"])
probes_0.7_13 <- shared_probes_0.7_13 %>% reduce(inner_join, by='Selected_Probes')
probes_0.7_13_df <- as.data.frame(probes_0.7_13)
colnames(probes_0.7_13_df) <- "Shared_Probes"

shared_probes_0.7_14 <- list(probes1_0.7["Selected_Probes"], probes4_0.7["Selected_Probes"])
probes_0.7_14 <- shared_probes_0.7_14 %>% reduce(inner_join, by='Selected_Probes')
probes_0.7_14_df <- as.data.frame(probes_0.7_14)
colnames(probes_0.7_14_df) <- "Shared_Probes"

shared_probes_0.7_15 <- list(probes1_0.7["Selected_Probes"], probes5_0.7["Selected_Probes"])
probes_0.7_15 <- shared_probes_0.7_15 %>% reduce(inner_join, by='Selected_Probes')
probes_0.7_15_df <- as.data.frame(probes_0.7_15)
colnames(probes_0.7_15_df) <- "Shared_Probes"

shared_probes_0.7_23 <- list(probes2_0.7["Selected_Probes"], probes3_0.7["Selected_Probes"])
probes_0.7_23 <- shared_probes_0.7_23 %>% reduce(inner_join, by='Selected_Probes')
probes_0.7_23_df <- as.data.frame(probes_0.7_23)
colnames(probes_0.7_23_df) <- "Shared_Probes"

shared_probes_0.7_24 <- list(probes2_0.7["Selected_Probes"], probes4_0.7["Selected_Probes"])
probes_0.7_24 <- shared_probes_0.7_24 %>% reduce(inner_join, by='Selected_Probes')
probes_0.7_24_df <- as.data.frame(probes_0.7_24)
colnames(probes_0.7_24_df) <- "Shared_Probes"

shared_probes_0.7_25 <- list(probes2_0.7["Selected_Probes"], probes5_0.7["Selected_Probes"])
probes_0.7_25 <- shared_probes_0.7_25 %>% reduce(inner_join, by='Selected_Probes')
probes_0.7_25_df <- as.data.frame(probes_0.7_25)
colnames(probes_0.7_25_df) <- "Shared_Probes"

shared_probes_0.7_34 <- list(probes3_0.7["Selected_Probes"], probes4_0.7["Selected_Probes"])
probes_0.7_34 <- shared_probes_0.7_34 %>% reduce(inner_join, by='Selected_Probes')
probes_0.7_34_df <- as.data.frame(probes_0.7_34)
colnames(probes_0.7_34_df) <- "Shared_Probes"

shared_probes_0.7_35 <- list(probes3_0.7["Selected_Probes"], probes5_0.7["Selected_Probes"])
probes_0.7_35 <- shared_probes_0.7_35 %>% reduce(inner_join, by='Selected_Probes')
probes_0.7_35_df <- as.data.frame(probes_0.7_35)
colnames(probes_0.7_35_df) <- "Shared_Probes"

shared_probes_0.7_45 <- list(probes4_0.7["Selected_Probes"], probes5_0.7["Selected_Probes"])
probes_0.7_45 <- shared_probes_0.7_45 %>% reduce(inner_join, by='Selected_Probes')
probes_0.7_45_df <- as.data.frame(probes_0.7_45)
colnames(probes_0.7_45_df) <- "Shared_Probes"


shared_probes_0.7 <- data.frame(matrix(0, ncol=5, nrow=5))
rownames(shared_probes_0.7) <- c("T1", "T2", "T3", "T4", "T5")
colnames(shared_probes_0.7) <- c("T1", "T2", "T3", "T4", "T5")
shared_probes_0.7[1,1] <- dim(probes1_0.7)[1]/dim(probes1_0.7)[1]
shared_probes_0.7[2,2] <- dim(probes2_0.7)[1]/dim(probes2_0.7)[1]
shared_probes_0.7[3,3] <- dim(probes3_0.7)[1]/dim(probes3_0.7)[1]
shared_probes_0.7[4,4] <- dim(probes4_0.7)[1]/dim(probes4_0.7)[1]
shared_probes_0.7[5,5] <- dim(probes5_0.7)[1]/dim(probes5_0.7)[1]
shared_probes_0.7[1,2:5] <- c(dim(probes_0.7_12_df)[1]/dim(probes2_0.7)[1], dim(probes_0.7_13_df)[1]/dim(probes3_0.7)[1], dim(probes_0.7_14_df)[1]/dim(probes4_0.7)[1], 
                              dim(probes_0.7_15_df)[1]/dim(probes5_0.7)[1])
shared_probes_0.7[2,3] <- dim(probes_0.7_23_df)[1]/dim(probes2_0.7)[1]
shared_probes_0.7[2,4] <- dim(probes_0.7_24_df)[1]/dim(probes4_0.7)[1]
shared_probes_0.7[2,5] <- dim(probes_0.7_25_df)[1]/dim(probes5_0.7)[1]
shared_probes_0.7[3,4] <- dim(probes_0.7_34_df)[1]/dim(probes3_0.7)[1]
shared_probes_0.7[3,5] <- dim(probes_0.7_35_df)[1]/dim(probes5_0.7)[1]
shared_probes_0.7[4,5] <- dim(probes_0.7_45_df)[1]/dim(probes5_0.7)[1]

shared_probes_0.7_matrix <- as.matrix(shared_probes_0.7)
shared_probes_0.7_matrix_sym <- forceSymmetric(shared_probes_0.7_matrix)
shared_probes_0.7_matrix_sym <- as.matrix(shared_probes_0.7_matrix_sym)
df4 <- as.data.frame(shared_probes_0.7_matrix_sym)
write.table(df4, "shared_probes_2x2_0.7.txt", row.names=T, col.names=T, quote=F)


# All the probes from models across train/test splits with cor >= 0.6 on test data


#1st Split
models1_0.6 <- table1[table1$Correlation >= 0.6,]
for (i in 1:nrow(models1_0.6)){
rownames(models1_0.6)[i] <- paste("Model", rownames(models1_0.6)[i])
}
probes1_0.6 <- probes_model1[probes_model1$Probes_Model %in% rownames(models1_0.6),]

#2nd Split
models2_0.6 <- table2[table2$Correlation >= 0.6,]
for (i in 1:nrow(models2_0.6)){
rownames(models2_0.6)[i] <- paste("Model", rownames(models2_0.6)[i])
}
probes2_0.6 <- probes_model2[probes_model2$Probes_Model %in% rownames(models2_0.6),]

#3th Split
models3_0.6 <- table3[table3$Correlation >= 0.6,]
for (i in 1:nrow(models3_0.6)){
rownames(models3_0.6)[i] <- paste("Model", rownames(models3_0.6)[i])
}
probes3_0.6 <- probes_model3[probes_model3$Probes_Model %in% rownames(models3_0.6),]

#4th Split
models4_0.6 <- table4[table4$Correlation >= 0.6,]
for (i in 1:nrow(models4_0.6)){
rownames(models4_0.6)[i] <- paste("Model", rownames(models4_0.6)[i])
}
probes4_0.6 <- probes_model4[probes_model4$Probes_Model %in% rownames(models4_0.6),]

#5th Split
models5_0.6 <- table5[table5$Correlation >= 0.6,]
for (i in 1:nrow(models5_0.6)){
rownames(models5_0.6)[i] <- paste("Model", rownames(models5_0.6)[i])
}
probes5_0.6 <- probes_model5[probes_model5$Probes_Model %in% rownames(models5_0.6),]


# Models with cor >= 0.6


shared_probes_0.6_12 <- list(probes1_0.6["Selected_Probes"], probes2_0.6["Selected_Probes"])
probes_0.6_12 <- shared_probes_0.6_12 %>% reduce(inner_join, by='Selected_Probes')
probes_0.6_12_df <- as.data.frame(probes_0.6_12)
colnames(probes_0.6_12_df) <- "Shared_Probes"

shared_probes_0.6_13 <- list(probes1_0.6["Selected_Probes"], probes3_0.6["Selected_Probes"])
probes_0.6_13 <- shared_probes_0.6_13 %>% reduce(inner_join, by='Selected_Probes')
probes_0.6_13_df <- as.data.frame(probes_0.6_13)
colnames(probes_0.6_13_df) <- "Shared_Probes"

shared_probes_0.6_14 <- list(probes1_0.6["Selected_Probes"], probes4_0.6["Selected_Probes"])
probes_0.6_14 <- shared_probes_0.6_14 %>% reduce(inner_join, by='Selected_Probes')
probes_0.6_14_df <- as.data.frame(probes_0.6_14)
colnames(probes_0.6_14_df) <- "Shared_Probes"

shared_probes_0.6_15 <- list(probes1_0.6["Selected_Probes"], probes5_0.6["Selected_Probes"])
probes_0.6_15 <- shared_probes_0.6_15 %>% reduce(inner_join, by='Selected_Probes')
probes_0.6_15_df <- as.data.frame(probes_0.6_15)
colnames(probes_0.6_15_df) <- "Shared_Probes"

shared_probes_0.6_23 <- list(probes2_0.6["Selected_Probes"], probes3_0.6["Selected_Probes"])
probes_0.6_23 <- shared_probes_0.6_23 %>% reduce(inner_join, by='Selected_Probes')
probes_0.6_23_df <- as.data.frame(probes_0.6_23)
colnames(probes_0.6_23_df) <- "Shared_Probes"

shared_probes_0.6_24 <- list(probes2_0.6["Selected_Probes"], probes4_0.6["Selected_Probes"])
probes_0.6_24 <- shared_probes_0.6_24 %>% reduce(inner_join, by='Selected_Probes')
probes_0.6_24_df <- as.data.frame(probes_0.6_24)
colnames(probes_0.6_24_df) <- "Shared_Probes"

shared_probes_0.6_25 <- list(probes2_0.6["Selected_Probes"], probes5_0.6["Selected_Probes"])
probes_0.6_25 <- shared_probes_0.6_25 %>% reduce(inner_join, by='Selected_Probes')
probes_0.6_25_df <- as.data.frame(probes_0.6_25)
colnames(probes_0.6_25_df) <- "Shared_Probes"

shared_probes_0.6_34 <- list(probes3_0.6["Selected_Probes"], probes4_0.6["Selected_Probes"])
probes_0.6_34 <- shared_probes_0.6_34 %>% reduce(inner_join, by='Selected_Probes')
probes_0.6_34_df <- as.data.frame(probes_0.6_34)
colnames(probes_0.6_34_df) <- "Shared_Probes"

shared_probes_0.6_35 <- list(probes3_0.6["Selected_Probes"], probes5_0.6["Selected_Probes"])
probes_0.6_35 <- shared_probes_0.6_35 %>% reduce(inner_join, by='Selected_Probes')
probes_0.6_35_df <- as.data.frame(probes_0.6_35)
colnames(probes_0.6_35_df) <- "Shared_Probes"

shared_probes_0.6_45 <- list(probes4_0.6["Selected_Probes"], probes5_0.6["Selected_Probes"])
probes_0.6_45 <- shared_probes_0.6_45 %>% reduce(inner_join, by='Selected_Probes')
probes_0.6_45_df <- as.data.frame(probes_0.6_45)
colnames(probes_0.6_45_df) <- "Shared_Probes"


shared_probes_0.6 <- data.frame(matrix(0, ncol=5, nrow=5))
rownames(shared_probes_0.6) <- c("T1", "T2", "T3", "T4", "T5")
colnames(shared_probes_0.6) <- c("T1", "T2", "T3", "T4", "T5")
shared_probes_0.6[1,1] <- dim(probes1_0.6)[1]/dim(probes1_0.6)[1]
shared_probes_0.6[2,2] <- dim(probes2_0.6)[1]/dim(probes2_0.6)[1]
shared_probes_0.6[3,3] <- dim(probes3_0.6)[1]/dim(probes3_0.6)[1]
shared_probes_0.6[4,4] <- dim(probes4_0.6)[1]/dim(probes4_0.6)[1]
shared_probes_0.6[5,5] <- dim(probes5_0.6)[1]/dim(probes5_0.6)[1]
shared_probes_0.6[1,2:5] <- c(dim(probes_0.6_12_df)[1]/dim(probes1_0.6)[1], dim(probes_0.6_13_df)[1]/dim(probes3_0.6)[1], dim(probes_0.6_14_df)[1]/dim(probes4_0.6)[1], 
                              dim(probes_0.6_15_df)[1]/dim(probes5_0.6)[1])
shared_probes_0.6[2,3] <- dim(probes_0.6_23_df)[1]/dim(probes3_0.6)[1]
shared_probes_0.6[2,4] <- dim(probes_0.6_24_df)[1]/dim(probes4_0.6)[1]
shared_probes_0.6[2,5] <- dim(probes_0.6_25_df)[1]/dim(probes5_0.6)[1]
shared_probes_0.6[3,4] <- dim(probes_0.6_34_df)[1]/dim(probes3_0.6)[1]
shared_probes_0.6[3,5] <- dim(probes_0.6_35_df)[1]/dim(probes5_0.6)[1]
shared_probes_0.6[4,5] <- dim(probes_0.6_45_df)[1]/dim(probes5_0.6)[1]

shared_probes_0.6_matrix <- as.matrix(shared_probes_0.6)
shared_probes_0.6_matrix_sym <- forceSymmetric(shared_probes_0.6_matrix)
shared_probes_0.6_matrix_sym <- as.matrix(shared_probes_0.6_matrix_sym)
df5 <- as.data.frame(shared_probes_0.6_matrix_sym)







df_boxplot <- data.frame(matrix(0,nrow=50, ncol=2))
colnames(df_boxplot) <- c("Overlap_Proportion", "Criteria")
                         
# Model 1
i = 0
for (row in 1:nrow(df1)){
        for (col in 1:ncol(df1)){
                if (col > row){
                        i = i + 1
                        df_boxplot[i,"Overlap_Proportion"] <- df1[row,col]
                        df_boxplot[i,"Criteria"] <- "Model 1"
                }
        }
}

# cor >= 0.9
i = 10
for (row in 1:nrow(df2)){
        for (col in 1:ncol(df2)){
                if (col > row){
                        i = i + 1
                        df_boxplot[i,"Overlap_Proportion"] <- df2[row,col]
                        df_boxplot[i,"Criteria"] <- "Models_0.9"
                }
        }
}

# cor >= 0.8
i = 20
for (row in 1:nrow(df3)){
        for (col in 1:ncol(df3)){
                if (col > row){
                        i = i + 1
                        df_boxplot[i,"Overlap_Proportion"] <- df3[row,col]
                        df_boxplot[i,"Criteria"] <- "Models_0.8"
                }
        }
}

# cor >= 0.7
i = 30
for (row in 1:nrow(df4)){
        for (col in 1:ncol(df4)){
                if (col > row){
                        i = i + 1
                        df_boxplot[i,"Overlap_Proportion"] <- df4[row,col]
                        df_boxplot[i,"Criteria"] <- "Models_0.7"
                }
        }
}

# cor >= 0.6
i = 40
for (row in 1:nrow(df5)){
        for (col in 1:ncol(df5)){
                if (col > row){
                        i = i + 1
                        df_boxplot[i,"Overlap_Proportion"] <- df5[row,col]
                        df_boxplot[i,"Criteria"] <- "Models_0.6"
                }
        }
}


boxplot(df_boxplot$Overlap_Proportion ~ df_boxplot$Criteria, xlab="Model_Criteria", ylab="Proportion of probe overlap", col="steelblue")














