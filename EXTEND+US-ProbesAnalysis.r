#!/usr/bin/env Rscript

## First Part

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



# All the probes from Model 1 ("best" model) across train/test splits
pbs_model1_best <- probes_model1[probes_model1$Probes_Model == "Model 1",]
pbs_model2_best <- probes_model2[probes_model2$Probes_Model == "Model 1",]
pbs_model3_best <- probes_model3[probes_model3$Probes_Model == "Model 1",]
pbs_model4_best <- probes_model4[probes_model4$Probes_Model == "Model 1",]
pbs_model5_best <- probes_model5[probes_model5$Probes_Model == "Model 1",]

## Second Part

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
shared_probes_Mod1[1,1] <- 1005
shared_probes_Mod1[2,2] <- 1049
shared_probes_Mod1[3,3] <- 1021
shared_probes_Mod1[4,4] <- 1010
shared_probes_Mod1[5,5] <- 1029
shared_probes_Mod1[1,2:5] <- c(dim(probes_Mod1_12_df)[1], dim(probes_Mod1_13_df)[1], dim(probes_Mod1_14_df)[1], dim(probes_Mod1_15_df)[1])
shared_probes_Mod1[2,3] <- dim(probes_Mod1_23_df)[1]
shared_probes_Mod1[2,4] <- dim(probes_Mod1_24_df)[1]
shared_probes_Mod1[2,5] <- dim(probes_Mod1_25_df)[1]
shared_probes_Mod1[3,4] <- dim(probes_Mod1_34_df)[1]
shared_probes_Mod1[3,5] <- dim(probes_Mod1_35_df)[1]
shared_probes_Mod1[4,5] <- dim(probes_Mod1_45_df)[1]

shared_probes_Mod1_matrix <- as.matrix(shared_probes_Mod1)
library(Matrix)
shared_probes_Mod1_matrix_sym <- forceSymmetric(shared_probes_Mod1_matrix)
shared_probes_Mod1_matrix_sym <- as.matrix(shared_probes_Mod1_matrix_sym)
df1 <- as.data.frame(shared_probes_Mod1_matrix_sym)

                    
                        
                       
                        
                        

