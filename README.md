The Exeter Ten Thousand (EXTEND) dataset
Description:
We generated DNAm data from whole blood obtained from 1,234 individuals included in the Exeter Ten Thousand Study (EXTEND).
EXTEND is a research biobank funded by the National Institute for Health Research (NIHR) and is a population study of >10,000 individuals >18 years of age who live within 25 miles of Exeter (Devon, UK).
For each participant, blood samples (either fasted or non-fasted) were collected through venipuncture; these were subsequently centrifuged to separate plasma and serum, and samples were aliquoted and frozen at -80°C.
The EZ-96 DNA Methylation-Gold kit (Zymo Research; Cat No# D5007) was used for treating 500 ng of DNA from each sample with sodium bisulfite.
DNAm data were generated using the Illumina EPIC DNA methylation array.
After stringent QC the EXTEND DNAm dataset consisted of data for 809,498 DNAm sites profiled in 1,234 samples (52% female; age range = 19-80 years; median age = 57 years; SD=11.68 years).
QC steps:
Raw data were used, prior to any QC or normalisation, and processed using the wateRmelon (Pidsley et al., 2013) package.
Our stringent QC pipeline included the following steps:
(1) checking methylated and unmethylated signal intensities and excluding poorly performing samples;
(2) assessing the chemistry of the experiment by calculating a bisulphite conversion statistic for each sample, excluding samples with a conversion rate <80%;
(3) identifying the fully methylated control sample was in the correct location;
(4) multidimensional scaling of sites on the X and Y chromosomes separately to confirm reported sex;
(5) using the 59 SNPs on the Illumina EPIC array to confirm that matched samples from the same individual were genetically identical and to check for sample duplications and mismatches;
(6) use of the pfilter() function in wateRmelon to exclude samples with >1 % of probes with a detection P value?>?0.05 and probes with >1 % of samples with detection P value? >?0.05;
(7) samples that were dramatically altered as a result of normalization were excluded on the basis of the difference between the normalized and raw data;
(8) the outlyx() function in the wateRmelon package was used to remove outliers – a data-driven outlier detection tool that uses dimensional reduction techniques to identify outliers according to two separate tests;
(9) removal of cross-hybridising and SNP probes (Chen et al., 2013). The subsequent normalisation of the DNA methylation data was performed using the dasen() function in either wateRmelon.
