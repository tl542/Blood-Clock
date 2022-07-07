#!/usr/bin/env Rscript

source("/mnt/data1/EXTEND/Methylation/QC/Theo/RScript_sourcing.r")
rs("/mnt/data1/EXTEND/Methylation/QC/Theo/RScript_EXTEND+US.r", to=75)
source("/mnt/data1/EXTEND/Methylation/QC/Theo/EXTEND+US-ProbesAnalysis.r")

# Get the 353 Cpgs from Horvath Clock (with Illumina 450K and Illumina 27K)
horvath_probes <- read.table("/mnt/data1/EXTEND/Methylation/QC/Theo/CpGs Horvath Clock.txt")
colnames(horvath_probes) <- "Selected_Probes"

# Get the 333 CpGs sites where methylation was measure by the EPIC array from our study
library(data.table)
copy_horvath <- copy(horvath_probes)
rownames(copy_horvath) <- copy_horvath$Selected_Probes
match <- which(colnames(train_all) %in% rownames(copy_horvath))
new_train_all <- train_all[,match]
horvath_probes <- data.frame(colnames(new_train_all))
colnames(horvath_probes) <- "Selected_Probes"


# Model 1

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


# cor >= 0.9

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

# cor >= 0.8

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

# cor >= 0.7

# Shared Probes between Models with cor >= 0.7 from Split 1 and Horvath clock
shared_horvath_0.7_s1 <- list(probes1_0.7["Selected_Probes"], horvath_probes["Selected_Probes"])
probes_0.7_horvath_s1 <- shared_horvath_0.7_s1  %>% reduce(inner_join, by='Selected_Probes')
probes_0.7_horvath_s1_df <- as.data.frame(probes_0.7_horvath_s1)
colnames(probes_0.7_horvath_s1_df) <- "Shared_Probes"

# Shared Probes between Models with cor >= 0.7 from Split 2 and Horvath clock
shared_horvath_0.7_s2 <- list(probes2_0.7["Selected_Probes"], horvath_probes["Selected_Probes"])
probes_0.7_horvath_s2 <- shared_horvath_0.7_s2  %>% reduce(inner_join, by='Selected_Probes')
probes_0.7_horvath_s2_df <- as.data.frame(probes_0.7_horvath_s2)
colnames(probes_0.7_horvath_s2_df) <- "Shared_Probes"

# Shared Probes between Models with cor >= 0.7 from Split 3 and Horvath clock
shared_horvath_0.7_s3 <- list(probes3_0.7["Selected_Probes"], horvath_probes["Selected_Probes"])
probes_0.7_horvath_s3 <- shared_horvath_0.7_s3  %>% reduce(inner_join, by='Selected_Probes')
probes_0.7_horvath_s3_df <- as.data.frame(probes_0.7_horvath_s3)
colnames(probes_0.7_horvath_s3_df) <- "Shared_Probes"

# Shared Probes between Models with cor >= 0.7 from Split 4 and Horvath clock
shared_horvath_0.7_s4 <- list(probes4_0.7["Selected_Probes"], horvath_probes["Selected_Probes"])
probes_0.7_horvath_s4 <- shared_horvath_0.7_s4  %>% reduce(inner_join, by='Selected_Probes')
probes_0.7_horvath_s4_df <- as.data.frame(probes_0.7_horvath_s4)
colnames(probes_0.7_horvath_s4_df) <- "Shared_Probes"

# Shared Probes between Models with cor >= 0.7 from Split 5 and Horvath clock
shared_horvath_0.7_s5 <- list(probes5_0.7["Selected_Probes"], horvath_probes["Selected_Probes"])
probes_0.7_horvath_s5 <- shared_horvath_0.7_s5  %>% reduce(inner_join, by='Selected_Probes')
probes_0.7_horvath_s5_df <- as.data.frame(probes_0.7_horvath_s5)
colnames(probes_0.7_horvath_s5_df) <- "Shared_Probes"

# cor >= 0.6

# Shared Probes between Models with cor >= 0.6 from Split 1 and Horvath clock
shared_horvath_0.6_s1 <- list(probes1_0.6["Selected_Probes"], horvath_probes["Selected_Probes"])
probes_0.6_horvath_s1 <- shared_horvath_0.6_s1  %>% reduce(inner_join, by='Selected_Probes')
probes_0.6_horvath_s1_df <- as.data.frame(probes_0.6_horvath_s1)
colnames(probes_0.6_horvath_s1_df) <- "Shared_Probes"

# Shared Probes between Models with cor >= 0.6 from Split 2 and Horvath clock
shared_horvath_0.6_s2 <- list(probes2_0.6["Selected_Probes"], horvath_probes["Selected_Probes"])
probes_0.6_horvath_s2 <- shared_horvath_0.6_s2  %>% reduce(inner_join, by='Selected_Probes')
probes_0.6_horvath_s2_df <- as.data.frame(probes_0.6_horvath_s2)
colnames(probes_0.6_horvath_s2_df) <- "Shared_Probes"

# Shared Probes between Models with cor >= 0.6 from Split 3 and Horvath clock
shared_horvath_0.6_s3 <- list(probes3_0.6["Selected_Probes"], horvath_probes["Selected_Probes"])
probes_0.6_horvath_s3 <- shared_horvath_0.6_s3  %>% reduce(inner_join, by='Selected_Probes')
probes_0.6_horvath_s3_df <- as.data.frame(probes_0.6_horvath_s3)
colnames(probes_0.6_horvath_s3_df) <- "Shared_Probes"

# Shared Probes between Models with cor >= 0.6 from Split 4 and Horvath clock
shared_horvath_0.6_s4 <- list(probes4_0.6["Selected_Probes"], horvath_probes["Selected_Probes"])
probes_0.6_horvath_s4 <- shared_horvath_0.6_s4  %>% reduce(inner_join, by='Selected_Probes')
probes_0.6_horvath_s4_df <- as.data.frame(probes_0.6_horvath_s4)
colnames(probes_0.6_horvath_s4_df) <- "Shared_Probes"

# Shared Probes between Models with cor >= 0.6 from Split 5 and Horvath clock
shared_horvath_0.6_s5 <- list(probes5_0.6["Selected_Probes"], horvath_probes["Selected_Probes"])
probes_0.6_horvath_s5 <- shared_horvath_0.6_s5  %>% reduce(inner_join, by='Selected_Probes')
probes_0.6_horvath_s5_df <- as.data.frame(probes_0.6_horvath_s5)
colnames(probes_0.6_horvath_s5_df) <- "Shared_Probes"

prop_probes_summary <- data.frame(matrix(0, nrow=5, ncol=5))
rownames(prop_probes_summary) <- c("T1", "T2", "T3", "T4", "T5")
colnames(prop_probes_summary) <- c("Overlap_Mod1_Horvath", "Overlap_0.9_Horvath", "Overlap_0.8_Horvath", "Overlap_0.7_Horvath", "Overlap_0.6_Horvath")
prop_probes_summary[1,] <- c(dim(probes_Mod1_horvath_s1_df)[1]/dim(horvath_probes)[1], dim(probes_0.9_horvath_s1_df)[1]/dim(horvath_probes)[1],
                             dim(probes_0.8_horvath_s1_df)[1]/dim(horvath_probes)[1], dim(probes_0.7_horvath_s1_df)[1]/dim(horvath_probes)[1], 
                             dim(probes_0.6_horvath_s1_df)[1]/dim(horvath_probes)[1])

prop_probes_summary[2,] <- c(dim(probes_Mod1_horvath_s2_df)[1]/dim(horvath_probes)[1], dim(probes_0.9_horvath_s2_df)[1]/dim(horvath_probes)[1],
                             dim(probes_0.8_horvath_s2_df)[1]/dim(horvath_probes)[1], dim(probes_0.7_horvath_s2_df)[1]/dim(horvath_probes)[1],
                             dim(probes_0.6_horvath_s2_df)[1]/dim(horvath_probes)[1])

prop_probes_summary[3,] <- c(dim(probes_Mod1_horvath_s3_df)[1]/dim(horvath_probes)[1], dim(probes_0.9_horvath_s3_df)[1]/dim(horvath_probes)[1],
                             dim(probes_0.8_horvath_s3_df)[1]/dim(horvath_probes)[1], dim(probes_0.7_horvath_s3_df)[1]/dim(horvath_probes)[1],
                             dim(probes_0.6_horvath_s3_df)[1]/dim(horvath_probes)[1])

prop_probes_summary[4,] <- c(dim(probes_Mod1_horvath_s4_df)[1]/dim(horvath_probes)[1], dim(probes_0.9_horvath_s4_df)[1]/dim(horvath_probes)[1],
                             dim(probes_0.8_horvath_s4_df)[1]/dim(horvath_probes)[1], dim(probes_0.7_horvath_s4_df)[1]/dim(horvath_probes)[1],
                             dim(probes_0.6_horvath_s4_df)[1]/dim(horvath_probes)[1])

prop_probes_summary[5,] <- c(dim(probes_Mod1_horvath_s5_df)[1]/dim(horvath_probes)[1], dim(probes_0.9_horvath_s5_df)[1]/dim(horvath_probes)[1],
                             dim(probes_0.8_horvath_s5_df)[1]/dim(horvath_probes)[1], dim(probes_0.7_horvath_s5_df)[1]/dim(horvath_probes)[1],
                             dim(probes_0.6_horvath_s5_df)[1]/dim(horvath_probes)[1])

write.table(prop_probes_summary, "shared_probes_horvath_summary(prop).txt", row.names=T, col.names=T, quote=F)

horvath_boxplot <- data.frame(matrix(0, nrow=25, ncol=2))
colnames(horvath_boxplot) <- c("Overlap_Proportion", "Model_Criteria")
horvath_boxplot[1:5,"Overlap_Proportion"] <- prop_probes_summary$Overlap_Mod1_Horvath
horvath_boxplot[1:5,"Model_Criteria"] <- "Model 1"
horvath_boxplot[6:10,"Overlap_Proportion"] <- prop_probes_summary$Overlap_0.9_Horvath
horvath_boxplot[6:10,"Model_Criteria"] <- "Models_0.9"
horvath_boxplot[11:15,"Overlap_Proportion"] <- prop_probes_summary$Overlap_0.8_Horvath
horvath_boxplot[11:15,"Model_Criteria"] <- "Models_0.8"
horvath_boxplot[16:20,"Overlap_Proportion"] <- prop_probes_summary$Overlap_0.7_Horvath
horvath_boxplot[16:20,"Model_Criteria"] <- "Models_0.7"
horvath_boxplot[21:25,"Overlap_Proportion"] <- prop_probes_summary$Overlap_0.6_Horvath
horvath_boxplot[21:25,"Model_Criteria"] <- "Models_0.6"


boxplot(horvath_boxplot$Overlap_Proportion ~ horvath_boxplot$Model_Criteria, xlab="Model_Criteria", ylab="Proportion of probe overlap", col="steelblue")
dev.copy("boxplot_horvath", pdf)
dev.off()

