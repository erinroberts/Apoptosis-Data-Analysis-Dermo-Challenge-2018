# Script to Rank Mortality Data from Dermo challenge 

# Load libraries for data processing
library(dplyr)
library(ggplot2)
library(cowplot)

MortDataQAed <- read.csv("../ANALYSIS_CSVs/MASTER_DATA/MortDataQAed.csv",header=TRUE, skip=2)

# Graphing with only families used for apoptosis 
FamCodes <- c("A","B","D","E","J","L")

MortDataQAed_Assay_Subset <- MortDataQAed %>% filter(Fam.Code %in% FamCodes)

head(MortDataQAed_Assay_Subset)

#Extract only those animals that died on their own during the experiment
  #aka exlude all morts that were Censored =Y or Notes=Survivor/CENSORED

MortDataQAed_Assay_Subset_morts <- MortDataQAed_Assay_Subset %>% filter(Cens..Y.N. == "N" & Notes=="whole body") 
MortDataQAed_Assay_Subset_morts_tally <- MortDataQAed_Assay_Subset_morts%>% count(Fam.Code, sort=TRUE)
mort_Data_apoptosis_subset <- ggplot(MortDataQAed_Assay_Subset_morts_tally, aes(x=Fam.Code, y=n)) + geom_col() + ylab("Number of Morts")+xlab("Family")+
  ggtitle("Number of Whole Body Morts Collected from Apoptosis Assay Families")+ scale_y_continuous(limits=c(0,20))

# Graphing for all families

MortDataQAed_Assay_morts <- MortDataQAed %>% filter(Cens..Y.N. == "N" & Notes=="whole body") 
MortDataQAed_Assay_morts_tally <- MortDataQAed_Assay_morts%>% count(Fam.Code, sort=TRUE)
mort_data_apoptosis_assay_all <-ggplot(MortDataQAed_Assay_morts_tally, aes(x=Fam.Code, y=n)) + geom_col() + ylab("Number of Morts")+xlab("Family")+
  ggtitle("Number of Whole Body Morts Collected from All Families")

# Put graphing in two panels
plot_grid(mort_Data_apoptosis_subset, mort_data_apoptosis_assay_all)

# Statistical Analysis (later)


