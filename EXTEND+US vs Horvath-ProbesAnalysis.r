#!/usr/bin/env Rscript

source("/mnt/data1/EXTEND/Methylation/QC/Theo/EXTEND+US-ProbesAnalysis.r")

horvath_probes <- read.table("/mnt/data1/EXTEND/Methylation/QC/Theo/CpGs Horvath Clock.txt")
colnames(horvath_probes) <- "Selected_Probes"

library(tidyverse)

# Shared Probes between Model 1 from Split 1 and Horvath clock
shared_horvath_mod1_s1 <- list(pbs_model1_best["Selected_Probes"], horvath_probes["Selected_Probes"]) 
probes_Mod1_horvath_s1 <- shared_horvath_mod1_s1 %>% reduce(inner_join, by='Selected_Probes')
probes_Mod1_horvath_s1_df <- as.data.frame(probes_Mod1_horvath_s1)
colnames(probes_Mod1_horvath_s1_df) <- "Shared_Probes"

# Shared Probes between Model 1 from Split 2 and Horvath clock
shared_horvath_mod1_s2 <- list(pbs_model2_best["Selected_Probes"], horvath_probes["Selected_Probes"])
probes_Mod1_horvath_s2 <- shared_horvath_mod1_s2 %>% reduce(inner_join, by='Selected_Probes')
probes_Mod1_horvath_s2_df <- as.data.frame(probes_Mod1_horvath_s2)
colnames(probes_Mod1_horvath_s2_df) <- "Shared_Probes"

# Shared Probes between Model 1 from Split 3 and Horvath clock
shared_horvath_mod1_s3 <- list(pbs_model3_best["Selected_Probes"], horvath_probes["Selected_Probes"])
probes_Mod1_horvath_s3 <- shared_horvath_mod1_s3 %>% reduce(inner_join, by='Selected_Probes')
probes_Mod1_horvath_s3_df <- as.data.frame(probes_Mod1_horvath_s3)
colnames(probes_Mod1_horvath_s3_df) <- "Shared_Probes"

# Shared Probes between Model 1 from Split 4 and Horvath clock
shared_horvath_mod1_s4 <- list(pbs_model4_best["Selected_Probes"], horvath_probes["Selected_Probes"])
probes_Mod1_horvath_s4 <- shared_horvath_mod1_s4 %>% reduce(inner_join, by='Selected_Probes')
probes_Mod1_horvath_s4_df <- as.data.frame(probes_Mod1_horvath_s4)
colnames(probes_Mod1_horvath_s4_df) <- "Shared_Probes"

# Shared Probes between Model 1 from Split5 and Horvath Clock
shared_horvath_mod1_s5 <- list(pbs_model5_best["Selected_Probes"], horvath_probes["Selected_Probes"])
probes_Mod1_horvath_s5 <- shared_horvath_mod1_s5 %>% reduce(inner_join, by='Selected_Probes')
probes_Mod1_horvath_s5_df <- as.data.frame(probes_Mod1_horvath_s5)
colnames(probes_Mod1_horvath_s5_df) <- "Shared_Probes"



# Shared Probes between Models with cor >= 0.9 from Split 1 and Horvath clock
shared_horvath_0.9_s1 <- list(probes1_0.9["Selected_Probes"], horvath_probes["Selected_Probes"])
probes_0.9_horvath_s1 <- shared_horvath_0.9_s1  %>% reduce(inner_join, by='Selected_Probes')
probes_0.9_horvath_s1_df <- as.data.frame(probes_0.9_horvath_s1)
colnames(probes_0.9_horvath_s1_df) <- "Shared_Probes"


# Shared Probes between Models with cor >= 0.9 from Split 2 and Horvath clock
shared_horvath_0.9_s2 <- list(probes2_0.9["Selected_Probes"], horvath_probes["Selected_Probes"])
probes_0.9_horvath_s2 <- shared_horvath_0.9_s2  %>% reduce(inner_join, by='Selected_Probes')
probes_0.9_horvath_s2_df <- as.data.frame(probes_0.9_horvath_s2)
colnames(probes_0.9_horvath_s2_df) <- "Shared_Probes"

# Shared Probes between Models with cor >= 0.9 from Split 3 and Horvath clock
shared_horvath_0.9_s3 <- list(probes3_0.9["Selected_Probes"], horvath_probes["Selected_Probes"])
probes_0.9_horvath_s3 <- shared_horvath_0.9_s3  %>% reduce(inner_join, by='Selected_Probes')
probes_0.9_horvath_s3_df <- as.data.frame(probes_0.9_horvath_s3)
colnames(probes_0.9_horvath_s3_df) <- "Shared_Probes"

# Shared Probes between Models with cor >= 0.9 from Split 4 and Horvath clock
shared_horvath_0.9_s4 <- list(probes4_0.9["Selected_Probes"], horvath_probes["Selected_Probes"])
probes_0.9_horvath_s4 <- shared_horvath_0.9_s4  %>% reduce(inner_join, by='Selected_Probes')
probes_0.9_horvath_s4_df <- as.data.frame(probes_0.9_horvath_s4)
colnames(probes_0.9_horvath_s4_df) <- "Shared_Probes"

# Shared Probes between Models with cor >= 0.9 from Split 5 and Horvath clock
shared_horvath_0.9_s5 <- list(probes5_0.9["Selected_Probes"], horvath_probes["Selected_Probes"])
probes_0.9_horvath_s5 <- shared_horvath_0.9_s5  %>% reduce(inner_join, by='Selected_Probes')
probes_0.9_horvath_s5_df <- as.data.frame(probes_0.9_horvath_s5)
colnames(probes_0.9_horvath_s5_df) <- "Shared_Probes"


# Shared Probes between Models with cor >= 0.8 from Split 1 and Horvath clock
shared_horvath_0.8_s1 <- list(probes1_0.8["Selected_Probes"], horvath_probes["Selected_Probes"])
probes_0.8_horvath_s1 <- shared_horvath_0.8_s1  %>% reduce(inner_join, by='Selected_Probes')
probes_0.8_horvath_s1_df <- as.data.frame(probes_0.8_horvath_s1)
colnames(probes_0.8_horvath_s1_df) <- "Shared_Probes"

# Shared Probes between Models with cor >= 0.8 from Split 2 and Horvath clock
shared_horvath_0.8_s2 <- list(probes2_0.8["Selected_Probes"], horvath_probes["Selected_Probes"])
probes_0.8_horvath_s2 <- shared_horvath_0.8_s2  %>% reduce(inner_join, by='Selected_Probes')
probes_0.8_horvath_s2_df <- as.data.frame(probes_0.8_horvath_s2)
colnames(probes_0.8_horvath_s2_df) <- "Shared_Probes"

# Shared Probes between Models with cor >= 0.8 from Split 3 and Horvath clock
shared_horvath_0.8_s3 <- list(probes3_0.8["Selected_Probes"], horvath_probes["Selected_Probes"])
probes_0.8_horvath_s3 <- shared_horvath_0.8_s3  %>% reduce(inner_join, by='Selected_Probes')
probes_0.8_horvath_s3_df <- as.data.frame(probes_0.8_horvath_s3)
colnames(probes_0.8_horvath_s3_df) <- "Shared_Probes"

# Shared Probes between Models with cor >= 0.8 from Split 4 and Horvath clock
shared_horvath_0.8_s4 <- list(probes4_0.8["Selected_Probes"], horvath_probes["Selected_Probes"])
probes_0.8_horvath_s4 <- shared_horvath_0.8_s4  %>% reduce(inner_join, by='Selected_Probes')
probes_0.8_horvath_s4_df <- as.data.frame(probes_0.8_horvath_s4)
colnames(probes_0.8_horvath_s4_df) <- "Shared_Probes"

# Shared Probes between Models with cor >= 0.8 from Split 5 and Horvath clock
shared_horvath_0.8_s5 <- list(probes5_0.8["Selected_Probes"], horvath_probes["Selected_Probes"])
probes_0.8_horvath_s5 <- shared_horvath_0.8_s5  %>% reduce(inner_join, by='Selected_Probes')
probes_0.8_horvath_s5_df <- as.data.frame(probes_0.8_horvath_s5)
colnames(probes_0.8_horvath_s5_df) <- "Shared_Probes"

n_probes_summary <- data.frame(matrix(0, nrow=5, ncol=3))
rownames(n_probes_summary) <- c("Split1", "Split2", "Split3", "Split4", "Split5")
colnames(n_probes_summary) <- c("shared_mod1", "shared_0.9", "shared_0.8")
n_probes_summary[1,] <- c(4, 47, 139)
n_probes_summary[2,] <- c(3, 45, 145)
n_probes_summary[3,] <- c(5, 49, 149)
n_probes_summary[4,] <- c(7, 41, 141)
n_probes_summary[5,] <- c(7, 58, 146)


prop_probes_summary <- data.frame(matrix(0, nrow=5, ncol=3))
rownames(prop_probes_summary) <- c("Split1", "Split2", "Split3", "Split4", "Split5")
colnames(prop_probes_summary) <- c("shared_mod1", "shared_0.9", "shared_0.8")
prop_probes_summary[1,] <- c(0.0029, 0.0038, 0.0011)
prop_probes_summary[2,] <- c(0.0021, 0.0036, 0.0010)
prop_probes_summary[3,] <- c(0.0036, 0.0034, 0.0010)
prop_probes_summary[4,] <- c(0.0051, 0.0034, 0.0012)
prop_probes_summary[5,] <- c(0.0050, 0.0040, 0.0011)



