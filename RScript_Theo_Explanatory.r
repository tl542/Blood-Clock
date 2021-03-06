#!/usr/bin/env Rscript
args = commandArgs(trailingOnly = TRUE)


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


# Train/Test split on the original DNAm df (1234 samples)
# Training Size: 864 and Test Size: 370
set.seed(123)
n <- nrow(new_df)
trainIndex <- sample(1:n, size=round(0.7*n), replace=FALSE)
train <- new_df[trainIndex,]
test <- new_df[-trainIndex,]
dim(train)
dim(test)

# Age distribution on original set + on training data from original set: Table + hist
table(new_df$Age)
table(train$Age)
#hist(new_df$Age, xlab="Age")
#hist(train$Age, xlab="Age")

# Two-sample t-test on Training data from original set
t.test(train$Age ~ train$Sex, mu=0, alt="two.sided", paired=FALSE, var.eq=FALSE)

# Two-sample t-test on original set
t.test(new_df$Age ~ new_df$Sex, mu=0, alt="two.sided", paired=FALSE, var.eq=FALSE)



# Restrict the original dataset down to samples aged less than 70 (1009)
new_df1 <- new_df[new_df$Age >= 40 & new_df$Age <= 70,]
# Train/Test split on the restricted data
# Training size: 706 and Test Size: 303
set.seed(123)
n <- nrow(new_df1)
trainIndex <- sample(1:n, size=round(0.7*n), replace=FALSE)
train1 <- new_df1[trainIndex,]
test1 <- new_df1[-trainIndex,]
dim(train1)
dim(test1)

# Age distribution on restricted set + training data from restricted set: Table + hist
table(new_df1$Age)
table(train1$Age)
#hist(new_df1$Age, xlab="Age")
#hist(train1$Age, xlab="Age")

# Two-sample t-test on Training data from restricted set
t.test(train1$Age ~ train1$Sex, mu=0, alt="two.sided", paired=FALSE, var.eq=FALSE)

# Two-sample t-test on restricted set
t.test(new_df1$Age ~ new_df1$Sex, mu=0, alt="two.sided", paired=FALSE, var.eq=FALSE)



