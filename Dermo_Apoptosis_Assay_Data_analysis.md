Load Packages
-------------

APOPTOSIS ASSAY Day 7
---------------------

Load in data for each plot
--------------------------

``` r
#Load in the Data for each plot on a separate spreadsheet

APOP_PLOT3_P1_GATE <- read.csv(file="../ANALYSIS_CSVs/APOPTOSIS_ASSAY/DAY7/PLOT3.csv", header=TRUE)
APOP_PLOT8_GRANULAR_AGRANULAR <- read.csv(file="../ANALYSIS_CSVs/APOPTOSIS_ASSAY/DAY7/PLOT8.csv", header=TRUE)
APOP_PLOT4_GRANULAR_QUAD_PLOT <-read.csv(file="../ANALYSIS_CSVs/APOPTOSIS_ASSAY/DAY7/PLOT4.csv", header=TRUE)
APOP_PLOT7_AGRANULAR_QUAD_PLOT <- read.csv(file="../ANALYSIS_CSVs/APOPTOSIS_ASSAY/DAY7/PLOT7.csv", header=TRUE)

APOP_PLOT4_GRANULAR_QUAD_PLOT_GATE_ADDED <- read.csv(file="../ANALYSIS_CSVs/APOPTOSIS_ASSAY/DAY7/PLOT4_GATE_ADDED.csv", header=TRUE)
APOP_PLOT7_AGRANULAR_QUAD_PLOT_GATE_ADDED <- read.csv(file="../ANALYSIS_CSVs/APOPTOSIS_ASSAY/DAY7/PLOT7_GATE_ADDED.csv", header=TRUE)

#Remove empty rows
APOP_PLOT3_P1_GATE <- na.omit(APOP_PLOT3_P1_GATE)
APOP_PLOT8_GRANULAR_AGRANULAR <- na.omit(APOP_PLOT8_GRANULAR_AGRANULAR)
APOP_PLOT4_GRANULAR_QUAD_PLOT <- na.omit(APOP_PLOT4_GRANULAR_QUAD_PLOT)
APOP_PLOT7_AGRANULAR_QUAD_PLOT<- na.omit(APOP_PLOT7_AGRANULAR_QUAD_PLOT)

APOP_PLOT4_GRANULAR_QUAD_PLOT_GATE_ADDED <- na.omit(APOP_PLOT4_GRANULAR_QUAD_PLOT_GATE_ADDED)
APOP_PLOT7_AGRANULAR_QUAD_PLOT_GATE_ADDED <- na.omit(APOP_PLOT7_AGRANULAR_QUAD_PLOT_GATE_ADDED)


## Remove percent symbol from columns 
APOP_PLOT3_P1_GATE$P1_PERCENT_OF_THE_PLOT <- as.numeric(gsub("\\%", "", APOP_PLOT3_P1_GATE$P1_PERCENT_OF_THE_PLOT))
APOP_PLOT8_GRANULAR_AGRANULAR$P3_PERCENT_OF_THIS_PLOT<- as.numeric(gsub("\\%", "", APOP_PLOT8_GRANULAR_AGRANULAR$P3_PERCENT_OF_THIS_PLOT))
APOP_PLOT8_GRANULAR_AGRANULAR$P4_PERCENT_OF_THIS_PLOT<- as.numeric(gsub("\\%", "", APOP_PLOT8_GRANULAR_AGRANULAR$P4_PERCENT_OF_THIS_PLOT))

APOP_PLOT4_GRANULAR_QUAD_PLOT$Q2.UL_PERCENT_OF_THIS_PLOT <- as.numeric(gsub("\\%", "", APOP_PLOT4_GRANULAR_QUAD_PLOT$Q2.UL_PERCENT_OF_THIS_PLOT))
APOP_PLOT4_GRANULAR_QUAD_PLOT$Q2.UR_PERCENT_OF_THIS_PLOT <- as.numeric(gsub("\\%", "", APOP_PLOT4_GRANULAR_QUAD_PLOT$Q2.UR_PERCENT_OF_THIS_PLOT))
APOP_PLOT4_GRANULAR_QUAD_PLOT$Q2.LL_PERCENT_OF_THIS_PLOT <- as.numeric(gsub("\\%", "", APOP_PLOT4_GRANULAR_QUAD_PLOT$Q2.LL_PERCENT_OF_THIS_PLOT))
APOP_PLOT4_GRANULAR_QUAD_PLOT$Q2.LR_PERCENT_OF_THIS_PLOT <- as.numeric(gsub("\\%", "", APOP_PLOT4_GRANULAR_QUAD_PLOT$Q2.LR_PERCENT_OF_THIS_PLOT))

APOP_PLOT7_AGRANULAR_QUAD_PLOT$Q1.UL_PERCENT_OF_THIS_PLOT <- as.numeric(gsub("\\%", "", APOP_PLOT7_AGRANULAR_QUAD_PLOT$Q1.UL_PERCENT_OF_THIS_PLOT))
APOP_PLOT7_AGRANULAR_QUAD_PLOT$Q1.UR_PERCENT_OF_THIS_PLOT <- as.numeric(gsub("\\%", "", APOP_PLOT7_AGRANULAR_QUAD_PLOT$Q1.UR_PERCENT_OF_THIS_PLOT))
APOP_PLOT7_AGRANULAR_QUAD_PLOT$Q1.LL_PERCENT_OF_THIS_PLOT <- as.numeric(gsub("\\%", "", APOP_PLOT7_AGRANULAR_QUAD_PLOT$Q1.LL_PERCENT_OF_THIS_PLOT))
APOP_PLOT7_AGRANULAR_QUAD_PLOT$Q1.LR_PERCENT_OF_THIS_PLOT <- as.numeric(gsub("\\%", "", APOP_PLOT7_AGRANULAR_QUAD_PLOT$Q1.LR_PERCENT_OF_THIS_PLOT))

APOP_PLOT4_GRANULAR_QUAD_PLOT_GATE_ADDED$PERCENT_OF_THIS_PLOT <- as.numeric(gsub("\\%", "", APOP_PLOT4_GRANULAR_QUAD_PLOT_GATE_ADDED$PERCENT_OF_THIS_PLOT))
APOP_PLOT7_AGRANULAR_QUAD_PLOT_GATE_ADDED$PERCENT_OF_THIS_PLOT <- as.numeric(gsub("\\%", "", APOP_PLOT7_AGRANULAR_QUAD_PLOT_GATE_ADDED$PERCENT_OF_THIS_PLOT))

# Load in Data for the samples to remove 
APOPTOSIS_Samples_Remove <- read.csv(file="../ANALYSIS_CSVs/APOPTOSIS_ASSAY/DAY7/APOPTOSIS_SAMPLES_REMOVE.csv", header=TRUE)

# Data Frame with bad samples removed
APOP_PLOT3_P1_GATE_BAD_REMOVED <- APOP_PLOT3_P1_GATE[!APOP_PLOT3_P1_GATE$SAMPLE_ID %in% APOPTOSIS_Samples_Remove$SAMPLE_ID, , drop=FALSE]
APOP_PLOT8_GRANULAR_AGRANULAR_BAD_REMOVED <- APOP_PLOT8_GRANULAR_AGRANULAR[!APOP_PLOT8_GRANULAR_AGRANULAR$SAMPLE_ID %in% APOPTOSIS_Samples_Remove$SAMPLE_ID, , drop=FALSE]
APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED <- APOP_PLOT4_GRANULAR_QUAD_PLOT[!APOP_PLOT4_GRANULAR_QUAD_PLOT$SAMPLE_ID %in% APOPTOSIS_Samples_Remove$SAMPLE_ID, , drop=FALSE]
APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED <- APOP_PLOT7_AGRANULAR_QUAD_PLOT[!APOP_PLOT7_AGRANULAR_QUAD_PLOT$SAMPLE_ID %in% APOPTOSIS_Samples_Remove$SAMPLE_ID, , drop=FALSE]
APOP_PLOT4_GRANULAR_QUAD_PLOT_GATE_ADDED_BAD_REMOVED <- APOP_PLOT4_GRANULAR_QUAD_PLOT_GATE_ADDED[!APOP_PLOT4_GRANULAR_QUAD_PLOT_GATE_ADDED$SAMPLE_ID %in% APOPTOSIS_Samples_Remove$SAMPLE_ID, , drop=FALSE]
APOP_PLOT7_AGRANULAR_QUAD_PLOT_GATE_ADDED_BAD_REMOVED <- APOP_PLOT7_AGRANULAR_QUAD_PLOT_GATE_ADDED[!APOP_PLOT7_AGRANULAR_QUAD_PLOT_GATE_ADDED$SAMPLE_ID %in% APOPTOSIS_Samples_Remove$SAMPLE_ID, , drop=FALSE]
```

Arc sine Percentage data
========================

``` r
# NOTE: NA's produced whenever the percentages were above 100%
APOP_PLOT3_P1_GATE$Arcsine<- transf.arcsin(APOP_PLOT3_P1_GATE$P1_PERCENT_OF_THE_PLOT*0.01)
APOP_PLOT8_GRANULAR_AGRANULAR$P3_Arcsine <- transf.arcsin(APOP_PLOT8_GRANULAR_AGRANULAR$P3_PERCENT_OF_THIS_PLOT *0.01)
APOP_PLOT8_GRANULAR_AGRANULAR$P4_Arcsine <- transf.arcsin(APOP_PLOT8_GRANULAR_AGRANULAR$P4_PERCENT_OF_THIS_PLOT*0.01)

APOP_PLOT4_GRANULAR_QUAD_PLOT$Q2.UL_Arcsine <- transf.arcsin(APOP_PLOT4_GRANULAR_QUAD_PLOT$Q2.UL_PERCENT_OF_THIS_PLOT*0.01)
APOP_PLOT4_GRANULAR_QUAD_PLOT$Q2.UR_Arcsine <- transf.arcsin(APOP_PLOT4_GRANULAR_QUAD_PLOT$Q2.UR_PERCENT_OF_THIS_PLOT*0.01)
APOP_PLOT4_GRANULAR_QUAD_PLOT$Q2.LL_Arcsine <- transf.arcsin(APOP_PLOT4_GRANULAR_QUAD_PLOT$Q2.LL_PERCENT_OF_THIS_PLOT*0.01)
APOP_PLOT4_GRANULAR_QUAD_PLOT$Q2.LR_Arcsine <- transf.arcsin(APOP_PLOT4_GRANULAR_QUAD_PLOT$Q2.LR_PERCENT_OF_THIS_PLOT*0.01)

APOP_PLOT7_AGRANULAR_QUAD_PLOT$Q1.UL_Arcsine <- transf.arcsin(APOP_PLOT7_AGRANULAR_QUAD_PLOT$Q1.UL_PERCENT_OF_THIS_PLOT*0.01)
APOP_PLOT7_AGRANULAR_QUAD_PLOT$Q1.UR_Arcsine <- transf.arcsin(APOP_PLOT7_AGRANULAR_QUAD_PLOT$Q1.UR_PERCENT_OF_THIS_PLOT*0.01)
APOP_PLOT7_AGRANULAR_QUAD_PLOT$Q1.LL_Arcsine <- transf.arcsin(APOP_PLOT7_AGRANULAR_QUAD_PLOT$Q1.LL_PERCENT_OF_THIS_PLOT*0.01)
APOP_PLOT7_AGRANULAR_QUAD_PLOT$Q1.LR_Arcsine <- transf.arcsin(APOP_PLOT7_AGRANULAR_QUAD_PLOT$Q1.LR_PERCENT_OF_THIS_PLOT*0.01)

APOP_PLOT4_GRANULAR_QUAD_PLOT_GATE_ADDED$Arcsine <- transf.arcsin(APOP_PLOT4_GRANULAR_QUAD_PLOT_GATE_ADDED$PERCENT_OF_THIS_PLOT*0.01)
APOP_PLOT7_AGRANULAR_QUAD_PLOT_GATE_ADDED$Arcsine <- transf.arcsin(APOP_PLOT7_AGRANULAR_QUAD_PLOT_GATE_ADDED$PERCENT_OF_THIS_PLOT*0.01)

# NOTE: NA's produced whenever the percentages were above 100%
APOP_PLOT3_P1_GATE_BAD_REMOVED$Arcsine<- transf.arcsin(APOP_PLOT3_P1_GATE_BAD_REMOVED$P1_PERCENT_OF_THE_PLOT*0.01)
APOP_PLOT8_GRANULAR_AGRANULAR_BAD_REMOVED$P3_Arcsine <- transf.arcsin(APOP_PLOT8_GRANULAR_AGRANULAR_BAD_REMOVED$P3_PERCENT_OF_THIS_PLOT *0.01)
APOP_PLOT8_GRANULAR_AGRANULAR_BAD_REMOVED$P4_Arcsine <- transf.arcsin(APOP_PLOT8_GRANULAR_AGRANULAR_BAD_REMOVED$P4_PERCENT_OF_THIS_PLOT*0.01)

APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$Q2.UL_Arcsine <- transf.arcsin(APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$Q2.UL_PERCENT_OF_THIS_PLOT*0.01)
APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$Q2.UR_Arcsine <- transf.arcsin(APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$Q2.UR_PERCENT_OF_THIS_PLOT*0.01)
APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$Q2.LL_Arcsine <- transf.arcsin(APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$Q2.LL_PERCENT_OF_THIS_PLOT*0.01)
APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$Q2.LR_Arcsine <- transf.arcsin(APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$Q2.LR_PERCENT_OF_THIS_PLOT*0.01)

APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$Q1.UL_Arcsine <- transf.arcsin(APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$Q1.UL_PERCENT_OF_THIS_PLOT*0.01)
APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$Q1.UR_Arcsine <- transf.arcsin(APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$Q1.UR_PERCENT_OF_THIS_PLOT*0.01)
APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$Q1.LL_Arcsine <- transf.arcsin(APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$Q1.LL_PERCENT_OF_THIS_PLOT*0.01)
APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$Q1.LR_Arcsine <- transf.arcsin(APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$Q1.LR_PERCENT_OF_THIS_PLOT*0.01)

APOP_PLOT4_GRANULAR_QUAD_PLOT_GATE_ADDED_BAD_REMOVED$Arcsine <- transf.arcsin(APOP_PLOT4_GRANULAR_QUAD_PLOT_GATE_ADDED_BAD_REMOVED$PERCENT_OF_THIS_PLOT*0.01)
APOP_PLOT7_AGRANULAR_QUAD_PLOT_GATE_ADDED_BAD_REMOVED$Arcsine <- transf.arcsin(APOP_PLOT7_AGRANULAR_QUAD_PLOT_GATE_ADDED_BAD_REMOVED$PERCENT_OF_THIS_PLOT*0.01)
```

% LIVE apoptotic granular hemocytes (PLOT4, Q2-LR)
==================================================

Percent LIVE apoptotic granular hemocytes (PLOT4, Q2-LR)
--------------------------------------------------------

``` r
APOP_live_apoptotic_granular_BAD_NOT_REMOVED <- ggplot(data=APOP_PLOT4_GRANULAR_QUAD_PLOT, aes(x=FAMILY, y=Q2.LR_PERCENT_OF_THIS_PLOT, color=GROUP, by=GROUP)) + geom_boxplot() + ggtitle("Percent of Live Apoptotic Granular Hemocytes \n Low Quality Not Removed") +
    xlab("Family") + ylab("Percent of Hemocyte Events") + ylim(0,100)

APOP_live_apoptotic_granular_BAD_NOT_REMOVED
```

![](Dermo_Apoptosis_Assay_Data_analysis_files/figure-markdown_github/LIVE_apoptotic_Granular-1.png)

``` r
APOP_live_apoptotic_granular_BAD_REMOVED <- ggplot(data= APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED, aes(x=FAMILY, y=Q2.LR_PERCENT_OF_THIS_PLOT, color=GROUP, by=GROUP)) + geom_boxplot() + ggtitle("Percent of Live Apoptotic Granular Hemocytes \nLow Quality Removed") +
  xlab("Family") + ylab("Percent of Hemocyte Events") + ylim(0,100)
APOP_live_apoptotic_granular_BAD_REMOVED
```

![](Dermo_Apoptosis_Assay_Data_analysis_files/figure-markdown_github/LIVE_apoptotic_Granular-2.png)

### FAMILY A

``` r
APOP_PLOT_4_granular_FAMILY_A <- APOP_PLOT4_GRANULAR_QUAD_PLOT %>% filter(FAMILY=="A")
```

    ## Warning: package 'bindrcpp' was built under R version 3.4.4

``` r
APOP_PLOT_4_granular_FAMILY_A_AOV <- aov(APOP_PLOT_4_granular_FAMILY_A$Q2.LR_Arcsine ~ APOP_PLOT_4_granular_FAMILY_A$GROUP, data=APOP_PLOT_4_granular_FAMILY_A)
summary(APOP_PLOT_4_granular_FAMILY_A_AOV)
```

    ##                                     Df  Sum Sq  Mean Sq F value Pr(>F)  
    ## APOP_PLOT_4_granular_FAMILY_A$GROUP  1 0.01358 0.013577   6.941  0.025 *
    ## Residuals                           10 0.01956 0.001956                 
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

``` r
APOP_PLOT_4_granular_FAMILY_A_BAD_REMOVED <-  APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED %>% filter(FAMILY=="A")
APOP_PLOT_4_granular_FAMILY_A_AOV_BAD_REMOVED <- aov(APOP_PLOT_4_granular_FAMILY_A_BAD_REMOVED$Q2.LR_Arcsine ~ APOP_PLOT_4_granular_FAMILY_A_BAD_REMOVED$GROUP, data=APOP_PLOT_4_granular_FAMILY_A_BAD_REMOVED)
summary(APOP_PLOT_4_granular_FAMILY_A_AOV_BAD_REMOVED)      
```

    ##                                                 Df  Sum Sq  Mean Sq
    ## APOP_PLOT_4_granular_FAMILY_A_BAD_REMOVED$GROUP  1 0.01439 0.014394
    ## Residuals                                        9 0.01866 0.002073
    ##                                                 F value Pr(>F)  
    ## APOP_PLOT_4_granular_FAMILY_A_BAD_REMOVED$GROUP   6.944 0.0271 *
    ## Residuals                                                       
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

### FAMILY B

``` r
APOP_PLOT_4_granular_FAMILY_B <- APOP_PLOT4_GRANULAR_QUAD_PLOT %>% filter(FAMILY=="B")

APOP_PLOT_4_granular_FAMILY_B_AOV <- aov(APOP_PLOT_4_granular_FAMILY_B$Q2.LR_Arcsine ~ APOP_PLOT_4_granular_FAMILY_B$GROUP, data=APOP_PLOT_4_granular_FAMILY_B)
summary(APOP_PLOT_4_granular_FAMILY_B_AOV)
```

    ##                                     Df   Sum Sq   Mean Sq F value Pr(>F)
    ## APOP_PLOT_4_granular_FAMILY_B$GROUP  1 0.000152 0.0001523   0.072  0.795
    ## Residuals                            8 0.016816 0.0021020

``` r
APOP_PLOT_4_granular_FAMILY_B_BAD_REMOVED <-  APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED %>% filter(FAMILY=="B")
APOP_PLOT_4_granular_FAMILY_B_AOV_BAD_REMOVED <- aov(APOP_PLOT_4_granular_FAMILY_B_BAD_REMOVED$Q2.LR_Arcsine ~ APOP_PLOT_4_granular_FAMILY_B_BAD_REMOVED$GROUP, data=APOP_PLOT_4_granular_FAMILY_B_BAD_REMOVED)
summary(APOP_PLOT_4_granular_FAMILY_B_AOV_BAD_REMOVED)      
```

    ##                                                 Df   Sum Sq   Mean Sq
    ## APOP_PLOT_4_granular_FAMILY_B_BAD_REMOVED$GROUP  1 0.000105 0.0001049
    ## Residuals                                        7 0.016682 0.0023832
    ##                                                 F value Pr(>F)
    ## APOP_PLOT_4_granular_FAMILY_B_BAD_REMOVED$GROUP   0.044   0.84
    ## Residuals

### FAMILY D

``` r
APOP_PLOT_4_granular_FAMILY_D <- APOP_PLOT4_GRANULAR_QUAD_PLOT %>% filter(FAMILY=="D")

APOP_PLOT_4_granular_FAMILY_D_AOV <- aov(APOP_PLOT_4_granular_FAMILY_D$Q2.LR_Arcsine ~ APOP_PLOT_4_granular_FAMILY_D$GROUP, data=APOP_PLOT_4_granular_FAMILY_D)
summary(APOP_PLOT_4_granular_FAMILY_D_AOV)
```

    ##                                     Df   Sum Sq  Mean Sq F value Pr(>F)
    ## APOP_PLOT_4_granular_FAMILY_D$GROUP  1 0.000641 0.000641   0.186  0.679
    ## Residuals                            7 0.024111 0.003444

``` r
APOP_PLOT_4_granular_FAMILY_D_BAD_REMOVED <-  APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED %>% filter(FAMILY=="D")
APOP_PLOT_4_granular_FAMILY_D_AOV_BAD_REMOVED <- aov(APOP_PLOT_4_granular_FAMILY_D_BAD_REMOVED$Q2.LR_Arcsine ~ APOP_PLOT_4_granular_FAMILY_D_BAD_REMOVED$GROUP, data=APOP_PLOT_4_granular_FAMILY_D_BAD_REMOVED)
summary(APOP_PLOT_4_granular_FAMILY_D_AOV_BAD_REMOVED)      
```

    ##                                                 Df   Sum Sq  Mean Sq
    ## APOP_PLOT_4_granular_FAMILY_D_BAD_REMOVED$GROUP  1 0.000555 0.000555
    ## Residuals                                        6 0.024063 0.004011
    ##                                                 F value Pr(>F)
    ## APOP_PLOT_4_granular_FAMILY_D_BAD_REMOVED$GROUP   0.138  0.723
    ## Residuals

### FAMILY E

``` r
APOP_PLOT_4_granular_FAMILY_E <- APOP_PLOT4_GRANULAR_QUAD_PLOT %>% filter(FAMILY=="E")

APOP_PLOT_4_granular_FAMILY_E_AOV <- aov(APOP_PLOT_4_granular_FAMILY_E$Q2.LR_Arcsine ~ APOP_PLOT_4_granular_FAMILY_E$GROUP, data=APOP_PLOT_4_granular_FAMILY_E)
summary(APOP_PLOT_4_granular_FAMILY_E_AOV)
```

    ##                                     Df  Sum Sq  Mean Sq F value Pr(>F)
    ## APOP_PLOT_4_granular_FAMILY_E$GROUP  1 0.00302 0.003024     0.7  0.425
    ## Residuals                            9 0.03889 0.004322

``` r
APOP_PLOT_4_granular_FAMILY_E_BAD_REMOVED <-  APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED %>% filter(FAMILY=="E")
APOP_PLOT_4_granular_FAMILY_E_AOV_BAD_REMOVED <- aov(APOP_PLOT_4_granular_FAMILY_E_BAD_REMOVED$Q2.LR_Arcsine ~ APOP_PLOT_4_granular_FAMILY_E_BAD_REMOVED$GROUP, data=APOP_PLOT_4_granular_FAMILY_E_BAD_REMOVED)
summary(APOP_PLOT_4_granular_FAMILY_E_AOV_BAD_REMOVED)      
```

    ##                                                 Df  Sum Sq  Mean Sq
    ## APOP_PLOT_4_granular_FAMILY_E_BAD_REMOVED$GROUP  1 0.00337 0.003369
    ## Residuals                                        7 0.03377 0.004825
    ##                                                 F value Pr(>F)
    ## APOP_PLOT_4_granular_FAMILY_E_BAD_REMOVED$GROUP   0.698  0.431
    ## Residuals

### FAMILY J

``` r
APOP_PLOT_4_granular_FAMILY_J <- APOP_PLOT4_GRANULAR_QUAD_PLOT %>% filter(FAMILY=="J")

APOP_PLOT_4_granular_FAMILY_J_AOV <- aov(APOP_PLOT_4_granular_FAMILY_J$Q2.LR_Arcsine ~ APOP_PLOT_4_granular_FAMILY_J$GROUP, data=APOP_PLOT_4_granular_FAMILY_J)
summary(APOP_PLOT_4_granular_FAMILY_J_AOV)
```

    ##                                     Df  Sum Sq  Mean Sq F value Pr(>F)
    ## APOP_PLOT_4_granular_FAMILY_J$GROUP  1 0.00301 0.003008    0.81  0.387
    ## Residuals                           11 0.04085 0.003714

``` r
APOP_PLOT_4_granular_FAMILY_J_BAD_REMOVED <-  APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED %>% filter(FAMILY=="J")
APOP_PLOT_4_granular_FAMILY_J_AOV_BAD_REMOVED <- aov(APOP_PLOT_4_granular_FAMILY_J_BAD_REMOVED$Q2.LR_Arcsine ~ APOP_PLOT_4_granular_FAMILY_J_BAD_REMOVED$GROUP, data=APOP_PLOT_4_granular_FAMILY_J_BAD_REMOVED)
summary(APOP_PLOT_4_granular_FAMILY_J_AOV_BAD_REMOVED)      
```

    ##                                                 Df  Sum Sq  Mean Sq
    ## APOP_PLOT_4_granular_FAMILY_J_BAD_REMOVED$GROUP  1 0.00264 0.002637
    ## Residuals                                        9 0.03916 0.004351
    ##                                                 F value Pr(>F)
    ## APOP_PLOT_4_granular_FAMILY_J_BAD_REMOVED$GROUP   0.606  0.456
    ## Residuals

### FAMILY L

``` r
APOP_PLOT_4_granular_FAMILY_L <- APOP_PLOT4_GRANULAR_QUAD_PLOT %>% filter(FAMILY=="L")

APOP_PLOT_4_granular_FAMILY_L_AOV <- aov(APOP_PLOT_4_granular_FAMILY_L$Q2.LR_Arcsine ~ APOP_PLOT_4_granular_FAMILY_L$GROUP, data=APOP_PLOT_4_granular_FAMILY_L)
summary(APOP_PLOT_4_granular_FAMILY_L_AOV)
```

    ##                                     Df  Sum Sq  Mean Sq F value Pr(>F)
    ## APOP_PLOT_4_granular_FAMILY_L$GROUP  1 0.00215 0.002148   0.127  0.728
    ## Residuals                           11 0.18628 0.016934

``` r
APOP_PLOT_4_granular_FAMILY_L_BAD_REMOVED <-  APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED %>% filter(FAMILY=="L")
APOP_PLOT_4_granular_FAMILY_L_AOV_BAD_REMOVED <- aov(APOP_PLOT_4_granular_FAMILY_L_BAD_REMOVED$Q2.LR_Arcsine ~ APOP_PLOT_4_granular_FAMILY_L_BAD_REMOVED$GROUP, data=APOP_PLOT_4_granular_FAMILY_L_BAD_REMOVED)
summary(APOP_PLOT_4_granular_FAMILY_L_AOV_BAD_REMOVED)      
```

    ##                                                 Df  Sum Sq  Mean Sq
    ## APOP_PLOT_4_granular_FAMILY_L_BAD_REMOVED$GROUP  1 0.00026 0.000265
    ## Residuals                                        7 0.09139 0.013055
    ##                                                 F value Pr(>F)
    ## APOP_PLOT_4_granular_FAMILY_L_BAD_REMOVED$GROUP    0.02  0.891
    ## Residuals

### TWO WAY ANOVA of granular apoptotic

``` r
APOP_PLOT_4_granular_TWO_WAY_AOV <- lm(APOP_PLOT4_GRANULAR_QUAD_PLOT$Q2.LR_Arcsine ~ APOP_PLOT4_GRANULAR_QUAD_PLOT$GROUP + APOP_PLOT4_GRANULAR_QUAD_PLOT$FAMILY, data=APOP_PLOT4_GRANULAR_QUAD_PLOT)
Anova(APOP_PLOT_4_granular_TWO_WAY_AOV, type="II") 
```

    ## Anova Table (Type II tests)
    ## 
    ## Response: APOP_PLOT4_GRANULAR_QUAD_PLOT$Q2.LR_Arcsine
    ##                                       Sum Sq Df F value    Pr(>F)    
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT$GROUP  0.00382  1  0.6746    0.4147    
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT$FAMILY 0.18589  5  6.5688 5.984e-05 ***
    ## Residuals                            0.34524 61                      
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

``` r
summary(APOP_PLOT_4_granular_TWO_WAY_AOV) #produces the overall p-value and r squared
```

    ## 
    ## Call:
    ## lm(formula = APOP_PLOT4_GRANULAR_QUAD_PLOT$Q2.LR_Arcsine ~ APOP_PLOT4_GRANULAR_QUAD_PLOT$GROUP + 
    ##     APOP_PLOT4_GRANULAR_QUAD_PLOT$FAMILY, data = APOP_PLOT4_GRANULAR_QUAD_PLOT)
    ## 
    ## Residuals:
    ##       Min        1Q    Median        3Q       Max 
    ## -0.161646 -0.036986 -0.005016  0.047921  0.211104 
    ## 
    ## Coefficients:
    ##                                                Estimate Std. Error t value
    ## (Intercept)                                   0.2326651  0.0272899   8.526
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT$GROUPtreatment -0.0180971  0.0220342  -0.821
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT$FAMILYB         0.1123507  0.0322308   3.486
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT$FAMILYD         0.0636212  0.0331793   1.917
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT$FAMILYE        -0.0008313  0.0314390  -0.026
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT$FAMILYJ         0.0364005  0.0301194   1.209
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT$FAMILYL        -0.0536973  0.0301194  -1.783
    ##                                              Pr(>|t|)    
    ## (Intercept)                                  5.51e-12 ***
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT$GROUPtreatment 0.414664    
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT$FAMILYB        0.000915 ***
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT$FAMILYD        0.059861 .  
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT$FAMILYE        0.978991    
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT$FAMILYJ        0.231504    
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT$FAMILYL        0.079593 .  
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
    ## 
    ## Residual standard error: 0.07523 on 61 degrees of freedom
    ## Multiple R-squared:  0.3536, Adjusted R-squared:  0.2901 
    ## F-statistic: 5.562 on 6 and 61 DF,  p-value: 0.0001191

``` r
#checking model assumptions, should be approximately normally distributed
hist(residuals(APOP_PLOT_4_granular_TWO_WAY_AOV))
```

![](Dermo_Apoptosis_Assay_Data_analysis_files/figure-markdown_github/live_granular_apoptotic_aov-1.png)

``` r
# Bad samples removed 
APOP_PLOT_4_granular_TWO_WAY_AOV_BAD_REMOVED <- lm(APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$Q2.LR_Arcsine ~ APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$GROUP + APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILY, data=APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED)
Anova(APOP_PLOT_4_granular_TWO_WAY_AOV_BAD_REMOVED, type="II")
```

    ## Anova Table (Type II tests)
    ## 
    ## Response: APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$Q2.LR_Arcsine
    ##                                                    Sum Sq Df F value
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$GROUP  0.001181  1  0.2422
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILY 0.147054  5  6.0303
    ## Residuals                                        0.243859 50        
    ##                                                     Pr(>F)    
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$GROUP  0.6247616    
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILY 0.0001929 ***
    ## Residuals                                                     
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

``` r
summary(APOP_PLOT_4_granular_TWO_WAY_AOV_BAD_REMOVED)
```

    ## 
    ## Call:
    ## lm(formula = APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$Q2.LR_Arcsine ~ 
    ##     APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$GROUP + APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILY, 
    ##     data = APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED)
    ## 
    ## Residuals:
    ##       Min        1Q    Median        3Q       Max 
    ## -0.156785 -0.035208 -0.008663  0.050641  0.128322 
    ## 
    ## Coefficients:
    ##                                                            Estimate
    ## (Intercept)                                               0.2261910
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$GROUPtreatment -0.0108772
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYB         0.1113887
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYD         0.0628110
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYE         0.0003187
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYJ         0.0406543
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYL        -0.0520848
    ##                                                          Std. Error
    ## (Intercept)                                               0.0264903
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$GROUPtreatment  0.0221011
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYB         0.0314092
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYD         0.0324543
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYE         0.0314092
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYJ         0.0298462
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYL         0.0314092
    ##                                                          t value Pr(>|t|)
    ## (Intercept)                                                8.539 2.47e-11
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$GROUPtreatment  -0.492 0.624762
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYB          3.546 0.000859
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYD          1.935 0.058611
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYE          0.010 0.991943
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYJ          1.362 0.179264
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYL         -1.658 0.103525
    ##                                                             
    ## (Intercept)                                              ***
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$GROUPtreatment    
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYB        ***
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYD        .  
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYE           
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYJ           
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYL           
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
    ## 
    ## Residual standard error: 0.06984 on 50 degrees of freedom
    ## Multiple R-squared:  0.3777, Adjusted R-squared:  0.303 
    ## F-statistic: 5.057 on 6 and 50 DF,  p-value: 0.0004028

``` r
#checking model assumptions
hist(residuals(APOP_PLOT_4_granular_TWO_WAY_AOV_BAD_REMOVED))
```

![](Dermo_Apoptosis_Assay_Data_analysis_files/figure-markdown_github/live_granular_apoptotic_aov-2.png)

``` r
# INTERACTION TERM ADDED  (using lm model)
APOP_PLOT_4_granular_hemocytes_INTERACTION_aov <- lm(APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$Q2.LR_Arcsine ~ APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILY + APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$GROUP + APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILY:APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$GROUP)
Anova(APOP_PLOT_4_granular_hemocytes_INTERACTION_aov, type="II") # effect of Family is significant, but interaction and group are not
```

    ## Anova Table (Type II tests)
    ## 
    ## Response: APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$Q2.LR_Arcsine
    ##                                                                                                    Sum Sq
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILY                                                 0.147054
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$GROUP                                                  0.001181
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILY:APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$GROUP 0.020142
    ## Residuals                                                                                        0.223717
    ##                                                                                                  Df
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILY                                                  5
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$GROUP                                                   1
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILY:APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$GROUP  5
    ## Residuals                                                                                        45
    ##                                                                                                  F value
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILY                                                  5.9159
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$GROUP                                                   0.2376
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILY:APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$GROUP  0.8103
    ## Residuals                                                                                               
    ##                                                                                                     Pr(>F)
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILY                                                 0.0002768
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$GROUP                                                  0.6282932
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILY:APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$GROUP 0.5485274
    ## Residuals                                                                                                 
    ##                                                                                                     
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILY                                                 ***
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$GROUP                                                     
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILY:APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$GROUP    
    ## Residuals                                                                                           
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

``` r
summary(APOP_PLOT_4_granular_hemocytes_INTERACTION_aov)
```

    ## 
    ## Call:
    ## lm(formula = APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$Q2.LR_Arcsine ~ 
    ##     APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILY + APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$GROUP + 
    ##         APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILY:APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$GROUP)
    ## 
    ## Residuals:
    ##       Min        1Q    Median        3Q       Max 
    ## -0.142269 -0.040523 -0.000724  0.054220  0.138182 
    ## 
    ## Coefficients:
    ##                                                                                                            Estimate
    ## (Intercept)                                                                                                 0.27735
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYB                                                           0.04538
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYD                                                          -0.01093
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYE                                                          -0.09550
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYJ                                                           0.01344
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYL                                                          -0.12185
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$GROUPtreatment                                                   -0.08122
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYB:APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$GROUPtreatment  0.08943
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYD:APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$GROUPtreatment  0.10045
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYE:APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$GROUPtreatment  0.12776
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYJ:APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$GROUPtreatment  0.04108
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYL:APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$GROUPtreatment  0.09426
    ##                                                                                                            Std. Error
    ## (Intercept)                                                                                                   0.04071
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYB                                                             0.06437
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYD                                                             0.06437
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYE                                                             0.06437
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYJ                                                             0.06437
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYL                                                             0.06437
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$GROUPtreatment                                                      0.04773
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYB:APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$GROUPtreatment    0.07399
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYD:APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$GROUPtreatment    0.07479
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYE:APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$GROUPtreatment    0.07399
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYJ:APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$GROUPtreatment    0.07292
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYL:APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$GROUPtreatment    0.07399
    ##                                                                                                            t value
    ## (Intercept)                                                                                                  6.813
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYB                                                            0.705
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYD                                                           -0.170
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYE                                                           -1.484
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYJ                                                            0.209
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYL                                                           -1.893
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$GROUPtreatment                                                    -1.702
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYB:APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$GROUPtreatment   1.209
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYD:APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$GROUPtreatment   1.343
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYE:APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$GROUPtreatment   1.727
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYJ:APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$GROUPtreatment   0.563
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYL:APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$GROUPtreatment   1.274
    ##                                                                                                            Pr(>|t|)
    ## (Intercept)                                                                                                1.93e-08
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYB                                                            0.4844
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYD                                                            0.8659
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYE                                                            0.1449
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYJ                                                            0.8356
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYL                                                            0.0648
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$GROUPtreatment                                                     0.0957
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYB:APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$GROUPtreatment   0.2331
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYD:APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$GROUPtreatment   0.1859
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYE:APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$GROUPtreatment   0.0911
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYJ:APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$GROUPtreatment   0.5760
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYL:APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$GROUPtreatment   0.2092
    ##                                                                                                               
    ## (Intercept)                                                                                                ***
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYB                                                             
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYD                                                             
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYE                                                             
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYJ                                                             
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYL                                                          .  
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$GROUPtreatment                                                   .  
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYB:APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$GROUPtreatment    
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYD:APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$GROUPtreatment    
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYE:APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$GROUPtreatment .  
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYJ:APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$GROUPtreatment    
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYL:APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$GROUPtreatment    
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
    ## 
    ## Residual standard error: 0.07051 on 45 degrees of freedom
    ## Multiple R-squared:  0.4291, Adjusted R-squared:  0.2895 
    ## F-statistic: 3.074 on 11 and 45 DF,  p-value: 0.003765

``` r
# Mean separation for main factor with lsmeans
lsmeans = lsmeans::lsmeans
APOP_PLOT_4_granular_hemocytes_INTERACTION_leastsquare <- lsmeans(APOP_PLOT_4_granular_hemocytes_INTERACTION_aov, "APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILY", adjust="tukey")
cld(APOP_PLOT_4_granular_hemocytes_INTERACTION_leastsquare, alpha=0.05, Letters=letters)
```

    ##  APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILY    lsmean         SE df
    ##  A                                                0.1961286 0.02492861 45
    ##  B                                                0.1961286 0.02492861 45
    ##  D                                                0.2367400 0.02386733 45
    ##  E                                                0.2367400 0.02386733 45
    ##  J                                                0.2367400 0.02386733 45
    ##  L                                                0.2635365 0.01824588 45
    ##   lower.CL  upper.CL .group
    ##  0.1459198 0.2463374  a    
    ##  0.1459198 0.2463374  a    
    ##  0.1886687 0.2848113  ab   
    ##  0.1886687 0.2848113  ab   
    ##  0.1886687 0.2848113  ab   
    ##  0.2267874 0.3002856   b   
    ## 
    ## Results are averaged over the levels of: APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$GROUP 
    ## Confidence level used: 0.95 
    ## P value adjustment: tukey method for comparing a family of 6 estimates 
    ## significance level used: alpha = 0.05

### One Way ANOVA of Differences between Families

``` r
APOP_PLOT_4_granular_hemocytes_BAD_REMOVED_CHALLENGE <- APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED[!grepl("control", APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$GROUP),]
APOP_PLOT_4_granular_hemocytes_oneway_aov <- aov(APOP_PLOT_4_granular_hemocytes_BAD_REMOVED_CHALLENGE$Q2.LR_Arcsine ~ APOP_PLOT_4_granular_hemocytes_BAD_REMOVED_CHALLENGE$FAMILY, data=APOP_PLOT_4_granular_hemocytes_BAD_REMOVED_CHALLENGE)
summary(APOP_PLOT_4_granular_hemocytes_oneway_aov)
```

    ##                                                             Df Sum Sq
    ## APOP_PLOT_4_granular_hemocytes_BAD_REMOVED_CHALLENGE$FAMILY  5 0.1234
    ## Residuals                                                   38 0.1567
    ##                                                              Mean Sq
    ## APOP_PLOT_4_granular_hemocytes_BAD_REMOVED_CHALLENGE$FAMILY 0.024676
    ## Residuals                                                   0.004122
    ##                                                             F value
    ## APOP_PLOT_4_granular_hemocytes_BAD_REMOVED_CHALLENGE$FAMILY   5.986
    ## Residuals                                                          
    ##                                                               Pr(>F)    
    ## APOP_PLOT_4_granular_hemocytes_BAD_REMOVED_CHALLENGE$FAMILY 0.000354 ***
    ## Residuals                                                               
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

``` r
TukeyHSD(APOP_PLOT_4_granular_hemocytes_oneway_aov)
```

    ##   Tukey multiple comparisons of means
    ##     95% family-wise confidence level
    ## 
    ## Fit: aov(formula = APOP_PLOT_4_granular_hemocytes_BAD_REMOVED_CHALLENGE$Q2.LR_Arcsine ~ APOP_PLOT_4_granular_hemocytes_BAD_REMOVED_CHALLENGE$FAMILY, data = APOP_PLOT_4_granular_hemocytes_BAD_REMOVED_CHALLENGE)
    ## 
    ## $`APOP_PLOT_4_granular_hemocytes_BAD_REMOVED_CHALLENGE$FAMILY`
    ##            diff         lwr           upr     p adj
    ## B-A  0.13481580  0.03512765  0.2345039522 0.0030377
    ## D-A  0.08952292 -0.01450151  0.1935473473 0.1267722
    ## E-A  0.03226255 -0.06742561  0.1319506993 0.9243084
    ## J-A  0.05451846 -0.03907600  0.1481129162 0.5103932
    ## L-A -0.02758463 -0.12727278  0.0721035213 0.9599896
    ## D-B -0.04529288 -0.15245442  0.0618686655 0.8001434
    ## E-B -0.10255325 -0.20551073  0.0004042288 0.0514144
    ## J-B -0.08029734 -0.17736659  0.0167719010 0.1552369
    ## L-B -0.16240043 -0.26535791 -0.0594429493 0.0004127
    ## E-D -0.05726037 -0.16442192  0.0499011705 0.6016887
    ## J-D -0.03500446 -0.13652191  0.0665129813 0.9032753
    ## L-D -0.11710755 -0.22426910 -0.0099460075 0.0252225
    ## J-E  0.02225591 -0.07481334  0.1193251539 0.9822508
    ## L-E -0.05984718 -0.16280466  0.0431103036 0.5126743
    ## L-J -0.08210309 -0.17917233  0.0149661573 0.1388098

% LIVE apoptotic agranular hemocytes (PLOT 7, Q1-LR)
====================================================

Percent LIVE apoptotic agranular hemocytes (PLOT7, Q1-LR)
---------------------------------------------------------

``` r
APOP_live_apoptotic_Agranular_BAD_NOT_REMOVED <- ggplot(data=APOP_PLOT7_AGRANULAR_QUAD_PLOT, aes(x=FAMILY, y=Q1.LR_PERCENT_OF_THIS_PLOT, color=GROUP, by=GROUP)) + geom_boxplot() + ggtitle("Percent of Live Apoptotic Agranular Hemocytes \n Low Quality Not Removed") + xlab("Family") + ylab("Percent of Hemocyte Events") + ylim(0,100)

APOP_live_apoptotic_Agranular_BAD_NOT_REMOVED
```

![](Dermo_Apoptosis_Assay_Data_analysis_files/figure-markdown_github/live_apoptotic_agranular-1.png)

``` r
APOP_live_apoptotic_Agranular_BAD_REMOVED <- ggplot(data= APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED, aes(x=FAMILY, y=Q1.LR_PERCENT_OF_THIS_PLOT, color=GROUP, by=GROUP)) + geom_boxplot() + ggtitle("Percent of Live Apoptotic Agranular Hemocytes \nLow Quality Removed") +
  xlab("Family") + ylab("Percent of Hemocyte Events") + ylim(0,100)
APOP_live_apoptotic_Agranular_BAD_REMOVED
```

![](Dermo_Apoptosis_Assay_Data_analysis_files/figure-markdown_github/live_apoptotic_agranular-2.png)

### FAMILY A

``` r
APOP_PLOT_7_agranular_FAMILY_A <- APOP_PLOT7_AGRANULAR_QUAD_PLOT %>% filter(FAMILY=="A")

APOP_PLOT_7_agranular_FAMILY_A_AOV <- aov(APOP_PLOT_7_agranular_FAMILY_A$Q1.LR_Arcsine ~ APOP_PLOT_7_agranular_FAMILY_A$GROUP, data=APOP_PLOT_7_agranular_FAMILY_A)
summary(APOP_PLOT_7_agranular_FAMILY_A_AOV)
```

    ##                                      Df  Sum Sq  Mean Sq F value Pr(>F)
    ## APOP_PLOT_7_agranular_FAMILY_A$GROUP  1 0.00432 0.004324   1.011  0.338
    ## Residuals                            10 0.04276 0.004276

``` r
APOP_PLOT_7_agranular_FAMILY_A_BAD_REMOVED <-  APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED %>% filter(FAMILY=="A")
APOP_PLOT_7_agranular_FAMILY_A_AOV_BAD_REMOVED <- aov(APOP_PLOT_7_agranular_FAMILY_A_BAD_REMOVED$Q1.LR_Arcsine ~ APOP_PLOT_7_agranular_FAMILY_A_BAD_REMOVED$GROUP, data=APOP_PLOT_7_agranular_FAMILY_A_BAD_REMOVED)
summary(APOP_PLOT_7_agranular_FAMILY_A_AOV_BAD_REMOVED)      
```

    ##                                                  Df  Sum Sq  Mean Sq
    ## APOP_PLOT_7_agranular_FAMILY_A_BAD_REMOVED$GROUP  1 0.00647 0.006467
    ## Residuals                                         9 0.03466 0.003851
    ##                                                  F value Pr(>F)
    ## APOP_PLOT_7_agranular_FAMILY_A_BAD_REMOVED$GROUP   1.679  0.227
    ## Residuals

### FAMILY B

    ##                                      Df  Sum Sq  Mean Sq F value Pr(>F)
    ## APOP_PLOT_7_agranular_FAMILY_B$GROUP  1 0.00283 0.002827   0.292  0.603
    ## Residuals                             8 0.07734 0.009667

    ##                                                  Df  Sum Sq  Mean Sq
    ## APOP_PLOT_7_agranular_FAMILY_B_BAD_REMOVED$GROUP  1 0.00421 0.004207
    ## Residuals                                         7 0.07177 0.010253
    ##                                                  F value Pr(>F)
    ## APOP_PLOT_7_agranular_FAMILY_B_BAD_REMOVED$GROUP    0.41  0.542
    ## Residuals

### FAMILY D

``` r
APOP_PLOT_7_agranular_FAMILY_D <- APOP_PLOT7_AGRANULAR_QUAD_PLOT %>% filter(FAMILY=="D")

APOP_PLOT_7_agranular_FAMILY_D_AOV <- aov(APOP_PLOT_7_agranular_FAMILY_D$Q1.LR_Arcsine ~ APOP_PLOT_7_agranular_FAMILY_D$GROUP, data=APOP_PLOT_7_agranular_FAMILY_D)
summary(APOP_PLOT_7_agranular_FAMILY_D_AOV)
```

    ##                                      Df  Sum Sq Mean Sq F value Pr(>F)
    ## APOP_PLOT_7_agranular_FAMILY_D$GROUP  1 0.01432 0.01432   3.027  0.125
    ## Residuals                             7 0.03311 0.00473

``` r
APOP_PLOT_7_agranular_FAMILY_D_BAD_REMOVED <-  APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED %>% filter(FAMILY=="D")
APOP_PLOT_7_agranular_FAMILY_D_AOV_BAD_REMOVED <- aov(APOP_PLOT_7_agranular_FAMILY_D_BAD_REMOVED$Q1.LR_Arcsine ~ APOP_PLOT_7_agranular_FAMILY_D_BAD_REMOVED$GROUP, data=APOP_PLOT_7_agranular_FAMILY_D_BAD_REMOVED)
summary(APOP_PLOT_7_agranular_FAMILY_D_AOV_BAD_REMOVED)      
```

    ##                                                  Df  Sum Sq Mean Sq
    ## APOP_PLOT_7_agranular_FAMILY_D_BAD_REMOVED$GROUP  1 0.01585 0.01585
    ## Residuals                                         6 0.03114 0.00519
    ##                                                  F value Pr(>F)
    ## APOP_PLOT_7_agranular_FAMILY_D_BAD_REMOVED$GROUP   3.054  0.131
    ## Residuals

### FAMILY E

``` r
APOP_PLOT_7_agranular_FAMILY_E <- APOP_PLOT7_AGRANULAR_QUAD_PLOT %>% filter(FAMILY=="E")

APOP_PLOT_7_agranular_FAMILY_E_AOV <- aov(APOP_PLOT_7_agranular_FAMILY_E$Q1.LR_Arcsine ~ APOP_PLOT_7_agranular_FAMILY_E$GROUP, data=APOP_PLOT_7_agranular_FAMILY_E)
summary(APOP_PLOT_7_agranular_FAMILY_E_AOV)
```

    ##                                      Df  Sum Sq Mean Sq F value Pr(>F)
    ## APOP_PLOT_7_agranular_FAMILY_E$GROUP  1 0.01485 0.01485   1.111  0.319
    ## Residuals                             9 0.12025 0.01336

``` r
APOP_PLOT_7_agranular_FAMILY_E_BAD_REMOVED <-  APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED %>% filter(FAMILY=="E")
APOP_PLOT_7_agranular_FAMILY_E_AOV_BAD_REMOVED <- aov(APOP_PLOT_7_agranular_FAMILY_E_BAD_REMOVED$Q1.LR_Arcsine ~ APOP_PLOT_7_agranular_FAMILY_E_BAD_REMOVED$GROUP, data=APOP_PLOT_7_agranular_FAMILY_E_BAD_REMOVED)
summary(APOP_PLOT_7_agranular_FAMILY_E_AOV_BAD_REMOVED)      
```

    ##                                                  Df  Sum Sq Mean Sq
    ## APOP_PLOT_7_agranular_FAMILY_E_BAD_REMOVED$GROUP  1 0.01347 0.01348
    ## Residuals                                         7 0.10284 0.01469
    ##                                                  F value Pr(>F)
    ## APOP_PLOT_7_agranular_FAMILY_E_BAD_REMOVED$GROUP   0.917   0.37
    ## Residuals

### FAMILY J

``` r
APOP_PLOT_7_agranular_FAMILY_J <- APOP_PLOT7_AGRANULAR_QUAD_PLOT %>% filter(FAMILY=="J")

APOP_PLOT_7_agranular_FAMILY_J_AOV <- aov(APOP_PLOT_7_agranular_FAMILY_J$Q1.LR_Arcsine ~ APOP_PLOT_7_agranular_FAMILY_J$GROUP, data=APOP_PLOT_7_agranular_FAMILY_J)
summary(APOP_PLOT_7_agranular_FAMILY_J_AOV)
```

    ##                                      Df Sum Sq Mean Sq F value Pr(>F)
    ## APOP_PLOT_7_agranular_FAMILY_J$GROUP  1 0.0127 0.01270   1.096  0.318
    ## Residuals                            11 0.1274 0.01158

``` r
APOP_PLOT_7_agranular_FAMILY_J_BAD_REMOVED <-  APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED %>% filter(FAMILY=="J")
APOP_PLOT_7_agranular_FAMILY_J_AOV_BAD_REMOVED <- aov(APOP_PLOT_7_agranular_FAMILY_J_BAD_REMOVED$Q1.LR_Arcsine ~ APOP_PLOT_7_agranular_FAMILY_J_BAD_REMOVED$GROUP, data=APOP_PLOT_7_agranular_FAMILY_J_BAD_REMOVED)
summary(APOP_PLOT_7_agranular_FAMILY_J_AOV_BAD_REMOVED)      
```

    ##                                                  Df Sum Sq Mean Sq F value
    ## APOP_PLOT_7_agranular_FAMILY_J_BAD_REMOVED$GROUP  1 0.0176 0.01760   1.664
    ## Residuals                                         9 0.0952 0.01058        
    ##                                                  Pr(>F)
    ## APOP_PLOT_7_agranular_FAMILY_J_BAD_REMOVED$GROUP  0.229
    ## Residuals

### FAMILY L

``` r
APOP_PLOT_7_agranular_FAMILY_L <- APOP_PLOT7_AGRANULAR_QUAD_PLOT %>% filter(FAMILY=="L")

APOP_PLOT_7_agranular_FAMILY_L_AOV <- aov(APOP_PLOT_7_agranular_FAMILY_L$Q1.LR_Arcsine ~ APOP_PLOT_7_agranular_FAMILY_L$GROUP, data=APOP_PLOT_7_agranular_FAMILY_L)
summary(APOP_PLOT_7_agranular_FAMILY_L_AOV)
```

    ##                                      Df  Sum Sq  Mean Sq F value Pr(>F)
    ## APOP_PLOT_7_agranular_FAMILY_L$GROUP  1 0.00588 0.005882    0.59  0.458
    ## Residuals                            11 0.10961 0.009965

``` r
APOP_PLOT_7_agranular_FAMILY_L_BAD_REMOVED <-  APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED %>% filter(FAMILY=="L")
APOP_PLOT_7_agranular_FAMILY_L_AOV_BAD_REMOVED <- aov(APOP_PLOT_7_agranular_FAMILY_L_BAD_REMOVED$Q1.LR_Arcsine ~ APOP_PLOT_7_agranular_FAMILY_L_BAD_REMOVED$GROUP, data=APOP_PLOT_7_agranular_FAMILY_L_BAD_REMOVED)
summary(APOP_PLOT_7_agranular_FAMILY_L_AOV_BAD_REMOVED)      
```

    ##                                                  Df  Sum Sq  Mean Sq
    ## APOP_PLOT_7_agranular_FAMILY_L_BAD_REMOVED$GROUP  1 0.00017 0.000169
    ## Residuals                                         7 0.05306 0.007580
    ##                                                  F value Pr(>F)
    ## APOP_PLOT_7_agranular_FAMILY_L_BAD_REMOVED$GROUP   0.022  0.886
    ## Residuals

### TWO WAY ANOVA

``` r
APOP_PLOT_7_agranular_TWO_WAY_AOV <- lm(APOP_PLOT7_AGRANULAR_QUAD_PLOT$Q1.LR_Arcsine ~ APOP_PLOT7_AGRANULAR_QUAD_PLOT$GROUP + APOP_PLOT7_AGRANULAR_QUAD_PLOT$FAMILY, data=APOP_PLOT7_AGRANULAR_QUAD_PLOT)
Anova(APOP_PLOT_7_agranular_TWO_WAY_AOV, type="II") #significant family effect
```

    ## Anova Table (Type II tests)
    ## 
    ## Response: APOP_PLOT7_AGRANULAR_QUAD_PLOT$Q1.LR_Arcsine
    ##                                        Sum Sq Df F value Pr(>F)  
    ## APOP_PLOT7_AGRANULAR_QUAD_PLOT$GROUP  0.00837  1  0.9171 0.3420  
    ## APOP_PLOT7_AGRANULAR_QUAD_PLOT$FAMILY 0.11327  5  2.4809 0.0413 *
    ## Residuals                             0.55701 61                 
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

``` r
summary(APOP_PLOT_7_agranular_TWO_WAY_AOV) # p-value overall is significant
```

    ## 
    ## Call:
    ## lm(formula = APOP_PLOT7_AGRANULAR_QUAD_PLOT$Q1.LR_Arcsine ~ APOP_PLOT7_AGRANULAR_QUAD_PLOT$GROUP + 
    ##     APOP_PLOT7_AGRANULAR_QUAD_PLOT$FAMILY, data = APOP_PLOT7_AGRANULAR_QUAD_PLOT)
    ## 
    ## Residuals:
    ##       Min        1Q    Median        3Q       Max 
    ## -0.208061 -0.057807  0.001519  0.062035  0.267726 
    ## 
    ## Coefficients:
    ##                                               Estimate Std. Error t value
    ## (Intercept)                                    0.21904    0.03466   6.319
    ## APOP_PLOT7_AGRANULAR_QUAD_PLOT$GROUPtreatment -0.02680    0.02799  -0.958
    ## APOP_PLOT7_AGRANULAR_QUAD_PLOT$FAMILYB         0.02510    0.04094   0.613
    ## APOP_PLOT7_AGRANULAR_QUAD_PLOT$FAMILYD         0.04606    0.04214   1.093
    ## APOP_PLOT7_AGRANULAR_QUAD_PLOT$FAMILYE        -0.01098    0.03993  -0.275
    ## APOP_PLOT7_AGRANULAR_QUAD_PLOT$FAMILYJ         0.04784    0.03826   1.251
    ## APOP_PLOT7_AGRANULAR_QUAD_PLOT$FAMILYL        -0.06685    0.03826  -1.747
    ##                                               Pr(>|t|)    
    ## (Intercept)                                   3.38e-08 ***
    ## APOP_PLOT7_AGRANULAR_QUAD_PLOT$GROUPtreatment   0.3420    
    ## APOP_PLOT7_AGRANULAR_QUAD_PLOT$FAMILYB          0.5421    
    ## APOP_PLOT7_AGRANULAR_QUAD_PLOT$FAMILYD          0.2787    
    ## APOP_PLOT7_AGRANULAR_QUAD_PLOT$FAMILYE          0.7842    
    ## APOP_PLOT7_AGRANULAR_QUAD_PLOT$FAMILYJ          0.2159    
    ## APOP_PLOT7_AGRANULAR_QUAD_PLOT$FAMILYL          0.0856 .  
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
    ## 
    ## Residual standard error: 0.09556 on 61 degrees of freedom
    ## Multiple R-squared:  0.1791, Adjusted R-squared:  0.09838 
    ## F-statistic: 2.218 on 6 and 61 DF,  p-value: 0.05314

``` r
APOP_PLOT_7_agranular_TWO_WAY_AOV_BAD_REMOVED <- lm(APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$Q1.LR_Arcsine ~ APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$GROUP + APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILY, data=APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED)
Anova(APOP_PLOT_7_agranular_TWO_WAY_AOV_BAD_REMOVED, type="II") # effect of family is significant
```

    ## Anova Table (Type II tests)
    ## 
    ## Response: APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$Q1.LR_Arcsine
    ##                                                    Sum Sq Df F value
    ## APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$GROUP  0.00404  1  0.4563
    ## APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILY 0.10530  5  2.3801
    ## Residuals                                         0.44240 50        
    ##                                                    Pr(>F)  
    ## APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$GROUP  0.50245  
    ## APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILY 0.05166 .
    ## Residuals                                                  
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

``` r
summary(APOP_PLOT_7_agranular_TWO_WAY_AOV_BAD_REMOVED)
```

    ## 
    ## Call:
    ## lm(formula = APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$Q1.LR_Arcsine ~ 
    ##     APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$GROUP + APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILY, 
    ##     data = APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED)
    ## 
    ## Residuals:
    ##       Min        1Q    Median        3Q       Max 
    ## -0.201897 -0.056630  0.001492  0.054568  0.272866 
    ## 
    ## Coefficients:
    ##                                                           Estimate
    ## (Intercept)                                                0.20685
    ## APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$GROUPtreatment -0.02011
    ## APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYB         0.03831
    ## APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYD         0.05002
    ## APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYE        -0.01062
    ## APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYJ         0.07263
    ## APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYL        -0.05639
    ##                                                           Std. Error
    ## (Intercept)                                                  0.03568
    ## APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$GROUPtreatment    0.02977
    ## APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYB           0.04231
    ## APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYD           0.04371
    ## APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYE           0.04231
    ## APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYJ           0.04020
    ## APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYL           0.04231
    ##                                                           t value Pr(>|t|)
    ## (Intercept)                                                 5.797 4.51e-07
    ## APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$GROUPtreatment  -0.676   0.5025
    ## APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYB          0.906   0.3695
    ## APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYD          1.144   0.2579
    ## APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYE         -0.251   0.8027
    ## APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYJ          1.807   0.0768
    ## APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYL         -1.333   0.1886
    ##                                                              
    ## (Intercept)                                               ***
    ## APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$GROUPtreatment    
    ## APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYB           
    ## APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYD           
    ## APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYE           
    ## APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYJ        .  
    ## APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYL           
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
    ## 
    ## Residual standard error: 0.09406 on 50 degrees of freedom
    ## Multiple R-squared:  0.1967, Adjusted R-squared:  0.1003 
    ## F-statistic: 2.041 on 6 and 50 DF,  p-value: 0.07737

``` r
# INTERACTION TERM ADDED
APOP_PLOT_7_agranular_INTERACTION_aov <- lm(APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$Q1.LR_Arcsine ~ APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILY + APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$GROUP + APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILY:APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$GROUP)
Anova(APOP_PLOT_7_agranular_INTERACTION_aov, type="II") #family is significant, but the interaction and group are not
```

    ## Anova Table (Type II tests)
    ## 
    ## Response: APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$Q1.LR_Arcsine
    ##                                                                                                     Sum Sq
    ## APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILY                                                  0.10530
    ## APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$GROUP                                                   0.00404
    ## APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILY:APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$GROUP 0.05373
    ## Residuals                                                                                          0.38867
    ##                                                                                                    Df
    ## APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILY                                                   5
    ## APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$GROUP                                                    1
    ## APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILY:APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$GROUP  5
    ## Residuals                                                                                          45
    ##                                                                                                    F value
    ## APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILY                                                   2.4382
    ## APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$GROUP                                                    0.4675
    ## APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILY:APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$GROUP  1.2441
    ## Residuals                                                                                                 
    ##                                                                                                     Pr(>F)
    ## APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILY                                                  0.04875
    ## APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$GROUP                                                   0.49765
    ## APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILY:APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$GROUP 0.30465
    ## Residuals                                                                                                 
    ##                                                                                                     
    ## APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILY                                                  *
    ## APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$GROUP                                                    
    ## APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILY:APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$GROUP  
    ## Residuals                                                                                           
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

``` r
summary(APOP_PLOT_7_agranular_INTERACTION_aov)
```

    ## 
    ## Call:
    ## lm(formula = APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$Q1.LR_Arcsine ~ 
    ##     APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILY + APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$GROUP + 
    ##         APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILY:APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$GROUP)
    ## 
    ## Residuals:
    ##       Min        1Q    Median        3Q       Max 
    ## -0.186698 -0.060222 -0.004472  0.048913  0.247715 
    ## 
    ## Coefficients:
    ##                                                                                                              Estimate
    ## (Intercept)                                                                                                   0.23182
    ## APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYB                                                           -0.04275
    ## APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYD                                                            0.08706
    ## APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYE                                                           -0.12362
    ## APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYJ                                                            0.11606
    ## APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYL                                                           -0.10510
    ## APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$GROUPtreatment                                                    -0.05444
    ## APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYB:APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$GROUPtreatment  0.10645
    ## APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYD:APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$GROUPtreatment -0.04835
    ## APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYE:APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$GROUPtreatment  0.14751
    ## APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYJ:APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$GROUPtreatment -0.04927
    ## APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYL:APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$GROUPtreatment  0.06485
    ##                                                                                                              Std. Error
    ## (Intercept)                                                                                                     0.05366
    ## APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYB                                                              0.08484
    ## APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYD                                                              0.08484
    ## APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYE                                                              0.08484
    ## APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYJ                                                              0.08484
    ## APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYL                                                              0.08484
    ## APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$GROUPtreatment                                                       0.06292
    ## APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYB:APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$GROUPtreatment    0.09753
    ## APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYD:APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$GROUPtreatment    0.09857
    ## APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYE:APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$GROUPtreatment    0.09753
    ## APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYJ:APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$GROUPtreatment    0.09611
    ## APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYL:APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$GROUPtreatment    0.09753
    ##                                                                                                              t value
    ## (Intercept)                                                                                                    4.320
    ## APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYB                                                            -0.504
    ## APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYD                                                             1.026
    ## APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYE                                                            -1.457
    ## APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYJ                                                             1.368
    ## APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYL                                                            -1.239
    ## APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$GROUPtreatment                                                     -0.865
    ## APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYB:APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$GROUPtreatment   1.091
    ## APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYD:APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$GROUPtreatment  -0.490
    ## APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYE:APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$GROUPtreatment   1.513
    ## APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYJ:APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$GROUPtreatment  -0.513
    ## APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYL:APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$GROUPtreatment   0.665
    ##                                                                                                              Pr(>|t|)
    ## (Intercept)                                                                                                  8.49e-05
    ## APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYB                                                              0.617
    ## APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYD                                                              0.310
    ## APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYE                                                              0.152
    ## APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYJ                                                              0.178
    ## APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYL                                                              0.222
    ## APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$GROUPtreatment                                                       0.391
    ## APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYB:APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$GROUPtreatment    0.281
    ## APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYD:APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$GROUPtreatment    0.626
    ## APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYE:APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$GROUPtreatment    0.137
    ## APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYJ:APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$GROUPtreatment    0.611
    ## APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYL:APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$GROUPtreatment    0.509
    ##                                                                                                                 
    ## (Intercept)                                                                                                  ***
    ## APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYB                                                              
    ## APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYD                                                              
    ## APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYE                                                              
    ## APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYJ                                                              
    ## APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYL                                                              
    ## APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$GROUPtreatment                                                       
    ## APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYB:APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$GROUPtreatment    
    ## APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYD:APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$GROUPtreatment    
    ## APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYE:APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$GROUPtreatment    
    ## APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYJ:APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$GROUPtreatment    
    ## APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYL:APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$GROUPtreatment    
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
    ## 
    ## Residual standard error: 0.09294 on 45 degrees of freedom
    ## Multiple R-squared:  0.2943, Adjusted R-squared:  0.1218 
    ## F-statistic: 1.706 on 11 and 45 DF,  p-value: 0.1029

``` r
APOP_PLOT_7_agranular_INTERACTION_aov_lsmeans<- lsmeans(APOP_PLOT_7_agranular_INTERACTION_aov, "APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILY", adjust="tukey")
cld(APOP_PLOT_7_agranular_INTERACTION_aov_lsmeans, alpha=0.05, Letters=letters) #each family is different from one another
```

    ##  APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILY    lsmean         SE df
    ##  A                                                 0.1773792 0.03285803 45
    ##  B                                                 0.1773792 0.03285803 45
    ##  D                                                 0.2045999 0.03145917 45
    ##  E                                                 0.2045999 0.03145917 45
    ##  J                                                 0.2045999 0.03145917 45
    ##  L                                                 0.2092304 0.02404962 45
    ##   lower.CL  upper.CL .group
    ##  0.1111997 0.2435587  a    
    ##  0.1111997 0.2435587  a    
    ##  0.1412378 0.2679619  a    
    ##  0.1412378 0.2679619  a    
    ##  0.1412378 0.2679619  a    
    ##  0.1607920 0.2576688  a    
    ## 
    ## Results are averaged over the levels of: APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$GROUP 
    ## Confidence level used: 0.95 
    ## P value adjustment: tukey method for comparing a family of 6 estimates 
    ## significance level used: alpha = 0.05

``` r
APOP_PLOT_7_agranular_INTERACTION_aov_lsmeans_group <- lsmeans(APOP_PLOT_7_agranular_INTERACTION_aov, "APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$GROUP", adjust="tukey")
cld(APOP_PLOT_7_agranular_INTERACTION_aov_lsmeans_group, alpha=0.05, Letters=letters) #control and treatment are also different
```

    ##  APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$GROUP    lsmean         SE df
    ##  control                                          0.1773792 0.03285803 45
    ##  treatment                                        0.2152169 0.02956353 45
    ##   lower.CL  upper.CL .group
    ##  0.1111997 0.2435587  a    
    ##  0.1556729 0.2747609  a    
    ## 
    ## Results are averaged over the levels of: APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILY 
    ## Confidence level used: 0.95 
    ## significance level used: alpha = 0.05

### One Way ANOVA of Differences between Families

% LIVE apoptotic granular and agranular hemocytes
-------------------------------------------------

``` r
# Graphing
agranular_live_apoptotic_all <- APOP_PLOT7_AGRANULAR_QUAD_PLOT_GATE_ADDED_BAD_REMOVED %>% filter(GATE=="Q1_LR")
granular_live_apoptotic_all <- APOP_PLOT4_GRANULAR_QUAD_PLOT_GATE_ADDED_BAD_REMOVED %>% filter(GATE=="Q2_LR")
APOP_Live_apoptotic_combined_all <- rbind(agranular_live_apoptotic_all,granular_live_apoptotic_all)

ggplot(APOP_Live_apoptotic_combined_all, aes(x=GROUP, y=PERCENT_OF_THIS_PLOT, fill=GATE)) + facet_grid(.~FAMILY+GROUP, scales="free") + geom_boxplot() + ggtitle("Percent of Granular and Agranular Live Apoptotic Hemocytes (low quality removed)") + ylab("Percent of Hemocyte Events in each quad plot") + scale_fill_manual(name="Hemocyte Type", labels=c("Live Apoptotic Agranular", "Live Apoptotic Granular"), values=c("Q2_LR"="#99a765","Q1_LR"="#96578a")) 
```

![](Dermo_Apoptosis_Assay_Data_analysis_files/figure-markdown_github/combined-1.png)

``` r
# Two-Way ANOVA
APOP_Live_apoptotic_combined_all_aov <- lm(APOP_Live_apoptotic_combined_all$Arcsine ~ APOP_Live_apoptotic_combined_all$FAMILY + APOP_Live_apoptotic_combined_all$GATE, data=APOP_Live_apoptotic_combined_all)
Anova(APOP_Live_apoptotic_combined_all_aov, type="II") #family and GATE significantly different
```

    ## Anova Table (Type II tests)
    ## 
    ## Response: APOP_Live_apoptotic_combined_all$Arcsine
    ##                                          Sum Sq  Df F value    Pr(>F)    
    ## APOP_Live_apoptotic_combined_all$FAMILY 0.22292   5  6.6286 2.056e-05 ***
    ## APOP_Live_apoptotic_combined_all$GATE   0.03701   1  5.5025   0.02083 *  
    ## Residuals                               0.71967 107                      
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

``` r
summary(APOP_Live_apoptotic_combined_all_aov)
```

    ## 
    ## Call:
    ## lm(formula = APOP_Live_apoptotic_combined_all$Arcsine ~ APOP_Live_apoptotic_combined_all$FAMILY + 
    ##     APOP_Live_apoptotic_combined_all$GATE, data = APOP_Live_apoptotic_combined_all)
    ## 
    ## Residuals:
    ##       Min        1Q    Median        3Q       Max 
    ## -0.184993 -0.047310 -0.002528  0.048968  0.267684 
    ## 
    ## Coefficients:
    ##                                             Estimate Std. Error t value
    ## (Intercept)                                 0.187236   0.019098   9.804
    ## APOP_Live_apoptotic_combined_all$FAMILYB    0.074068   0.026065   2.842
    ## APOP_Live_apoptotic_combined_all$FAMILYD    0.056064   0.026946   2.081
    ## APOP_Live_apoptotic_combined_all$FAMILYE   -0.005935   0.026065  -0.228
    ## APOP_Live_apoptotic_combined_all$FAMILYJ    0.055235   0.024727   2.234
    ## APOP_Live_apoptotic_combined_all$FAMILYL   -0.055021   0.026065  -2.111
    ## APOP_Live_apoptotic_combined_all$GATEQ2_LR  0.036036   0.015362   2.346
    ##                                            Pr(>|t|)    
    ## (Intercept)                                 < 2e-16 ***
    ## APOP_Live_apoptotic_combined_all$FAMILYB    0.00537 ** 
    ## APOP_Live_apoptotic_combined_all$FAMILYD    0.03986 *  
    ## APOP_Live_apoptotic_combined_all$FAMILYE    0.82030    
    ## APOP_Live_apoptotic_combined_all$FAMILYJ    0.02758 *  
    ## APOP_Live_apoptotic_combined_all$FAMILYL    0.03711 *  
    ## APOP_Live_apoptotic_combined_all$GATEQ2_LR  0.02083 *  
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
    ## 
    ## Residual standard error: 0.08201 on 107 degrees of freedom
    ## Multiple R-squared:  0.2653, Adjusted R-squared:  0.2241 
    ## F-statistic: 6.441 on 6 and 107 DF,  p-value: 8.071e-06

``` r
hist(residuals(APOP_Live_apoptotic_combined_all_aov))
```

![](Dermo_Apoptosis_Assay_Data_analysis_files/figure-markdown_github/combined-2.png)

``` r
# Two-Way ANOVA with interaction 
APOP_Live_apoptotic_combined_all_aov_interaction <- lm(Arcsine ~ FAMILY + GATE + FAMILY:GATE, data=APOP_Live_apoptotic_combined_all)
Anova(APOP_Live_apoptotic_combined_all_aov_interaction, type="II") #family and GATE are significntly different
```

    ## Anova Table (Type II tests)
    ## 
    ## Response: Arcsine
    ##              Sum Sq  Df F value    Pr(>F)    
    ## FAMILY      0.22292   5  6.5765 2.416e-05 ***
    ## GATE        0.03701   1  5.4592   0.02142 *  
    ## FAMILY:GATE 0.02820   5  0.8318   0.53002    
    ## Residuals   0.69148 102                      
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

``` r
summary(APOP_Live_apoptotic_combined_all_aov_interaction)
```

    ## 
    ## Call:
    ## lm(formula = Arcsine ~ FAMILY + GATE + FAMILY:GATE, data = APOP_Live_apoptotic_combined_all)
    ## 
    ## Residuals:
    ##       Min        1Q    Median        3Q       Max 
    ## -0.205554 -0.049804 -0.004193  0.050482  0.268398 
    ## 
    ## Coefficients:
    ##                    Estimate Std. Error t value Pr(>|t|)    
    ## (Intercept)        0.192227   0.024825   7.743 7.32e-12 ***
    ## FAMILYB            0.037298   0.037007   1.008   0.3159    
    ## FAMILYD            0.049565   0.038258   1.296   0.1981    
    ## FAMILYE           -0.011640   0.037007  -0.315   0.7538    
    ## FAMILYJ            0.070804   0.035108   2.017   0.0464 *  
    ## FAMILYL           -0.057407   0.037007  -1.551   0.1239    
    ## GATEQ2_LR          0.026053   0.035108   0.742   0.4597    
    ## FAMILYB:GATEQ2_LR  0.073542   0.052336   1.405   0.1630    
    ## FAMILYD:GATEQ2_LR  0.012999   0.054105   0.240   0.8106    
    ## FAMILYE:GATEQ2_LR  0.011410   0.052336   0.218   0.8279    
    ## FAMILYJ:GATEQ2_LR -0.031139   0.049650  -0.627   0.5320    
    ## FAMILYL:GATEQ2_LR  0.004773   0.052336   0.091   0.9275    
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
    ## 
    ## Residual standard error: 0.08234 on 102 degrees of freedom
    ## Multiple R-squared:  0.2941, Adjusted R-squared:  0.218 
    ## F-statistic: 3.864 on 11 and 102 DF,  p-value: 0.0001137

``` r
hist(residuals(APOP_Live_apoptotic_combined_all_aov_interaction))
```

![](Dermo_Apoptosis_Assay_Data_analysis_files/figure-markdown_github/combined-3.png)

``` r
APOP_Live_apoptotic_combined_all_aov_interaction_leastsquare <- lsmeans(APOP_Live_apoptotic_combined_all_aov_interaction, "FAMILY",adjust="tukey")
```

    ## NOTE: Results may be misleading due to involvement in interactions

``` r
cld(APOP_Live_apoptotic_combined_all_aov_interaction_leastsquare, alpha=0.05, Letters=letters)
```

    ##  FAMILY    lsmean         SE  df  lower.CL  upper.CL .group
    ##  L      0.1502328 0.01940677 102 0.1117396 0.1887261  a    
    ##  E      0.1993182 0.01940677 102 0.1608250 0.2378114  ab   
    ##  A      0.2052536 0.01755409 102 0.1704351 0.2400720  abc  
    ##  J      0.2604883 0.01755409 102 0.2256699 0.2953068   bc  
    ##  D      0.2613178 0.02058399 102 0.2204896 0.3021460   bc  
    ##  B      0.2793220 0.01940677 102 0.2408288 0.3178152    c  
    ## 
    ## Results are averaged over the levels of: GATE 
    ## Confidence level used: 0.95 
    ## P value adjustment: tukey method for comparing a family of 6 estimates 
    ## significance level used: alpha = 0.05

``` r
APOP_Live_apoptotic_combined_all_aov_interaction_leastsquare_gate <- lsmeans(APOP_Live_apoptotic_combined_all_aov_interaction, "GATE",adjust="tukey")
```

    ## NOTE: Results may be misleading due to involvement in interactions

``` r
cld(APOP_Live_apoptotic_combined_all_aov_interaction_leastsquare_gate, alpha=0.05, Letters=letters) #the two gates are significantly different 
```

    ##  GATE     lsmean         SE  df  lower.CL  upper.CL .group
    ##  Q1_LR 0.2069967 0.01097943 102 0.1852190 0.2287743  a    
    ##  Q2_LR 0.2449809 0.01097943 102 0.2232033 0.2667586   b   
    ## 
    ## Results are averaged over the levels of: FAMILY 
    ## Confidence level used: 0.95 
    ## significance level used: alpha = 0.05

% DEAD apoptotic granular hemocytes (PLOT4, Q2-UR)
--------------------------------------------------

Percent DEAD apoptotic granular hemocytes (PLOT4, Q1-UR)
--------------------------------------------------------

``` r
APOP_dead_apoptotic_granular_BAD_NOT_REMOVED <- ggplot(data=APOP_PLOT4_GRANULAR_QUAD_PLOT, aes(x=FAMILY, y=Q2.UR_PERCENT_OF_THIS_PLOT, color=GROUP, by=GROUP)) + geom_boxplot() + ggtitle("Percent of Dead Apoptotic Granular Hemocytes \n Low Quality Not Removed") + xlab("Family") + ylab("Percent of Hemocyte Events") + ylim(0,100)

APOP_dead_apoptotic_granular_BAD_NOT_REMOVED
```

![](Dermo_Apoptosis_Assay_Data_analysis_files/figure-markdown_github/dead_apoptotic_granular-1.png)

``` r
APOP_dead_apoptotic_granular_BAD_REMOVED <- ggplot(data=APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED, aes(x=FAMILY, y=Q2.UR_PERCENT_OF_THIS_PLOT, color=GROUP, by=GROUP)) + geom_boxplot() + ggtitle("Percent of Dead Apoptotic Granular Hemocytes \nLow Quality Removed") +
  xlab("Family") + ylab("Percent of Hemocyte Events") + ylim(0,100)
APOP_dead_apoptotic_granular_BAD_REMOVED
```

![](Dermo_Apoptosis_Assay_Data_analysis_files/figure-markdown_github/dead_apoptotic_granular-2.png)

### FAMILY A

``` r
APOP_PLOT_4_dead_granular_FAMILY_A_AOV <- aov(APOP_PLOT_4_granular_FAMILY_A$Q2.UR_Arcsine ~ APOP_PLOT_4_granular_FAMILY_A$GROUP, data=APOP_PLOT_4_granular_FAMILY_A)
summary(APOP_PLOT_4_dead_granular_FAMILY_A_AOV)
```

    ##                                     Df   Sum Sq  Mean Sq F value Pr(>F)  
    ## APOP_PLOT_4_granular_FAMILY_A$GROUP  1 0.007312 0.007312   7.951 0.0182 *
    ## Residuals                           10 0.009197 0.000920                 
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

``` r
APOP_PLOT_4_dead_granular_FAMILY_A_AOV_BAD_REMOVED <- aov(APOP_PLOT_4_granular_FAMILY_A_BAD_REMOVED$Q2.UR_Arcsine ~ APOP_PLOT_4_granular_FAMILY_A_BAD_REMOVED$GROUP, data=APOP_PLOT_4_granular_FAMILY_A_BAD_REMOVED)
summary(APOP_PLOT_4_dead_granular_FAMILY_A_AOV_BAD_REMOVED)      
```

    ##                                                 Df   Sum Sq  Mean Sq
    ## APOP_PLOT_4_granular_FAMILY_A_BAD_REMOVED$GROUP  1 0.007408 0.007408
    ## Residuals                                        9 0.009082 0.001009
    ##                                                 F value Pr(>F)  
    ## APOP_PLOT_4_granular_FAMILY_A_BAD_REMOVED$GROUP   7.341  0.024 *
    ## Residuals                                                       
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

### FAMILY B

``` r
APOP_PLOT_4_dead_granular_FAMILY_B_AOV <- aov(APOP_PLOT_4_granular_FAMILY_B$Q2.UR_Arcsine ~ APOP_PLOT_4_granular_FAMILY_B$GROUP, data=APOP_PLOT_4_granular_FAMILY_B)
summary(APOP_PLOT_4_dead_granular_FAMILY_B_AOV)
```

    ##                                     Df   Sum Sq   Mean Sq F value Pr(>F)
    ## APOP_PLOT_4_granular_FAMILY_B$GROUP  1 0.000898 0.0008978   0.466  0.514
    ## Residuals                            8 0.015396 0.0019245

``` r
APOP_PLOT_4_dead_granular_FAMILY_B_AOV_BAD_REMOVED <- aov(APOP_PLOT_4_granular_FAMILY_B_BAD_REMOVED$Q2.UR_Arcsine ~ APOP_PLOT_4_granular_FAMILY_B_BAD_REMOVED$GROUP, data=APOP_PLOT_4_granular_FAMILY_B_BAD_REMOVED)
summary(APOP_PLOT_4_dead_granular_FAMILY_B_AOV_BAD_REMOVED)      
```

    ##                                                 Df   Sum Sq  Mean Sq
    ## APOP_PLOT_4_granular_FAMILY_B_BAD_REMOVED$GROUP  1 0.001757 0.001757
    ## Residuals                                        7 0.009888 0.001413
    ##                                                 F value Pr(>F)
    ## APOP_PLOT_4_granular_FAMILY_B_BAD_REMOVED$GROUP   1.244  0.302
    ## Residuals

### FAMILY D

``` r
APOP_PLOT_4_dead_granular_FAMILY_D_AOV <- aov(APOP_PLOT_4_granular_FAMILY_D$Q2.UR_Arcsine ~ APOP_PLOT_4_granular_FAMILY_D$GROUP, data=APOP_PLOT_4_granular_FAMILY_D)
summary(APOP_PLOT_4_dead_granular_FAMILY_D_AOV)
```

    ##                                     Df   Sum Sq   Mean Sq F value Pr(>F)  
    ## APOP_PLOT_4_granular_FAMILY_D$GROUP  1 0.003109 0.0031088   4.749 0.0657 .
    ## Residuals                            7 0.004583 0.0006547                 
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

``` r
APOP_PLOT_4_dead_granular_FAMILY_D_AOV_BAD_REMOVED <- aov(APOP_PLOT_4_granular_FAMILY_D_BAD_REMOVED$Q2.UR_Arcsine ~ APOP_PLOT_4_granular_FAMILY_D_BAD_REMOVED$GROUP, data=APOP_PLOT_4_granular_FAMILY_D_BAD_REMOVED)
summary(APOP_PLOT_4_dead_granular_FAMILY_D_AOV_BAD_REMOVED)      
```

    ##                                                 Df   Sum Sq  Mean Sq
    ## APOP_PLOT_4_granular_FAMILY_D_BAD_REMOVED$GROUP  1 0.003169 0.003169
    ## Residuals                                        6 0.004516 0.000753
    ##                                                 F value Pr(>F)  
    ## APOP_PLOT_4_granular_FAMILY_D_BAD_REMOVED$GROUP    4.21  0.086 .
    ## Residuals                                                       
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

### FAMILY E

``` r
APOP_PLOT_4_dead_granular_FAMILY_E_AOV <- aov(APOP_PLOT_4_granular_FAMILY_E$Q2.UR_Arcsine ~ APOP_PLOT_4_granular_FAMILY_E$GROUP, data=APOP_PLOT_4_granular_FAMILY_E)
summary(APOP_PLOT_4_dead_granular_FAMILY_E_AOV)
```

    ##                                     Df  Sum Sq  Mean Sq F value Pr(>F)
    ## APOP_PLOT_4_granular_FAMILY_E$GROUP  1 0.01057 0.010567   2.721  0.133
    ## Residuals                            9 0.03495 0.003883

``` r
APOP_PLOT_4_dead_granular_FAMILY_E_AOV_BAD_REMOVED <- aov(APOP_PLOT_4_granular_FAMILY_E_BAD_REMOVED$Q2.UR_Arcsine ~ APOP_PLOT_4_granular_FAMILY_E_BAD_REMOVED$GROUP, data=APOP_PLOT_4_granular_FAMILY_E_BAD_REMOVED)
summary(APOP_PLOT_4_dead_granular_FAMILY_E_AOV_BAD_REMOVED)      
```

    ##                                                 Df   Sum Sq  Mean Sq
    ## APOP_PLOT_4_granular_FAMILY_E_BAD_REMOVED$GROUP  1 0.007159 0.007159
    ## Residuals                                        7 0.029893 0.004270
    ##                                                 F value Pr(>F)
    ## APOP_PLOT_4_granular_FAMILY_E_BAD_REMOVED$GROUP   1.676  0.236
    ## Residuals

### FAMILY J

``` r
APOP_PLOT_4_dead_granular_FAMILY_J_AOV <- aov(APOP_PLOT_4_granular_FAMILY_J$Q2.UR_Arcsine ~ APOP_PLOT_4_granular_FAMILY_J$GROUP, data=APOP_PLOT_4_granular_FAMILY_J)
summary(APOP_PLOT_4_dead_granular_FAMILY_J_AOV)
```

    ##                                     Df  Sum Sq  Mean Sq F value Pr(>F)
    ## APOP_PLOT_4_granular_FAMILY_J$GROUP  1 0.00443 0.004433   0.737  0.409
    ## Residuals                           11 0.06619 0.006017

``` r
APOP_PLOT_4_dead_granular_FAMILY_J_AOV_BAD_REMOVED <- aov(APOP_PLOT_4_granular_FAMILY_J_BAD_REMOVED$Q2.UR_Arcsine ~ APOP_PLOT_4_granular_FAMILY_J_BAD_REMOVED$GROUP, data=APOP_PLOT_4_granular_FAMILY_J_BAD_REMOVED)
summary(APOP_PLOT_4_dead_granular_FAMILY_J_AOV_BAD_REMOVED)      
```

    ##                                                 Df  Sum Sq  Mean Sq
    ## APOP_PLOT_4_granular_FAMILY_J_BAD_REMOVED$GROUP  1 0.00319 0.003190
    ## Residuals                                        9 0.06474 0.007193
    ##                                                 F value Pr(>F)
    ## APOP_PLOT_4_granular_FAMILY_J_BAD_REMOVED$GROUP   0.443  0.522
    ## Residuals

### FAMILY L

``` r
APOP_PLOT_4_dead_granular_FAMILY_L_AOV <- aov(APOP_PLOT_4_granular_FAMILY_L$Q2.UR_Arcsine ~ APOP_PLOT_4_granular_FAMILY_L$GROUP, data=APOP_PLOT_4_granular_FAMILY_L)
summary(APOP_PLOT_4_dead_granular_FAMILY_L_AOV)
```

    ##                                     Df  Sum Sq  Mean Sq F value Pr(>F)
    ## APOP_PLOT_4_granular_FAMILY_L$GROUP  1 0.00309 0.003087   0.286  0.604
    ## Residuals                           11 0.11886 0.010805

``` r
APOP_PLOT_4_dead_granular_FAMILY_L_AOV_BAD_REMOVED <- aov(APOP_PLOT_4_granular_FAMILY_L_BAD_REMOVED$Q2.UR_Arcsine ~ APOP_PLOT_4_granular_FAMILY_L_BAD_REMOVED$GROUP, data=APOP_PLOT_4_granular_FAMILY_L_BAD_REMOVED)
summary(APOP_PLOT_4_dead_granular_FAMILY_L_AOV_BAD_REMOVED)      
```

    ##                                                 Df  Sum Sq  Mean Sq
    ## APOP_PLOT_4_granular_FAMILY_L_BAD_REMOVED$GROUP  1 0.00060 0.000596
    ## Residuals                                        7 0.06212 0.008875
    ##                                                 F value Pr(>F)
    ## APOP_PLOT_4_granular_FAMILY_L_BAD_REMOVED$GROUP   0.067  0.803
    ## Residuals

### TWO WAY ANOVA

``` r
APOP_PLOT_4_dead_granular_TWO_WAY_AOV <- lm(APOP_PLOT4_GRANULAR_QUAD_PLOT$Q2.UR_Arcsine ~ APOP_PLOT4_GRANULAR_QUAD_PLOT$GROUP + APOP_PLOT4_GRANULAR_QUAD_PLOT$FAMILY, data=APOP_PLOT4_GRANULAR_QUAD_PLOT)
Anova(APOP_PLOT_4_dead_granular_TWO_WAY_AOV, type="II")
```

    ## Anova Table (Type II tests)
    ## 
    ## Response: APOP_PLOT4_GRANULAR_QUAD_PLOT$Q2.UR_Arcsine
    ##                                        Sum Sq Df F value   Pr(>F)   
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT$GROUP  0.003833  1  0.8510 0.359898   
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT$FAMILY 0.093481  5  4.1511 0.002605 **
    ## Residuals                            0.274741 61                    
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

``` r
summary(APOP_PLOT_4_dead_granular_TWO_WAY_AOV)
```

    ## 
    ## Call:
    ## lm(formula = APOP_PLOT4_GRANULAR_QUAD_PLOT$Q2.UR_Arcsine ~ APOP_PLOT4_GRANULAR_QUAD_PLOT$GROUP + 
    ##     APOP_PLOT4_GRANULAR_QUAD_PLOT$FAMILY, data = APOP_PLOT4_GRANULAR_QUAD_PLOT)
    ## 
    ## Residuals:
    ##       Min        1Q    Median        3Q       Max 
    ## -0.111343 -0.045350 -0.005694  0.030688  0.199476 
    ## 
    ## Coefficients:
    ##                                              Estimate Std. Error t value
    ## (Intercept)                                   0.14890    0.02434   6.116
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT$GROUPtreatment -0.01813    0.01966  -0.923
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT$FAMILYB         0.08768    0.02875   3.050
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT$FAMILYD         0.02320    0.02960   0.784
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT$FAMILYE         0.01332    0.02805   0.475
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT$FAMILYJ         0.02580    0.02687   0.960
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT$FAMILYL        -0.03755    0.02687  -1.398
    ##                                              Pr(>|t|)    
    ## (Intercept)                                  7.45e-08 ***
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT$GROUPtreatment  0.35990    
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT$FAMILYB         0.00339 ** 
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT$FAMILYD         0.43625    
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT$FAMILYE         0.63642    
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT$FAMILYJ         0.34065    
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT$FAMILYL         0.16728    
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
    ## 
    ## Residual standard error: 0.06711 on 61 degrees of freedom
    ## Multiple R-squared:  0.2599, Adjusted R-squared:  0.1871 
    ## F-statistic:  3.57 on 6 and 61 DF,  p-value: 0.004269

``` r
APOP_PLOT_4_dead_granular_TWO_WAY_AOV_BAD_REMOVED <- lm(APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$Q2.UR_Arcsine ~ APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$GROUP + APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILY, data=APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED)
Anova(APOP_PLOT_4_dead_granular_TWO_WAY_AOV_BAD_REMOVED, type="II")
```

    ## Anova Table (Type II tests)
    ## 
    ## Response: APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$Q2.UR_Arcsine
    ##                                                    Sum Sq Df F value
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$GROUP  0.003039  1  0.7579
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILY 0.078908  5  3.9359
    ## Residuals                                        0.200483 50        
    ##                                                    Pr(>F)   
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$GROUP  0.388144   
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILY 0.004364 **
    ## Residuals                                                   
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

``` r
summary(APOP_PLOT_4_dead_granular_TWO_WAY_AOV_BAD_REMOVED)
```

    ## 
    ## Call:
    ## lm(formula = APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$Q2.UR_Arcsine ~ 
    ##     APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$GROUP + APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILY, 
    ##     data = APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED)
    ## 
    ## Residuals:
    ##       Min        1Q    Median        3Q       Max 
    ## -0.101670 -0.044786 -0.007722  0.030407  0.192469 
    ## 
    ## Coefficients:
    ##                                                          Estimate
    ## (Intercept)                                               0.14836
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$GROUPtreatment -0.01745
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYB         0.08009
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYD         0.02241
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYE         0.02558
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYJ         0.03266
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYL        -0.04669
    ##                                                          Std. Error
    ## (Intercept)                                                 0.02402
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$GROUPtreatment    0.02004
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYB           0.02848
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYD           0.02943
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYE           0.02848
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYJ           0.02706
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYL           0.02848
    ##                                                          t value Pr(>|t|)
    ## (Intercept)                                                6.177 1.16e-07
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$GROUPtreatment  -0.871  0.38814
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYB          2.812  0.00701
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYD          0.762  0.44983
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYE          0.898  0.37347
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYJ          1.207  0.23318
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYL         -1.640  0.10739
    ##                                                             
    ## (Intercept)                                              ***
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$GROUPtreatment    
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYB        ** 
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYD           
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYE           
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYJ           
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYL           
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
    ## 
    ## Residual standard error: 0.06332 on 50 degrees of freedom
    ## Multiple R-squared:  0.2889, Adjusted R-squared:  0.2035 
    ## F-statistic: 3.385 on 6 and 50 DF,  p-value: 0.007032

``` r
# INTERACTION TERM ADDED  (using lm model)
APOP_PLOT_4_dead_granular_INTERACTION_aov <- lm(APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$Q2.UR_Arcsine ~ APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILY + APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$GROUP + APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILY:APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$GROUP)
Anova(APOP_PLOT_4_dead_granular_INTERACTION_aov, type="II") # family is significant 
```

    ## Anova Table (Type II tests)
    ## 
    ## Response: APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$Q2.UR_Arcsine
    ##                                                                                                    Sum Sq
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILY                                                 0.078908
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$GROUP                                                  0.003039
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILY:APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$GROUP 0.020239
    ## Residuals                                                                                        0.180243
    ##                                                                                                  Df
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILY                                                  5
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$GROUP                                                   1
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILY:APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$GROUP  5
    ## Residuals                                                                                        45
    ##                                                                                                  F value
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILY                                                  3.9401
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$GROUP                                                   0.7587
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILY:APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$GROUP  1.0106
    ## Residuals                                                                                               
    ##                                                                                                    Pr(>F)
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILY                                                 0.004771
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$GROUP                                                  0.388355
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILY:APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$GROUP 0.422618
    ## Residuals                                                                                                
    ##                                                                                                    
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILY                                                 **
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$GROUP                                                    
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILY:APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$GROUP   
    ## Residuals                                                                                          
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

``` r
summary(APOP_PLOT_4_dead_granular_INTERACTION_aov)
```

    ## 
    ## Call:
    ## lm(formula = APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$Q2.UR_Arcsine ~ 
    ##     APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILY + APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$GROUP + 
    ##         APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILY:APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$GROUP)
    ## 
    ## Residuals:
    ##       Min        1Q    Median        3Q       Max 
    ## -0.103325 -0.035622 -0.002897  0.029526  0.181270 
    ## 
    ## Coefficients:
    ##                                                                                                             Estimate
    ## (Intercept)                                                                                                 0.178052
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYB                                                           0.062972
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYD                                                          -0.054833
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYE                                                           0.035081
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYJ                                                          -0.047428
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYL                                                          -0.074726
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$GROUPtreatment                                                   -0.058269
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYB:APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$GROUPtreatment  0.024665
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYD:APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$GROUPtreatment  0.104232
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYE:APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$GROUPtreatment -0.009571
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYJ:APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$GROUPtreatment  0.102419
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYL:APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$GROUPtreatment  0.038696
    ##                                                                                                            Std. Error
    ## (Intercept)                                                                                                  0.036540
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYB                                                            0.057774
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYD                                                            0.057774
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYE                                                            0.057774
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYJ                                                            0.057774
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYL                                                            0.057774
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$GROUPtreatment                                                     0.042846
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYB:APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$GROUPtreatment   0.066413
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYD:APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$GROUPtreatment   0.067127
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYE:APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$GROUPtreatment   0.066413
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYJ:APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$GROUPtreatment   0.065449
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYL:APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$GROUPtreatment   0.066413
    ##                                                                                                            t value
    ## (Intercept)                                                                                                  4.873
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYB                                                            1.090
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYD                                                           -0.949
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYE                                                            0.607
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYJ                                                           -0.821
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYL                                                           -1.293
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$GROUPtreatment                                                    -1.360
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYB:APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$GROUPtreatment   0.371
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYD:APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$GROUPtreatment   1.553
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYE:APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$GROUPtreatment  -0.144
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYJ:APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$GROUPtreatment   1.565
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYL:APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$GROUPtreatment   0.583
    ##                                                                                                            Pr(>|t|)
    ## (Intercept)                                                                                                 1.4e-05
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYB                                                             0.282
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYD                                                             0.348
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYE                                                             0.547
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYJ                                                             0.416
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYL                                                             0.202
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$GROUPtreatment                                                      0.181
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYB:APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$GROUPtreatment    0.712
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYD:APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$GROUPtreatment    0.127
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYE:APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$GROUPtreatment    0.886
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYJ:APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$GROUPtreatment    0.125
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYL:APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$GROUPtreatment    0.563
    ##                                                                                                               
    ## (Intercept)                                                                                                ***
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYB                                                             
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYD                                                             
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYE                                                             
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYJ                                                             
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYL                                                             
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$GROUPtreatment                                                      
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYB:APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$GROUPtreatment    
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYD:APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$GROUPtreatment    
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYE:APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$GROUPtreatment    
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYJ:APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$GROUPtreatment    
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYL:APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$GROUPtreatment    
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
    ## 
    ## Residual standard error: 0.06329 on 45 degrees of freedom
    ## Multiple R-squared:  0.3607, Adjusted R-squared:  0.2044 
    ## F-statistic: 2.308 on 11 and 45 DF,  p-value: 0.0242

``` r
APOP_PLOT_4_dead_granular_INTERACTION_aov_leastsquares <- lsmeans(APOP_PLOT_4_dead_granular_INTERACTION_aov, "APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILY", adjust="tukey")
cld(APOP_PLOT_4_dead_granular_INTERACTION_aov_leastsquares, alpha=0.05, Letters=letters) #each is significantly different 
```

    ##  APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILY    lsmean         SE df
    ##  A                                                0.1197823 0.02237580 45
    ##  B                                                0.1197823 0.02237580 45
    ##  D                                                0.1489169 0.02142320 45
    ##  E                                                0.1489169 0.02142320 45
    ##  J                                                0.1489169 0.02142320 45
    ##  L                                                0.1636006 0.01637741 45
    ##    lower.CL  upper.CL .group
    ##  0.07471509 0.1648494  a    
    ##  0.07471509 0.1648494  a    
    ##  0.10576838 0.1920654  a    
    ##  0.10576838 0.1920654  a    
    ##  0.10576838 0.1920654  a    
    ##  0.13061477 0.1965864  a    
    ## 
    ## Results are averaged over the levels of: APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$GROUP 
    ## Confidence level used: 0.95 
    ## P value adjustment: tukey method for comparing a family of 6 estimates 
    ## significance level used: alpha = 0.05

### One Way ANOVA of Differences between Families

% DEAD apoptotic agranular hemocytes (PLOT 7, Q1-UR)
----------------------------------------------------

Percent DEAD apoptotic agranular hemocytes (PLOT 7, Q1-UR)
----------------------------------------------------------

``` r
APOP_dead_apoptotic_Agranular_BAD_NOT_REMOVED <- ggplot(data=APOP_PLOT7_AGRANULAR_QUAD_PLOT, aes(x=FAMILY, y=Q1.UR_PERCENT_OF_THIS_PLOT, color=GROUP, by=GROUP)) + geom_boxplot() + ggtitle("Percent of Dead Apoptotic Agranular Hemocytes \n Low Quality Not Removed") + xlab("Family") + ylab("Percent of Hemocyte Events") + ylim(0,100)

APOP_dead_apoptotic_Agranular_BAD_NOT_REMOVED
```

![](Dermo_Apoptosis_Assay_Data_analysis_files/figure-markdown_github/dead%20apoptotic_agranular-1.png)

``` r
APOP_dead_apoptotic_Agranular_BAD_REMOVED <- ggplot(data=APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED, aes(x=FAMILY, y=Q1.UR_PERCENT_OF_THIS_PLOT, color=GROUP, by=GROUP)) + geom_boxplot() + ggtitle("Percent of Dead Apoptotic Agranular Hemocytes \nLow Quality Removed") +
  xlab("Family") + ylab("Percent of Hemocyte Events") + ylim(0,100)
APOP_dead_apoptotic_Agranular_BAD_REMOVED
```

![](Dermo_Apoptosis_Assay_Data_analysis_files/figure-markdown_github/dead%20apoptotic_agranular-2.png)

### FAMILY A

``` r
APOP_PLOT_7_dead_agranular_FAMILY_A_AOV <- aov(APOP_PLOT_7_agranular_FAMILY_A$Q1.UR_Arcsine ~ APOP_PLOT_7_agranular_FAMILY_A$GROUP, data=APOP_PLOT_7_agranular_FAMILY_A)
summary(APOP_PLOT_7_dead_agranular_FAMILY_A_AOV)
```

    ##                                      Df  Sum Sq  Mean Sq F value Pr(>F)
    ## APOP_PLOT_7_agranular_FAMILY_A$GROUP  1 0.00773 0.007728   0.537  0.481
    ## Residuals                            10 0.14394 0.014394

``` r
APOP_PLOT_7_dead_agranular_FAMILY_A_AOV_BAD_REMOVED <- aov(APOP_PLOT_7_agranular_FAMILY_A_BAD_REMOVED$Q1.UR_Arcsine ~ APOP_PLOT_7_agranular_FAMILY_A_BAD_REMOVED$GROUP, data=APOP_PLOT_7_agranular_FAMILY_A_BAD_REMOVED)
summary(APOP_PLOT_7_dead_agranular_FAMILY_A_AOV_BAD_REMOVED)      
```

    ##                                                  Df  Sum Sq Mean Sq
    ## APOP_PLOT_7_agranular_FAMILY_A_BAD_REMOVED$GROUP  1 0.01415 0.01415
    ## Residuals                                         9 0.10933 0.01215
    ##                                                  F value Pr(>F)
    ## APOP_PLOT_7_agranular_FAMILY_A_BAD_REMOVED$GROUP   1.165  0.309
    ## Residuals

### FAMILY B

``` r
APOP_PLOT_7_dead_agranular_FAMILY_B_AOV <- aov(APOP_PLOT_7_agranular_FAMILY_B$Q1.UR_Arcsine ~ APOP_PLOT_7_agranular_FAMILY_B$GROUP, data=APOP_PLOT_7_agranular_FAMILY_B)
summary(APOP_PLOT_7_dead_agranular_FAMILY_B_AOV)
```

    ##                                      Df  Sum Sq Mean Sq F value Pr(>F)
    ## APOP_PLOT_7_agranular_FAMILY_B$GROUP  1 0.00277 0.00277   0.083  0.781
    ## Residuals                             8 0.26811 0.03351

``` r
APOP_PLOT_7_dead_agranular_FAMILY_B_AOV_BAD_REMOVED <- aov(APOP_PLOT_7_agranular_FAMILY_B_BAD_REMOVED$Q1.UR_Arcsine ~ APOP_PLOT_7_agranular_FAMILY_B_BAD_REMOVED$GROUP, data=APOP_PLOT_7_agranular_FAMILY_B_BAD_REMOVED)
summary(APOP_PLOT_7_dead_agranular_FAMILY_B_AOV_BAD_REMOVED)      
```

    ##                                                  Df Sum Sq Mean Sq F value
    ## APOP_PLOT_7_agranular_FAMILY_B_BAD_REMOVED$GROUP  1 0.0003 0.00030   0.009
    ## Residuals                                         7 0.2253 0.03219        
    ##                                                  Pr(>F)
    ## APOP_PLOT_7_agranular_FAMILY_B_BAD_REMOVED$GROUP  0.925
    ## Residuals

### FAMILY D

``` r
APOP_PLOT_7_dead_agranular_FAMILY_D_AOV <- aov(APOP_PLOT_7_agranular_FAMILY_D$Q1.UR_Arcsine ~ APOP_PLOT_7_agranular_FAMILY_D$GROUP, data=APOP_PLOT_7_agranular_FAMILY_D)
summary(APOP_PLOT_7_dead_agranular_FAMILY_D_AOV)
```

    ##                                      Df  Sum Sq  Mean Sq F value Pr(>F)
    ## APOP_PLOT_7_agranular_FAMILY_D$GROUP  1 0.00134 0.001343   0.084  0.781
    ## Residuals                             7 0.11229 0.016042

``` r
APOP_PLOT_7_dead_agranular_FAMILY_D_AOV_BAD_REMOVED <- aov(APOP_PLOT_7_agranular_FAMILY_D_BAD_REMOVED$Q1.UR_Arcsine ~ APOP_PLOT_7_agranular_FAMILY_D_BAD_REMOVED$GROUP, data=APOP_PLOT_7_agranular_FAMILY_D_BAD_REMOVED)
summary(APOP_PLOT_7_dead_agranular_FAMILY_D_AOV_BAD_REMOVED)      
```

    ##                                                  Df  Sum Sq Mean Sq
    ## APOP_PLOT_7_agranular_FAMILY_D_BAD_REMOVED$GROUP  1 0.00009 0.00009
    ## Residuals                                         6 0.09264 0.01544
    ##                                                  F value Pr(>F)
    ## APOP_PLOT_7_agranular_FAMILY_D_BAD_REMOVED$GROUP   0.006  0.942
    ## Residuals

### FAMILY E

``` r
APOP_PLOT_7_dead_agranular_FAMILY_E_AOV <- aov(APOP_PLOT_7_agranular_FAMILY_E$Q1.UR_Arcsine ~ APOP_PLOT_7_agranular_FAMILY_E$GROUP, data=APOP_PLOT_7_agranular_FAMILY_E)
summary(APOP_PLOT_7_dead_agranular_FAMILY_E_AOV)
```

    ##                                      Df  Sum Sq Mean Sq F value Pr(>F)
    ## APOP_PLOT_7_agranular_FAMILY_E$GROUP  1 0.01271 0.01271   0.666  0.436
    ## Residuals                             9 0.17185 0.01910

``` r
APOP_PLOT_7_dead_agranular_FAMILY_E_AOV_BAD_REMOVED <- aov(APOP_PLOT_7_agranular_FAMILY_E_BAD_REMOVED$Q1.UR_Arcsine ~ APOP_PLOT_7_agranular_FAMILY_E_BAD_REMOVED$GROUP, data=APOP_PLOT_7_agranular_FAMILY_E_BAD_REMOVED)
summary(APOP_PLOT_7_dead_agranular_FAMILY_E_AOV_BAD_REMOVED)      
```

    ##                                                  Df  Sum Sq  Mean Sq
    ## APOP_PLOT_7_agranular_FAMILY_E_BAD_REMOVED$GROUP  1 0.00386 0.003857
    ## Residuals                                         7 0.12383 0.017691
    ##                                                  F value Pr(>F)
    ## APOP_PLOT_7_agranular_FAMILY_E_BAD_REMOVED$GROUP   0.218  0.655
    ## Residuals

### FAMILY J

``` r
APOP_PLOT_7_dead_agranular_FAMILY_J_AOV <- aov(APOP_PLOT_7_agranular_FAMILY_J$Q1.UR_Arcsine ~ APOP_PLOT_7_agranular_FAMILY_J$GROUP, data=APOP_PLOT_7_agranular_FAMILY_J)
summary(APOP_PLOT_7_dead_agranular_FAMILY_J_AOV)
```

    ##                                      Df  Sum Sq  Mean Sq F value Pr(>F)
    ## APOP_PLOT_7_agranular_FAMILY_J$GROUP  1 0.00501 0.005006   0.343   0.57
    ## Residuals                            11 0.16033 0.014575

``` r
APOP_PLOT_7_dead_agranular_FAMILY_J_AOV_BAD_REMOVED <- aov(APOP_PLOT_7_agranular_FAMILY_J_BAD_REMOVED$Q1.UR_Arcsine ~ APOP_PLOT_7_agranular_FAMILY_J_BAD_REMOVED$GROUP, data=APOP_PLOT_7_agranular_FAMILY_J_BAD_REMOVED)
summary(APOP_PLOT_7_dead_agranular_FAMILY_J_AOV_BAD_REMOVED)      
```

    ##                                                  Df  Sum Sq  Mean Sq
    ## APOP_PLOT_7_agranular_FAMILY_J_BAD_REMOVED$GROUP  1 0.00166 0.001664
    ## Residuals                                         9 0.15357 0.017063
    ##                                                  F value Pr(>F)
    ## APOP_PLOT_7_agranular_FAMILY_J_BAD_REMOVED$GROUP   0.098  0.762
    ## Residuals

### FAMILY L

``` r
APOP_PLOT_7_dead_agranular_FAMILY_L_AOV <- aov(APOP_PLOT_7_agranular_FAMILY_L$Q1.UR_Arcsine ~ APOP_PLOT_7_agranular_FAMILY_L$GROUP, data=APOP_PLOT_7_agranular_FAMILY_L)
summary(APOP_PLOT_7_dead_agranular_FAMILY_L_AOV)
```

    ##                                      Df Sum Sq Mean Sq F value Pr(>F)
    ## APOP_PLOT_7_agranular_FAMILY_L$GROUP  1 0.0127 0.01266   0.337  0.573
    ## Residuals                            11 0.4128 0.03753

``` r
APOP_PLOT_7_dead_agranular_FAMILY_L_AOV_BAD_REMOVED <- aov(APOP_PLOT_7_agranular_FAMILY_L_BAD_REMOVED$Q1.UR_Arcsine ~ APOP_PLOT_7_agranular_FAMILY_L_BAD_REMOVED$GROUP, data=APOP_PLOT_7_agranular_FAMILY_L_BAD_REMOVED)
summary(APOP_PLOT_7_dead_agranular_FAMILY_L_AOV_BAD_REMOVED)      
```

    ##                                                  Df  Sum Sq Mean Sq
    ## APOP_PLOT_7_agranular_FAMILY_L_BAD_REMOVED$GROUP  1 0.00008 0.00008
    ## Residuals                                         7 0.26287 0.03755
    ##                                                  F value Pr(>F)
    ## APOP_PLOT_7_agranular_FAMILY_L_BAD_REMOVED$GROUP   0.002  0.965
    ## Residuals

### TWO WAY ANOVA

``` r
APOP_PLOT_7_dead_agranular_TWO_WAY_AOV <- lm(APOP_PLOT7_AGRANULAR_QUAD_PLOT$Q1.UR_Arcsine ~ APOP_PLOT7_AGRANULAR_QUAD_PLOT$GROUP + APOP_PLOT7_AGRANULAR_QUAD_PLOT$FAMILY, data=APOP_PLOT7_AGRANULAR_QUAD_PLOT)
Anova(APOP_PLOT_7_dead_agranular_TWO_WAY_AOV, type="II")
```

    ## Anova Table (Type II tests)
    ## 
    ## Response: APOP_PLOT7_AGRANULAR_QUAD_PLOT$Q1.UR_Arcsine
    ##                                        Sum Sq Df F value    Pr(>F)    
    ## APOP_PLOT7_AGRANULAR_QUAD_PLOT$GROUP  0.02442  1  1.1575 0.2862202    
    ## APOP_PLOT7_AGRANULAR_QUAD_PLOT$FAMILY 0.58557  5  5.5502 0.0002815 ***
    ## Residuals                             1.28717 61                      
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

``` r
summary(APOP_PLOT_7_dead_agranular_TWO_WAY_AOV)
```

    ## 
    ## Call:
    ## lm(formula = APOP_PLOT7_AGRANULAR_QUAD_PLOT$Q1.UR_Arcsine ~ APOP_PLOT7_AGRANULAR_QUAD_PLOT$GROUP + 
    ##     APOP_PLOT7_AGRANULAR_QUAD_PLOT$FAMILY, data = APOP_PLOT7_AGRANULAR_QUAD_PLOT)
    ## 
    ## Residuals:
    ##      Min       1Q   Median       3Q      Max 
    ## -0.25505 -0.11640  0.03650  0.09035  0.28911 
    ## 
    ## Coefficients:
    ##                                               Estimate Std. Error t value
    ## (Intercept)                                    0.41560    0.05269   7.887
    ## APOP_PLOT7_AGRANULAR_QUAD_PLOT$GROUPtreatment -0.04577    0.04255  -1.076
    ## APOP_PLOT7_AGRANULAR_QUAD_PLOT$FAMILYB         0.12037    0.06223   1.934
    ## APOP_PLOT7_AGRANULAR_QUAD_PLOT$FAMILYD         0.13270    0.06407   2.071
    ## APOP_PLOT7_AGRANULAR_QUAD_PLOT$FAMILYE         0.01588    0.06071   0.262
    ## APOP_PLOT7_AGRANULAR_QUAD_PLOT$FAMILYJ         0.06508    0.05816   1.119
    ## APOP_PLOT7_AGRANULAR_QUAD_PLOT$FAMILYL        -0.14171    0.05816  -2.437
    ##                                               Pr(>|t|)    
    ## (Intercept)                                   6.88e-11 ***
    ## APOP_PLOT7_AGRANULAR_QUAD_PLOT$GROUPtreatment   0.2862    
    ## APOP_PLOT7_AGRANULAR_QUAD_PLOT$FAMILYB          0.0577 .  
    ## APOP_PLOT7_AGRANULAR_QUAD_PLOT$FAMILYD          0.0426 *  
    ## APOP_PLOT7_AGRANULAR_QUAD_PLOT$FAMILYE          0.7946    
    ## APOP_PLOT7_AGRANULAR_QUAD_PLOT$FAMILYJ          0.2675    
    ## APOP_PLOT7_AGRANULAR_QUAD_PLOT$FAMILYL          0.0178 *  
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
    ## 
    ## Residual standard error: 0.1453 on 61 degrees of freedom
    ## Multiple R-squared:  0.3203, Adjusted R-squared:  0.2534 
    ## F-statistic: 4.791 on 6 and 61 DF,  p-value: 0.0004615

``` r
APOP_PLOT_7_dead_agranular_TWO_WAY_AOV_BAD_REMOVED <- lm(APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$Q1.UR_Arcsine ~ APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$GROUP + APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILY, data=APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED)
Anova(APOP_PLOT_7_dead_agranular_TWO_WAY_AOV_BAD_REMOVED,type="II")
```

    ## Anova Table (Type II tests)
    ## 
    ## Response: APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$Q1.UR_Arcsine
    ##                                                    Sum Sq Df F value
    ## APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$GROUP  0.00939  1  0.4801
    ## APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILY 0.45959  5  4.6976
    ## Residuals                                         0.97835 50        
    ##                                                     Pr(>F)   
    ## APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$GROUP  0.491583   
    ## APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILY 0.001358 **
    ## Residuals                                                    
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

``` r
summary(APOP_PLOT_7_dead_agranular_TWO_WAY_AOV_BAD_REMOVED) 
```

    ## 
    ## Call:
    ## lm(formula = APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$Q1.UR_Arcsine ~ 
    ##     APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$GROUP + APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILY, 
    ##     data = APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED)
    ## 
    ## Residuals:
    ##      Min       1Q   Median       3Q      Max 
    ## -0.27036 -0.10280  0.03097  0.10358  0.28523 
    ## 
    ## Coefficients:
    ##                                                           Estimate
    ## (Intercept)                                                0.38896
    ## APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$GROUPtreatment -0.03067
    ## APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYB         0.11182
    ## APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYD         0.16378
    ## APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYE         0.06231
    ## APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYJ         0.08517
    ## APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYL        -0.12629
    ##                                                           Std. Error
    ## (Intercept)                                                  0.05306
    ## APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$GROUPtreatment    0.04427
    ## APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYB           0.06291
    ## APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYD           0.06501
    ## APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYE           0.06291
    ## APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYJ           0.05978
    ## APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYL           0.06291
    ##                                                           t value Pr(>|t|)
    ## (Intercept)                                                 7.331 1.83e-09
    ## APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$GROUPtreatment  -0.693   0.4916
    ## APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYB          1.777   0.0816
    ## APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYD          2.519   0.0150
    ## APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYE          0.990   0.3268
    ## APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYJ          1.425   0.1604
    ## APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYL         -2.007   0.0501
    ##                                                              
    ## (Intercept)                                               ***
    ## APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$GROUPtreatment    
    ## APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYB        .  
    ## APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYD        *  
    ## APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYE           
    ## APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYJ           
    ## APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYL        .  
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
    ## 
    ## Residual standard error: 0.1399 on 50 degrees of freedom
    ## Multiple R-squared:  0.3236, Adjusted R-squared:  0.2424 
    ## F-statistic: 3.986 on 6 and 50 DF,  p-value: 0.002455

``` r
# INTERACTION TERM ADDED
APOP_PLOT_7_dead_agranular_INTERACTION_aov <- lm(APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$Q1.UR_Arcsine ~ APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILY + APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$GROUP + APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILY*APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$GROUP)
Anova(APOP_PLOT_7_dead_agranular_INTERACTION_aov, type="II") #family is significant
```

    ## Anova Table (Type II tests)
    ## 
    ## Response: APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$Q1.UR_Arcsine
    ##                                                                                                     Sum Sq
    ## APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILY                                                  0.45959
    ## APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$GROUP                                                   0.00939
    ## APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILY:APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$GROUP 0.01075
    ## Residuals                                                                                          0.96760
    ##                                                                                                    Df
    ## APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILY                                                   5
    ## APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$GROUP                                                    1
    ## APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILY:APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$GROUP  5
    ## Residuals                                                                                          45
    ##                                                                                                    F value
    ## APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILY                                                   4.2748
    ## APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$GROUP                                                    0.4369
    ## APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILY:APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$GROUP  0.1000
    ## Residuals                                                                                                 
    ##                                                                                                     Pr(>F)
    ## APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILY                                                  0.00289
    ## APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$GROUP                                                   0.51200
    ## APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILY:APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$GROUP 0.99162
    ## Residuals                                                                                                 
    ##                                                                                                      
    ## APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILY                                                  **
    ## APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$GROUP                                                     
    ## APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILY:APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$GROUP   
    ## Residuals                                                                                            
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

``` r
summary(APOP_PLOT_7_dead_agranular_INTERACTION_aov)
```

    ## 
    ## Call:
    ## lm(formula = APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$Q1.UR_Arcsine ~ 
    ##     APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILY + APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$GROUP + 
    ##         APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILY * APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$GROUP)
    ## 
    ## Residuals:
    ##      Min       1Q   Median       3Q      Max 
    ## -0.26611 -0.09201  0.03120  0.09928  0.27999 
    ## 
    ## Coefficients:
    ##                                                                                                              Estimate
    ## (Intercept)                                                                                                   0.42522
    ## APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYB                                                            0.04082
    ## APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYD                                                            0.11033
    ## APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYE                                                            0.04092
    ## APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYJ                                                            0.04991
    ## APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYL                                                           -0.18088
    ## APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$GROUPtreatment                                                    -0.08053
    ## APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYB:APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$GROUPtreatment  0.09452
    ## APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYD:APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$GROUPtreatment  0.07277
    ## APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYE:APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$GROUPtreatment  0.03074
    ## APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYJ:APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$GROUPtreatment  0.04864
    ## APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYL:APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$GROUPtreatment  0.07343
    ##                                                                                                              Std. Error
    ## (Intercept)                                                                                                     0.08466
    ## APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYB                                                              0.13386
    ## APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYD                                                              0.13386
    ## APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYE                                                              0.13386
    ## APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYJ                                                              0.13386
    ## APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYL                                                              0.13386
    ## APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$GROUPtreatment                                                       0.09927
    ## APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYB:APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$GROUPtreatment    0.15388
    ## APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYD:APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$GROUPtreatment    0.15553
    ## APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYE:APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$GROUPtreatment    0.15388
    ## APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYJ:APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$GROUPtreatment    0.15164
    ## APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYL:APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$GROUPtreatment    0.15388
    ##                                                                                                              t value
    ## (Intercept)                                                                                                    5.023
    ## APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYB                                                             0.305
    ## APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYD                                                             0.824
    ## APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYE                                                             0.306
    ## APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYJ                                                             0.373
    ## APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYL                                                            -1.351
    ## APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$GROUPtreatment                                                     -0.811
    ## APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYB:APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$GROUPtreatment   0.614
    ## APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYD:APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$GROUPtreatment   0.468
    ## APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYE:APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$GROUPtreatment   0.200
    ## APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYJ:APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$GROUPtreatment   0.321
    ## APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYL:APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$GROUPtreatment   0.477
    ##                                                                                                              Pr(>|t|)
    ## (Intercept)                                                                                                  8.53e-06
    ## APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYB                                                              0.762
    ## APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYD                                                              0.414
    ## APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYE                                                              0.761
    ## APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYJ                                                              0.711
    ## APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYL                                                              0.183
    ## APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$GROUPtreatment                                                       0.422
    ## APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYB:APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$GROUPtreatment    0.542
    ## APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYD:APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$GROUPtreatment    0.642
    ## APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYE:APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$GROUPtreatment    0.843
    ## APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYJ:APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$GROUPtreatment    0.750
    ## APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYL:APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$GROUPtreatment    0.636
    ##                                                                                                                 
    ## (Intercept)                                                                                                  ***
    ## APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYB                                                              
    ## APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYD                                                              
    ## APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYE                                                              
    ## APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYJ                                                              
    ## APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYL                                                              
    ## APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$GROUPtreatment                                                       
    ## APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYB:APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$GROUPtreatment    
    ## APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYD:APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$GROUPtreatment    
    ## APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYE:APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$GROUPtreatment    
    ## APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYJ:APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$GROUPtreatment    
    ## APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYL:APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$GROUPtreatment    
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
    ## 
    ## Residual standard error: 0.1466 on 45 degrees of freedom
    ## Multiple R-squared:  0.331,  Adjusted R-squared:  0.1675 
    ## F-statistic: 2.024 on 11 and 45 DF,  p-value: 0.04819

``` r
APOP_PLOT_7_dead_agranular_INTERACTION_aov_leastsquares <- lsmeans(APOP_PLOT_7_dead_agranular_INTERACTION_aov, "APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILY", adjust="tukey")
cld(APOP_PLOT_7_dead_agranular_INTERACTION_aov_leastsquares, alpha=0.05, Letters=letters)
```

    ##  APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILY    lsmean         SE df
    ##  A                                                 0.3446900 0.05184378 45
    ##  B                                                 0.3446900 0.05184378 45
    ##  D                                                 0.3849555 0.04963664 45
    ##  E                                                 0.3849555 0.04963664 45
    ##  J                                                 0.3849555 0.04963664 45
    ##  L                                                 0.4123633 0.03794576 45
    ##   lower.CL  upper.CL .group
    ##  0.2402713 0.4491088  a    
    ##  0.2402713 0.4491088  a    
    ##  0.2849822 0.4849289  a    
    ##  0.2849822 0.4849289  a    
    ##  0.2849822 0.4849289  a    
    ##  0.3359366 0.4887900  a    
    ## 
    ## Results are averaged over the levels of: APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$GROUP 
    ## Confidence level used: 0.95 
    ## P value adjustment: tukey method for comparing a family of 6 estimates 
    ## significance level used: alpha = 0.05

``` r
#each family is significantly different
```

### One Way ANOVA of Differences between Families

``` r
APOP_PLOT_7_dead_agranular_hemocytes_BAD_REMOVED_CHALLENGE <- APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED[!grepl("control",APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$GROUP),]
APOP_PLOT_7_dead_agranular_oneway_aov <- aov(APOP_PLOT_7_dead_agranular_hemocytes_BAD_REMOVED_CHALLENGE$Q1.UR_Arcsine ~ APOP_PLOT_7_dead_agranular_hemocytes_BAD_REMOVED_CHALLENGE$FAMILY, data=APOP_PLOT_7_dead_agranular_hemocytes_BAD_REMOVED_CHALLENGE)
summary(APOP_PLOT_7_dead_agranular_oneway_aov)
```

    ##                                                                   Df
    ## APOP_PLOT_7_dead_agranular_hemocytes_BAD_REMOVED_CHALLENGE$FAMILY  5
    ## Residuals                                                         38
    ##                                                                   Sum Sq
    ## APOP_PLOT_7_dead_agranular_hemocytes_BAD_REMOVED_CHALLENGE$FAMILY  0.370
    ## Residuals                                                          0.754
    ##                                                                   Mean Sq
    ## APOP_PLOT_7_dead_agranular_hemocytes_BAD_REMOVED_CHALLENGE$FAMILY 0.07401
    ## Residuals                                                         0.01984
    ##                                                                   F value
    ## APOP_PLOT_7_dead_agranular_hemocytes_BAD_REMOVED_CHALLENGE$FAMILY    3.73
    ## Residuals                                                                
    ##                                                                    Pr(>F)
    ## APOP_PLOT_7_dead_agranular_hemocytes_BAD_REMOVED_CHALLENGE$FAMILY 0.00762
    ## Residuals                                                                
    ##                                                                     
    ## APOP_PLOT_7_dead_agranular_hemocytes_BAD_REMOVED_CHALLENGE$FAMILY **
    ## Residuals                                                           
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

``` r
TukeyHSD(APOP_PLOT_7_dead_agranular_oneway_aov)
```

    ##   Tukey multiple comparisons of means
    ##     95% family-wise confidence level
    ## 
    ## Fit: aov(formula = APOP_PLOT_7_dead_agranular_hemocytes_BAD_REMOVED_CHALLENGE$Q1.UR_Arcsine ~ APOP_PLOT_7_dead_agranular_hemocytes_BAD_REMOVED_CHALLENGE$FAMILY, data = APOP_PLOT_7_dead_agranular_hemocytes_BAD_REMOVED_CHALLENGE)
    ## 
    ## $`APOP_PLOT_7_dead_agranular_hemocytes_BAD_REMOVED_CHALLENGE$FAMILY`
    ##            diff         lwr          upr     p adj
    ## B-A  0.13534652 -0.08336146  0.354054503 0.4435284
    ## D-A  0.18310263 -0.04511880  0.411324054 0.1795580
    ## E-A  0.07165620 -0.14705178  0.290364176 0.9205755
    ## J-A  0.09855086 -0.10678803  0.303889762 0.7030758
    ## L-A -0.10745627 -0.32616425  0.111251712 0.6823533
    ## D-B  0.04775611 -0.18734791  0.282860121 0.9897027
    ## E-B -0.06369033 -0.28957096  0.162190304 0.9567138
    ## J-B -0.03679566 -0.24975796  0.176166642 0.9951202
    ## L-B -0.24280279 -0.46868342 -0.016922160 0.0288820
    ## E-D -0.11144643 -0.34655045  0.123657582 0.7136913
    ## J-D -0.08455176 -0.30727307  0.138169541 0.8619690
    ## L-D -0.29055890 -0.52566291 -0.055454883 0.0081052
    ## J-E  0.02689467 -0.18606763  0.239856969 0.9989006
    ## L-E -0.17911246 -0.40499310  0.046768166 0.1893945
    ## L-J -0.20600713 -0.41896943  0.006955169 0.0628821

Percent Dead Apoptotic Granular and Agranular Hemocytes
-------------------------------------------------------

``` r
dead_apoptotic_granular <- APOP_PLOT4_GRANULAR_QUAD_PLOT_GATE_ADDED %>% filter(GATE=="Q2_UR") 
dead_apoptotic_agranular <- APOP_PLOT7_AGRANULAR_QUAD_PLOT_GATE_ADDED %>% filter(GATE=="Q1_UR")
combined_dead_apoptotic_agranular_granular <- rbind(dead_apoptotic_granular, dead_apoptotic_agranular)
ggplot(combined_dead_apoptotic_agranular_granular, aes(x=GROUP, y=PERCENT_OF_THIS_PLOT, fill=GATE)) + geom_boxplot() + ggtitle("Percent of Granular and Agranular Dead Apoptotic Hemocytes \n in Challenged Oysters (low quality removed)") +
  ylab("Percent of Hemocyte Events in each quad plot") + scale_fill_manual(name="Hemocyte Type", labels=c("Dead Apoptotic Granular", "Dead Apoptotic Agranular"), values=c("Q2_UR"="#99a765","Q1_UR"="#96578a")) + facet_grid(.~FAMILY+GROUP, scales="free")
```

![](Dermo_Apoptosis_Assay_Data_analysis_files/figure-markdown_github/dead_apoptotic_granular_agranular-1.png)

``` r
# Two-Way ANOVA
combined_dead_apoptotic_agranular_granular_aov <- lm(combined_dead_apoptotic_agranular_granular$Arcsine ~ combined_dead_apoptotic_agranular_granular$FAMILY + combined_dead_apoptotic_agranular_granular$GATE, data=combined_dead_apoptotic_agranular_granular) # both family and gate are very significant
Anova(combined_dead_apoptotic_agranular_granular_aov, type="II")
```

    ## Anova Table (Type II tests)
    ## 
    ## Response: combined_dead_apoptotic_agranular_granular$Arcsine
    ##                                                    Sum Sq  Df  F value
    ## combined_dead_apoptotic_agranular_granular$FAMILY 0.53712   5   8.0202
    ## combined_dead_apoptotic_agranular_granular$GATE   2.16712   1 161.7977
    ## Residuals                                         1.72783 129         
    ##                                                      Pr(>F)    
    ## combined_dead_apoptotic_agranular_granular$FAMILY 1.303e-06 ***
    ## combined_dead_apoptotic_agranular_granular$GATE   < 2.2e-16 ***
    ## Residuals                                                      
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

``` r
summary(combined_dead_apoptotic_agranular_granular_aov)
```

    ## 
    ## Call:
    ## lm(formula = combined_dead_apoptotic_agranular_granular$Arcsine ~ 
    ##     combined_dead_apoptotic_agranular_granular$FAMILY + combined_dead_apoptotic_agranular_granular$GATE, 
    ##     data = combined_dead_apoptotic_agranular_granular)
    ## 
    ## Residuals:
    ##      Min       1Q   Median       3Q      Max 
    ## -0.27427 -0.06356 -0.01033  0.08266  0.24734 
    ## 
    ## Coefficients:
    ##                                                      Estimate Std. Error
    ## (Intercept)                                           0.13205    0.02562
    ## combined_dead_apoptotic_agranular_granular$FAMILYB    0.10243    0.03504
    ## combined_dead_apoptotic_agranular_granular$FAMILYD    0.07706    0.03609
    ## combined_dead_apoptotic_agranular_granular$FAMILYE    0.01242    0.03416
    ## combined_dead_apoptotic_agranular_granular$FAMILYJ    0.04483    0.03276
    ## combined_dead_apoptotic_agranular_granular$FAMILYL   -0.09024    0.03276
    ## combined_dead_apoptotic_agranular_granular$GATEQ1_UR  0.25247    0.01985
    ##                                                      t value Pr(>|t|)    
    ## (Intercept)                                            5.153 9.35e-07 ***
    ## combined_dead_apoptotic_agranular_granular$FAMILYB     2.923  0.00409 ** 
    ## combined_dead_apoptotic_agranular_granular$FAMILYD     2.135  0.03461 *  
    ## combined_dead_apoptotic_agranular_granular$FAMILYE     0.364  0.71672    
    ## combined_dead_apoptotic_agranular_granular$FAMILYJ     1.368  0.17357    
    ## combined_dead_apoptotic_agranular_granular$FAMILYL    -2.755  0.00672 ** 
    ## combined_dead_apoptotic_agranular_granular$GATEQ1_UR  12.720  < 2e-16 ***
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
    ## 
    ## Residual standard error: 0.1157 on 129 degrees of freedom
    ## Multiple R-squared:  0.6102, Adjusted R-squared:  0.592 
    ## F-statistic: 33.65 on 6 and 129 DF,  p-value: < 2.2e-16

``` r
#Two-Way ANOVA plus an interaction 
combined_dead_apoptotic_agranular_granular_aov_interaction <- lm(combined_dead_apoptotic_agranular_granular$Arcsine ~ combined_dead_apoptotic_agranular_granular$FAMILY + combined_dead_apoptotic_agranular_granular$GATE + combined_dead_apoptotic_agranular_granular$FAMILY:combined_dead_apoptotic_agranular_granular$GATE, data=combined_dead_apoptotic_agranular_granular)
Anova(combined_dead_apoptotic_agranular_granular_aov_interaction, type="II") #Gate and family are significant
```

    ## Anova Table (Type II tests)
    ## 
    ## Response: combined_dead_apoptotic_agranular_granular$Arcsine
    ##                                                                                                    Sum Sq
    ## combined_dead_apoptotic_agranular_granular$FAMILY                                                 0.53712
    ## combined_dead_apoptotic_agranular_granular$GATE                                                   2.16712
    ## combined_dead_apoptotic_agranular_granular$FAMILY:combined_dead_apoptotic_agranular_granular$GATE 0.13766
    ## Residuals                                                                                         1.59016
    ##                                                                                                    Df
    ## combined_dead_apoptotic_agranular_granular$FAMILY                                                   5
    ## combined_dead_apoptotic_agranular_granular$GATE                                                     1
    ## combined_dead_apoptotic_agranular_granular$FAMILY:combined_dead_apoptotic_agranular_granular$GATE   5
    ## Residuals                                                                                         124
    ##                                                                                                    F value
    ## combined_dead_apoptotic_agranular_granular$FAMILY                                                   8.3768
    ## combined_dead_apoptotic_agranular_granular$GATE                                                   168.9908
    ## combined_dead_apoptotic_agranular_granular$FAMILY:combined_dead_apoptotic_agranular_granular$GATE   2.1470
    ## Residuals                                                                                                 
    ##                                                                                                      Pr(>F)
    ## combined_dead_apoptotic_agranular_granular$FAMILY                                                 7.513e-07
    ## combined_dead_apoptotic_agranular_granular$GATE                                                   < 2.2e-16
    ## combined_dead_apoptotic_agranular_granular$FAMILY:combined_dead_apoptotic_agranular_granular$GATE   0.06421
    ## Residuals                                                                                                  
    ##                                                                                                      
    ## combined_dead_apoptotic_agranular_granular$FAMILY                                                 ***
    ## combined_dead_apoptotic_agranular_granular$GATE                                                   ***
    ## combined_dead_apoptotic_agranular_granular$FAMILY:combined_dead_apoptotic_agranular_granular$GATE .  
    ## Residuals                                                                                            
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

``` r
summary(combined_dead_apoptotic_agranular_granular_aov_interaction)
```

    ## 
    ## Call:
    ## lm(formula = combined_dead_apoptotic_agranular_granular$Arcsine ~ 
    ##     combined_dead_apoptotic_agranular_granular$FAMILY + combined_dead_apoptotic_agranular_granular$GATE + 
    ##         combined_dead_apoptotic_agranular_granular$FAMILY:combined_dead_apoptotic_agranular_granular$GATE, 
    ##     data = combined_dead_apoptotic_agranular_granular)
    ## 
    ## Residuals:
    ##       Min        1Q    Median        3Q       Max 
    ## -0.265614 -0.067390  0.000297  0.073355  0.278547 
    ## 
    ## Coefficients:
    ##                                                                                                           Estimate
    ## (Intercept)                                                                                              0.1352963
    ## combined_dead_apoptotic_agranular_granular$FAMILYB                                                       0.0867773
    ## combined_dead_apoptotic_agranular_granular$FAMILYD                                                       0.0226927
    ## combined_dead_apoptotic_agranular_granular$FAMILYE                                                       0.0120880
    ## combined_dead_apoptotic_agranular_granular$FAMILYJ                                                       0.0254556
    ## combined_dead_apoptotic_agranular_granular$FAMILYL                                                      -0.0379017
    ## combined_dead_apoptotic_agranular_granular$GATEQ1_UR                                                     0.2459689
    ## combined_dead_apoptotic_agranular_granular$FAMILYB:combined_dead_apoptotic_agranular_granular$GATEQ1_UR  0.0313018
    ## combined_dead_apoptotic_agranular_granular$FAMILYD:combined_dead_apoptotic_agranular_granular$GATEQ1_UR  0.1087353
    ## combined_dead_apoptotic_agranular_granular$FAMILYE:combined_dead_apoptotic_agranular_granular$GATEQ1_UR  0.0006682
    ## combined_dead_apoptotic_agranular_granular$FAMILYJ:combined_dead_apoptotic_agranular_granular$GATEQ1_UR  0.0387468
    ## combined_dead_apoptotic_agranular_granular$FAMILYL:combined_dead_apoptotic_agranular_granular$GATEQ1_UR -0.1046858
    ##                                                                                                         Std. Error
    ## (Intercept)                                                                                              0.0326903
    ## combined_dead_apoptotic_agranular_granular$FAMILYB                                                       0.0484876
    ## combined_dead_apoptotic_agranular_granular$FAMILYD                                                       0.0499353
    ## combined_dead_apoptotic_agranular_granular$FAMILYE                                                       0.0472702
    ## combined_dead_apoptotic_agranular_granular$FAMILYJ                                                       0.0453334
    ## combined_dead_apoptotic_agranular_granular$FAMILYL                                                       0.0453334
    ## combined_dead_apoptotic_agranular_granular$GATEQ1_UR                                                     0.0462311
    ## combined_dead_apoptotic_agranular_granular$FAMILYB:combined_dead_apoptotic_agranular_granular$GATEQ1_UR  0.0685718
    ## combined_dead_apoptotic_agranular_granular$FAMILYD:combined_dead_apoptotic_agranular_granular$GATEQ1_UR  0.0706192
    ## combined_dead_apoptotic_agranular_granular$FAMILYE:combined_dead_apoptotic_agranular_granular$GATEQ1_UR  0.0668501
    ## combined_dead_apoptotic_agranular_granular$FAMILYJ:combined_dead_apoptotic_agranular_granular$GATEQ1_UR  0.0641110
    ## combined_dead_apoptotic_agranular_granular$FAMILYL:combined_dead_apoptotic_agranular_granular$GATEQ1_UR  0.0641110
    ##                                                                                                         t value
    ## (Intercept)                                                                                               4.139
    ## combined_dead_apoptotic_agranular_granular$FAMILYB                                                        1.790
    ## combined_dead_apoptotic_agranular_granular$FAMILYD                                                        0.454
    ## combined_dead_apoptotic_agranular_granular$FAMILYE                                                        0.256
    ## combined_dead_apoptotic_agranular_granular$FAMILYJ                                                        0.562
    ## combined_dead_apoptotic_agranular_granular$FAMILYL                                                       -0.836
    ## combined_dead_apoptotic_agranular_granular$GATEQ1_UR                                                      5.320
    ## combined_dead_apoptotic_agranular_granular$FAMILYB:combined_dead_apoptotic_agranular_granular$GATEQ1_UR   0.456
    ## combined_dead_apoptotic_agranular_granular$FAMILYD:combined_dead_apoptotic_agranular_granular$GATEQ1_UR   1.540
    ## combined_dead_apoptotic_agranular_granular$FAMILYE:combined_dead_apoptotic_agranular_granular$GATEQ1_UR   0.010
    ## combined_dead_apoptotic_agranular_granular$FAMILYJ:combined_dead_apoptotic_agranular_granular$GATEQ1_UR   0.604
    ## combined_dead_apoptotic_agranular_granular$FAMILYL:combined_dead_apoptotic_agranular_granular$GATEQ1_UR  -1.633
    ##                                                                                                         Pr(>|t|)
    ## (Intercept)                                                                                             6.40e-05
    ## combined_dead_apoptotic_agranular_granular$FAMILYB                                                        0.0759
    ## combined_dead_apoptotic_agranular_granular$FAMILYD                                                        0.6503
    ## combined_dead_apoptotic_agranular_granular$FAMILYE                                                        0.7986
    ## combined_dead_apoptotic_agranular_granular$FAMILYJ                                                        0.5755
    ## combined_dead_apoptotic_agranular_granular$FAMILYL                                                        0.4047
    ## combined_dead_apoptotic_agranular_granular$GATEQ1_UR                                                    4.67e-07
    ## combined_dead_apoptotic_agranular_granular$FAMILYB:combined_dead_apoptotic_agranular_granular$GATEQ1_UR   0.6488
    ## combined_dead_apoptotic_agranular_granular$FAMILYD:combined_dead_apoptotic_agranular_granular$GATEQ1_UR   0.1262
    ## combined_dead_apoptotic_agranular_granular$FAMILYE:combined_dead_apoptotic_agranular_granular$GATEQ1_UR   0.9920
    ## combined_dead_apoptotic_agranular_granular$FAMILYJ:combined_dead_apoptotic_agranular_granular$GATEQ1_UR   0.5467
    ## combined_dead_apoptotic_agranular_granular$FAMILYL:combined_dead_apoptotic_agranular_granular$GATEQ1_UR   0.1050
    ##                                                                                                            
    ## (Intercept)                                                                                             ***
    ## combined_dead_apoptotic_agranular_granular$FAMILYB                                                      .  
    ## combined_dead_apoptotic_agranular_granular$FAMILYD                                                         
    ## combined_dead_apoptotic_agranular_granular$FAMILYE                                                         
    ## combined_dead_apoptotic_agranular_granular$FAMILYJ                                                         
    ## combined_dead_apoptotic_agranular_granular$FAMILYL                                                         
    ## combined_dead_apoptotic_agranular_granular$GATEQ1_UR                                                    ***
    ## combined_dead_apoptotic_agranular_granular$FAMILYB:combined_dead_apoptotic_agranular_granular$GATEQ1_UR    
    ## combined_dead_apoptotic_agranular_granular$FAMILYD:combined_dead_apoptotic_agranular_granular$GATEQ1_UR    
    ## combined_dead_apoptotic_agranular_granular$FAMILYE:combined_dead_apoptotic_agranular_granular$GATEQ1_UR    
    ## combined_dead_apoptotic_agranular_granular$FAMILYJ:combined_dead_apoptotic_agranular_granular$GATEQ1_UR    
    ## combined_dead_apoptotic_agranular_granular$FAMILYL:combined_dead_apoptotic_agranular_granular$GATEQ1_UR    
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
    ## 
    ## Residual standard error: 0.1132 on 124 degrees of freedom
    ## Multiple R-squared:  0.6412, Adjusted R-squared:  0.6094 
    ## F-statistic: 20.15 on 11 and 124 DF,  p-value: < 2.2e-16

``` r
combined_dead_apoptotic_agranular_granular_aov_interaction_leastsquares <- lsmeans(combined_dead_apoptotic_agranular_granular_aov_interaction, "combined_dead_apoptotic_agranular_granular$FAMILY", adjust = "tukey")
cld(combined_dead_apoptotic_agranular_granular_aov_interaction_leastsquares, alpha=0.05, Letters=letters) #indicates significant differences between families
```

    ##  combined_dead_apoptotic_agranular_granular$FAMILY    lsmean         SE
    ##  A                                                 0.1352963 0.03269035
    ##  B                                                 0.1352963 0.03269035
    ##  D                                                 0.1352963 0.03269035
    ##  E                                                 0.1352963 0.03269035
    ##  J                                                 0.1352963 0.03269035
    ##  L                                                 0.1352963 0.03269035
    ##   df   lower.CL  upper.CL .group
    ##  124 0.07059292 0.1999996  a    
    ##  124 0.07059292 0.1999996  a    
    ##  124 0.07059292 0.1999996  a    
    ##  124 0.07059292 0.1999996  a    
    ##  124 0.07059292 0.1999996  a    
    ##  124 0.07059292 0.1999996  a    
    ## 
    ## Results are averaged over the levels of: combined_dead_apoptotic_agranular_granular$GATE 
    ## Confidence level used: 0.95 
    ## P value adjustment: tukey method for comparing a family of 6 estimates 
    ## significance level used: alpha = 0.05

``` r
combined_dead_apoptotic_agranular_granular_aov_interaction_leastsquares_gate <- lsmeans(combined_dead_apoptotic_agranular_granular_aov_interaction, "combined_dead_apoptotic_agranular_granular$GATE", adjust = "tukey")
cld(combined_dead_apoptotic_agranular_granular_aov_interaction_leastsquares_gate,  alpha=0.05, Letters=letters) 
```

    ##  combined_dead_apoptotic_agranular_granular$GATE    lsmean         SE  df
    ##  Q2_UR                                           0.1352963 0.03269035 124
    ##  Q1_UR                                           0.1352963 0.03269035 124
    ##    lower.CL  upper.CL .group
    ##  0.07059292 0.1999996  a    
    ##  0.07059292 0.1999996  a    
    ## 
    ## Results are averaged over the levels of: combined_dead_apoptotic_agranular_granular$FAMILY 
    ## Confidence level used: 0.95 
    ## significance level used: alpha = 0.05

Percent necrotic granular hemocytes (PLOT 4, Q2-UL)
---------------------------------------------------

Percent Necrotic granular hemocytes (PLOT 4, Q2-UL)
---------------------------------------------------

``` r
APOP_necrotic_granular_BAD_NOT_REMOVED <- ggplot(data=APOP_PLOT4_GRANULAR_QUAD_PLOT, aes(x=FAMILY, y=Q2.UL_PERCENT_OF_THIS_PLOT, color=GROUP, by=GROUP)) + geom_boxplot() + ggtitle("Percent of Necrotic Granular Hemocytes \n Low Quality Not Removed") + xlab("Family") + ylab("Percent of Hemocyte Events") + ylim(0,100)

APOP_necrotic_granular_BAD_NOT_REMOVED
```

![](Dermo_Apoptosis_Assay_Data_analysis_files/figure-markdown_github/necrotic_apoptosis_granular-1.png)

``` r
APOP_necrotic_granular_BAD_REMOVED <- ggplot(data=APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED, aes(x=FAMILY, y=Q2.UL_PERCENT_OF_THIS_PLOT, color=GROUP, by=GROUP)) + geom_boxplot() + ggtitle("Percent of Necrotic Granular Hemocytes \nLow Quality Removed") +
  xlab("Family") + ylab("Percent of Hemocyte Events") + ylim(0,100)
APOP_necrotic_granular_BAD_REMOVED
```

![](Dermo_Apoptosis_Assay_Data_analysis_files/figure-markdown_github/necrotic_apoptosis_granular-2.png)

### FAMILY A

``` r
APOP_PLOT_4_necrotic_granular_FAMILY_A_AOV <- aov(APOP_PLOT_4_granular_FAMILY_A$Q2.UL_Arcsine ~ APOP_PLOT_4_granular_FAMILY_A$GROUP, data=APOP_PLOT_4_granular_FAMILY_A)
summary(APOP_PLOT_4_necrotic_granular_FAMILY_A_AOV)
```

    ##                                     Df   Sum Sq   Mean Sq F value Pr(>F)
    ## APOP_PLOT_4_granular_FAMILY_A$GROUP  1 0.000559 0.0005586   1.454  0.256
    ## Residuals                           10 0.003840 0.0003840

``` r
APOP_PLOT_4_necrotic_granular_FAMILY_A_AOV_BAD_REMOVED <- aov(APOP_PLOT_4_granular_FAMILY_A_BAD_REMOVED$Q2.UL_Arcsine ~ APOP_PLOT_4_granular_FAMILY_A_BAD_REMOVED$GROUP, data=APOP_PLOT_4_granular_FAMILY_A_BAD_REMOVED)
summary(APOP_PLOT_4_necrotic_granular_FAMILY_A_AOV_BAD_REMOVED)      
```

    ##                                                 Df   Sum Sq   Mean Sq
    ## APOP_PLOT_4_granular_FAMILY_A_BAD_REMOVED$GROUP  1 0.000549 0.0005488
    ## Residuals                                        9 0.003840 0.0004266
    ##                                                 F value Pr(>F)
    ## APOP_PLOT_4_granular_FAMILY_A_BAD_REMOVED$GROUP   1.286  0.286
    ## Residuals

### FAMILY B

``` r
APOP_PLOT_4_necrotic_granular_FAMILY_B_AOV <- aov(APOP_PLOT_4_granular_FAMILY_B$Q2.UL_Arcsine ~ APOP_PLOT_4_granular_FAMILY_B$GROUP, data=APOP_PLOT_4_granular_FAMILY_B)
summary(APOP_PLOT_4_necrotic_granular_FAMILY_B_AOV)
```

    ##                                     Df   Sum Sq   Mean Sq F value Pr(>F)
    ## APOP_PLOT_4_granular_FAMILY_B$GROUP  1 0.001919 0.0019191   2.124  0.183
    ## Residuals                            8 0.007227 0.0009034

``` r
APOP_PLOT_4_necrotic_granular_FAMILY_B_AOV_BAD_REMOVED <- aov(APOP_PLOT_4_granular_FAMILY_B_BAD_REMOVED$Q2.UL_Arcsine ~ APOP_PLOT_4_granular_FAMILY_B_BAD_REMOVED$GROUP, data=APOP_PLOT_4_granular_FAMILY_B_BAD_REMOVED)
summary(APOP_PLOT_4_necrotic_granular_FAMILY_B_AOV_BAD_REMOVED)      
```

    ##                                                 Df   Sum Sq   Mean Sq
    ## APOP_PLOT_4_granular_FAMILY_B_BAD_REMOVED$GROUP  1 0.002584 0.0025839
    ## Residuals                                        7 0.005127 0.0007325
    ##                                                 F value Pr(>F)
    ## APOP_PLOT_4_granular_FAMILY_B_BAD_REMOVED$GROUP   3.528  0.102
    ## Residuals

### FAMILY D

``` r
APOP_PLOT_4_necrotic_granular_FAMILY_D_AOV <- aov(APOP_PLOT_4_granular_FAMILY_D$Q2.UL_Arcsine ~ APOP_PLOT_4_granular_FAMILY_D$GROUP, data=APOP_PLOT_4_granular_FAMILY_D)
summary(APOP_PLOT_4_necrotic_granular_FAMILY_D_AOV)
```

    ##                                     Df   Sum Sq  Mean Sq F value Pr(>F)  
    ## APOP_PLOT_4_granular_FAMILY_D$GROUP  1 0.004864 0.004864   9.258 0.0188 *
    ## Residuals                            7 0.003678 0.000525                 
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

``` r
APOP_PLOT_4_necrotic_granular_FAMILY_D_AOV_BAD_REMOVED <- aov(APOP_PLOT_4_granular_FAMILY_D_BAD_REMOVED$Q2.UL_Arcsine ~ APOP_PLOT_4_granular_FAMILY_D_BAD_REMOVED$GROUP, data=APOP_PLOT_4_granular_FAMILY_D_BAD_REMOVED)
summary(APOP_PLOT_4_necrotic_granular_FAMILY_D_AOV_BAD_REMOVED)      
```

    ##                                                 Df   Sum Sq  Mean Sq
    ## APOP_PLOT_4_granular_FAMILY_D_BAD_REMOVED$GROUP  1 0.005411 0.005411
    ## Residuals                                        6 0.002958 0.000493
    ##                                                 F value Pr(>F)  
    ## APOP_PLOT_4_granular_FAMILY_D_BAD_REMOVED$GROUP   10.98 0.0161 *
    ## Residuals                                                       
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

### FAMILY E

``` r
APOP_PLOT_4_necrotic_granular_FAMILY_E_AOV <- aov(APOP_PLOT_4_granular_FAMILY_E$Q2.UL_Arcsine ~ APOP_PLOT_4_granular_FAMILY_E$GROUP, data=APOP_PLOT_4_granular_FAMILY_E)
summary(APOP_PLOT_4_necrotic_granular_FAMILY_E_AOV)
```

    ##                                     Df  Sum Sq Mean Sq F value Pr(>F)  
    ## APOP_PLOT_4_granular_FAMILY_E$GROUP  1 0.05108 0.05108   8.923 0.0153 *
    ## Residuals                            9 0.05153 0.00573                 
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

``` r
APOP_PLOT_4_necrotic_granular_FAMILY_E_AOV_BAD_REMOVED <- aov(APOP_PLOT_4_granular_FAMILY_E_BAD_REMOVED$Q2.UL_Arcsine ~ APOP_PLOT_4_granular_FAMILY_E_BAD_REMOVED$GROUP, data=APOP_PLOT_4_granular_FAMILY_E_BAD_REMOVED)
summary(APOP_PLOT_4_necrotic_granular_FAMILY_E_AOV_BAD_REMOVED)      
```

    ##                                                 Df  Sum Sq Mean Sq F value
    ## APOP_PLOT_4_granular_FAMILY_E_BAD_REMOVED$GROUP  1 0.04461 0.04461   6.396
    ## Residuals                                        7 0.04882 0.00697        
    ##                                                 Pr(>F)  
    ## APOP_PLOT_4_granular_FAMILY_E_BAD_REMOVED$GROUP 0.0393 *
    ## Residuals                                               
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

### FAMILY J

``` r
APOP_PLOT_4_necrotic_granular_FAMILY_J_AOV <- aov(APOP_PLOT_4_granular_FAMILY_J$Q2.UL_Arcsine ~ APOP_PLOT_4_granular_FAMILY_J$GROUP, data=APOP_PLOT_4_granular_FAMILY_J)
summary(APOP_PLOT_4_necrotic_granular_FAMILY_J_AOV)
```

    ##                                     Df   Sum Sq  Mean Sq F value Pr(>F)  
    ## APOP_PLOT_4_granular_FAMILY_J$GROUP  1 0.005878 0.005878    4.14 0.0667 .
    ## Residuals                           11 0.015620 0.001420                 
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

``` r
APOP_PLOT_4_necrotic_granular_FAMILY_J_AOV_BAD_REMOVED <- aov(APOP_PLOT_4_granular_FAMILY_J_BAD_REMOVED$Q2.UL_Arcsine ~ APOP_PLOT_4_granular_FAMILY_J_BAD_REMOVED$GROUP, data=APOP_PLOT_4_granular_FAMILY_J_BAD_REMOVED)
summary(APOP_PLOT_4_necrotic_granular_FAMILY_J_AOV_BAD_REMOVED)      
```

    ##                                                 Df   Sum Sq  Mean Sq
    ## APOP_PLOT_4_granular_FAMILY_J_BAD_REMOVED$GROUP  1 0.002738 0.002738
    ## Residuals                                        9 0.014271 0.001586
    ##                                                 F value Pr(>F)
    ## APOP_PLOT_4_granular_FAMILY_J_BAD_REMOVED$GROUP   1.727  0.221
    ## Residuals

### FAMILY L

``` r
APOP_PLOT_4_necrotic_granular_FAMILY_L_AOV <- aov(APOP_PLOT_4_granular_FAMILY_L$Q2.UL_Arcsine ~ APOP_PLOT_4_granular_FAMILY_L$GROUP, data=APOP_PLOT_4_granular_FAMILY_L)
summary(APOP_PLOT_4_necrotic_granular_FAMILY_L_AOV)
```

    ##                                     Df   Sum Sq   Mean Sq F value Pr(>F)
    ## APOP_PLOT_4_granular_FAMILY_L$GROUP  1 0.000053 0.0000527    0.04  0.846
    ## Residuals                           11 0.014573 0.0013248

``` r
APOP_PLOT_4_necrotic_granular_FAMILY_L_AOV_BAD_REMOVED <- aov(APOP_PLOT_4_granular_FAMILY_L_BAD_REMOVED$Q2.UL_Arcsine ~ APOP_PLOT_4_granular_FAMILY_L_BAD_REMOVED$GROUP, data=APOP_PLOT_4_granular_FAMILY_L_BAD_REMOVED)
summary(APOP_PLOT_4_necrotic_granular_FAMILY_L_AOV_BAD_REMOVED)      
```

    ##                                                 Df   Sum Sq   Mean Sq
    ## APOP_PLOT_4_granular_FAMILY_L_BAD_REMOVED$GROUP  1 0.000274 0.0002743
    ## Residuals                                        7 0.004726 0.0006751
    ##                                                 F value Pr(>F)
    ## APOP_PLOT_4_granular_FAMILY_L_BAD_REMOVED$GROUP   0.406  0.544
    ## Residuals

### TWO WAY ANOVA

``` r
APOP_PLOT_4_necrotic_granular_TWO_WAY_AOV <- lm(APOP_PLOT4_GRANULAR_QUAD_PLOT$Q2.UL_Arcsine ~ APOP_PLOT4_GRANULAR_QUAD_PLOT$GROUP + APOP_PLOT4_GRANULAR_QUAD_PLOT$FAMILY, data=APOP_PLOT4_GRANULAR_QUAD_PLOT)
Anova(APOP_PLOT_4_necrotic_granular_TWO_WAY_AOV, type="II")
```

    ## Anova Table (Type II tests)
    ## 
    ## Response: APOP_PLOT4_GRANULAR_QUAD_PLOT$Q2.UL_Arcsine
    ##                                        Sum Sq Df F value Pr(>F)
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT$GROUP  0.000768  1  0.2926 0.5905
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT$FAMILY 0.011326  5  0.8633 0.5110
    ## Residuals                            0.160051 61

``` r
summary(APOP_PLOT_4_necrotic_granular_TWO_WAY_AOV) #nothing significant
```

    ## 
    ## Call:
    ## lm(formula = APOP_PLOT4_GRANULAR_QUAD_PLOT$Q2.UL_Arcsine ~ APOP_PLOT4_GRANULAR_QUAD_PLOT$GROUP + 
    ##     APOP_PLOT4_GRANULAR_QUAD_PLOT$FAMILY, data = APOP_PLOT4_GRANULAR_QUAD_PLOT)
    ## 
    ## Residuals:
    ##       Min        1Q    Median        3Q       Max 
    ## -0.078765 -0.021768 -0.005298  0.020258  0.285060 
    ## 
    ## Coefficients:
    ##                                                Estimate Std. Error t value
    ## (Intercept)                                   0.0990386  0.0185810   5.330
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT$GROUPtreatment -0.0081152  0.0150026  -0.541
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT$FAMILYB         0.0306175  0.0219452   1.395
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT$FAMILYD        -0.0002206  0.0225910  -0.010
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT$FAMILYE         0.0123389  0.0214061   0.576
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT$FAMILYJ         0.0188651  0.0205076   0.920
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT$FAMILYL        -0.0075145  0.0205076  -0.366
    ##                                              Pr(>|t|)    
    ## (Intercept)                                  1.51e-06 ***
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT$GROUPtreatment    0.591    
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT$FAMILYB           0.168    
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT$FAMILYD           0.992    
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT$FAMILYE           0.566    
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT$FAMILYJ           0.361    
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT$FAMILYL           0.715    
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
    ## 
    ## Residual standard error: 0.05122 on 61 degrees of freedom
    ## Multiple R-squared:  0.06943,    Adjusted R-squared:  -0.0221 
    ## F-statistic: 0.7585 on 6 and 61 DF,  p-value: 0.6052

``` r
# INTERACTION TERM ADDED
APOP_PLOT_4_necrotic_granular_INTERACTION_aov <- lm(APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$Q2.UL_Arcsine ~ APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILY + APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$GROUP + APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILY:APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$GROUP)
Anova(APOP_PLOT_4_necrotic_granular_INTERACTION_aov, type="II") #the interaction term is significant
```

    ## Anova Table (Type II tests)
    ## 
    ## Response: APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$Q2.UL_Arcsine
    ##                                                                                                    Sum Sq
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILY                                                 0.012678
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$GROUP                                                  0.001314
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILY:APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$GROUP 0.054851
    ## Residuals                                                                                        0.079744
    ##                                                                                                  Df
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILY                                                  5
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$GROUP                                                   1
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILY:APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$GROUP  5
    ## Residuals                                                                                        45
    ##                                                                                                  F value
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILY                                                  1.4309
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$GROUP                                                   0.7414
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILY:APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$GROUP  6.1906
    ## Residuals                                                                                               
    ##                                                                                                     Pr(>F)
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILY                                                 0.2316156
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$GROUP                                                  0.3937732
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILY:APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$GROUP 0.0001904
    ## Residuals                                                                                                 
    ##                                                                                                     
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILY                                                    
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$GROUP                                                     
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILY:APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$GROUP ***
    ## Residuals                                                                                           
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

``` r
summary(APOP_PLOT_4_necrotic_granular_INTERACTION_aov)
```

    ## 
    ## Call:
    ## lm(formula = APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$Q2.UL_Arcsine ~ 
    ##     APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILY + APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$GROUP + 
    ##         APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILY:APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$GROUP)
    ## 
    ## Residuals:
    ##       Min        1Q    Median        3Q       Max 
    ## -0.147140 -0.016909  0.002601  0.018301  0.147140 
    ## 
    ## Coefficients:
    ##                                                                                                             Estimate
    ## (Intercept)                                                                                                 0.081135
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYB                                                           0.069735
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYD                                                          -0.032123
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYE                                                           0.168163
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYJ                                                           0.003618
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYL                                                          -0.009060
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$GROUPtreatment                                                    0.015859
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYB:APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$GROUPtreatment -0.056616
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYD:APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$GROUPtreatment  0.044202
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYE:APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$GROUPtreatment -0.185202
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYJ:APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$GROUPtreatment  0.025046
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYL:APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$GROUPtreatment -0.002581
    ##                                                                                                            Std. Error
    ## (Intercept)                                                                                                  0.024304
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYB                                                            0.038428
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYD                                                            0.038428
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYE                                                            0.038428
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYJ                                                            0.038428
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYL                                                            0.038428
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$GROUPtreatment                                                     0.028499
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYB:APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$GROUPtreatment   0.044175
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYD:APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$GROUPtreatment   0.044650
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYE:APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$GROUPtreatment   0.044175
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYJ:APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$GROUPtreatment   0.043533
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYL:APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$GROUPtreatment   0.044175
    ##                                                                                                            t value
    ## (Intercept)                                                                                                  3.338
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYB                                                            1.815
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYD                                                           -0.836
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYE                                                            4.376
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYJ                                                            0.094
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYL                                                           -0.236
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$GROUPtreatment                                                     0.556
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYB:APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$GROUPtreatment  -1.282
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYD:APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$GROUPtreatment   0.990
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYE:APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$GROUPtreatment  -4.192
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYJ:APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$GROUPtreatment   0.575
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYL:APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$GROUPtreatment  -0.058
    ##                                                                                                            Pr(>|t|)
    ## (Intercept)                                                                                                0.001699
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYB                                                          0.076241
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYD                                                          0.407622
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYE                                                           7.1e-05
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYJ                                                          0.925410
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYL                                                          0.814685
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$GROUPtreatment                                                   0.580639
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYB:APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$GROUPtreatment 0.206535
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYD:APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$GROUPtreatment 0.327477
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYE:APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$GROUPtreatment 0.000127
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYJ:APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$GROUPtreatment 0.567941
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYL:APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$GROUPtreatment 0.953670
    ##                                                                                                               
    ## (Intercept)                                                                                                ** 
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYB                                                          .  
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYD                                                             
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYE                                                          ***
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYJ                                                             
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYL                                                             
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$GROUPtreatment                                                      
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYB:APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$GROUPtreatment    
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYD:APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$GROUPtreatment    
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYE:APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$GROUPtreatment ***
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYJ:APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$GROUPtreatment    
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYL:APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$GROUPtreatment    
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
    ## 
    ## Residual standard error: 0.0421 on 45 degrees of freedom
    ## Multiple R-squared:  0.4621, Adjusted R-squared:  0.3307 
    ## F-statistic: 3.515 on 11 and 45 DF,  p-value: 0.001325

``` r
#mean separations for the interaction effect with lsmeans
APOP_PLOT_4_necrotic_granular_INTERACTION_aov_leastsquares <- lsmeans(APOP_PLOT_4_necrotic_granular_INTERACTION_aov, pairwise ~ APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILY:APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$GROUP,adjust="tukey")
cld(APOP_PLOT_4_necrotic_granular_INTERACTION_aov_leastsquares, alpha=0.05, Letters=letters) #groups are not significantly different
```

    ##  APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILY
    ##  D                                               
    ##  E                                               
    ##  J                                               
    ##  A                                               
    ##  B                                               
    ##  D                                               
    ##  E                                               
    ##  J                                               
    ##  L                                               
    ##  A                                               
    ##  B                                               
    ##  L                                               
    ##  APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$GROUP     lsmean         SE df
    ##  treatment                                       0.08113521 0.02430419 45
    ##  treatment                                       0.08113521 0.02430419 45
    ##  treatment                                       0.08113521 0.02430419 45
    ##  control                                         0.09699448 0.01488322 45
    ##  control                                         0.09699448 0.01488322 45
    ##  control                                         0.09699448 0.01488322 45
    ##  control                                         0.09699448 0.01488322 45
    ##  control                                         0.09699448 0.01488322 45
    ##  control                                         0.09699448 0.01488322 45
    ##  treatment                                       0.09699448 0.01488322 45
    ##  treatment                                       0.09699448 0.01488322 45
    ##  treatment                                       0.11011400 0.01591083 45
    ##    lower.CL  upper.CL .group
    ##  0.03218405 0.1300864  a    
    ##  0.03218405 0.1300864  a    
    ##  0.03218405 0.1300864  a    
    ##  0.06701814 0.1269708  a    
    ##  0.06701814 0.1269708  a    
    ##  0.06701814 0.1269708  a    
    ##  0.06701814 0.1269708  a    
    ##  0.06701814 0.1269708  a    
    ##  0.06701814 0.1269708  a    
    ##  0.06701814 0.1269708  a    
    ##  0.06701814 0.1269708  a    
    ##  0.07806795 0.1421601  a    
    ## 
    ## Confidence level used: 0.95 
    ## P value adjustment: tukey method for comparing a family of 12 estimates 
    ## significance level used: alpha = 0.05

### One Way ANOVA of Differences between Families

``` r
APOP_PLOT_4_necrotic_granular_hemocytes_BAD_REMOVED_CHALLENGE <- APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED[!grepl("control",APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$GROUP),]
APOP_PLOT_4_necrotic_granular_oneway_aov <- aov(APOP_PLOT_4_necrotic_granular_hemocytes_BAD_REMOVED_CHALLENGE$Q2.UL_Arcsine ~ APOP_PLOT_4_necrotic_granular_hemocytes_BAD_REMOVED_CHALLENGE$FAMILY, data=APOP_PLOT_4_necrotic_granular_hemocytes_BAD_REMOVED_CHALLENGE)
summary(APOP_PLOT_4_necrotic_granular_oneway_aov)
```

    ##                                                                      Df
    ## APOP_PLOT_4_necrotic_granular_hemocytes_BAD_REMOVED_CHALLENGE$FAMILY  5
    ## Residuals                                                            38
    ##                                                                       Sum Sq
    ## APOP_PLOT_4_necrotic_granular_hemocytes_BAD_REMOVED_CHALLENGE$FAMILY 0.01134
    ## Residuals                                                            0.03288
    ##                                                                        Mean Sq
    ## APOP_PLOT_4_necrotic_granular_hemocytes_BAD_REMOVED_CHALLENGE$FAMILY 0.0022681
    ## Residuals                                                            0.0008652
    ##                                                                      F value
    ## APOP_PLOT_4_necrotic_granular_hemocytes_BAD_REMOVED_CHALLENGE$FAMILY   2.621
    ## Residuals                                                                   
    ##                                                                      Pr(>F)
    ## APOP_PLOT_4_necrotic_granular_hemocytes_BAD_REMOVED_CHALLENGE$FAMILY 0.0393
    ## Residuals                                                                  
    ##                                                                       
    ## APOP_PLOT_4_necrotic_granular_hemocytes_BAD_REMOVED_CHALLENGE$FAMILY *
    ## Residuals                                                             
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

``` r
TukeyHSD(APOP_PLOT_4_necrotic_granular_oneway_aov)
```

    ##   Tukey multiple comparisons of means
    ##     95% family-wise confidence level
    ## 
    ## Fit: aov(formula = APOP_PLOT_4_necrotic_granular_hemocytes_BAD_REMOVED_CHALLENGE$Q2.UL_Arcsine ~ APOP_PLOT_4_necrotic_granular_hemocytes_BAD_REMOVED_CHALLENGE$FAMILY, data = APOP_PLOT_4_necrotic_granular_hemocytes_BAD_REMOVED_CHALLENGE)
    ## 
    ## $`APOP_PLOT_4_necrotic_granular_hemocytes_BAD_REMOVED_CHALLENGE$FAMILY`
    ##             diff          lwr         upr     p adj
    ## B-A  0.013119518 -0.032549852 0.058788887 0.9532274
    ## D-A  0.012079653 -0.035576261 0.059735567 0.9724599
    ## E-A -0.017039492 -0.062708862 0.028629877 0.8703332
    ## J-A  0.028663445 -0.014214268 0.071541158 0.3582521
    ## L-A -0.011640857 -0.057310226 0.034028513 0.9717891
    ## D-B -0.001039865 -0.050132962 0.048053233 0.9999998
    ## E-B -0.030159010 -0.077326132 0.017008112 0.4072058
    ## J-B  0.015543928 -0.028925661 0.060013517 0.8981528
    ## L-B -0.024760374 -0.071927496 0.022406748 0.6194987
    ## E-D -0.029119145 -0.078212242 0.019973952 0.4905291
    ## J-D  0.016583792 -0.029923617 0.063091202 0.8902355
    ## L-D -0.023720509 -0.072813607 0.025372588 0.6972283
    ## J-E  0.045702938  0.001233348 0.090172527 0.0409537
    ## L-E  0.005398636 -0.041768486 0.052565758 0.9993170
    ## L-J -0.040304302 -0.084773891 0.004165287 0.0947731

Percent necrotic agranular hemocytes (PLOT 7, Q1-UL)
----------------------------------------------------

Percent necrotic agranular hemocytes (PLOT 7, Q1-UL)
----------------------------------------------------

``` r
APOP_necrotic_Agranular_BAD_NOT_REMOVED <- ggplot(data=APOP_PLOT7_AGRANULAR_QUAD_PLOT, aes(x=FAMILY, y=Q1.UL_PERCENT_OF_THIS_PLOT, color=GROUP, by=GROUP)) + geom_boxplot() + ggtitle("Percent of Necrotic Agranular Hemocytes \n Low Quality Not Removed") + xlab("Family") + ylab("Percent of Hemocyte Events") + ylim(0,100)

APOP_necrotic_Agranular_BAD_NOT_REMOVED
```

![](Dermo_Apoptosis_Assay_Data_analysis_files/figure-markdown_github/necrotic_apoptotic_agranular-1.png)

``` r
APOP_necrotic_Agranular_BAD_REMOVED <- ggplot(data=APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED, aes(x=FAMILY, y=Q1.UL_PERCENT_OF_THIS_PLOT, color=GROUP, by=GROUP)) + geom_boxplot() + ggtitle("Percent of Necrotic Agranular Hemocytes \nLow Quality Removed") +
  xlab("Family") + ylab("Percent of Hemocyte Events") + ylim(0,100)
APOP_necrotic_Agranular_BAD_REMOVED
```

![](Dermo_Apoptosis_Assay_Data_analysis_files/figure-markdown_github/necrotic_apoptotic_agranular-2.png)

### FAMILY A

``` r
APOP_PLOT_7_necrotic_agranular_FAMILY_A_AOV <- aov(APOP_PLOT_7_agranular_FAMILY_A$Q1.UL_Arcsine ~ APOP_PLOT_7_agranular_FAMILY_A$GROUP, data=APOP_PLOT_7_agranular_FAMILY_A)
summary(APOP_PLOT_7_necrotic_agranular_FAMILY_A_AOV)
```

    ##                                      Df  Sum Sq Mean Sq F value Pr(>F)
    ## APOP_PLOT_7_agranular_FAMILY_A$GROUP  1 0.02189 0.02189   1.255  0.289
    ## Residuals                            10 0.17438 0.01744

``` r
APOP_PLOT_7_necrotic_agranular_FAMILY_A_AOV_BAD_REMOVED <- aov(APOP_PLOT_7_agranular_FAMILY_A_BAD_REMOVED$Q1.UL_Arcsine ~ APOP_PLOT_7_agranular_FAMILY_A_BAD_REMOVED$GROUP, data=APOP_PLOT_7_agranular_FAMILY_A_BAD_REMOVED)
summary(APOP_PLOT_7_necrotic_agranular_FAMILY_A_AOV_BAD_REMOVED)      
```

    ##                                                  Df  Sum Sq Mean Sq
    ## APOP_PLOT_7_agranular_FAMILY_A_BAD_REMOVED$GROUP  1 0.02129 0.02129
    ## Residuals                                         9 0.17438 0.01937
    ##                                                  F value Pr(>F)
    ## APOP_PLOT_7_agranular_FAMILY_A_BAD_REMOVED$GROUP   1.099  0.322
    ## Residuals

### FAMILY B

``` r
APOP_PLOT_7_necrotic_agranular_FAMILY_B_AOV <- aov(APOP_PLOT_7_agranular_FAMILY_B$Q1.UL_Arcsine ~ APOP_PLOT_7_agranular_FAMILY_B$GROUP, data=APOP_PLOT_7_agranular_FAMILY_B)
summary(APOP_PLOT_7_necrotic_agranular_FAMILY_B_AOV)
```

    ##                                      Df Sum Sq Mean Sq F value Pr(>F)
    ## APOP_PLOT_7_agranular_FAMILY_B$GROUP  1 0.0356 0.03560   2.572  0.147
    ## Residuals                             8 0.1107 0.01384

``` r
APOP_PLOT_7_necrotic_agranular_FAMILY_B_AOV_BAD_REMOVED <- aov(APOP_PLOT_7_agranular_FAMILY_B_BAD_REMOVED$Q1.UL_Arcsine ~ APOP_PLOT_7_agranular_FAMILY_B_BAD_REMOVED$GROUP, data=APOP_PLOT_7_agranular_FAMILY_B_BAD_REMOVED)
summary(APOP_PLOT_7_necrotic_agranular_FAMILY_B_AOV_BAD_REMOVED)      
```

    ##                                                  Df  Sum Sq Mean Sq
    ## APOP_PLOT_7_agranular_FAMILY_B_BAD_REMOVED$GROUP  1 0.03981 0.03981
    ## Residuals                                         7 0.10416 0.01488
    ##                                                  F value Pr(>F)
    ## APOP_PLOT_7_agranular_FAMILY_B_BAD_REMOVED$GROUP   2.676  0.146
    ## Residuals

### FAMILY D

``` r
APOP_PLOT_7_necrotic_agranular_FAMILY_D_AOV <- aov(APOP_PLOT_7_agranular_FAMILY_D$Q1.UL_Arcsine ~ APOP_PLOT_7_agranular_FAMILY_D$GROUP, data=APOP_PLOT_7_agranular_FAMILY_D)
summary(APOP_PLOT_7_necrotic_agranular_FAMILY_D_AOV)
```

    ##                                      Df  Sum Sq  Mean Sq F value Pr(>F)
    ## APOP_PLOT_7_agranular_FAMILY_D$GROUP  1 0.00833 0.008328   0.298  0.602
    ## Residuals                             7 0.19539 0.027914

``` r
APOP_PLOT_7_necrotic_agranular_FAMILY_D_AOV_BAD_REMOVED <- aov(APOP_PLOT_7_agranular_FAMILY_D_BAD_REMOVED$Q1.UL_Arcsine ~ APOP_PLOT_7_agranular_FAMILY_D_BAD_REMOVED$GROUP, data=APOP_PLOT_7_agranular_FAMILY_D_BAD_REMOVED)
summary(APOP_PLOT_7_necrotic_agranular_FAMILY_D_AOV_BAD_REMOVED)      
```

    ##                                                  Df  Sum Sq Mean Sq
    ## APOP_PLOT_7_agranular_FAMILY_D_BAD_REMOVED$GROUP  1 0.01605 0.01605
    ## Residuals                                         6 0.15694 0.02616
    ##                                                  F value Pr(>F)
    ## APOP_PLOT_7_agranular_FAMILY_D_BAD_REMOVED$GROUP   0.613  0.463
    ## Residuals

### FAMILY E

``` r
APOP_PLOT_7_necrotic_agranular_FAMILY_E_AOV <- aov(APOP_PLOT_7_agranular_FAMILY_E$Q1.UL_Arcsine ~ APOP_PLOT_7_agranular_FAMILY_E$GROUP, data=APOP_PLOT_7_agranular_FAMILY_E)
summary(APOP_PLOT_7_necrotic_agranular_FAMILY_E_AOV)
```

    ##                                      Df Sum Sq Mean Sq F value Pr(>F)  
    ## APOP_PLOT_7_agranular_FAMILY_E$GROUP  1 0.1769 0.17687   4.834 0.0555 .
    ## Residuals                             9 0.3293 0.03659                 
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

``` r
APOP_PLOT_7_necrotic_agranular_FAMILY_E_AOV_BAD_REMOVED <- aov(APOP_PLOT_7_agranular_FAMILY_E_BAD_REMOVED$Q1.UL_Arcsine ~ APOP_PLOT_7_agranular_FAMILY_E_BAD_REMOVED$GROUP, data=APOP_PLOT_7_agranular_FAMILY_E_BAD_REMOVED)
summary(APOP_PLOT_7_necrotic_agranular_FAMILY_E_AOV_BAD_REMOVED)      
```

    ##                                                  Df Sum Sq Mean Sq F value
    ## APOP_PLOT_7_agranular_FAMILY_E_BAD_REMOVED$GROUP  1 0.1515 0.15148   3.326
    ## Residuals                                         7 0.3188 0.04554        
    ##                                                  Pr(>F)
    ## APOP_PLOT_7_agranular_FAMILY_E_BAD_REMOVED$GROUP  0.111
    ## Residuals

### FAMILY J

``` r
APOP_PLOT_7_necrotic_agranular_FAMILY_J_AOV <- aov(APOP_PLOT_7_agranular_FAMILY_J$Q1.UL_Arcsine ~ APOP_PLOT_7_agranular_FAMILY_J$GROUP, data=APOP_PLOT_7_agranular_FAMILY_J)
summary(APOP_PLOT_7_necrotic_agranular_FAMILY_J_AOV)
```

    ##                                      Df  Sum Sq  Mean Sq F value Pr(>F)
    ## APOP_PLOT_7_agranular_FAMILY_J$GROUP  1 0.01263 0.012632   1.569  0.236
    ## Residuals                            11 0.08858 0.008053

``` r
APOP_PLOT_7_necrotic_agranular_FAMILY_J_AOV_BAD_REMOVED <- aov(APOP_PLOT_7_agranular_FAMILY_J_BAD_REMOVED$Q1.UL_Arcsine ~ APOP_PLOT_7_agranular_FAMILY_J_BAD_REMOVED$GROUP, data=APOP_PLOT_7_agranular_FAMILY_J_BAD_REMOVED)
summary(APOP_PLOT_7_necrotic_agranular_FAMILY_J_AOV_BAD_REMOVED)      
```

    ##                                                  Df  Sum Sq  Mean Sq
    ## APOP_PLOT_7_agranular_FAMILY_J_BAD_REMOVED$GROUP  1 0.01344 0.013441
    ## Residuals                                         9 0.07915 0.008795
    ##                                                  F value Pr(>F)
    ## APOP_PLOT_7_agranular_FAMILY_J_BAD_REMOVED$GROUP   1.528  0.248
    ## Residuals

### FAMILY L

``` r
APOP_PLOT_7_necrotic_agranular_FAMILY_L_AOV <- aov(APOP_PLOT_7_agranular_FAMILY_L$Q1.UL_Arcsine ~ APOP_PLOT_7_agranular_FAMILY_L$GROUP, data=APOP_PLOT_7_agranular_FAMILY_L)
summary(APOP_PLOT_7_necrotic_agranular_FAMILY_L_AOV)
```

    ##                                      Df  Sum Sq  Mean Sq F value Pr(>F)
    ## APOP_PLOT_7_agranular_FAMILY_L$GROUP  1 0.00215 0.002152   0.551  0.474
    ## Residuals                            11 0.04300 0.003909

``` r
APOP_PLOT_7_necrotic_agranular_FAMILY_L_AOV_BAD_REMOVED <- aov(APOP_PLOT_7_agranular_FAMILY_L_BAD_REMOVED$Q1.UL_Arcsine ~ APOP_PLOT_7_agranular_FAMILY_L_BAD_REMOVED$GROUP, data=APOP_PLOT_7_agranular_FAMILY_L_BAD_REMOVED)
summary(APOP_PLOT_7_necrotic_agranular_FAMILY_L_AOV_BAD_REMOVED)      
```

    ##                                                  Df   Sum Sq  Mean Sq
    ## APOP_PLOT_7_agranular_FAMILY_L_BAD_REMOVED$GROUP  1 0.004293 0.004293
    ## Residuals                                         7 0.010608 0.001515
    ##                                                  F value Pr(>F)
    ## APOP_PLOT_7_agranular_FAMILY_L_BAD_REMOVED$GROUP   2.833  0.136
    ## Residuals

### TWO WAY ANOVA

``` r
APOP_PLOT_7_necrotic_agranular_TWO_WAY_AOV <- lm(APOP_PLOT7_AGRANULAR_QUAD_PLOT$Q1.UL_Arcsine ~ APOP_PLOT7_AGRANULAR_QUAD_PLOT$GROUP + APOP_PLOT7_AGRANULAR_QUAD_PLOT$FAMILY, data=APOP_PLOT7_AGRANULAR_QUAD_PLOT)
Anova(APOP_PLOT_7_necrotic_agranular_TWO_WAY_AOV, type="II")
```

    ## Anova Table (Type II tests)
    ## 
    ## Response: APOP_PLOT7_AGRANULAR_QUAD_PLOT$Q1.UL_Arcsine
    ##                                        Sum Sq Df F value Pr(>F)
    ## APOP_PLOT7_AGRANULAR_QUAD_PLOT$GROUP  0.00995  1  0.5107 0.4775
    ## APOP_PLOT7_AGRANULAR_QUAD_PLOT$FAMILY 0.06989  5  0.7172 0.6129
    ## Residuals                             1.18886 61

``` r
summary(APOP_PLOT_7_necrotic_agranular_TWO_WAY_AOV)
```

    ## 
    ## Call:
    ## lm(formula = APOP_PLOT7_AGRANULAR_QUAD_PLOT$Q1.UL_Arcsine ~ APOP_PLOT7_AGRANULAR_QUAD_PLOT$GROUP + 
    ##     APOP_PLOT7_AGRANULAR_QUAD_PLOT$FAMILY, data = APOP_PLOT7_AGRANULAR_QUAD_PLOT)
    ## 
    ## Residuals:
    ##      Min       1Q   Median       3Q      Max 
    ## -0.18680 -0.08516 -0.03674  0.04425  0.58927 
    ## 
    ## Coefficients:
    ##                                                 Estimate Std. Error
    ## (Intercept)                                    0.3215311  0.0506414
    ## APOP_PLOT7_AGRANULAR_QUAD_PLOT$GROUPtreatment -0.0292211  0.0408885
    ## APOP_PLOT7_AGRANULAR_QUAD_PLOT$FAMILYB         0.0008149  0.0598102
    ## APOP_PLOT7_AGRANULAR_QUAD_PLOT$FAMILYD         0.0701336  0.0615705
    ## APOP_PLOT7_AGRANULAR_QUAD_PLOT$FAMILYE         0.0656138  0.0583410
    ## APOP_PLOT7_AGRANULAR_QUAD_PLOT$FAMILYJ        -0.0141641  0.0558922
    ## APOP_PLOT7_AGRANULAR_QUAD_PLOT$FAMILYL         0.0121265  0.0558922
    ##                                               t value Pr(>|t|)    
    ## (Intercept)                                     6.349    3e-08 ***
    ## APOP_PLOT7_AGRANULAR_QUAD_PLOT$GROUPtreatment  -0.715    0.478    
    ## APOP_PLOT7_AGRANULAR_QUAD_PLOT$FAMILYB          0.014    0.989    
    ## APOP_PLOT7_AGRANULAR_QUAD_PLOT$FAMILYD          1.139    0.259    
    ## APOP_PLOT7_AGRANULAR_QUAD_PLOT$FAMILYE          1.125    0.265    
    ## APOP_PLOT7_AGRANULAR_QUAD_PLOT$FAMILYJ         -0.253    0.801    
    ## APOP_PLOT7_AGRANULAR_QUAD_PLOT$FAMILYL          0.217    0.829    
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
    ## 
    ## Residual standard error: 0.1396 on 61 degrees of freedom
    ## Multiple R-squared:  0.06182,    Adjusted R-squared:  -0.03046 
    ## F-statistic: 0.6699 on 6 and 61 DF,  p-value: 0.6742

``` r
APOP_PLOT_7_necrotic_agranular_TWO_WAY_AOV_BAD_REMOVED <- lm(APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$Q1.UL_Arcsine ~ APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$GROUP + APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILY, data=APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED)
Anova(APOP_PLOT_7_necrotic_agranular_TWO_WAY_AOV_BAD_REMOVED, type="II")
```

    ## Anova Table (Type II tests)
    ## 
    ## Response: APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$Q1.UL_Arcsine
    ##                                                    Sum Sq Df F value
    ## APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$GROUP  0.00884  1  0.4085
    ## APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILY 0.09621  5  0.8896
    ## Residuals                                         1.08157 50        
    ##                                                   Pr(>F)
    ## APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$GROUP  0.5257
    ## APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILY 0.4952
    ## Residuals

``` r
summary(APOP_PLOT_7_necrotic_agranular_TWO_WAY_AOV_BAD_REMOVED)
```

    ## 
    ## Call:
    ## lm(formula = APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$Q1.UL_Arcsine ~ 
    ##     APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$GROUP + APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILY, 
    ##     data = APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED)
    ## 
    ## Residuals:
    ##      Min       1Q   Median       3Q      Max 
    ## -0.21178 -0.08833 -0.03814  0.03241  0.56375 
    ## 
    ## Coefficients:
    ##                                                            Estimate
    ## (Intercept)                                                0.319117
    ## APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$GROUPtreatment -0.029748
    ## APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYB        -0.002112
    ## APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYD         0.092793
    ## APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYE         0.093539
    ## APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYJ         0.000804
    ## APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYL         0.028183
    ##                                                           Std. Error
    ## (Intercept)                                                 0.055789
    ## APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$GROUPtreatment   0.046545
    ## APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYB          0.066148
    ## APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYD          0.068349
    ## APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYE          0.066148
    ## APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYJ          0.062856
    ## APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYL          0.066148
    ##                                                           t value Pr(>|t|)
    ## (Intercept)                                                 5.720 5.94e-07
    ## APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$GROUPtreatment  -0.639    0.526
    ## APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYB         -0.032    0.975
    ## APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYD          1.358    0.181
    ## APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYE          1.414    0.164
    ## APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYJ          0.013    0.990
    ## APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYL          0.426    0.672
    ##                                                              
    ## (Intercept)                                               ***
    ## APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$GROUPtreatment    
    ## APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYB           
    ## APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYD           
    ## APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYE           
    ## APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYJ           
    ## APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYL           
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
    ## 
    ## Residual standard error: 0.1471 on 50 degrees of freedom
    ## Multiple R-squared:  0.08901,    Adjusted R-squared:  -0.02031 
    ## F-statistic: 0.8142 on 6 and 50 DF,  p-value: 0.564

``` r
#NONE are significant
```

### One Way ANOVA of Differences between Families

``` r
APOP_PLOT_7_necrotic_agranular_hemocytes_BAD_REMOVED_CHALLENGE <- APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED[!grepl("control",APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$GROUP),]
APOP_PLOT_7_necrotic_agranular_oneway_aov <- aov(APOP_PLOT_7_necrotic_agranular_hemocytes_BAD_REMOVED_CHALLENGE$Q1.UL_Arcsine ~ APOP_PLOT_7_necrotic_agranular_hemocytes_BAD_REMOVED_CHALLENGE$FAMILY, data=APOP_PLOT_7_necrotic_agranular_hemocytes_BAD_REMOVED_CHALLENGE)
summary(APOP_PLOT_7_necrotic_agranular_oneway_aov)
```

    ##                                                                       Df
    ## APOP_PLOT_7_necrotic_agranular_hemocytes_BAD_REMOVED_CHALLENGE$FAMILY  5
    ## Residuals                                                             38
    ##                                                                       Sum Sq
    ## APOP_PLOT_7_necrotic_agranular_hemocytes_BAD_REMOVED_CHALLENGE$FAMILY 0.0824
    ## Residuals                                                             0.5499
    ##                                                                       Mean Sq
    ## APOP_PLOT_7_necrotic_agranular_hemocytes_BAD_REMOVED_CHALLENGE$FAMILY 0.01647
    ## Residuals                                                             0.01447
    ##                                                                       F value
    ## APOP_PLOT_7_necrotic_agranular_hemocytes_BAD_REMOVED_CHALLENGE$FAMILY   1.138
    ## Residuals                                                                    
    ##                                                                       Pr(>F)
    ## APOP_PLOT_7_necrotic_agranular_hemocytes_BAD_REMOVED_CHALLENGE$FAMILY  0.357
    ## Residuals

Necrotic granular and agranular hemoctes
----------------------------------------

``` r
necrotic_granular <- APOP_PLOT4_GRANULAR_QUAD_PLOT_GATE_ADDED_BAD_REMOVED %>% filter(GATE=="Q2_UL")
necrotic_agranular <- APOP_PLOT7_AGRANULAR_QUAD_PLOT_GATE_ADDED_BAD_REMOVED %>% filter(GATE=="Q1_UL")
necrotic_granular_agranular_combined <- rbind(necrotic_granular,necrotic_agranular)

ggplot(necrotic_granular_agranular_combined, aes(x=GROUP, y=PERCENT_OF_THIS_PLOT, fill=GATE)) + facet_grid(.~FAMILY+GROUP, scales="free") + geom_boxplot() + ggtitle("Percent of Granular and Agranular Necrotic Hemocytes (low quality removed)") + ylab("Percent of Hemocyte Events in each quad plot") +
scale_fill_manual(name="Hemocyte Type", labels=c("Necrotic Granular", "Necrotic Agranular"), values=c("Q2_UL"="#99a765","Q1_UL"="#96578a")) 
```

![](Dermo_Apoptosis_Assay_Data_analysis_files/figure-markdown_github/necrotic_granular_agranular-1.png)

``` r
# Two way ANOVA
necrotic_granular_agranula_aov <- lm(necrotic_granular_agranular_combined$Arcsine ~necrotic_granular_agranular_combined$FAMILY + necrotic_granular_agranular_combined$GATE, data=necrotic_granular_agranular_combined)
Anova(necrotic_granular_agranula_aov, type="II") #GATE is significant
```

    ## Anova Table (Type II tests)
    ## 
    ## Response: necrotic_granular_agranular_combined$Arcsine
    ##                                              Sum Sq  Df  F value Pr(>F)
    ## necrotic_granular_agranular_combined$FAMILY 0.05203   5   0.8676 0.5055
    ## necrotic_granular_agranular_combined$GATE   1.42906   1 119.1371 <2e-16
    ## Residuals                                   1.28347 107                
    ##                                                
    ## necrotic_granular_agranular_combined$FAMILY    
    ## necrotic_granular_agranular_combined$GATE   ***
    ## Residuals                                      
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

``` r
summary(necrotic_granular_agranula_aov)
```

    ## 
    ## Call:
    ## lm(formula = necrotic_granular_agranular_combined$Arcsine ~ necrotic_granular_agranular_combined$FAMILY + 
    ##     necrotic_granular_agranular_combined$GATE, data = necrotic_granular_agranular_combined)
    ## 
    ## Residuals:
    ##      Min       1Q   Median       3Q      Max 
    ## -0.19439 -0.05816 -0.00560  0.03376  0.61090 
    ## 
    ## Coefficients:
    ##                                                Estimate Std. Error t value
    ## (Intercept)                                    0.083113   0.025504   3.259
    ## necrotic_granular_agranular_combined$FAMILYB   0.011444   0.034808   0.329
    ## necrotic_granular_agranular_combined$FAMILYD   0.046753   0.035985   1.299
    ## necrotic_granular_agranular_combined$FAMILYE   0.058477   0.034808   1.680
    ## necrotic_granular_agranular_combined$FAMILYJ   0.011826   0.033022   0.358
    ## necrotic_granular_agranular_combined$FAMILYL   0.008207   0.034808   0.236
    ## necrotic_granular_agranular_combined$GATEQ1_UL 0.223925   0.020515  10.915
    ##                                                Pr(>|t|)    
    ## (Intercept)                                      0.0015 ** 
    ## necrotic_granular_agranular_combined$FAMILYB     0.7430    
    ## necrotic_granular_agranular_combined$FAMILYD     0.1967    
    ## necrotic_granular_agranular_combined$FAMILYE     0.0959 .  
    ## necrotic_granular_agranular_combined$FAMILYJ     0.7210    
    ## necrotic_granular_agranular_combined$FAMILYL     0.8141    
    ## necrotic_granular_agranular_combined$GATEQ1_UL   <2e-16 ***
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
    ## 
    ## Residual standard error: 0.1095 on 107 degrees of freedom
    ## Multiple R-squared:  0.5357, Adjusted R-squared:  0.5097 
    ## F-statistic: 20.58 on 6 and 107 DF,  p-value: 6.653e-16

``` r
# Two- Way ANOVA 
necrotic_granular_agranula_aov_interaction <- lm(necrotic_granular_agranular_combined$Arcsine ~ necrotic_granular_agranular_combined$FAMILY + necrotic_granular_agranular_combined$GATE + necrotic_granular_agranular_combined$FAMILY:necrotic_granular_agranular_combined$GATE, data=necrotic_granular_agranular_combined)
Anova(necrotic_granular_agranula_aov_interaction, type="II") #GATE is significant
```

    ## Anova Table (Type II tests)
    ## 
    ## Response: necrotic_granular_agranular_combined$Arcsine
    ##                                                                                        Sum Sq
    ## necrotic_granular_agranular_combined$FAMILY                                           0.05203
    ## necrotic_granular_agranular_combined$GATE                                             1.42906
    ## necrotic_granular_agranular_combined$FAMILY:necrotic_granular_agranular_combined$GATE 0.05716
    ## Residuals                                                                             1.22632
    ##                                                                                        Df
    ## necrotic_granular_agranular_combined$FAMILY                                             5
    ## necrotic_granular_agranular_combined$GATE                                               1
    ## necrotic_granular_agranular_combined$FAMILY:necrotic_granular_agranular_combined$GATE   5
    ## Residuals                                                                             102
    ##                                                                                        F value
    ## necrotic_granular_agranular_combined$FAMILY                                             0.8656
    ## necrotic_granular_agranular_combined$GATE                                             118.8633
    ## necrotic_granular_agranular_combined$FAMILY:necrotic_granular_agranular_combined$GATE   0.9508
    ## Residuals                                                                                     
    ##                                                                                       Pr(>F)
    ## necrotic_granular_agranular_combined$FAMILY                                           0.5070
    ## necrotic_granular_agranular_combined$GATE                                             <2e-16
    ## necrotic_granular_agranular_combined$FAMILY:necrotic_granular_agranular_combined$GATE 0.4517
    ## Residuals                                                                                   
    ##                                                                                          
    ## necrotic_granular_agranular_combined$FAMILY                                              
    ## necrotic_granular_agranular_combined$GATE                                             ***
    ## necrotic_granular_agranular_combined$FAMILY:necrotic_granular_agranular_combined$GATE    
    ## Residuals                                                                                
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

``` r
summary(necrotic_granular_agranula_aov_interaction)
```

    ## 
    ## Call:
    ## lm(formula = necrotic_granular_agranular_combined$Arcsine ~ necrotic_granular_agranular_combined$FAMILY + 
    ##     necrotic_granular_agranular_combined$GATE + necrotic_granular_agranular_combined$FAMILY:necrotic_granular_agranular_combined$GATE, 
    ##     data = necrotic_granular_agranular_combined)
    ## 
    ## Residuals:
    ##      Min       1Q   Median       3Q      Max 
    ## -0.21839 -0.05770 -0.01051  0.02622  0.58689 
    ## 
    ## Coefficients:
    ##                                                                                             Estimate
    ## (Intercept)                                                                                  0.09267
    ## necrotic_granular_agranular_combined$FAMILYB                                                 0.02650
    ## necrotic_granular_agranular_combined$FAMILYD                                                 0.00139
    ## necrotic_granular_agranular_combined$FAMILYE                                                 0.02492
    ## necrotic_granular_agranular_combined$FAMILYJ                                                 0.02555
    ## necrotic_granular_agranular_combined$FAMILYL                                                -0.01027
    ## necrotic_granular_agranular_combined$GATEQ1_UL                                               0.20481
    ## necrotic_granular_agranular_combined$FAMILYB:necrotic_granular_agranular_combined$GATEQ1_UL -0.03012
    ## necrotic_granular_agranular_combined$FAMILYD:necrotic_granular_agranular_combined$GATEQ1_UL  0.09073
    ## necrotic_granular_agranular_combined$FAMILYE:necrotic_granular_agranular_combined$GATEQ1_UL  0.06712
    ## necrotic_granular_agranular_combined$FAMILYJ:necrotic_granular_agranular_combined$GATEQ1_UL -0.02745
    ## necrotic_granular_agranular_combined$FAMILYL:necrotic_granular_agranular_combined$GATEQ1_UL  0.03695
    ##                                                                                             Std. Error
    ## (Intercept)                                                                                    0.03306
    ## necrotic_granular_agranular_combined$FAMILYB                                                   0.04928
    ## necrotic_granular_agranular_combined$FAMILYD                                                   0.05095
    ## necrotic_granular_agranular_combined$FAMILYE                                                   0.04928
    ## necrotic_granular_agranular_combined$FAMILYJ                                                   0.04675
    ## necrotic_granular_agranular_combined$FAMILYL                                                   0.04928
    ## necrotic_granular_agranular_combined$GATEQ1_UL                                                 0.04675
    ## necrotic_granular_agranular_combined$FAMILYB:necrotic_granular_agranular_combined$GATEQ1_UL    0.06970
    ## necrotic_granular_agranular_combined$FAMILYD:necrotic_granular_agranular_combined$GATEQ1_UL    0.07205
    ## necrotic_granular_agranular_combined$FAMILYE:necrotic_granular_agranular_combined$GATEQ1_UL    0.06970
    ## necrotic_granular_agranular_combined$FAMILYJ:necrotic_granular_agranular_combined$GATEQ1_UL    0.06612
    ## necrotic_granular_agranular_combined$FAMILYL:necrotic_granular_agranular_combined$GATEQ1_UL    0.06970
    ##                                                                                             t value
    ## (Intercept)                                                                                   2.803
    ## necrotic_granular_agranular_combined$FAMILYB                                                  0.538
    ## necrotic_granular_agranular_combined$FAMILYD                                                  0.027
    ## necrotic_granular_agranular_combined$FAMILYE                                                  0.506
    ## necrotic_granular_agranular_combined$FAMILYJ                                                  0.547
    ## necrotic_granular_agranular_combined$FAMILYL                                                 -0.208
    ## necrotic_granular_agranular_combined$GATEQ1_UL                                                4.381
    ## necrotic_granular_agranular_combined$FAMILYB:necrotic_granular_agranular_combined$GATEQ1_UL  -0.432
    ## necrotic_granular_agranular_combined$FAMILYD:necrotic_granular_agranular_combined$GATEQ1_UL   1.259
    ## necrotic_granular_agranular_combined$FAMILYE:necrotic_granular_agranular_combined$GATEQ1_UL   0.963
    ## necrotic_granular_agranular_combined$FAMILYJ:necrotic_granular_agranular_combined$GATEQ1_UL  -0.415
    ## necrotic_granular_agranular_combined$FAMILYL:necrotic_granular_agranular_combined$GATEQ1_UL   0.530
    ##                                                                                             Pr(>|t|)
    ## (Intercept)                                                                                  0.00606
    ## necrotic_granular_agranular_combined$FAMILYB                                                 0.59192
    ## necrotic_granular_agranular_combined$FAMILYD                                                 0.97830
    ## necrotic_granular_agranular_combined$FAMILYE                                                 0.61423
    ## necrotic_granular_agranular_combined$FAMILYJ                                                 0.58591
    ## necrotic_granular_agranular_combined$FAMILYL                                                 0.83540
    ## necrotic_granular_agranular_combined$GATEQ1_UL                                              2.88e-05
    ## necrotic_granular_agranular_combined$FAMILYB:necrotic_granular_agranular_combined$GATEQ1_UL  0.66658
    ## necrotic_granular_agranular_combined$FAMILYD:necrotic_granular_agranular_combined$GATEQ1_UL  0.21084
    ## necrotic_granular_agranular_combined$FAMILYE:necrotic_granular_agranular_combined$GATEQ1_UL  0.33782
    ## necrotic_granular_agranular_combined$FAMILYJ:necrotic_granular_agranular_combined$GATEQ1_UL  0.67888
    ## necrotic_granular_agranular_combined$FAMILYL:necrotic_granular_agranular_combined$GATEQ1_UL  0.59719
    ##                                                                                                
    ## (Intercept)                                                                                 ** 
    ## necrotic_granular_agranular_combined$FAMILYB                                                   
    ## necrotic_granular_agranular_combined$FAMILYD                                                   
    ## necrotic_granular_agranular_combined$FAMILYE                                                   
    ## necrotic_granular_agranular_combined$FAMILYJ                                                   
    ## necrotic_granular_agranular_combined$FAMILYL                                                   
    ## necrotic_granular_agranular_combined$GATEQ1_UL                                              ***
    ## necrotic_granular_agranular_combined$FAMILYB:necrotic_granular_agranular_combined$GATEQ1_UL    
    ## necrotic_granular_agranular_combined$FAMILYD:necrotic_granular_agranular_combined$GATEQ1_UL    
    ## necrotic_granular_agranular_combined$FAMILYE:necrotic_granular_agranular_combined$GATEQ1_UL    
    ## necrotic_granular_agranular_combined$FAMILYJ:necrotic_granular_agranular_combined$GATEQ1_UL    
    ## necrotic_granular_agranular_combined$FAMILYL:necrotic_granular_agranular_combined$GATEQ1_UL    
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
    ## 
    ## Residual standard error: 0.1096 on 102 degrees of freedom
    ## Multiple R-squared:  0.5564, Adjusted R-squared:  0.5086 
    ## F-statistic: 11.63 on 11 and 102 DF,  p-value: 8.869e-14

``` r
necgate1<-filter(necrotic_granular_agranular_combined, GATE=="Q1_UL")
necgate2<-filter(necrotic_granular_agranular_combined, GATE=="Q2_UL")
t.test(necgate1$Arcsine,necgate2$Arcsine)
```

    ## 
    ##  Welch Two Sample t-test
    ## 
    ## data:  necgate1$Arcsine and necgate2$Arcsine
    ## t = 10.947, df = 69.772, p-value < 2.2e-16
    ## alternative hypothesis: true difference in means is not equal to 0
    ## 95 percent confidence interval:
    ##  0.1831273 0.2647229
    ## sample estimates:
    ## mean of x mean of y 
    ## 0.3282181 0.1042931

``` r
necrotic_granular_agranula_aov_interaction_leastsquares <- lsmeans(necrotic_granular_agranula_aov_interaction, "necrotic_granular_agranular_combined$GATE", adjust="tukey")
cld(necrotic_granular_agranula_aov_interaction_leastsquares, alpha=0.05, Letters=letters) # the means of the two groups are not significantly different 
```

    ##  necrotic_granular_agranular_combined$GATE     lsmean         SE  df
    ##  Q2_UL                                     0.09266923 0.03306015 102
    ##  Q1_UL                                     0.09708619 0.02821554 102
    ##    lower.CL  upper.CL .group
    ##  0.02709457 0.1582439  a    
    ##  0.04112080 0.1530516  a    
    ## 
    ## Results are averaged over the levels of: necrotic_granular_agranular_combined$FAMILY 
    ## Confidence level used: 0.95 
    ## significance level used: alpha = 0.05

Combined Faceted all parameters by cell type
--------------------------------------------

``` r
ggplot(APOP_PLOT4_GRANULAR_QUAD_PLOT_GATE_ADDED_BAD_REMOVED, aes(x=GROUP, y=PERCENT_OF_THIS_PLOT, fill=GATE)) + facet_grid(.~FAMILY+GROUP, scales="free") + geom_boxplot() + ggtitle("Percent of Granular Hemocytes in each Quadrant (low quality removed)") + ylab("Percent of Hemocyte Events in each quad plot") + scale_fill_manual(name="Hemocyte Type", labels=c("Live Non-Apoptotic", "Live Apoptotic", "Dead Apoptotic", "Necrotic"), values=c("Q2_LL"="red","Q2_LR"="green", "Q2_UL"="purple", "Q2_UR"="blue")) 
```

![](Dermo_Apoptosis_Assay_Data_analysis_files/figure-markdown_github/graphing_granular-1.png)

``` r
ggplot(APOP_PLOT7_AGRANULAR_QUAD_PLOT_GATE_ADDED_BAD_REMOVED, aes(x=GROUP, y=PERCENT_OF_THIS_PLOT, fill=GATE)) + facet_grid(.~FAMILY+GROUP, scales="free") + geom_boxplot() + ggtitle("Percent of Agranular Hemocytes in each Quadrant (low quality removed)") + ylab("Percent of Hemocyte Events in each quad plot")+ scale_fill_manual(name="Hemocyte Type", labels=c("Live Non-Apoptotic", "Live Apoptotic", "Dead Apoptotic", "Necrotic"), values=c("Q1_LL"="red","Q1_LR"="green", "Q1_UL"="purple", "Q1_UR"="blue")) 
```

![](Dermo_Apoptosis_Assay_Data_analysis_files/figure-markdown_github/graphing_granular-2.png)

``` r
APOP_PLOT7_AGRANULAR_QUAD_PLOT_GATE_ADDED_BAD_REMOVED$cell <- "agranular"
APOP_PLOT4_GRANULAR_QUAD_PLOT_GATE_ADDED_BAD_REMOVED$cell <- "granular"
full_Data <- rbind(APOP_PLOT7_AGRANULAR_QUAD_PLOT_GATE_ADDED_BAD_REMOVED, APOP_PLOT4_GRANULAR_QUAD_PLOT_GATE_ADDED_BAD_REMOVED)

ggplot(full_Data, aes(x=GROUP, y=PERCENT_OF_THIS_PLOT, fill=GATE, linetype=cell, color=cell)) + facet_grid(.~FAMILY, scales="free") +
  ggtitle("Percent of Granular and Agranular Hemocytes in each Quadrant (low quality removed)") +
  geom_boxplot()+
  ylab("Percent of Hemocyte Events in each quad plot") + 
  scale_fill_manual(name="Hemocyte Type", labels=c("Live Agranular Non-Apoptotic", "Live Agranular Apoptotic", "Dead Agranular Apoptotic", "Agranular Necrotic", "Live Granular Non-Apoptotic", "Live Granular Apoptotic", "Dead Granular Apoptotic", "Granular Necrotic"), values=c("Q1_LL"="#50b47b","Q1_LR"="#5d3585", "Q1_UL"="#98a441", "Q1_UR"="#6770d5","Q2_LL"="#ba6437","Q2_LR"="#6d8dd7", "Q2_UL"="#ba496b", "Q2_UR"="#c26abb")) +
  scale_color_manual(values=c("granular"="black","agranular"="black"))
```

![](Dermo_Apoptosis_Assay_Data_analysis_files/figure-markdown_github/graphing_granular-3.png)

#### Calculate Summary Statistics

full\_combined &lt;- rbind(APOP\_PLOT4\_GRANULAR\_QUAD\_PLOT\_GATE\_ADDED\_BAD\_REMOVED, APOP\_PLOT7\_AGRANULAR\_QUAD\_PLOT\_GATE\_ADDED\_BAD\_REMOVED)

full\_statistics &lt;- summarySE(data=full\_combined, "PERCENT\_OF\_THIS\_PLOT", groupvars=c("GATE", "GROUP", "cell","FAMILY"), conf.interval= 0.95)
