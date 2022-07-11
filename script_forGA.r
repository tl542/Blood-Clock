#!/usr/bin/env Rscript


# Load in the RData
data <- load("/mnt/data1/EXTEND/Methylation/QC/EXTEND_batch1_2_merged/EXTEND_batches_1_2_normalised_together.rdat")


# Transpose + Cast the DNA methylation data into DF
# Transpose the pheno data into DF
DNAm <- t(betas)
DNAm_df <- as.data.frame(DNAm)
pheno_df <- as.data.frame(pheno)


# Combine DNAm df with phenotypic Sex variable
new_df <- cbind(DNAm_df, pheno_df[,c("Sex","Age")])
colnames(new_df)[809499] <- "Sex"
colnames(new_df)[809500] <- "Age"



# Restrict the original dataset down to samples aged less than 70
new_df1 <- new_df[new_df$Age >= 40 & new_df$Age <= 70,]






load("/mnt/data1/EPICQC/UnderstandingSociety/US_Betas_Pheno.rda")
DNAm_us <- t(dat)
DNAm_df_us <- as.data.frame(DNAm_us)
pheno_df_us <- as.data.frame(pheno)
new_df_us <- cbind(DNAm_df_us, pheno_df_us[,c("nsex","confage")])
colnames(new_df_us)[857131] <- "Sex"
colnames(new_df_us)[857132] <- "Age"
new_df2_us <- new_df_us[new_df_us$Age >= 40 & new_df_us$Age <= 70,]
new_df2_us$Age <- as.integer(new_df2_us$Age)



new_df <- intersect(colnames(new_df1), colnames(new_df2_us))
new_df1 <- new_df1[,new_df]
new_df2_us <- new_df2_us[,new_df]
df_all <- rbind(new_df1, new_df2_us)
dim(df_all)
df_all <- df_all[,-803377]
