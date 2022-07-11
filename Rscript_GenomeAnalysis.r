#!/usr/bin/env Rscript

source("/mnt/data1/EXTEND/Methylation/QC/Theo/RScript_sourcing.r")
rs("/mnt/data1/EXTEND/Methylation/QC/Theo/RScript_EXTEND+US.r", to=77)

epicManifest<-read.csv("/mnt/data1/EPIC_reference/MethylationEPIC_v-1-0_B2.csv", skip = 7)

df_final <- data.frame()
for (i in seq(1,22)){
probes_i <- epicManifest[epicManifest$Chromosome_36 == i, c("Name","Chromosome_36")]
df_final <- rbind(df_final, probes_i)
}

probes_1 <- df_final[df_final$Chromosome_36 == 1,]
probes_1 <- probes_1[1:2991,]
