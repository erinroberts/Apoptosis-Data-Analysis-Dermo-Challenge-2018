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
library(tidyr)
library(Rmisc)

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
```

################### Assemble Regression modeling Data Frame for Viability Assay Data #######################

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
nrow(VI_PLOT4_E1_E3_GATE_BAD_REMOVED)
nrow(VI_PLOT9_E1_MINUS_V1R_BAD_REMOVED)
nrow(VI_PLOT10_E3_MINUS_V1R_BAD_REMOVED)
E1_plot4_count_day50 <- VI_DAY50_PLOT4_E1_E3_GATE_BAD_REMOVED %>% filter(GATE=="E1") 
nrow(E1_plot4_count_day50)
E3_plot4_count_day50 <- VI_DAY50_PLOT4_E1_E3_GATE_BAD_REMOVED %>% filter(GATE=="E3") 
nrow(E3_plot4_count_day50)
nrow(VI_DAY50_PLOT10_E3_MINUS_V1R_BAD_REMOVED)
nrow(VI_DAY50_PLOT9_E1_MINUS_V1R_BAD_REMOVED)

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
VI_DAY7_LIVE_combined_merged_total["DAY"] <- "7"
VI_DAY50_LIVE_combined_merged_total["DAY"] <- "50"

VI_DAY7_subset_for_merge <- VI_DAY7_LIVE_combined_merged_total[,c(1:6,23,24,25,26,27,28,30)]
VI_DAY50_subset_for_merge <- VI_DAY50_LIVE_combined_merged_total[,c(1:6,29:34,36)]
VI_DAY7_DAY50_LIVE_combined_merged_total <-rbind(VI_DAY7_subset_for_merge,VI_DAY50_subset_for_merge)

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

# perform left join
all_granular_agranular_DAY7_DAY50_OYSTER_ID_7_joined <- left_join(x=all_granular_agranular_DAY7_DAY50_OYSTER_ID_7, y=APOP_PLOT4_GRANULAR_QUAD_PLOT_GATE_ADDED_BAD_REMOVED_lookup_table, by = "SAMPLE_ID")

#Only remove entirely duplicated rows, should have duplicate oyster ID's 
all_granular_agranular_DAY7_DAY50_OYSTER_ID_7_no_dups <-all_granular_agranular_DAY7_DAY50_OYSTER_ID_7_joined[!duplicated(all_granular_agranular_DAY7_DAY50_OYSTER_ID_7_joined),]

#Correct column name of OYSTER ID
all_granular_agranular_DAY7_DAY50_OYSTER_ID_7_no_dups <- all_granular_agranular_DAY7_DAY50_OYSTER_ID_7_no_dups$OYTER_ID
colnames(all_granular_agranular_DAY7_DAY50_OYSTER_ID_7_no_dups)[11] <- "OYSTER_ID"

# Make OYSTER_ID column for DAY 50 data with -A removed, then rejoin Day7 and Day50
all_granular_agranular_DAY7_DAY50_day50 <- all_granular_agranular_DAY7_DAY50 %>% filter(DAY =="50")
all_granular_agranular_DAY7_DAY50_day50["OYSTER_ID"] <- gsub("-A","" ,all_granular_agranular_DAY7_DAY50_day50$SAMPLE_ID)

# create combined data frame with fixed OYSTER_ID so data frame can be merged with qPCR data above 
all_granular_agranular_DAY7_DAY50_OYSTER_ID_fixed <- rbind(all_granular_agranular_DAY7_DAY50_day50, all_granular_agranular_DAY7_DAY50_OYSTER_ID_7_no_dups)

# Remove SAMPLE_ID column because the difference between Day7 and Day50 is really confusing! Just look at the OysterID
all_granular_agranular_DAY7_DAY50_OYSTER_ID_fixed

# Find unique phenotype headers 
head(all_granular_agranular_DAY7_DAY50_OYSTER_ID_fixed)
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

# Combine the granular and the agranular cells after checking the data frames over 

# Check that nrows here matches original total number of apoptosis assay samples
nrow(all_granular_agranular_DAY7_DAY50_OYSTER_ID_fixed_merged_1)
nrow(all_granular_agranular_DAY7_DAY50) # 1056/8 = 132, they match!




