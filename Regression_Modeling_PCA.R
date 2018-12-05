# REGRESSION MODELING and PCA WITH MASTER DATA # 

# Load Libraries for use
#install.packages("betareg")
library(betareg)
#install.packages("emmeans")
library(emmeans)
#install.packages("lmtest")
library(lmtest)
library(dplyr)
library(DirechletReg)
library(tidyverse)
library(Rmisc)
install.packages("devtools")
library(devtools)
install_github("vqv/ggbiplot")
library(ggbiplot)

################### Loading in data ##############################################

Master_Data <- read.csv("../ANALYSIS_CSVs/MASTER_DATA/MasterData.csv",header=TRUE)
MortDataQAed <- read.csv("../ANALYSIS_CSVs/MASTER_DATA/MortDataQAed.csv",header=TRUE, skip=2)
PreExperimentData <- read.csv("../ANALYSIS_CSVs/MASTER_DATA/PreExperimentData.csv",header=TRUE, skip=2)

# QPCR data sheet was edited so that the first row was split into multiple rows and the FamCode was split by "-"
QPCRDataQAed_edited <- read.csv("../ANALYSIS_CSVs/MASTER_DATA/QPCRDataQAed_edited.csv",header=TRUE)

# Make Fam Code Column for PreExperimentData via lookup table and dply left join 
FamCodeLookupTable <- Master_Data[,c(1,2)] %>% unique()
PreExperimentData_FamCode <- PreExperimentData %>% left_join(FamCodeLookupTable)

# Subset Data for Families that were used in Apoptosis Assays
FamCodes <- c("A","B","D","E","J","L")
Master_Data_Assay_Subset <- Master_Data %>% filter(FamCode %in% FamCodes)
MortDataQAed_Assay_Subset <- MortDataQAed %>% filter(Fam.Code %in% FamCodes)
PreExperimentData_Assay_Subset <- PreExperimentData_FamCode %>% filter(FamCode %in% FamCodes)
QPCRDataQAed_Assay_Subset <- QPCRDataQAed_edited %>% filter(FamCode %in% FamCodes) %>% filter(Dose %in% c("10^7","0","CNTRLS")) 


## qPCR Data Summary Statistics 
# Need to convert the ave.log.pconc column into a numeric value but not mess with the other columns, do this with transform 
QPCRDataQAed_Assay_Subset2 <- transform(QPCRDataQAed_Assay_Subset, ave.log.pconc = as.numeric(ave.log.pconc))
QPCRDataQAed_Assay_Subset_summary <- summarySE(data=QPCRDataQAed_Assay_Subset2, "ave.log.pconc", groupvars=c("FamCode","Plate_Condition","Dose"), conf.interval = 0.95)


################### Assemble Data Frame for Viability Assay Data #######################

# Variables of interest: Family, Live, Dead
# Regression Analysis
# http://r-statistics.co/Dirichlet-Regression-With-R.html

### Dirichlet multinomial regression potential
#Use a Dirichlet multinomial regression for compositional data when the dependent variable is the 
#sum total contribution from multiple components. Multiple dependent Y variables and one predictor variable. 
#To use the data it must be separated into fractions that sum up to 1. 

# Setting up data with ratios that can be used for the Dirichlet Multinomial Distribution
# Assemble plot from Plot 4 but separate into live and dead for both granular and agranular cells 

# DEAD Granular Cells = PLOT4 E1 Count - PLOT9 Count
# DEAD Agranular Cells = PLOT4 E3 Count - PLOT10
# LIVE Granular Cells = PLOT9 
# LIVE Agranular Cells = PLOT10 

# Check that number of rows are compatible
nrow(VI_PLOT4_E1_E3_GATE_BAD_REMOVED) # 53
nrow(VI_PLOT9_E1_MINUS_V1R_BAD_REMOVED)
nrow(VI_PLOT10_E3_MINUS_V1R_BAD_REMOVED)
E1_plot4_count_day50 <- VI_DAY50_PLOT4_E1_E3_GATE_BAD_REMOVED %>% filter(GATE=="E1") 
nrow(E1_plot4_count_day50) # 74
E3_plot4_count_day50 <- VI_DAY50_PLOT4_E1_E3_GATE_BAD_REMOVED %>% filter(GATE=="E3") 
nrow(E3_plot4_count_day50) # 74
nrow(VI_DAY50_PLOT10_E3_MINUS_V1R_BAD_REMOVED) #74 
nrow(VI_DAY50_PLOT9_E1_MINUS_V1R_BAD_REMOVED) # 74

# Merge data frames Subtract # live from total number to get number of dead cells
# first change colnames so that they can be merged with new column but same sample IDs
colnames(VI_PLOT9_E1_MINUS_V1R_BAD_REMOVED)[8] <- "E1_LIVE_COUNT_THIS_PLOT"
colnames(VI_PLOT10_E3_MINUS_V1R_BAD_REMOVED)[8] <- "E3_LIVE_COUNT_THIS_PLOT"
colnames(VI_PLOT9_E1_MINUS_V1R_BAD_REMOVED)[9] <- "E1_PERCENT_LIVE"
colnames(VI_PLOT10_E3_MINUS_V1R_BAD_REMOVED)[9] <- "E3_PERCENT_LIVE"
colnames(VI_PLOT9_E1_MINUS_V1R_BAD_REMOVED)[10] <- "E1_Arcsine_LIVE"
colnames(VI_PLOT10_E3_MINUS_V1R_BAD_REMOVED)[10] <- "E3_Arcsine_LIVE"

#Separate E3 data into two separate data frames and then merge
VI_DAY50_PLOT4_E1_E3_GATE_BAD_REMOVED_separated <- VI_DAY50_PLOT4_E1_E3_GATE_BAD_REMOVED %>% filter(GATE=="E3")
colnames(VI_DAY50_PLOT4_E1_E3_GATE_BAD_REMOVED_separated)[9]<-"E3_COUNT"
colnames(VI_DAY50_PLOT4_E1_E3_GATE_BAD_REMOVED_separated)[11]<-"E3_PERCENT_OF_THIS_PLOT"
colnames(VI_DAY50_PLOT4_E1_E3_GATE_BAD_REMOVED_separated)[12]<-"E3_Arcsine"
VI_DAY50_PLOT4_E1_E3_GATE_BAD_REMOVED_separated_E1 <- VI_DAY50_PLOT4_E1_E3_GATE_BAD_REMOVED %>% filter(GATE=="E1")
colnames(VI_DAY50_PLOT4_E1_E3_GATE_BAD_REMOVED_separated_E1)[9]<-"E1_COUNT"
colnames(VI_DAY50_PLOT4_E1_E3_GATE_BAD_REMOVED_separated_E1)[11]<-"E1_PERCENT_OF_THIS_PLOT"
colnames(VI_DAY50_PLOT4_E1_E3_GATE_BAD_REMOVED_separated_E1)[12]<-"E1_Arcsine"

VI_DAY50_PLOT4_E1_E3_GATE_BAD_REMOVED_merged <- merge(VI_DAY50_PLOT4_E1_E3_GATE_BAD_REMOVED_separated, VI_DAY50_PLOT4_E1_E3_GATE_BAD_REMOVED_separated_E1, by = c("SAMPLE_ID","FAMILY","FLOW_CODE","ASSAY","GROUP", "OYSTER_ID","PLOT","COUNT_THIS_PLOT"))

colnames(VI_DAY50_PLOT9_E1_MINUS_V1R_BAD_REMOVED)[8] <- "E1_LIVE_COUNT_THIS_PLOT"
colnames(VI_DAY50_PLOT10_E3_MINUS_V1R_BAD_REMOVED)[8] <- "E3_LIVE_COUNT_THIS_PLOT"
colnames(VI_DAY50_PLOT9_E1_MINUS_V1R_BAD_REMOVED)[10] <- "E1_PERCENT_LIVE"
colnames(VI_DAY50_PLOT10_E3_MINUS_V1R_BAD_REMOVED)[10] <- "E3_PERCENT_LIVE"
colnames(VI_DAY50_PLOT9_E1_MINUS_V1R_BAD_REMOVED )[11] <- "E1_Arcsine_LIVE"
colnames(VI_DAY50_PLOT10_E3_MINUS_V1R_BAD_REMOVED)[11] <- "E3_Arcsine_LIVE"

#Merge two live columns
VI_DAY7_LIVE_combined <- merge(VI_PLOT9_E1_MINUS_V1R_BAD_REMOVED,VI_PLOT10_E3_MINUS_V1R_BAD_REMOVED, by= c("SAMPLE_ID","FAMILY","FLOW_CODE","ASSAY","GROUP","OYSTER_ID"))
VI_DAY50_LIVE_combined <-merge(VI_DAY50_PLOT9_E1_MINUS_V1R_BAD_REMOVED,VI_DAY50_PLOT10_E3_MINUS_V1R_BAD_REMOVED, by= c("SAMPLE_ID","FAMILY","FLOW_CODE","ASSAY","GROUP","OYSTER_ID"))

# Merged the live columns with the total 
VI_DAY7_LIVE_combined_merged_total <- merge(VI_DAY7_LIVE_combined, VI_PLOT4_E1_E3_GATE_BAD_REMOVED, by =c("SAMPLE_ID","FAMILY","FLOW_CODE","ASSAY","GROUP","OYSTER_ID"))
head(VI_DAY7_LIVE_combined_merged_total)
VI_DAY50_LIVE_combined_merged_total <- merge(VI_DAY50_LIVE_combined, VI_DAY50_PLOT4_E1_E3_GATE_BAD_REMOVED_merged, by =c("SAMPLE_ID","FAMILY","FLOW_CODE","ASSAY","GROUP","OYSTER_ID"))
head(VI_DAY50_LIVE_combined_merged_total)

# Substract E1 (granular) live from E1 total Day 7
VI_DAY7_LIVE_combined_merged_total$Dead_granular <- (VI_DAY7_LIVE_combined_merged_total$E1_COUNT - VI_DAY7_LIVE_combined_merged_total$E1_LIVE_COUNT_THIS_PLOT) 
VI_DAY50_LIVE_combined_merged_total$Dead_granular <- (VI_DAY50_LIVE_combined_merged_total$E1_COUNT - VI_DAY50_LIVE_combined_merged_total$E1_LIVE_COUNT_THIS_PLOT) 

# Subtract E3 (agranular) live from E3 total Day 7
VI_DAY7_LIVE_combined_merged_total$Dead_agranular <- (VI_DAY7_LIVE_combined_merged_total$E3_COUNT - VI_DAY7_LIVE_combined_merged_total$E3_LIVE_COUNT_THIS_PLOT)

VI_DAY50_LIVE_combined_merged_total$Dead_agranular <- (VI_DAY50_LIVE_combined_merged_total$E3_COUNT - VI_DAY50_LIVE_combined_merged_total$E3_LIVE_COUNT_THIS_PLOT) 

# Create ratio of dead granular
VI_DAY7_LIVE_combined_merged_total$Dead_granular_ratio <- (VI_DAY7_LIVE_combined_merged_total$Dead_granular/VI_DAY7_LIVE_combined_merged_total$E1_COUNT)
VI_DAY50_LIVE_combined_merged_total$Dead_granular_ratio <- (VI_DAY50_LIVE_combined_merged_total$Dead_granular/VI_DAY50_LIVE_combined_merged_total$E1_COUNT)

# Create ratio of dead agranular 
VI_DAY7_LIVE_combined_merged_total$Dead_agranular_ratio <- (VI_DAY7_LIVE_combined_merged_total$Dead_agranular/VI_DAY7_LIVE_combined_merged_total$E3_COUNT)
VI_DAY50_LIVE_combined_merged_total$Dead_agranular_ratio <- (VI_DAY50_LIVE_combined_merged_total$Dead_agranular/VI_DAY50_LIVE_combined_merged_total$E3_COUNT)

# Create ratio of live granular
VI_DAY7_LIVE_combined_merged_total$Live_granular_ratio <- (VI_DAY7_LIVE_combined_merged_total$E1_LIVE_COUNT_THIS_PLOT/VI_DAY7_LIVE_combined_merged_total$E1_COUNT)

VI_DAY50_LIVE_combined_merged_total$Live_granular_ratio <- (VI_DAY50_LIVE_combined_merged_total$E1_LIVE_COUNT_THIS_PLOT/VI_DAY50_LIVE_combined_merged_total$E1_COUNT)

# Create ratio of live agranular
VI_DAY7_LIVE_combined_merged_total$Live_agranular_ratio <- (VI_DAY7_LIVE_combined_merged_total$E3_LIVE_COUNT_THIS_PLOT/VI_DAY7_LIVE_combined_merged_total$E3_COUNT)
VI_DAY50_LIVE_combined_merged_total$Live_agranular_ratio <- (VI_DAY50_LIVE_combined_merged_total$E3_LIVE_COUNT_THIS_PLOT/VI_DAY50_LIVE_combined_merged_total$E3_COUNT)

#check that they all add up to 2.0, one for agranular and one for granular!
VI_DAY7_LIVE_combined_merged_total$Ratios_added <- (VI_DAY7_LIVE_combined_merged_total$Dead_agranular_ratio + VI_DAY7_LIVE_combined_merged_total$Dead_granular_ratio + VI_DAY7_LIVE_combined_merged_total$Live_agranular_ratio + VI_DAY7_LIVE_combined_merged_total$Live_granular_ratio)
VI_DAY50_LIVE_combined_merged_total$Ratios_added <- (VI_DAY50_LIVE_combined_merged_total$Dead_agranular_ratio + VI_DAY50_LIVE_combined_merged_total$Dead_granular_ratio + VI_DAY50_LIVE_combined_merged_total$Live_agranular_ratio + VI_DAY50_LIVE_combined_merged_total$Live_granular_ratio)

# Make one combined data frame across days by using rbind!
# Need to make a new data frame with this info in 
VI_DAY7_LIVE_combined_merged_total["DAY"] <- "07"
VI_DAY50_LIVE_combined_merged_total["DAY"] <- "50"

VI_DAY7_subset_for_merge <- VI_DAY7_LIVE_combined_merged_total[,c(1:6,23,24,25,26,27,28,30)]
VI_DAY50_subset_for_merge <- VI_DAY50_LIVE_combined_merged_total[,c(1:6,29:34,36)]
VI_DAY7_DAY50_LIVE_combined_merged_total <-rbind(VI_DAY7_subset_for_merge,VI_DAY50_subset_for_merge)

nrow(VI_DAY7_DAY50_LIVE_combined_merged_total) # 127
View(VI_DAY7_DAY50_LIVE_combined_merged_total)

########################### Beta Regression for VIABIILITY ASSAY ################################################
# See the following website for reference: http://rcompanion.org/handbook/J_02.html
# The summary function in betareg produces a pseudo R-squared value for the model, and the recommended test for the p-value for the model is the lrtest function in the lmtest package.

modelbeta= betareg(Live_granular_ratio ~ FAMILY + DAY + GROUP, data=VI_DAY7_DAY50_LIVE_combined_merged_total)

model= lm(Live_granular_ratio ~ FAMILY + GROUP + FAMILY:GROUP + DAY, data=VI_DAY7_DAY50_LIVE_combined_merged_total)

model2= lm(Live_granular_ratio ~ DAY, data=VI_DAY7_DAY50_LIVE_combined_merged_total)

model3= lm(Live_granular_ratio ~ FAMILY, data=VI_DAY7_DAY50_LIVE_combined_merged_total)

#run joint test on model
joint_tests(model)

#likelihood ratio test
lrtest(modelbeta)

# summary
summary(modelbeta)

# plot the model fit
plot(fitted(model),residuals(model))

############################# FORMAT APOPTOSIS ASSAY DATA FOR PCA #################################
# GOAL: generate a table that integrates the Viability Assay Data, the qPCR data for Day7 and Day 50, Apoptosis Assay Phenotypes, 
#       and caspase assay phenotype
# Steps required:
  # 1. Load in all qPCR data with the Sample ID in the correct format with the Family, Sample ID, GROUP information (done above)
  # 2. Merge with the Viability Assay DAta
  # 3. Put data for each apoptosis Phenotype in its own column with ratios rather than percentages, keep day 7 and 50 together
  # 4. Merge the Viability Assay + qPCR data frame with the new Apoptosis Assay data frame with left join, 
  # 5. Put Caspase assay data in its own data frame with each column as a phenotype with ratio numbers rather than percentages
  # 6. Left join with combined VIA+qPCR+APOP data
  # 7. Run PCA Analysis on VIA+qPCR+APOP+CASP and VIA+qPCR+APOP separately because merging with Caspase data will 
  #    required for many of the control samples to be removed 
####

# 1. Load in all qPCR data with the Sample ID in the correct format with the Family, Sample ID, GROUP information (done above)

QPCRDataQAed_Assay_Subset_PCA_format <- QPCRDataQAed_Assay_Subset[,c(5,6,10)]
  
QPCRDataQAed_Assay_Subset_PCA_format_combined <-  unite(QPCRDataQAed_Assay_Subset_PCA_format, 
          OYSTER_ID, c(FamCode,ID), sep="-",remove=FALSE)
QPCRDataQAed_Assay_Subset_PCA_format_combined_final <- QPCRDataQAed_Assay_Subset_PCA_format_combined[,c(1,4)]

# 2. Merge with Viability Assay Data based on OYSTER_ID

head(VI_DAY7_DAY50_LIVE_combined_merged_total)

# Perform left join with qPCR data
VI_DAY7_DAY50_LIVE_combined_merged_total_QPCR <- VI_DAY7_DAY50_LIVE_combined_merged_total %>% 
  left_join(QPCRDataQAed_Assay_Subset_PCA_format_combined_final, by = "OYSTER_ID")

  # L-13 sample was mislabeled, can be removed 
VI_DAY7_DAY50_LIVE_combined_merged_total_QPCR <- VI_DAY7_DAY50_LIVE_combined_merged_total_QPCR %>% filter(!OYSTER_ID == "L-13") 

nrow(VI_DAY7_DAY50_LIVE_combined_merged_total_QPCR) # 126 

# 3. Put data for each apoptosis Phenotype in its own column with ratios rather than percentages, keep day 7 and 50 together

# need to make the Day 7 Sample ID be the oyster ID so that it will merge correctly 
  # went back to the Apoptosis Assay data frame used to combine the data
  # APOP_PLOT4_GRANULAR_QUAD_PLOT_GATE_ADDED_BAD_REMOVED, APOP_PLOT7_AGRANULAR_QUAD_PLOT_GATE_ADDED_BAD_REMOVED

APOP_PLOT4_GRANULAR_QUAD_PLOT_GATE_ADDED_BAD_REMOVED_lookup_table <- APOP_PLOT4_GRANULAR_QUAD_PLOT_GATE_ADDED_BAD_REMOVED[,c("SAMPLE_ID","OYTER_ID")]
APOP_PLOT7_AGRANULAR_QUAD_PLOT_GATE_ADDED_BAD_REMOVED_lookup_table <- APOP_PLOT7_AGRANULAR_QUAD_PLOT_GATE_ADDED_BAD_REMOVED[,c("SAMPLE_ID","OYTER_ID")]
APOP_PLOT4_GRANULAR_QUAD_PLOT_GATE_ADDED_BAD_REMOVED_lookup_table <- as.data.frame(  APOP_PLOT4_GRANULAR_QUAD_PLOT_GATE_ADDED_BAD_REMOVED_lookup_table)

#compare to make sure the lists are the same
all_equal(APOP_PLOT4_GRANULAR_QUAD_PLOT_GATE_ADDED_BAD_REMOVED_lookup_table,APOP_PLOT7_AGRANULAR_QUAD_PLOT_GATE_ADDED_BAD_REMOVED_lookup_table )

# Use lookup table to change all SAMPLE_ID's for day 7 to their oyster ID
all_granular_agranular_DAY7_DAY50_OYSTER_ID_7 <- all_granular_agranular_DAY7_DAY50 %>% filter(DAY== "07") #separate out the day 7 values first
nrow(all_granular_agranular_DAY7_DAY50_OYSTER_ID_7)

# perform left join
all_granular_agranular_DAY7_DAY50_OYSTER_ID_7_joined <- left_join(x=all_granular_agranular_DAY7_DAY50_OYSTER_ID_7, y=APOP_PLOT4_GRANULAR_QUAD_PLOT_GATE_ADDED_BAD_REMOVED_lookup_table, by = "SAMPLE_ID")

#Only remove entirely duplicated rows, should have duplicate oyster ID's 
all_granular_agranular_DAY7_DAY50_OYSTER_ID_7_no_dups <-all_granular_agranular_DAY7_DAY50_OYSTER_ID_7_joined[!duplicated(all_granular_agranular_DAY7_DAY50_OYSTER_ID_7_joined),]
nrow(all_granular_agranular_DAY7_DAY50_OYSTER_ID_7_no_dups) #456

#Correct column name of OYSTER ID
colnames(all_granular_agranular_DAY7_DAY50_OYSTER_ID_7_no_dups)[11] <- "OYSTER_ID"

# Make OYSTER_ID column for DAY 50 data with -A removed, then rejoin Day7 and Day50
all_granular_agranular_DAY7_DAY50_day50 <- all_granular_agranular_DAY7_DAY50 %>% filter(DAY =="50")
all_granular_agranular_DAY7_DAY50_day50["OYSTER_ID"] <- gsub("-A","" ,all_granular_agranular_DAY7_DAY50_day50$SAMPLE_ID)

# create combined data frame with fixed OYSTER_ID so data frame can be merged with qPCR data above 
all_granular_agranular_DAY7_DAY50_OYSTER_ID_fixed <- rbind(all_granular_agranular_DAY7_DAY50_day50, all_granular_agranular_DAY7_DAY50_OYSTER_ID_7_no_dups)
nrow(all_granular_agranular_DAY7_DAY50_OYSTER_ID_fixed) #1048

# Find unique phenotype headers 
head(all_granular_agranular_DAY7_DAY50_OYSTER_ID_fixed)
nrow(all_granular_agranular_DAY7_DAY50_OYSTER_ID_fixed) #1048
unique(all_granular_agranular_DAY7_DAY50_OYSTER_ID_fixed$GATE)

#Create unique columns for each phenotype with the Percent of this plot values
##### KEY ######
# Q2_UL: Granular Necrotic
# Q2_UR: Granular Dead Apoptotic
# Q2_LL: Granular Live
# Q2_LR: Granular Live Apoptotic
# Q1_UL: Agranular Necrotic
# Q1_UR: Agranular Dead Apoptotic
# Q1_LL: Agranular Live
# Q1_LR: Agranular Live Apoptotic

all_granular_agranular_DAY7_DAY50_OYSTER_ID_fixed_Q2_UL <- all_granular_agranular_DAY7_DAY50_OYSTER_ID_fixed %>% filter(GATE == "Q2_UL")
colnames(all_granular_agranular_DAY7_DAY50_OYSTER_ID_fixed_Q2_UL)[4] <- "Q2_UL_Granular_Necrotic"

all_granular_agranular_DAY7_DAY50_OYSTER_ID_fixed_Q2_UR <- all_granular_agranular_DAY7_DAY50_OYSTER_ID_fixed %>% filter(GATE == "Q2_UR")
colnames(all_granular_agranular_DAY7_DAY50_OYSTER_ID_fixed_Q2_UR)[4] <- "Q2_UR_Granular_Dead_Apoptotic"

all_granular_agranular_DAY7_DAY50_OYSTER_ID_fixed_Q2_LL <- all_granular_agranular_DAY7_DAY50_OYSTER_ID_fixed %>% filter(GATE == "Q2_LL")
colnames(all_granular_agranular_DAY7_DAY50_OYSTER_ID_fixed_Q2_LL)[4] <- "Q2_LL_Granular_Live" 

all_granular_agranular_DAY7_DAY50_OYSTER_ID_fixed_Q2_LR <- all_granular_agranular_DAY7_DAY50_OYSTER_ID_fixed %>% filter(GATE == "Q2_LR")
colnames(all_granular_agranular_DAY7_DAY50_OYSTER_ID_fixed_Q2_LR)[4] <- "Q2_LR_Granular_Live_Apoptotic" 

all_granular_agranular_DAY7_DAY50_OYSTER_ID_fixed_Q1_UL <- all_granular_agranular_DAY7_DAY50_OYSTER_ID_fixed %>% filter(GATE == "Q1_UL")
colnames(all_granular_agranular_DAY7_DAY50_OYSTER_ID_fixed_Q1_UL)[4] <- "Q1_UL_Agranular_Necrotic"

all_granular_agranular_DAY7_DAY50_OYSTER_ID_fixed_Q1_UR <- all_granular_agranular_DAY7_DAY50_OYSTER_ID_fixed %>% filter(GATE == "Q1_UR")
colnames(all_granular_agranular_DAY7_DAY50_OYSTER_ID_fixed_Q1_UR)[4] <- "Q1_UR_Agranular_Dead_Apoptotic"

all_granular_agranular_DAY7_DAY50_OYSTER_ID_fixed_Q1_LL <- all_granular_agranular_DAY7_DAY50_OYSTER_ID_fixed %>% filter(GATE == "Q1_LL")
colnames(all_granular_agranular_DAY7_DAY50_OYSTER_ID_fixed_Q1_LL)[4] <- "Q1_LL_Agranular_Live" 

all_granular_agranular_DAY7_DAY50_OYSTER_ID_fixed_Q1_LR <- all_granular_agranular_DAY7_DAY50_OYSTER_ID_fixed %>% filter(GATE == "Q1_LR")
colnames(all_granular_agranular_DAY7_DAY50_OYSTER_ID_fixed_Q1_LR)[4] <- "Q1_LR_Agranular_Live_Apoptotic" 

# Left join the new data, but for each cell type separately 

# Granular cells 
all_granular_agranular_DAY7_DAY50_OYSTER_ID_fixed_merged_1 <- merge(all_granular_agranular_DAY7_DAY50_OYSTER_ID_fixed_Q2_UL, all_granular_agranular_DAY7_DAY50_OYSTER_ID_fixed_Q2_UR, 
                                        by =c("FAMILY","GROUP","DAY","CELL","OYSTER_ID", "ASSAY","PLOT","SAMPLE_ID"))
all_granular_agranular_DAY7_DAY50_OYSTER_ID_fixed_merged_2 <- merge(all_granular_agranular_DAY7_DAY50_OYSTER_ID_fixed_merged_1, all_granular_agranular_DAY7_DAY50_OYSTER_ID_fixed_Q2_LL, 
                                                                    by =c("FAMILY","GROUP","DAY","CELL","OYSTER_ID", "ASSAY","PLOT","SAMPLE_ID"))
all_granular_agranular_DAY7_DAY50_OYSTER_ID_fixed_merged_3 <- merge(all_granular_agranular_DAY7_DAY50_OYSTER_ID_fixed_merged_2, all_granular_agranular_DAY7_DAY50_OYSTER_ID_fixed_Q2_LR, 
                                                                    by =c("FAMILY","GROUP","DAY","CELL","OYSTER_ID", "ASSAY","PLOT","SAMPLE_ID"))
all_granular_agranular_DAY7_DAY50_OYSTER_ID_fixed_merged_3_trimmed <- all_granular_agranular_DAY7_DAY50_OYSTER_ID_fixed_merged_3[,c("FAMILY","GROUP","DAY","CELL","OYSTER_ID","ASSAY","Q2_UL_Granular_Necrotic","Q2_UR_Granular_Dead_Apoptotic", "Q2_LL_Granular_Live","Q2_LR_Granular_Live_Apoptotic")]

# Agranular cells 
all_granular_agranular_DAY7_DAY50_OYSTER_ID_fixed_merged_4 <- merge(all_granular_agranular_DAY7_DAY50_OYSTER_ID_fixed_Q1_UL, all_granular_agranular_DAY7_DAY50_OYSTER_ID_fixed_Q1_UR, 
                                                                    by =c("FAMILY","GROUP","DAY","CELL","OYSTER_ID", "ASSAY","PLOT","SAMPLE_ID"))
all_granular_agranular_DAY7_DAY50_OYSTER_ID_fixed_merged_5 <- merge(all_granular_agranular_DAY7_DAY50_OYSTER_ID_fixed_merged_4, all_granular_agranular_DAY7_DAY50_OYSTER_ID_fixed_Q1_LL, 
                                                                    by =c("FAMILY","GROUP","DAY","CELL","OYSTER_ID", "ASSAY","PLOT","SAMPLE_ID"))
all_granular_agranular_DAY7_DAY50_OYSTER_ID_fixed_merged_6 <- merge(all_granular_agranular_DAY7_DAY50_OYSTER_ID_fixed_merged_5, all_granular_agranular_DAY7_DAY50_OYSTER_ID_fixed_Q1_LR, 
                                                                    by =c("FAMILY","GROUP","DAY","CELL","OYSTER_ID", "ASSAY","PLOT","SAMPLE_ID"))
all_granular_agranular_DAY7_DAY50_OYSTER_ID_fixed_merged_6_trimmed <- all_granular_agranular_DAY7_DAY50_OYSTER_ID_fixed_merged_6[,c("FAMILY","GROUP","DAY","CELL","OYSTER_ID","ASSAY","Q1_UL_Agranular_Necrotic","Q1_UR_Agranular_Dead_Apoptotic", "Q1_LL_Agranular_Live","Q1_LR_Agranular_Live_Apoptotic")]

# Combine the granular and the agranular cells after checking the data frames over, not merging by the cell so they can be added side by side 
Apop_all_phenotypes_combined <- merge(all_granular_agranular_DAY7_DAY50_OYSTER_ID_fixed_merged_3_trimmed,all_granular_agranular_DAY7_DAY50_OYSTER_ID_fixed_merged_6_trimmed, by = c("FAMILY","GROUP","DAY","OYSTER_ID", "ASSAY"))
Apop_all_phenotypes_combined_trimmed <- Apop_all_phenotypes_combined[-c(6,11)]
nrow(Apop_all_phenotypes_combined_trimmed) #131

# Check that nrows here matches original total number of apoptosis assay samples
nrow(Apop_all_phenotypes_combined_trimmed) #131
nrow(all_granular_agranular_DAY7_DAY50) # 1048/8 = 131, they match!

# Combine Apoptosis Plot with the Viability Assay Data and qPCR data

# Compare the data frames so they can be merged correctly
head(Apop_all_phenotypes_combined_trimmed)
head(VI_DAY7_DAY50_LIVE_combined_merged_total_QPCR)
nrow(VI_DAY7_DAY50_LIVE_combined_merged_total_QPCR) #126 

VI_DAY7_DAY50_LIVE_combined_merged_total_QPCR_formatted_fixed_APOP <- merge(VI_DAY7_DAY50_LIVE_combined_merged_total_QPCR_formatted_fixed, Apop_all_phenotypes_combined_trimmed, 
                                                                            by= c("FAMILY","GROUP","DAY","OYSTER_ID"))

# Remove Assay.x and Assay.y, and FLOW CODE from the data frame
VI_DAY7_DAY50_LIVE_combined_merged_total_QPCR_formatted_fixed_APOP <- VI_DAY7_DAY50_LIVE_combined_merged_total_QPCR_formatted_fixed_APOP[-c(6,7,15)]

# check number of rows still 126
nrow(VI_DAY7_DAY50_LIVE_combined_merged_total_QPCR_formatted_fixed_APOP)
#125

################ Format Caspase Assay Data to be merged with VIA,APOP, qPCR data ##########################

##### CASPASE ASSAY KEY ######
#Q3_LR = granular live apoptotic
#Q4-LR = agranular live apoptotic


head(all_caspase_granular_agranular_DAY7_DAY50)
head(VI_DAY7_DAY50_LIVE_combined_merged_total_QPCR_formatted_fixed_APOP)

unique(all_caspase_granular_agranular_DAY7_DAY50$GATE)

# remove Day.1 column and X column that existed in the dataframe and add back the oyster_id column 
all_caspase_granular_agranular_DAY7_DAY50 <- all_caspase_granular_agranular_DAY7_DAY50[,-9]
all_caspase_granular_agranular_DAY7_DAY50_Q3_LR <- all_caspase_granular_agranular_DAY7_DAY50 %>% filter(GATE=="Q3_LR") 
all_caspase_granular_agranular_DAY7_DAY50_Q4_LR <- all_caspase_granular_agranular_DAY7_DAY50 %>% filter(GATE=="Q4_LR") 
colnames(all_caspase_granular_agranular_DAY7_DAY50_Q3_LR)[3] <- "Q3_LR_Granular_Live_Caspase_Dependent_Apoptotic" 
colnames(all_caspase_granular_agranular_DAY7_DAY50_Q4_LR)[3] <- "Q4_LR_Agranular_Live_Caspase_Dependent_Apoptotic" 

# Had to remove PLOT as an aspect of the merge for this to work 
all_caspase_granular_agranular_DAY7_DAY50_Q3_LR_Q4_LR <- merge(all_caspase_granular_agranular_DAY7_DAY50_Q3_LR,all_caspase_granular_agranular_DAY7_DAY50_Q4_LR,
                                                               by = c("FAMILY","GROUP","DAY","OYSTER_ID", "SAMPLE_ID"))
# Remove unwanted columns
all_caspase_granular_agranular_DAY7_DAY50_Q3_LR_Q4_LR <- all_caspase_granular_agranular_DAY7_DAY50_Q3_LR_Q4_LR[-c(7:9, 11:13)]
nrow(all_caspase_granular_agranular_DAY7_DAY50_Q3_LR_Q4_LR) #115 
nrow(VI_DAY7_DAY50_LIVE_combined_merged_total_QPCR_formatted_fixed_APOP) #125 rows, should only go down to 115


# Merge Capase data with VI and APOP data, do left join to see which were the samples being dropped 
VI_DAY7_DAY50_LIVE_combined_merged_total_QPCR_formatted_fixed_APOP_CASPASE <- merge(VI_DAY7_DAY50_LIVE_combined_merged_total_QPCR_formatted_fixed_APOP,all_caspase_granular_agranular_DAY7_DAY50_Q3_LR_Q4_LR,
                                                                                    by = c("OYSTER_ID"))
VI_DAY7_DAY50_LIVE_combined_merged_total_QPCR_formatted_fixed_APOP_CASPASE_left_join <- left_join(VI_DAY7_DAY50_LIVE_combined_merged_total_QPCR_formatted_fixed_APOP,all_caspase_granular_agranular_DAY7_DAY50_Q3_LR_Q4_LR,
                                                                                    by = c("OYSTER_ID"))
nrow(VI_DAY7_DAY50_LIVE_combined_merged_total_QPCR_formatted_fixed_APOP_CASPASE_left_join) # 125
nrow(VI_DAY7_DAY50_LIVE_combined_merged_total_QPCR_formatted_fixed_APOP_CASPASE)
#90 

# Remove Sample_ID columns after checking to make sure that they match 
VI_DAY7_DAY50_LIVE_combined_merged_total_QPCR_formatted_fixed_APOP_CASPASE_subset <- VI_DAY7_DAY50_LIVE_combined_merged_total_QPCR_formatted_fixed_APOP_CASPASE[-c(5,21)]
nrow(VI_DAY7_DAY50_LIVE_combined_merged_total_QPCR_formatted_fixed_APOP_CASPASE_subset) #90

# Use Lapply to make only the number columns numeric 
VI_DAY7_DAY50_LIVE_combined_merged_total_QPCR_formatted_fixed_APOP_CASPASE_subset[,c(5:21)] <- lapply(VI_DAY7_DAY50_LIVE_combined_merged_total_QPCR_formatted_fixed_APOP_CASPASE_subset[,c(5:20)], as.numeric)
nrow(VI_DAY7_DAY50_LIVE_combined_merged_total_QPCR_formatted_fixed_APOP_CASPASE_subset)
# Went down to only 90 samples because many fewer had Caspase Assay Samples

############################# PCA ANALYSIS FOR FULL PHENOTYPE  #######################################

# perform simple PCA on only the numeric values 
rownames(VI_DAY7_DAY50_LIVE_combined_merged_total_QPCR_formatted_fixed_APOP_CASPASE_subset) <- VI_DAY7_DAY50_LIVE_combined_merged_total_QPCR_formatted_fixed_APOP_CASPASE_subset$OYSTER_ID
full_phenotype_data_set_PCA <- prcomp(VI_DAY7_DAY50_LIVE_combined_merged_total_QPCR_formatted_fixed_APOP_CASPASE_subset[,c(5:21)], center=TRUE, scale=TRUE)

summary(full_phenotype_data_set_PCA)

# Use ggbiplot to plot the PCA

ggbiplot(full_phenotype_data_set_PCA, labels=VI_DAY7_DAY50_LIVE_combined_merged_total_QPCR_formatted_fixed_APOP_CASPASE_subset$FAMILY)
ggbiplot(full_phenotype_data_set_PCA, labels=VI_DAY7_DAY50_LIVE_combined_merged_total_QPCR_formatted_fixed_APOP_CASPASE_subset$GROUP)
ggbiplot(full_phenotype_data_set_PCA, labels=VI_DAY7_DAY50_LIVE_combined_merged_total_QPCR_formatted_fixed_APOP_CASPASE_subset$DAY)

# Scree plot of Eigenvalues 
#(see helpful tutorial for the code below: https://www.analyticsvidhya.com/blog/2016/03/practical-guide-principal-component-analysis-python/)
# Compute the standard deviation of each principal component
std_dev_full <- full_phenotype_data_set_PCA$sdev
# compute variance
pr_var_full <- std_dev_full^2

# proportion of variance explained
prop_varex_full <- pr_var_full/sum(pr_var_full)
prop_varex_full

plot(prop_varex_full, xlab= "Principal Component ",
     ylab="Proportion of Variance Explained", type="b")

#cumulative scree plot
plot(cumsum(prop_varex_full), xlab = "Principal Component",
       ylab = "Cumulative Proportion of Variance Explained",
       type = "b")

# ~ 13 components explains 98% of the variability of the data

# Additional types of PCA plots in R #
# http://www.sthda.com/english/articles/31-principal-component-methods-in-r-practical-guide/118-principal-component-analysis-in-r-prcomp-vs-princomp/#compute-pca-in-r-using-prcomp 
# Use factoextra to plot
#install.packages("factoextra")
library(factoextra)

# plot scree plot with fviz
fviz_eig(full_phenotype_data_set_PCA)
# PCA might not be the best way to describe this dataset, need most of the PC's to explain the data

# Graph of Individuals
fviz_pca_ind(full_phenotype_data_set_PCA,
             col.ind = "cos2", # Color by the quality of representation
             gradient.cols = c("#00AFBB", "#E7B800", "#FC4E07"),
             repel = TRUE     # Avoid text overlapping
)

# Graph of variables, positively correlated ones point to the same side of the plot
fviz_pca_var(full_phenotype_data_set_PCA,
             col.var = "contrib", # Color by contributions to the PC
             gradient.cols = c("#00AFBB", "#E7B800", "#FC4E07"),
             repel = TRUE     # Avoid text overlapping
)

# Draw ellipses around the data using Euclidean distance 
fviz_ellipses(full_phenotype_data_set_PCA,VI_DAY7_DAY50_LIVE_combined_merged_total_QPCR_formatted_fixed_APOP_CASPASE_subset, 1:2, geom="point", ellipse.type = "euclid")

# Biplot of individuals and variables
fviz_pca_biplot(full_phenotype_data_set_PCA, repel = TRUE,
                col.var = "#2E9FDF", # Variables color
                col.ind = "#696969",  # Individuals color
                )

############################# PCA ANALYSIS FOR APOPTOSIS and VIABILITY PHENOTYPE  #######################################

# Make numeric
VI_DAY7_DAY50_LIVE_combined_merged_total_QPCR_formatted_fixed_APOP_CASPASE_subset_matrix <- VI_DAY7_DAY50_LIVE_combined_merged_total_QPCR_formatted_fixed_APOP
rownames(VI_DAY7_DAY50_LIVE_combined_merged_total_QPCR_formatted_fixed_APOP_CASPASE_subset_matrix) <-VI_DAY7_DAY50_LIVE_combined_merged_total_QPCR_formatted_fixed_APOP_CASPASE_subset_matrix$OYSTER_ID

VI_DAY7_DAY50_LIVE_combined_merged_total_QPCR_formatted_fixed_APOP_CASPASE_subset_matrix[,c(6:20)] <- lapply(VI_DAY7_DAY50_LIVE_combined_merged_total_QPCR_formatted_fixed_APOP[,c(6:20)], as.numeric)
nrow(VI_DAY7_DAY50_LIVE_combined_merged_total_QPCR_formatted_fixed_APOP_numeric_matrix)
#125 beecause more samples were preserved 

# perform simple PCA on only the numeric values 
APOP_VIA_phenotype_data_set_PCA <- prcomp(VI_DAY7_DAY50_LIVE_combined_merged_total_QPCR_formatted_fixed_APOP_CASPASE_subset_matrix[,c(6:20)], center=TRUE, scale=TRUE)

summary(APOP_VIA_phenotype_data_set_PCA)

# Use ggbiplot to plot the PCA, and then plot PC1 and PC3, setting scale = True normalizes the variables to have a standard deviation equal to 1 
ggbiplot(APOP_VIA_phenotype_data_set_PCA, labels=VI_DAY7_DAY50_LIVE_combined_merged_total_QPCR_formatted_fixed_APOP_CASPASE_subset_matrix$FAMILY)
ggbiplot(APOP_VIA_phenotype_data_set_PCA, choices = c(1,3), labels=VI_DAY7_DAY50_LIVE_combined_merged_total_QPCR_formatted_fixed_APOP_CASPASE_subset_matrix$FAMILY)

ggbiplot(APOP_VIA_phenotype_data_set_PCA, labels=VI_DAY7_DAY50_LIVE_combined_merged_total_QPCR_formatted_fixed_APOP_CASPASE_subset_matrix$GROUP)
ggbiplot(APOP_VIA_phenotype_data_set_PCA, choices = c(1,3), labels=VI_DAY7_DAY50_LIVE_combined_merged_total_QPCR_formatted_fixed_APOP_CASPASE_subset_matrix$GROUP)

ggbiplot(APOP_VIA_phenotype_data_set_PCA, labels=VI_DAY7_DAY50_LIVE_combined_merged_total_QPCR_formatted_fixed_APOP_CASPASE_subset_matrix$DAY)
ggbiplot(APOP_VIA_phenotype_data_set_PCA, choices = c(1,3),labels=VI_DAY7_DAY50_LIVE_combined_merged_total_QPCR_formatted_fixed_APOP_CASPASE_subset_matrix$DAY)

ggbiplot(APOP_VIA_phenotype_data_set_PCA, labels=VI_DAY7_DAY50_LIVE_combined_merged_total_QPCR_formatted_fixed_APOP_CASPASE_subset_matrix$ave.log.pconc)
ggbiplot(APOP_VIA_phenotype_data_set_PCA,choices = c(1,3), labels=VI_DAY7_DAY50_LIVE_combined_merged_total_QPCR_formatted_fixed_APOP_CASPASE_subset_matrix$ave.log.pconc)

# # plot scree plot with fviz
fviz_eig(APOP_VIA_phenotype_data_set_PCA)
# the first 6 PC's describe most of the variation

# Graph of Individuals
fviz_pca_ind(APOP_VIA_phenotype_data_set_PCA,
             col.ind = "cos2", # Color by the quality of representation
             gradient.cols = c("#00AFBB", "#E7B800", "#FC4E07"),
             repel = TRUE     # Avoid text overlapping
)

# Graph of variables, positively correlated ones point to the same side of the plot
fviz_pca_var(APOP_VIA_phenotype_data_set_PCA,
             col.var = "contrib", # Color by contributions to the PC
             gradient.cols = c("#00AFBB", "#E7B800", "#FC4E07"),
             repel = TRUE     # Avoid text overlapping
)

# Biplot of individuals and variables
fviz_pca_biplot(APOP_VIA_phenotype_data_set_PCA, repel = TRUE,
                col.var = "#2E9FDF", # Variables color
                col.ind = "#696969"  # Individuals color
)

# Plot elipses around the points 
fviz_ellipses(APOP_VIA_phenotype_data_set_PCA,VI_DAY7_DAY50_LIVE_combined_merged_total_QPCR_formatted_fixed_APOP_CASPASE_subset_matrix, 1:2, geom="point", ellipse.type = "euclid")


####### Modeling the full apoptosis phenotype ###########



