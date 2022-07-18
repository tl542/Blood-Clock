

hannum_probes <- read.table("/mnt/data1/EXTEND/Methylation/QC/Theo/Hannum Clock CpGs.txt")
colnames(hannum_probes) <- "Selected_Probes"

# Get the 333 CpGs sites where methylation was measure by the EPIC array from our study
#library(data.table)
#copy_Hannum <- copy(Hannum_probes)
#rownames(copy_Hannum) <- copy_Hannum$Selected_Probes
#match <- which(colnames(train_all) %in% rownames(copy_Hannum))
#new_train_all <- train_all[,match]
#Hannum_probes <- data.frame(colnames(new_train_all))
#colnames(Hannum_probes) <- "Selected_Probes"


# Overlap between Hannum Clock and Model 1 - Five splits

# Shared Probes between Model 1 from Split 1 and Hannum clock
library(tidyverse)
shared_Hannum_mod1_s1 <- list(pbs_model1_best["Selected_Probes"], Hannum_probes["Selected_Probes"]) 
probes_Mod1_Hannum_s1 <- shared_Hannum_mod1_s1 %>% reduce(inner_join, by='Selected_Probes')
probes_Mod1_Hannum_s1_df <- as.data.frame(probes_Mod1_Hannum_s1)
colnames(probes_Mod1_Hannum_s1_df) <- "Shared_Probes"

# Shared Probes between Model 1 from Split 2 and Hannum clock
shared_Hannum_mod1_s2 <- list(pbs_model2_best["Selected_Probes"], Hannum_probes["Selected_Probes"])
probes_Mod1_Hannum_s2 <- shared_Hannum_mod1_s2 %>% reduce(inner_join, by='Selected_Probes')
probes_Mod1_Hannum_s2_df <- as.data.frame(probes_Mod1_Hannum_s2)
colnames(probes_Mod1_Hannum_s2_df) <- "Shared_Probes"

# Shared Probes between Model 1 from Split 3 and Hannum clock
shared_Hannum_mod1_s3 <- list(pbs_model3_best["Selected_Probes"], Hannum_probes["Selected_Probes"])
probes_Mod1_Hannum_s3 <- shared_Hannum_mod1_s3 %>% reduce(inner_join, by='Selected_Probes')
probes_Mod1_Hannum_s3_df <- as.data.frame(probes_Mod1_Hannum_s3)
colnames(probes_Mod1_Hannum_s3_df) <- "Shared_Probes"

# Shared Probes between Model 1 from Split 4 and Hannum clock
shared_Hannum_mod1_s4 <- list(pbs_model4_best["Selected_Probes"], Hannum_probes["Selected_Probes"])
probes_Mod1_Hannum_s4 <- shared_Hannum_mod1_s4 %>% reduce(inner_join, by='Selected_Probes')
probes_Mod1_Hannum_s4_df <- as.data.frame(probes_Mod1_Hannum_s4)
colnames(probes_Mod1_Hannum_s4_df) <- "Shared_Probes"

# Shared Probes between Model 1 from Split5 and Hannum Clock
shared_Hannum_mod1_s5 <- list(pbs_model5_best["Selected_Probes"], Hannum_probes["Selected_Probes"])
probes_Mod1_Hannum_s5 <- shared_Hannum_mod1_s5 %>% reduce(inner_join, by='Selected_Probes')
probes_Mod1_Hannum_s5_df <- as.data.frame(probes_Mod1_Hannum_s5)
colnames(probes_Mod1_Hannum_s5_df) <- "Shared_Probes"


# Overlap between Hannum Clock and Models with cor >= 0.9 - Five Splits

# Shared Probes between Models with cor >= 0.9 from Split 1 and Hannum clock
shared_Hannum_0.9_s1 <- list(probes1_0.9["Selected_Probes"], Hannum_probes["Selected_Probes"])
probes_0.9_Hannum_s1 <- shared_Hannum_0.9_s1  %>% reduce(inner_join, by='Selected_Probes')
probes_0.9_Hannum_s1_df <- as.data.frame(probes_0.9_Hannum_s1)
colnames(probes_0.9_Hannum_s1_df) <- "Shared_Probes"


# Shared Probes between Models with cor >= 0.9 from Split 2 and Hannum clock
shared_Hannum_0.9_s2 <- list(probes2_0.9["Selected_Probes"], Hannum_probes["Selected_Probes"])
probes_0.9_Hannum_s2 <- shared_Hannum_0.9_s2  %>% reduce(inner_join, by='Selected_Probes')
probes_0.9_Hannum_s2_df <- as.data.frame(probes_0.9_Hannum_s2)
colnames(probes_0.9_Hannum_s2_df) <- "Shared_Probes"

# Shared Probes between Models with cor >= 0.9 from Split 3 and Hannum clock
shared_Hannum_0.9_s3 <- list(probes3_0.9["Selected_Probes"], Hannum_probes["Selected_Probes"])
probes_0.9_Hannum_s3 <- shared_Hannum_0.9_s3  %>% reduce(inner_join, by='Selected_Probes')
probes_0.9_Hannum_s3_df <- as.data.frame(probes_0.9_Hannum_s3)
colnames(probes_0.9_Hannum_s3_df) <- "Shared_Probes"

# Shared Probes between Models with cor >= 0.9 from Split 4 and Hannum clock
shared_Hannum_0.9_s4 <- list(probes4_0.9["Selected_Probes"], Hannum_probes["Selected_Probes"])
probes_0.9_Hannum_s4 <- shared_Hannum_0.9_s4  %>% reduce(inner_join, by='Selected_Probes')
probes_0.9_Hannum_s4_df <- as.data.frame(probes_0.9_Hannum_s4)
colnames(probes_0.9_Hannum_s4_df) <- "Shared_Probes"

# Shared Probes between Models with cor >= 0.9 from Split 5 and Hannum clock
shared_Hannum_0.9_s5 <- list(probes5_0.9["Selected_Probes"], Hannum_probes["Selected_Probes"])
probes_0.9_Hannum_s5 <- shared_Hannum_0.9_s5  %>% reduce(inner_join, by='Selected_Probes')
probes_0.9_Hannum_s5_df <- as.data.frame(probes_0.9_Hannum_s5)
colnames(probes_0.9_Hannum_s5_df) <- "Shared_Probes"


# Overlap between Hannum Clock and Models with cor >= 0.8 - Five Splits

# Shared Probes between Models with cor >= 0.8 from Split 1 and Hannum clock
shared_Hannum_0.8_s1 <- list(probes1_0.8["Selected_Probes"], Hannum_probes["Selected_Probes"])
probes_0.8_Hannum_s1 <- shared_Hannum_0.8_s1  %>% reduce(inner_join, by='Selected_Probes')
probes_0.8_Hannum_s1_df <- as.data.frame(probes_0.8_Hannum_s1)
colnames(probes_0.8_Hannum_s1_df) <- "Shared_Probes"

# Shared Probes between Models with cor >= 0.8 from Split 2 and Hannum clock
shared_Hannum_0.8_s2 <- list(probes2_0.8["Selected_Probes"], Hannum_probes["Selected_Probes"])
probes_0.8_Hannum_s2 <- shared_Hannum_0.8_s2  %>% reduce(inner_join, by='Selected_Probes')
probes_0.8_Hannum_s2_df <- as.data.frame(probes_0.8_Hannum_s2)
colnames(probes_0.8_Hannum_s2_df) <- "Shared_Probes"

# Shared Probes between Models with cor >= 0.8 from Split 3 and Hannum clock
shared_Hannum_0.8_s3 <- list(probes3_0.8["Selected_Probes"], Hannum_probes["Selected_Probes"])
probes_0.8_Hannum_s3 <- shared_Hannum_0.8_s3  %>% reduce(inner_join, by='Selected_Probes')
probes_0.8_Hannum_s3_df <- as.data.frame(probes_0.8_Hannum_s3)
colnames(probes_0.8_Hannum_s3_df) <- "Shared_Probes"

# Shared Probes between Models with cor >= 0.8 from Split 4 and Hannum clock
shared_Hannum_0.8_s4 <- list(probes4_0.8["Selected_Probes"], Hannum_probes["Selected_Probes"])
probes_0.8_Hannum_s4 <- shared_Hannum_0.8_s4  %>% reduce(inner_join, by='Selected_Probes')
probes_0.8_Hannum_s4_df <- as.data.frame(probes_0.8_Hannum_s4)
colnames(probes_0.8_Hannum_s4_df) <- "Shared_Probes"

# Shared Probes between Models with cor >= 0.8 from Split 5 and Hannum clock
shared_Hannum_0.8_s5 <- list(probes5_0.8["Selected_Probes"], Hannum_probes["Selected_Probes"])
probes_0.8_Hannum_s5 <- shared_Hannum_0.8_s5  %>% reduce(inner_join, by='Selected_Probes')
probes_0.8_Hannum_s5_df <- as.data.frame(probes_0.8_Hannum_s5)
colnames(probes_0.8_Hannum_s5_df) <- "Shared_Probes"

# Overlap between Hannum Clock and Models with cor >= 0.7 - Five Splits

# Shared Probes between Models with cor >= 0.7 from Split 1 and Hannum clock
shared_Hannum_0.7_s1 <- list(probes1_0.7["Selected_Probes"], Hannum_probes["Selected_Probes"])
probes_0.7_Hannum_s1 <- shared_Hannum_0.7_s1  %>% reduce(inner_join, by='Selected_Probes')
probes_0.7_Hannum_s1_df <- as.data.frame(probes_0.7_Hannum_s1)
colnames(probes_0.7_Hannum_s1_df) <- "Shared_Probes"

# Shared Probes between Models with cor >= 0.7 from Split 2 and Hannum clock
shared_Hannum_0.7_s2 <- list(probes2_0.7["Selected_Probes"], Hannum_probes["Selected_Probes"])
probes_0.7_Hannum_s2 <- shared_Hannum_0.7_s2  %>% reduce(inner_join, by='Selected_Probes')
probes_0.7_Hannum_s2_df <- as.data.frame(probes_0.7_Hannum_s2)
colnames(probes_0.7_Hannum_s2_df) <- "Shared_Probes"

# Shared Probes between Models with cor >= 0.7 from Split 3 and Hannum clock
shared_Hannum_0.7_s3 <- list(probes3_0.7["Selected_Probes"], Hannum_probes["Selected_Probes"])
probes_0.7_Hannum_s3 <- shared_Hannum_0.7_s3  %>% reduce(inner_join, by='Selected_Probes')
probes_0.7_Hannum_s3_df <- as.data.frame(probes_0.7_Hannum_s3)
colnames(probes_0.7_Hannum_s3_df) <- "Shared_Probes"

# Shared Probes between Models with cor >= 0.7 from Split 4 and Hannum clock
shared_Hannum_0.7_s4 <- list(probes4_0.7["Selected_Probes"], Hannum_probes["Selected_Probes"])
probes_0.7_Hannum_s4 <- shared_Hannum_0.7_s4  %>% reduce(inner_join, by='Selected_Probes')
probes_0.7_Hannum_s4_df <- as.data.frame(probes_0.7_Hannum_s4)
colnames(probes_0.7_Hannum_s4_df) <- "Shared_Probes"

# Shared Probes between Models with cor >= 0.7 from Split 5 and Hannum clock
shared_Hannum_0.7_s5 <- list(probes5_0.7["Selected_Probes"], Hannum_probes["Selected_Probes"])
probes_0.7_Hannum_s5 <- shared_Hannum_0.7_s5  %>% reduce(inner_join, by='Selected_Probes')
probes_0.7_Hannum_s5_df <- as.data.frame(probes_0.7_Hannum_s5)
colnames(probes_0.7_Hannum_s5_df) <- "Shared_Probes"

# Overlap between Hannum Clock and Models with cor >= 0.6 - Five Splits

# Shared Probes between Models with cor >= 0.6 from Split 1 and Hannum clock
shared_Hannum_0.6_s1 <- list(probes1_0.6["Selected_Probes"], Hannum_probes["Selected_Probes"])
probes_0.6_Hannum_s1 <- shared_Hannum_0.6_s1  %>% reduce(inner_join, by='Selected_Probes')
probes_0.6_Hannum_s1_df <- as.data.frame(probes_0.6_Hannum_s1)
colnames(probes_0.6_Hannum_s1_df) <- "Shared_Probes"

# Shared Probes between Models with cor >= 0.6 from Split 2 and Hannum clock
shared_Hannum_0.6_s2 <- list(probes2_0.6["Selected_Probes"], Hannum_probes["Selected_Probes"])
probes_0.6_Hannum_s2 <- shared_Hannum_0.6_s2  %>% reduce(inner_join, by='Selected_Probes')
probes_0.6_Hannum_s2_df <- as.data.frame(probes_0.6_Hannum_s2)
colnames(probes_0.6_Hannum_s2_df) <- "Shared_Probes"

# Shared Probes between Models with cor >= 0.6 from Split 3 and Hannum clock
shared_Hannum_0.6_s3 <- list(probes3_0.6["Selected_Probes"], Hannum_probes["Selected_Probes"])
probes_0.6_Hannum_s3 <- shared_Hannum_0.6_s3  %>% reduce(inner_join, by='Selected_Probes')
probes_0.6_Hannum_s3_df <- as.data.frame(probes_0.6_Hannum_s3)
colnames(probes_0.6_Hannum_s3_df) <- "Shared_Probes"

# Shared Probes between Models with cor >= 0.6 from Split 4 and Hannum clock
shared_Hannum_0.6_s4 <- list(probes4_0.6["Selected_Probes"], Hannum_probes["Selected_Probes"])
probes_0.6_Hannum_s4 <- shared_Hannum_0.6_s4  %>% reduce(inner_join, by='Selected_Probes')
probes_0.6_Hannum_s4_df <- as.data.frame(probes_0.6_Hannum_s4)
colnames(probes_0.6_Hannum_s4_df) <- "Shared_Probes"

# Shared Probes between Models with cor >= 0.6 from Split 5 and Hannum clock
shared_Hannum_0.6_s5 <- list(probes5_0.6["Selected_Probes"], Hannum_probes["Selected_Probes"])
probes_0.6_Hannum_s5 <- shared_Hannum_0.6_s5  %>% reduce(inner_join, by='Selected_Probes')
probes_0.6_Hannum_s5_df <- as.data.frame(probes_0.6_Hannum_s5)
colnames(probes_0.6_Hannum_s5_df) <- "Shared_Probes"


# Overlap between Hannum Clock and Models with cor >= 0.5 - Five Splits

# Shared Probes between Models with cor >= 0.5 from Split 1 and Hannum clock
shared_Hannum_0.5_s1 <- list(probes1_0.5["Selected_Probes"], Hannum_probes["Selected_Probes"])
probes_0.5_Hannum_s1 <- shared_Hannum_0.5_s1  %>% reduce(inner_join, by='Selected_Probes')
probes_0.5_Hannum_s1_df <- as.data.frame(probes_0.5_Hannum_s1)
colnames(probes_0.5_Hannum_s1_df) <- "Shared_Probes"

# Shared Probes between Models with cor >= 0.5 from Split 2 and Hannum clock
shared_Hannum_0.5_s2 <- list(probes2_0.5["Selected_Probes"], Hannum_probes["Selected_Probes"])
probes_0.5_Hannum_s2 <- shared_Hannum_0.5_s2  %>% reduce(inner_join, by='Selected_Probes')
probes_0.5_Hannum_s2_df <- as.data.frame(probes_0.5_Hannum_s2)
colnames(probes_0.5_Hannum_s2_df) <- "Shared_Probes"

# Shared Probes between Models with cor >= 0.5 from Split 3 and Hannum clock
shared_Hannum_0.5_s3 <- list(probes3_0.5["Selected_Probes"], Hannum_probes["Selected_Probes"])
probes_0.5_Hannum_s3 <- shared_Hannum_0.5_s3  %>% reduce(inner_join, by='Selected_Probes')
probes_0.5_Hannum_s3_df <- as.data.frame(probes_0.5_Hannum_s3)
colnames(probes_0.5_Hannum_s3_df) <- "Shared_Probes"

# Shared Probes between Models with cor >= 0.5 from Split 4 and Hannum clock
shared_Hannum_0.5_s4 <- list(probes4_0.5["Selected_Probes"], Hannum_probes["Selected_Probes"])
probes_0.5_Hannum_s4 <- shared_Hannum_0.5_s4  %>% reduce(inner_join, by='Selected_Probes')
probes_0.5_Hannum_s4_df <- as.data.frame(probes_0.5_Hannum_s4)
colnames(probes_0.5_Hannum_s4_df) <- "Shared_Probes"

# Shared Probes between Models with cor >= 0.5 from Split 5 and Hannum clock
shared_Hannum_0.5_s5 <- list(probes5_0.5["Selected_Probes"], Hannum_probes["Selected_Probes"])
probes_0.5_Hannum_s5 <- shared_Hannum_0.5_s5  %>% reduce(inner_join, by='Selected_Probes')
probes_0.5_Hannum_s5_df <- as.data.frame(probes_0.5_Hannum_s5)
colnames(probes_0.5_Hannum_s5_df) <- "Shared_Probes"



# Overlap between Hannum Clock and Models with cor >= 0.4 - Five Splits

# Shared Probes between Models with cor >= 0.4 from Split 1 and Hannum clock
shared_Hannum_0.4_s1 <- list(probes1_0.4["Selected_Probes"], Hannum_probes["Selected_Probes"])
probes_0.4_Hannum_s1 <- shared_Hannum_0.4_s1  %>% reduce(inner_join, by='Selected_Probes')
probes_0.4_Hannum_s1_df <- as.data.frame(probes_0.4_Hannum_s1)
colnames(probes_0.4_Hannum_s1_df) <- "Shared_Probes"

# Shared Probes between Models with cor >= 0.4 from Split 2 and Hannum clock
shared_Hannum_0.4_s2 <- list(probes2_0.4["Selected_Probes"], Hannum_probes["Selected_Probes"])
probes_0.4_Hannum_s2 <- shared_Hannum_0.4_s2  %>% reduce(inner_join, by='Selected_Probes')
probes_0.4_Hannum_s2_df <- as.data.frame(probes_0.4_Hannum_s2)
colnames(probes_0.4_Hannum_s2_df) <- "Shared_Probes"

# Shared Probes between Models with cor >= 0.4 from Split 3 and Hannum clock
shared_Hannum_0.4_s3 <- list(probes3_0.4["Selected_Probes"], Hannum_probes["Selected_Probes"])
probes_0.4_Hannum_s3 <- shared_Hannum_0.4_s3  %>% reduce(inner_join, by='Selected_Probes')
probes_0.4_Hannum_s3_df <- as.data.frame(probes_0.4_Hannum_s3)
colnames(probes_0.4_Hannum_s3_df) <- "Shared_Probes"

# Shared Probes between Models with cor >= 0.4 from Split 4 and Hannum clock
shared_Hannum_0.4_s4 <- list(probes4_0.4["Selected_Probes"], Hannum_probes["Selected_Probes"])
probes_0.4_Hannum_s4 <- shared_Hannum_0.4_s4  %>% reduce(inner_join, by='Selected_Probes')
probes_0.4_Hannum_s4_df <- as.data.frame(probes_0.4_Hannum_s4)
colnames(probes_0.4_Hannum_s4_df) <- "Shared_Probes"

# Shared Probes between Models with cor >= 0.4 from Split 5 and Hannum clock
shared_Hannum_0.4_s5 <- list(probes5_0.4["Selected_Probes"], Hannum_probes["Selected_Probes"])
probes_0.4_Hannum_s5 <- shared_Hannum_0.4_s5  %>% reduce(inner_join, by='Selected_Probes')
probes_0.4_Hannum_s5_df <- as.data.frame(probes_0.4_Hannum_s5)
colnames(probes_0.4_Hannum_s5_df) <- "Shared_Probes"




# Store the whole in df 

prop_probes_summary <- data.frame(matrix(0, nrow=5, ncol=7))
rownames(prop_probes_summary) <- c("T1", "T2", "T3", "T4", "T5")
colnames(prop_probes_summary) <- c("Overlap_Mod1_Hannum", "Overlap_0.9_Hannum", "Overlap_0.8_Hannum", "Overlap_0.7_Hannum", "Overlap_0.6_Hannum", "Overlap_0.5_Hannum",
                                   "Overlap_0.4_Hannum")
prop_probes_summary[1,] <- c(dim(probes_Mod1_Hannum_s1_df)[1]/dim(Hannum_probes)[1], dim(probes_0.9_Hannum_s1_df)[1]/dim(Hannum_probes)[1],
                             dim(probes_0.8_Hannum_s1_df)[1]/dim(Hannum_probes)[1], dim(probes_0.7_Hannum_s1_df)[1]/dim(Hannum_probes)[1], 
                             dim(probes_0.6_Hannum_s1_df)[1]/dim(Hannum_probes)[1], dim(probes_0.5_Hannum_s1_df)[1]/dim(Hannum_probes)[1],
                             dim(probes_0.4_Hannum_s1_df)[1]/dim(Hannum_probes)[1])

prop_probes_summary[2,] <- c(dim(probes_Mod1_Hannum_s2_df)[1]/dim(Hannum_probes)[1], dim(probes_0.9_Hannum_s2_df)[1]/dim(Hannum_probes)[1],
                             dim(probes_0.8_Hannum_s2_df)[1]/dim(Hannum_probes)[1], dim(probes_0.7_Hannum_s2_df)[1]/dim(Hannum_probes)[1],
                             dim(probes_0.6_Hannum_s2_df)[1]/dim(Hannum_probes)[1], dim(probes_0.5_Hannum_s1_df)[1]/dim(Hannum_probes)[1],
                             dim(probes_0.4_Hannum_s2_df)[1]/dim(Hannum_probes)[1])

prop_probes_summary[3,] <- c(dim(probes_Mod1_Hannum_s3_df)[1]/dim(Hannum_probes)[1], dim(probes_0.9_Hannum_s3_df)[1]/dim(Hannum_probes)[1],
                             dim(probes_0.8_Hannum_s3_df)[1]/dim(Hannum_probes)[1], dim(probes_0.7_Hannum_s3_df)[1]/dim(Hannum_probes)[1],
                             dim(probes_0.6_Hannum_s3_df)[1]/dim(Hannum_probes)[1], dim(probes_0.5_Hannum_s1_df)[1]/dim(Hannum_probes)[1],
                             dim(probes_0.4_Hannum_s3_df)[1]/dim(Hannum_probes)[1])

prop_probes_summary[4,] <- c(dim(probes_Mod1_Hannum_s4_df)[1]/dim(Hannum_probes)[1], dim(probes_0.9_Hannum_s4_df)[1]/dim(Hannum_probes)[1],
                             dim(probes_0.8_Hannum_s4_df)[1]/dim(Hannum_probes)[1], dim(probes_0.7_Hannum_s4_df)[1]/dim(Hannum_probes)[1],
                             dim(probes_0.6_Hannum_s4_df)[1]/dim(Hannum_probes)[1], dim(probes_0.5_Hannum_s1_df)[1]/dim(Hannum_probes)[1],
                             dim(probes_0.4_Hannum_s4_df)[1]/dim(Hannum_probes)[1])

prop_probes_summary[5,] <- c(dim(probes_Mod1_Hannum_s5_df)[1]/dim(Hannum_probes)[1], dim(probes_0.9_Hannum_s5_df)[1]/dim(Hannum_probes)[1],
                             dim(probes_0.8_Hannum_s5_df)[1]/dim(Hannum_probes)[1], dim(probes_0.7_Hannum_s5_df)[1]/dim(Hannum_probes)[1],
                             dim(probes_0.6_Hannum_s5_df)[1]/dim(Hannum_probes)[1], dim(probes_0.5_Hannum_s1_df)[1]/dim(Hannum_probes)[1],
                             dim(probes_0.4_Hannum_s5_df)[1]/dim(Hannum_probes)[1])

write.table(prop_probes_summary, "shared_probes_Hannum_summary(prop).txt", row.names=T, col.names=T, quote=F)


# Boxplot for Hannum/Current Study probe overlap

Hannum_boxplot <- data.frame(matrix(0, nrow=35, ncol=2))
colnames(Hannum_boxplot) <- c("Overlap_Proportion", "Model_Criteria")
Hannum_boxplot[1:5,"Overlap_Proportion"] <- prop_probes_summary$Overlap_Mod1_Hannum
Hannum_boxplot[1:5,"Model_Criteria"] <- "Model 1"
Hannum_boxplot[6:10,"Overlap_Proportion"] <- prop_probes_summary$Overlap_0.9_Hannum
Hannum_boxplot[6:10,"Model_Criteria"] <- "Models_0.9"
Hannum_boxplot[11:15,"Overlap_Proportion"] <- prop_probes_summary$Overlap_0.8_Hannum
Hannum_boxplot[11:15,"Model_Criteria"] <- "Models_0.8"
Hannum_boxplot[16:20,"Overlap_Proportion"] <- prop_probes_summary$Overlap_0.7_Hannum
Hannum_boxplot[16:20,"Model_Criteria"] <- "Models_0.7"
Hannum_boxplot[21:25,"Overlap_Proportion"] <- prop_probes_summary$Overlap_0.6_Hannum
Hannum_boxplot[21:25,"Model_Criteria"] <- "Models_0.6"
Hannum_boxplot[26:30,"Overlap_Proportion"] <- prop_probes_summary$Overlap_0.5_Hannum
Hannum_boxplot[26:30,"Model_Criteria"] <- "Models_0.5"
Hannum_boxplot[31:35,"Overlap_Proportion"] <- prop_probes_summary$Overlap_0.4_Hannum
Hannum_boxplot[31:35,"Model_Criteria"] <- "Models_0.4"



Hannum_boxplot$Model_Criteria <- factor(Hannum_boxplot$Model_Criteria, c("Model 1", "Models_0.9", "Models_0.8", "Models_0.7", "Models_0.6", "Models_0.5", "Models_0.4"))
par(bg="aliceblue")
boxplot(Hannum_boxplot$Overlap_Proportion ~ Hannum_boxplot$Model_Criteria, xlab="Model_Criteria", ylab="Proportion of probe overlap", col="steelblue", main="Proportion of Hannum clock probes overlapping with study probes")
dev.copy(pdf, "boxplot_Hannum.pdf")
dev.off()


# Average magnitude of the coefs

probes_coef_split1 <- read.table("/mnt/data1/EXTEND/Methylation/QC/Theo/probes_coef (Split 1).txt", sep= " ")
probes_coef_split1$Probes_model <- paste(probes_coef_split1$Coef, probes_coef_split1$Probes_Model)
probes_coef_split1 <- probes_coef_split1[,c(1,2,5)]
colnames(probes_coef_split1)[1:2] <- c("Selected_Probes", "Coef")

probes_coef_split2 <- read.table("/mnt/data1/EXTEND/Methylation/QC/Theo/probes_coef (Split 2).txt", sep= " ")
probes_coef_split2$Probes_model <- paste(probes_coef_split2$Coef, probes_coef_split2$Probes_Model)
probes_coef_split2 <- probes_coef_split2[,c(1,2,5)]
colnames(probes_coef_split2)[1:2] <- c("Selected_Probes", "Coef")

probes_coef_split3 <- read.table("/mnt/data1/EXTEND/Methylation/QC/Theo/probes_coef (Split 3).txt", sep= " ")
probes_coef_split3$Probes_model <- paste(probes_coef_split3$Coef, probes_coef_split3$Probes_Model)
probes_coef_split3 <- probes_coef_split3[,c(1,2,5)]
colnames(probes_coef_split3)[1:2] <- c("Selected_Probes", "Coef")

probes_coef_split4 <- read.table("/mnt/data1/EXTEND/Methylation/QC/Theo/probes_coef (Split 4).txt", sep= " ")
probes_coef_split4$Probes_model <- paste(probes_coef_split4$Coef, probes_coef_split4$Probes_Model)
probes_coef_split4 <- probes_coef_split4[,c(1,2,5)]
colnames(probes_coef_split4)[1:2] <- c("Selected_Probes", "Coef")

probes_coef_split5 <- read.table("/mnt/data1/EXTEND/Methylation/QC/Theo/probes_coef (Split 5).txt", sep= " ")
probes_coef_split5$Probes_model <- paste(probes_coef_split5$Coef, probes_coef_split5$Probes_Model)
probes_coef_split5 <- probes_coef_split5[,c(1,2,5)]
colnames(probes_coef_split5)[1:2] <- c("Selected_Probes", "Coef")


# Average magnitude of probe coefficients overlapping with Hannum clock probes

library(data.table)

# Split 1
probes_Mod1_Hannum_s1_df_copy <- copy(probes_Mod1_Hannum_s1_df)
colnames(probes_Mod1_Hannum_s1_df_copy) <- "Selected_Probes"
coefs_shared_probes_Mod1_Hannum_s1 <- merge(probes_Mod1_Hannum_s1_df_copy, probes_coef_split1, by="Selected_Probes")

probes_0.9_Hannum_s1_df_copy <- copy(probes_0.9_Hannum_s1_df)
colnames(probes_0.9_Hannum_s1_df_copy) <- "Selected_Probes"
coefs_shared_probes_0.9_Hannum_s1 <- merge(probes_0.9_Hannum_s1_df_copy, probes_coef_split1, by="Selected_Probes")

probes_0.8_Hannum_s1_df_copy <- copy(probes_0.8_Hannum_s1_df)
colnames(probes_0.8_Hannum_s1_df_copy) <- "Selected_Probes"
coefs_shared_probes_0.8_Hannum_s1 <- merge(probes_0.8_Hannum_s1_df_copy, probes_coef_split1, by="Selected_Probes")

probes_0.7_Hannum_s1_df_copy <- copy(probes_0.7_Hannum_s1_df)
colnames(probes_0.7_Hannum_s1_df_copy) <- "Selected_Probes"
coefs_shared_probes_0.7_Hannum_s1 <- merge(probes_0.7_Hannum_s1_df_copy, probes_coef_split1, by="Selected_Probes")

probes_0.6_Hannum_s1_df_copy <- copy(probes_0.6_Hannum_s1_df)
colnames(probes_0.6_Hannum_s1_df_copy) <- "Selected_Probes"
coefs_shared_probes_0.6_Hannum_s1 <- merge(probes_0.6_Hannum_s1_df_copy, probes_coef_split1, by="Selected_Probes")

probes_0.5_Hannum_s1_df_copy <- copy(probes_0.5_Hannum_s1_df)
colnames(probes_0.5_Hannum_s1_df_copy) <- "Selected_Probes"
coefs_shared_probes_0.5_Hannum_s1 <- merge(probes_0.5_Hannum_s1_df_copy, probes_coef_split1, by="Selected_Probes")

probes_0.4_Hannum_s1_df_copy <- copy(probes_0.4_Hannum_s1_df)
colnames(probes_0.4_Hannum_s1_df_copy) <- "Selected_Probes"
coefs_shared_probes_0.4_Hannum_s1 <- merge(probes_0.4_Hannum_s1_df_copy, probes_coef_split1, by="Selected_Probes")



coefs_s1 <- data.frame(matrix(0, nrow=7, ncol=2))
colnames(coefs_s1) <- c("Average_Coefs", "Model_Criteria")
coefs_s1$Average_Coefs <- c(mean(coefs_shared_probes_Mod1_Hannum_s1$Coef), mean(coefs_shared_probes_0.9_Hannum_s1$Coef), mean(coefs_shared_probes_0.8_Hannum_s1$Coef),
                    mean(coefs_shared_probes_0.7_Hannum_s1$Coef), mean(coefs_shared_probes_0.6_Hannum_s1$Coef), mean(coefs_shared_probes_0.5_Hannum_s1$Coef),
                    mean(coefs_shared_probes_0.4_Hannum_s1$Coef))

coefs_s1$Model_Criteria[1] <- "Model 1"
threshold <- seq(1,0.4,by=-0.1)
for (i in 2:nrow(coefs_s1)){
  coefs_s1$Model_Criteria[i] <- paste("Models_",threshold[i],sep="")
}
  
# Split 2
probes_Mod1_Hannum_s2_df_copy <- copy(probes_Mod1_Hannum_s2_df)
colnames(probes_Mod1_Hannum_s2_df_copy) <- "Selected_Probes"
coefs_shared_probes_Mod1_Hannum_s2 <- merge(probes_Mod1_Hannum_s2_df_copy, probes_coef_split2, by="Selected_Probes")

probes_0.9_Hannum_s2_df_copy <- copy(probes_0.9_Hannum_s2_df)
colnames(probes_0.9_Hannum_s2_df_copy) <- "Selected_Probes"
coefs_shared_probes_0.9_Hannum_s2 <- merge(probes_0.9_Hannum_s2_df_copy, probes_coef_split2, by="Selected_Probes")

probes_0.8_Hannum_s2_df_copy <- copy(probes_0.8_Hannum_s2_df)
colnames(probes_0.8_Hannum_s2_df_copy) <- "Selected_Probes"
coefs_shared_probes_0.8_Hannum_s2 <- merge(probes_0.8_Hannum_s2_df_copy, probes_coef_split2, by="Selected_Probes")

probes_0.7_Hannum_s2_df_copy <- copy(probes_0.7_Hannum_s2_df)
colnames(probes_0.7_Hannum_s2_df_copy) <- "Selected_Probes"
coefs_shared_probes_0.7_Hannum_s2 <- merge(probes_0.7_Hannum_s2_df_copy, probes_coef_split2, by="Selected_Probes")

probes_0.6_Hannum_s2_df_copy <- copy(probes_0.6_Hannum_s2_df)
colnames(probes_0.6_Hannum_s2_df_copy) <- "Selected_Probes"
coefs_shared_probes_0.6_Hannum_s2 <- merge(probes_0.6_Hannum_s2_df_copy, probes_coef_split2, by="Selected_Probes")

probes_0.5_Hannum_s2_df_copy <- copy(probes_0.5_Hannum_s2_df)
colnames(probes_0.5_Hannum_s2_df_copy) <- "Selected_Probes"
coefs_shared_probes_0.5_Hannum_s2 <- merge(probes_0.5_Hannum_s2_df_copy, probes_coef_split2, by="Selected_Probes")

probes_0.4_Hannum_s2_df_copy <- copy(probes_0.4_Hannum_s2_df)
colnames(probes_0.4_Hannum_s2_df_copy) <- "Selected_Probes"
coefs_shared_probes_0.4_Hannum_s2 <- merge(probes_0.4_Hannum_s2_df_copy, probes_coef_split2, by="Selected_Probes")



coefs_s2 <- data.frame(matrix(0, nrow=7, ncol=2))
colnames(coefs_s2) <- c("Average_Coefs", "Model_Criteria")
coefs_s2$Average_Coefs <- c(mean(coefs_shared_probes_Mod1_Hannum_s2$Coef), mean(coefs_shared_probes_0.9_Hannum_s2$Coef), mean(coefs_shared_probes_0.8_Hannum_s2$Coef),
                    mean(coefs_shared_probes_0.7_Hannum_s2$Coef), mean(coefs_shared_probes_0.6_Hannum_s2$Coef), mean(coefs_shared_probes_0.5_Hannum_s2$Coef),
                    mean(coefs_shared_probes_0.4_Hannum_s2$Coef))

coefs_s2$Model_Criteria[1] <- "Model 1"
threshold <- seq(1,0.4,by=-0.1)
for (i in 2:nrow(coefs_s2)){
  coefs_s2$Model_Criteria[i] <- paste("Models_",threshold[i],sep="")
}
  

# Split 3
probes_Mod1_Hannum_s3_df_copy <- copy(probes_Mod1_Hannum_s3_df)
colnames(probes_Mod1_Hannum_s3_df_copy) <- "Selected_Probes"
coefs_shared_probes_Mod1_Hannum_s3 <- merge(probes_Mod1_Hannum_s3_df_copy, probes_coef_split3, by="Selected_Probes")

probes_0.9_Hannum_s3_df_copy <- copy(probes_0.9_Hannum_s3_df)
colnames(probes_0.9_Hannum_s3_df_copy) <- "Selected_Probes"
coefs_shared_probes_0.9_Hannum_s3 <- merge(probes_0.9_Hannum_s3_df_copy, probes_coef_split3, by="Selected_Probes")

probes_0.8_Hannum_s3_df_copy <- copy(probes_0.8_Hannum_s3_df)
colnames(probes_0.8_Hannum_s3_df_copy) <- "Selected_Probes"
coefs_shared_probes_0.8_Hannum_s3 <- merge(probes_0.8_Hannum_s3_df_copy, probes_coef_split3, by="Selected_Probes")

probes_0.7_Hannum_s3_df_copy <- copy(probes_0.7_Hannum_s3_df)
colnames(probes_0.7_Hannum_s3_df_copy) <- "Selected_Probes"
coefs_shared_probes_0.7_Hannum_s3 <- merge(probes_0.7_Hannum_s3_df_copy, probes_coef_split3, by="Selected_Probes")

probes_0.6_Hannum_s3_df_copy <- copy(probes_0.6_Hannum_s3_df)
colnames(probes_0.6_Hannum_s3_df_copy) <- "Selected_Probes"
coefs_shared_probes_0.6_Hannum_s3 <- merge(probes_0.6_Hannum_s3_df_copy, probes_coef_split3, by="Selected_Probes")

probes_0.5_Hannum_s3_df_copy <- copy(probes_0.5_Hannum_s3_df)
colnames(probes_0.5_Hannum_s3_df_copy) <- "Selected_Probes"
coefs_shared_probes_0.5_Hannum_s3 <- merge(probes_0.5_Hannum_s3_df_copy, probes_coef_split3, by="Selected_Probes")

probes_0.4_Hannum_s3_df_copy <- copy(probes_0.4_Hannum_s3_df)
colnames(probes_0.4_Hannum_s3_df_copy) <- "Selected_Probes"
coefs_shared_probes_0.4_Hannum_s3 <- merge(probes_0.4_Hannum_s3_df_copy, probes_coef_split3, by="Selected_Probes")



coefs_s3 <- data.frame(matrix(0, nrow=7, ncol=2))
colnames(coefs_s3) <- c("Average_Coefs", "Model_Criteria")
coefs_s3$Average_Coefs <- c(mean(coefs_shared_probes_Mod1_Hannum_s3$Coef), mean(coefs_shared_probes_0.9_Hannum_s3$Coef), mean(coefs_shared_probes_0.8_Hannum_s3$Coef),
                    mean(coefs_shared_probes_0.7_Hannum_s3$Coef), mean(coefs_shared_probes_0.6_Hannum_s3$Coef), mean(coefs_shared_probes_0.5_Hannum_s3$Coef),
                    mean(coefs_shared_probes_0.4_Hannum_s3$Coef))

coefs_s3$Model_Criteria[1] <- "Model 1"
threshold <- seq(1,0.4,by=-0.1)
for (i in 2:nrow(coefs_s3)){
  coefs_s3$Model_Criteria[i] <- paste("Models_",threshold[i],sep="")
}
  
  

# Split 4
probes_Mod1_Hannum_s4_df_copy <- copy(probes_Mod1_Hannum_s4_df)
colnames(probes_Mod1_Hannum_s4_df_copy) <- "Selected_Probes"
coefs_shared_probes_Mod1_Hannum_s4 <- merge(probes_Mod1_Hannum_s4_df_copy, probes_coef_split4, by="Selected_Probes")

probes_0.9_Hannum_s4_df_copy <- copy(probes_0.9_Hannum_s4_df)
colnames(probes_0.9_Hannum_s4_df_copy) <- "Selected_Probes"
coefs_shared_probes_0.9_Hannum_s4 <- merge(probes_0.9_Hannum_s4_df_copy, probes_coef_split4, by="Selected_Probes")

probes_0.8_Hannum_s4_df_copy <- copy(probes_0.8_Hannum_s4_df)
colnames(probes_0.8_Hannum_s4_df_copy) <- "Selected_Probes"
coefs_shared_probes_0.8_Hannum_s4 <- merge(probes_0.8_Hannum_s4_df_copy, probes_coef_split4, by="Selected_Probes")

probes_0.7_Hannum_s4_df_copy <- copy(probes_0.7_Hannum_s4_df)
colnames(probes_0.7_Hannum_s4_df_copy) <- "Selected_Probes"
coefs_shared_probes_0.7_Hannum_s4 <- merge(probes_0.7_Hannum_s4_df_copy, probes_coef_split4, by="Selected_Probes")

probes_0.6_Hannum_s4_df_copy <- copy(probes_0.6_Hannum_s4_df)
colnames(probes_0.6_Hannum_s4_df_copy) <- "Selected_Probes"
coefs_shared_probes_0.6_Hannum_s4 <- merge(probes_0.6_Hannum_s4_df_copy, probes_coef_split4, by="Selected_Probes")

probes_0.5_Hannum_s4_df_copy <- copy(probes_0.5_Hannum_s4_df)
colnames(probes_0.5_Hannum_s4_df_copy) <- "Selected_Probes"
coefs_shared_probes_0.5_Hannum_s4 <- merge(probes_0.5_Hannum_s4_df_copy, probes_coef_split4, by="Selected_Probes")

probes_0.4_Hannum_s4_df_copy <- copy(probes_0.4_Hannum_s4_df)
colnames(probes_0.4_Hannum_s4_df_copy) <- "Selected_Probes"
coefs_shared_probes_0.4_Hannum_s4 <- merge(probes_0.4_Hannum_s4_df_copy, probes_coef_split4, by="Selected_Probes")



coefs_s4 <- data.frame(matrix(0, nrow=7, ncol=2))
colnames(coefs_s4) <- c("Average_Coefs", "Model_Criteria")
coefs_s4$Average_Coefs <- c(mean(coefs_shared_probes_Mod1_Hannum_s4$Coef), mean(coefs_shared_probes_0.9_Hannum_s4$Coef), mean(coefs_shared_probes_0.8_Hannum_s4$Coef),
                    mean(coefs_shared_probes_0.7_Hannum_s4$Coef), mean(coefs_shared_probes_0.6_Hannum_s4$Coef), mean(coefs_shared_probes_0.5_Hannum_s4$Coef),
                    mean(coefs_shared_probes_0.4_Hannum_s4$Coef))

coefs_s4$Model_Criteria[1] <- "Model 1"
threshold <- seq(1,0.4,by=-0.1)
for (i in 2:nrow(coefs_s4)){
  coefs_s4$Model_Criteria[i] <- paste("Models_",threshold[i],sep="")
}
  
  
  
# Split 5
probes_Mod1_Hannum_s5_df_copy <- copy(probes_Mod1_Hannum_s5_df)
colnames(probes_Mod1_Hannum_s5_df_copy) <- "Selected_Probes"
coefs_shared_probes_Mod1_Hannum_s5 <- merge(probes_Mod1_Hannum_s5_df_copy, probes_coef_split5, by="Selected_Probes")

probes_0.9_Hannum_s5_df_copy <- copy(probes_0.9_Hannum_s5_df)
colnames(probes_0.9_Hannum_s5_df_copy) <- "Selected_Probes"
coefs_shared_probes_0.9_Hannum_s5 <- merge(probes_0.9_Hannum_s5_df_copy, probes_coef_split5, by="Selected_Probes")

probes_0.8_Hannum_s5_df_copy <- copy(probes_0.8_Hannum_s5_df)
colnames(probes_0.8_Hannum_s5_df_copy) <- "Selected_Probes"
coefs_shared_probes_0.8_Hannum_s5 <- merge(probes_0.8_Hannum_s5_df_copy, probes_coef_split5, by="Selected_Probes")

probes_0.7_Hannum_s5_df_copy <- copy(probes_0.7_Hannum_s5_df)
colnames(probes_0.7_Hannum_s5_df_copy) <- "Selected_Probes"
coefs_shared_probes_0.7_Hannum_s5 <- merge(probes_0.7_Hannum_s5_df_copy, probes_coef_split5, by="Selected_Probes")

probes_0.6_Hannum_s5_df_copy <- copy(probes_0.6_Hannum_s5_df)
colnames(probes_0.6_Hannum_s5_df_copy) <- "Selected_Probes"
coefs_shared_probes_0.6_Hannum_s5 <- merge(probes_0.6_Hannum_s5_df_copy, probes_coef_split5, by="Selected_Probes")

probes_0.5_Hannum_s5_df_copy <- copy(probes_0.5_Hannum_s5_df)
colnames(probes_0.5_Hannum_s5_df_copy) <- "Selected_Probes"
coefs_shared_probes_0.5_Hannum_s5 <- merge(probes_0.5_Hannum_s5_df_copy, probes_coef_split5, by="Selected_Probes")

probes_0.4_Hannum_s5_df_copy <- copy(probes_0.4_Hannum_s5_df)
colnames(probes_0.4_Hannum_s5_df_copy) <- "Selected_Probes"
coefs_shared_probes_0.4_Hannum_s5 <- merge(probes_0.4_Hannum_s5_df_copy, probes_coef_split5, by="Selected_Probes")



coefs_s5 <- data.frame(matrix(0, nrow=7, ncol=2))
colnames(coefs_s5) <- c("Average_Coefs", "Model_Criteria")
coefs_s5$Average_Coefs <- c(mean(coefs_shared_probes_Mod1_Hannum_s5$Coef), mean(coefs_shared_probes_0.9_Hannum_s5$Coef), mean(coefs_shared_probes_0.8_Hannum_s5$Coef),
                    mean(coefs_shared_probes_0.7_Hannum_s5$Coef), mean(coefs_shared_probes_0.6_Hannum_s5$Coef), mean(coefs_shared_probes_0.5_Hannum_s5$Coef),
                    mean(coefs_shared_probes_0.4_Hannum_s5$Coef))

coefs_s5$Model_Criteria[1] <- "Model 1"
threshold <- seq(1,0.4,by=-0.1)
for (i in 2:nrow(coefs_s5)){
  coefs_s5$Model_Criteria[i] <- paste("Models_",threshold[i],sep="")
}


  
  
coef_boxplot_df <- data.frame(matrix(0,nrow=35, ncol=2))
colnames(coef_boxplot_df)[1] <- "Average_Coefs"
colnames(coef_boxplot_df)[2]<- "Model_Criteria"
coef_boxplot_df[1:5,"Average_Coefs"] <- c(coefs_s1[1,"Average_Coefs"], coefs_s2[1,"Average_Coefs"], coefs_s3[1,"Average_Coefs"], coefs_s4[1,"Average_Coefs"], 
                                  coefs_s5[1,"Average_Coefs"])

coef_boxplot_df[1:5,"Model_Criteria"] <- "Model 1"

coef_boxplot_df[6:10,"Average_Coefs"] <- c(coefs_s1[2,"Average_Coefs"], coefs_s2[2,"Average_Coefs"], coefs_s3[2,"Average_Coefs"], coefs_s4[2,"Average_Coefs"], 
                                  coefs_s5[2,"Average_Coefs"])

coef_boxplot_df[6:10,"Model_Criteria"] <- "Models_0.9"

  
coef_boxplot_df[11:15,"Average_Coefs"] <- c(coefs_s1[3,"Average_Coefs"], coefs_s2[3,"Average_Coefs"], coefs_s3[3,"Average_Coefs"], coefs_s4[3,"Average_Coefs"], 
                                  coefs_s5[3,"Average_Coefs"])
  

coef_boxplot_df[11:15,"Model_Criteria"] <- "Models_0.8"  
  

coef_boxplot_df[16:20,"Average_Coefs"] <- c(coefs_s1[4,"Average_Coefs"], coefs_s2[4,"Average_Coefs"], coefs_s3[4,"Average_Coefs"], coefs_s4[4,"Average_Coefs"], 
                                  coefs_s5[4,"Average_Coefs"])
  
coef_boxplot_df[16:20,"Model_Criteria"] <- "Models_0.7" 
  
  
coef_boxplot_df[21:25,"Average_Coefs"] <- c(coefs_s1[5,"Average_Coefs"], coefs_s2[5,"Average_Coefs"], coefs_s3[5,"Average_Coefs"], coefs_s4[5,"Average_Coefs"], 
                                  coefs_s5[5,"Average_Coefs"])
  
coef_boxplot_df[21:25,"Model_Criteria"] <- "Models_0.6" 
  
  
coef_boxplot_df[26:30,"Average_Coefs"] <- c(coefs_s1[6,"Average_Coefs"], coefs_s2[6,"Average_Coefs"], coefs_s3[6,"Average_Coefs"], coefs_s4[6,"Average_Coefs"], 
                                  coefs_s5[6,"Average_Coefs"])
  
coef_boxplot_df[26:30,"Model_Criteria"] <- "Models_0.5"
 

coef_boxplot_df[31:35,"Average_Coefs"] <- c(coefs_s1[7,"Average_Coefs"], coefs_s2[7,"Average_Coefs"], coefs_s3[7,"Average_Coefs"], coefs_s4[7,"Average_Coefs"], 
                                  coefs_s5[7,"Average_Coefs"])
  
coef_boxplot_df[31:35,"Model_Criteria"] <- "Models_0.4"
write.table(coef_boxplot_df, "average_magnitude_coefs.txt", row.names=T, col.names=T, quote=F)

  
coef_boxplot_df$Model_Criteria <- factor(coef_boxplot_df$Model_Criteria, c("Model 1", "Models_0.9", "Models_0.8", "Models_0.7", "Models_0.6", "Models_0.5", "Models_0.4"))
par(bg="aliceblue")
boxplot(coef_boxplot_df$Average_Coefs ~ coef_boxplot_df$Model_Criteria, xlab="Model_Criteria", ylab="Average magnitude of coefficients", col="steelblue",
        main="Average coef magnitude for study probes/Hannum overlap")
dev.copy(pdf, "boxplot_coefs.pdf")
dev.off()
