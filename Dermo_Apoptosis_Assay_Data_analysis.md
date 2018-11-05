Dermo Challenge Apoptosis Assay Data Analysis
================
Erin Roberts
8/14/2018

Load Packages
-------------

``` r
library(ggplot2)
library(metafor)
```

    ## Loading required package: Matrix

    ## Loading 'metafor' package (version 2.0-0). For an overview 
    ## and introduction to the package please type: help(metafor).

``` r
library(dplyr)
```

    ## Warning: package 'dplyr' was built under R version 3.4.2

    ## 
    ## Attaching package: 'dplyr'

    ## The following objects are masked from 'package:stats':
    ## 
    ##     filter, lag

    ## The following objects are masked from 'package:base':
    ## 
    ##     intersect, setdiff, setequal, union

``` r
library(car)
```

    ## Warning: package 'car' was built under R version 3.4.4

    ## Loading required package: carData

    ## Warning: package 'carData' was built under R version 3.4.4

    ## 
    ## Attaching package: 'car'

    ## The following object is masked from 'package:dplyr':
    ## 
    ##     recode

``` r
library(lsmeans)
```

    ## Warning: package 'lsmeans' was built under R version 3.4.4

    ## The 'lsmeans' package is being deprecated.
    ## Users are encouraged to switch to 'emmeans'.
    ## See help('transition') for more information, including how
    ## to convert 'lsmeans' objects and scripts to work with 'emmeans'.

``` r
library(rgr)
```

    ## Warning: package 'rgr' was built under R version 3.4.4

    ## Loading required package: MASS

    ## 
    ## Attaching package: 'MASS'

    ## The following object is masked from 'package:dplyr':
    ## 
    ##     select

    ## Loading required package: fastICA

    ## 
    ## Attaching package: 'rgr'

    ## The following object is masked from 'package:car':
    ## 
    ##     logit

``` r
library(multcompView)
library(Rmisc)
```

    ## Loading required package: lattice

    ## Loading required package: plyr

    ## -------------------------------------------------------------------------

    ## You have loaded plyr after dplyr - this is likely to cause problems.
    ## If you need functions from both plyr and dplyr, please load plyr first, then dplyr:
    ## library(plyr); library(dplyr)

    ## -------------------------------------------------------------------------

    ## 
    ## Attaching package: 'plyr'

    ## The following objects are masked from 'package:dplyr':
    ## 
    ##     arrange, count, desc, failwith, id, mutate, rename, summarise,
    ##     summarize

``` r
library(ggpubr)
```

    ## Warning: package 'ggpubr' was built under R version 3.4.2

    ## Loading required package: magrittr

    ## 
    ## Attaching package: 'magrittr'

    ## The following object is masked from 'package:rgr':
    ## 
    ##     inset

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
ggsave(filename = "./Figures/APOP_live_apoptotic_granular_BAD_NOT_REMOVED.png",plot=APOP_live_apoptotic_granular_BAD_NOT_REMOVED)
```

    ## Saving 7 x 5 in image

![Percent of Live Apoptotic Granular Hemocytes Low Quality Not Removed](https://github.com/erinroberts/Apoptosis-Data-Analysis-Dermo-Challenge-2018/tree/master/Figures/APOP_live_apoptotic_granular_BAD_NOT_REMOVED.png)

``` r
APOP_live_apoptotic_granular_BAD_REMOVED <- ggplot(data= APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED, aes(x=FAMILY, y=Q2.LR_PERCENT_OF_THIS_PLOT, color=GROUP, by=GROUP)) + geom_boxplot() + ggtitle("Percent of Live Apoptotic Granular Hemocytes \nLow Quality Removed") +
  xlab("Family") + ylab("Percent of Hemocyte Events") + ylim(0,100)
ggsave(filename="./Figures/APOP_live_apoptotic_granular_BAD_REMOVED.png",plot=APOP_live_apoptotic_granular_BAD_REMOVED)
```

    ## Saving 7 x 5 in image

![Percent of Live Apoptotic Granular Hemocytes Low Quality Removed](https://github.com/erinroberts/Apoptosis-Data-Analysis-Dermo-Challenge-2018/tree/master/Figures/APOP_live_apoptotic_granular_BAD_REMOVED.png)

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

ggsave(filename="./Figures/APOP_live_apoptotic_Agranular_BAD_NOT_REMOVED.png",plot=APOP_live_apoptotic_Agranular_BAD_NOT_REMOVED)
```

    ## Saving 7 x 5 in image

![APOP\_live\_apoptotic\_Agranular\_BAD\_NOT\_REMOVED](https://github.com/erinroberts/Apoptosis-Data-Analysis-Dermo-Challenge-2018/tree/master/Figures/APOP_live_apoptotic_Agranular_BAD_NOT_REMOVED.png)

``` r
APOP_live_apoptotic_Agranular_BAD_REMOVED <- ggplot(data= APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED, aes(x=FAMILY, y=Q1.LR_PERCENT_OF_THIS_PLOT, color=GROUP, by=GROUP)) + geom_boxplot() + ggtitle("Percent of Live Apoptotic Agranular Hemocytes \nLow Quality Removed") +
  xlab("Family") + ylab("Percent of Hemocyte Events") + ylim(0,100)
ggsave(filename="./Figures/APOP_live_apoptotic_Agranular_BAD_REMOVED.png",plot=APOP_live_apoptotic_Agranular_BAD_NOT_REMOVED)
```

    ## Saving 7 x 5 in image

![Percent of Live Apoptotic Agranular Hemocytes Low Quality Removed](https://github.com/erinroberts/Apoptosis-Data-Analysis-Dermo-Challenge-2018/tree/master/Figures/APOP_live_apoptotic_Agranular_BAD_REMOVED.png)

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
# Graph for abstract
ggplot(APOP_Live_apoptotic_combined_all, aes(x=GROUP, y=PERCENT_OF_THIS_PLOT, fill=GATE)) + facet_grid(.~FAMILY+GROUP, scales="free") + theme(strip.text = element_text(size=15), axis.text = element_text(size=15, face="bold"), axis.title = element_text(size=15, face="bold"), plot.title = element_text(size=20, face="bold"),legend.text = element_text(size=15, face="bold"), legend.title = element_text(size=15, face="bold")) + geom_boxplot() + ggtitle("Percent of Granular and Agranular Live Apoptotic Hemocytes at Day 7 Post-Challenge") + ylab("Percent of Hemocyte Events") + scale_fill_manual(name="Hemocyte Type", labels=c("Live Apoptotic Agranular", "Live Apoptotic Granular"), values=c("Q2_LR"="black","Q1_LR"="grey"))
```

![](Dermo_Apoptosis_Assay_Data_analysis_files/figure-markdown_github/combined-2.png)

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

![](Dermo_Apoptosis_Assay_Data_analysis_files/figure-markdown_github/combined-3.png)

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

![](Dermo_Apoptosis_Assay_Data_analysis_files/figure-markdown_github/combined-4.png)

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

ggplot(combined_dead_apoptotic_agranular_granular, aes(x=GROUP, y=PERCENT_OF_THIS_PLOT, fill=GATE)) + geom_boxplot() + ggtitle("Percent of Granular and Agranular Dead Apoptotic Hemocytes (low quality removed)") +
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

#### Percent Live Granular Hemocytes

### One-Way ANOVA control vs. challenge

Plotting
--------

``` r
ggplot(data=APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED, aes(x=FAMILY, y=Q2.LL_PERCENT_OF_THIS_PLOT, color=GROUP, by=GROUP)) + geom_boxplot() + ggtitle("Percent of Live Granular Hemocytes \nLow Quality Removed") +
  xlab("Family") + ylab("Percent of Hemocyte Events") + ylim(0,100)
```

![](Dermo_Apoptosis_Assay_Data_analysis_files/figure-markdown_github/live_granular_plotting-1.png)

### Family A

``` r
APOP_PLOT_4_live_granular_FAMILY_A_AOV_BAD_REMOVED <- aov(APOP_PLOT_4_granular_FAMILY_A_BAD_REMOVED$Q2.LL_Arcsine ~ APOP_PLOT_4_granular_FAMILY_A_BAD_REMOVED$GROUP, data=APOP_PLOT_4_granular_FAMILY_A_BAD_REMOVED)
summary(APOP_PLOT_4_live_granular_FAMILY_A_AOV_BAD_REMOVED)
```

    ##                                                 Df  Sum Sq Mean Sq F value
    ## APOP_PLOT_4_granular_FAMILY_A_BAD_REMOVED$GROUP  1 0.01812 0.01812   6.059
    ## Residuals                                        9 0.02691 0.00299        
    ##                                                 Pr(>F)  
    ## APOP_PLOT_4_granular_FAMILY_A_BAD_REMOVED$GROUP 0.0361 *
    ## Residuals                                               
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

### Family B

``` r
APOP_PLOT_4_live_granular_FAMILY_B_AOV_BAD_REMOVED <- aov(APOP_PLOT_4_granular_FAMILY_B_BAD_REMOVED$Q2.LL_Arcsine ~ APOP_PLOT_4_granular_FAMILY_B_BAD_REMOVED$GROUP, data=APOP_PLOT_4_granular_FAMILY_B_BAD_REMOVED)
summary(APOP_PLOT_4_live_granular_FAMILY_B_AOV_BAD_REMOVED)
```

    ##                                                 Df   Sum Sq  Mean Sq
    ## APOP_PLOT_4_granular_FAMILY_B_BAD_REMOVED$GROUP  1 0.001076 0.001076
    ## Residuals                                        7 0.012820 0.001831
    ##                                                 F value Pr(>F)
    ## APOP_PLOT_4_granular_FAMILY_B_BAD_REMOVED$GROUP   0.587  0.469
    ## Residuals

### Family D

``` r
APOP_PLOT_4_live_granular_FAMILY_D_AOV_BAD_REMOVED <- aov(APOP_PLOT_4_granular_FAMILY_D_BAD_REMOVED$Q2.LL_Arcsine ~ APOP_PLOT_4_granular_FAMILY_D_BAD_REMOVED$GROUP, data=APOP_PLOT_4_granular_FAMILY_D_BAD_REMOVED)
summary(APOP_PLOT_4_live_granular_FAMILY_D_AOV_BAD_REMOVED)
```

    ##                                                 Df  Sum Sq  Mean Sq
    ## APOP_PLOT_4_granular_FAMILY_D_BAD_REMOVED$GROUP  1 0.00484 0.004840
    ## Residuals                                        6 0.01881 0.003135
    ##                                                 F value Pr(>F)
    ## APOP_PLOT_4_granular_FAMILY_D_BAD_REMOVED$GROUP   1.544   0.26
    ## Residuals

### Family E

``` r
APOP_PLOT_4_live_granular_FAMILY_E_AOV_BAD_REMOVED <- aov(APOP_PLOT_4_granular_FAMILY_E_BAD_REMOVED$Q2.LL_Arcsine ~ APOP_PLOT_4_granular_FAMILY_E_BAD_REMOVED$GROUP, data=APOP_PLOT_4_granular_FAMILY_E_BAD_REMOVED)
summary(APOP_PLOT_4_live_granular_FAMILY_E_AOV_BAD_REMOVED)
```

    ##                                                 Df  Sum Sq  Mean Sq
    ## APOP_PLOT_4_granular_FAMILY_E_BAD_REMOVED$GROUP  1 0.02226 0.022256
    ## Residuals                                        7 0.05758 0.008225
    ##                                                 F value Pr(>F)
    ## APOP_PLOT_4_granular_FAMILY_E_BAD_REMOVED$GROUP   2.706  0.144
    ## Residuals

### Family J

``` r
APOP_PLOT_4_live_granular_FAMILY_J_AOV_BAD_REMOVED <- aov(APOP_PLOT_4_granular_FAMILY_J_BAD_REMOVED$Q2.LL_Arcsine ~ APOP_PLOT_4_granular_FAMILY_J_BAD_REMOVED$GROUP, data=APOP_PLOT_4_granular_FAMILY_J_BAD_REMOVED)
summary(APOP_PLOT_4_live_granular_FAMILY_J_AOV_BAD_REMOVED)
```

    ##                                                 Df  Sum Sq  Mean Sq
    ## APOP_PLOT_4_granular_FAMILY_J_BAD_REMOVED$GROUP  1 0.00015 0.000154
    ## Residuals                                        9 0.07414 0.008238
    ##                                                 F value Pr(>F)
    ## APOP_PLOT_4_granular_FAMILY_J_BAD_REMOVED$GROUP   0.019  0.894
    ## Residuals

### Family L

``` r
APOP_PLOT_4_live_granular_FAMILY_L_AOV_BAD_REMOVED <- aov(APOP_PLOT_4_granular_FAMILY_L_BAD_REMOVED$Q2.LL_Arcsine ~ APOP_PLOT_4_granular_FAMILY_L_BAD_REMOVED$GROUP, data=APOP_PLOT_4_granular_FAMILY_L_BAD_REMOVED)
summary(APOP_PLOT_4_live_granular_FAMILY_L_AOV_BAD_REMOVED)
```

    ##                                                 Df  Sum Sq  Mean Sq
    ## APOP_PLOT_4_granular_FAMILY_L_BAD_REMOVED$GROUP  1 0.00001 0.000011
    ## Residuals                                        7 0.12772 0.018246
    ##                                                 F value Pr(>F)
    ## APOP_PLOT_4_granular_FAMILY_L_BAD_REMOVED$GROUP   0.001  0.981
    ## Residuals

### Two- Way ANOVA

``` r
APOP_PLOT_4_live_granular_FAMILY_BAD_REMOVED_lm <- lm(APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$Q2.LL_Arcsine ~ APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$GROUP + APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILY, data=APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED)
Anova(APOP_PLOT_4_live_granular_FAMILY_BAD_REMOVED_lm, type="II")
```

    ## Anova Table (Type II tests)
    ## 
    ## Response: APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$Q2.LL_Arcsine
    ##                                                   Sum Sq Df F value
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$GROUP  0.01083  1  1.5308
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILY 0.21882  5  6.1882
    ## Residuals                                        0.35362 50        
    ##                                                     Pr(>F)    
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$GROUP  0.2217758    
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILY 0.0001543 ***
    ## Residuals                                                     
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

``` r
summary(APOP_PLOT_4_live_granular_FAMILY_BAD_REMOVED_lm)
```

    ## 
    ## Call:
    ## lm(formula = APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$Q2.LL_Arcsine ~ 
    ##     APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$GROUP + APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILY, 
    ##     data = APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED)
    ## 
    ## Residuals:
    ##       Min        1Q    Median        3Q       Max 
    ## -0.142341 -0.056250 -0.000734  0.057375  0.179053 
    ## 
    ## Coefficients:
    ##                                                          Estimate
    ## (Intercept)                                               1.26967
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$GROUPtreatment  0.03293
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYB        -0.14494
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYD        -0.06561
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYE        -0.03977
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYJ        -0.06676
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYL         0.05959
    ##                                                          Std. Error
    ## (Intercept)                                                 0.03190
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$GROUPtreatment    0.02661
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYB           0.03782
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYD           0.03908
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYE           0.03782
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYJ           0.03594
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYL           0.03782
    ##                                                          t value Pr(>|t|)
    ## (Intercept)                                               39.802  < 2e-16
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$GROUPtreatment   1.237 0.221776
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYB         -3.832 0.000356
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYD         -1.679 0.099427
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYE         -1.051 0.298117
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYJ         -1.858 0.069117
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYL          1.575 0.121466
    ##                                                             
    ## (Intercept)                                              ***
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$GROUPtreatment    
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYB        ***
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYD        .  
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYE           
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYJ        .  
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYL           
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
    ## 
    ## Residual standard error: 0.0841 on 50 degrees of freedom
    ## Multiple R-squared:  0.3919, Adjusted R-squared:  0.3189 
    ## F-statistic:  5.37 on 6 and 50 DF,  p-value: 0.0002415

``` r
# Interaction
APOP_PLOT_4_live_granular_FAMILY_BAD_REMOVED_interaction_lm <- lm(APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$Q2.LL_Arcsine ~ APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$GROUP + APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILY + APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$GROUP:APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILY, data=APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED)
Anova(APOP_PLOT_4_live_granular_FAMILY_BAD_REMOVED_interaction_lm, type="II") # Family is significant
```

    ## Anova Table (Type II tests)
    ## 
    ## Response: APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$Q2.LL_Arcsine
    ##                                                                                                   Sum Sq
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$GROUP                                                  0.01083
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILY                                                 0.21882
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$GROUP:APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILY 0.03563
    ## Residuals                                                                                        0.31799
    ##                                                                                                  Df
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$GROUP                                                   1
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILY                                                  5
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$GROUP:APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILY  5
    ## Residuals                                                                                        45
    ##                                                                                                  F value
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$GROUP                                                   1.5321
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILY                                                  6.1934
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$GROUP:APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILY  1.0084
    ## Residuals                                                                                               
    ##                                                                                                     Pr(>F)
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$GROUP                                                  0.2222227
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILY                                                 0.0001897
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$GROUP:APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILY 0.4238653
    ## Residuals                                                                                                 
    ##                                                                                                     
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$GROUP                                                     
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILY                                                 ***
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$GROUP:APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILY    
    ## Residuals                                                                                           
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

``` r
summary(APOP_PLOT_4_live_granular_FAMILY_BAD_REMOVED_interaction_lm)
```

    ## 
    ## Call:
    ## lm(formula = APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$Q2.LL_Arcsine ~ 
    ##     APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$GROUP + APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILY + 
    ##         APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$GROUP:APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILY, 
    ##     data = APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED)
    ## 
    ## Residuals:
    ##       Min        1Q    Median        3Q       Max 
    ## -0.155479 -0.049632  0.001893  0.054674  0.155479 
    ## 
    ## Coefficients:
    ##                                                                                                            Estimate
    ## (Intercept)                                                                                                 1.22734
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$GROUPtreatment                                                    0.09113
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYB                                                          -0.09746
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYD                                                           0.04402
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYE                                                          -0.06486
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYJ                                                           0.01044
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYL                                                           0.12549
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$GROUPtreatment:APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYB -0.06483
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$GROUPtreatment:APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYD -0.14793
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$GROUPtreatment:APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYE  0.02849
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$GROUPtreatment:APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYJ -0.10083
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$GROUPtreatment:APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYL -0.08851
    ##                                                                                                            Std. Error
    ## (Intercept)                                                                                                   0.04853
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$GROUPtreatment                                                      0.05691
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYB                                                             0.07674
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYD                                                             0.07674
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYE                                                             0.07674
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYJ                                                             0.07674
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYL                                                             0.07674
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$GROUPtreatment:APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYB    0.08821
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$GROUPtreatment:APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYD    0.08916
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$GROUPtreatment:APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYE    0.08821
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$GROUPtreatment:APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYJ    0.08693
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$GROUPtreatment:APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYL    0.08821
    ##                                                                                                            t value
    ## (Intercept)                                                                                                 25.289
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$GROUPtreatment                                                     1.601
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYB                                                           -1.270
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYD                                                            0.574
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYE                                                           -0.845
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYJ                                                            0.136
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYL                                                            1.635
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$GROUPtreatment:APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYB  -0.735
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$GROUPtreatment:APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYD  -1.659
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$GROUPtreatment:APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYE   0.323
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$GROUPtreatment:APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYJ  -1.160
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$GROUPtreatment:APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYL  -1.003
    ##                                                                                                            Pr(>|t|)
    ## (Intercept)                                                                                                  <2e-16
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$GROUPtreatment                                                      0.116
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYB                                                             0.211
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYD                                                             0.569
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYE                                                             0.402
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYJ                                                             0.892
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYL                                                             0.109
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$GROUPtreatment:APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYB    0.466
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$GROUPtreatment:APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYD    0.104
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$GROUPtreatment:APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYE    0.748
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$GROUPtreatment:APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYJ    0.252
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$GROUPtreatment:APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYL    0.321
    ##                                                                                                               
    ## (Intercept)                                                                                                ***
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$GROUPtreatment                                                      
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYB                                                             
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYD                                                             
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYE                                                             
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYJ                                                             
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYL                                                             
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$GROUPtreatment:APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYB    
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$GROUPtreatment:APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYD    
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$GROUPtreatment:APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYE    
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$GROUPtreatment:APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYJ    
    ## APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$GROUPtreatment:APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYL    
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
    ## 
    ## Residual standard error: 0.08406 on 45 degrees of freedom
    ## Multiple R-squared:  0.4532, Adjusted R-squared:  0.3195 
    ## F-statistic:  3.39 on 11 and 45 DF,  p-value: 0.001777

``` r
APOP_PLOT_4_live_granular_FAMILY_BAD_REMOVED_interaction_lm_leastsquares <-lsmeans(APOP_PLOT_4_live_granular_FAMILY_BAD_REMOVED_interaction_lm, "APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILY", adjust="tukey")
cld(APOP_PLOT_4_live_granular_FAMILY_BAD_REMOVED_interaction_lm_leastsquares, alpha=0.05, Letters=letters)
```

    ##  APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILY   lsmean         SE df
    ##  L                                                1.191757 0.02900409 45
    ##  J                                                1.227338 0.04853313 45
    ##  A                                                1.318466 0.02972035 45
    ##  B                                                1.318466 0.02972035 45
    ##  D                                                1.318466 0.02972035 45
    ##  E                                                1.318466 0.02972035 45
    ##  lower.CL upper.CL .group
    ##  1.133340 1.250174  a    
    ##  1.129587 1.325089  ab   
    ##  1.258606 1.378326   b   
    ##  1.258606 1.378326   b   
    ##  1.258606 1.378326   b   
    ##  1.258606 1.378326   b   
    ## 
    ## Results are averaged over the levels of: APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$GROUP 
    ## Confidence level used: 0.95 
    ## P value adjustment: tukey method for comparing a family of 6 estimates 
    ## significance level used: alpha = 0.05

### One-Way Anova of just challenged

``` r
APOP_PLOT_4_granular_hemocytes_BAD_REMOVED_CHALLENGE <- APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED[!grepl("control",APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$GROUP),]

APOP_PLOT_4_granular_oneway_aov <- aov(APOP_PLOT_4_granular_hemocytes_BAD_REMOVED_CHALLENGE$Q2.LL_Arcsine ~ APOP_PLOT_4_granular_hemocytes_BAD_REMOVED_CHALLENGE$FAMILY, data=APOP_PLOT_4_granular_hemocytes_BAD_REMOVED_CHALLENGE)
summary(APOP_PLOT_4_granular_oneway_aov)
```

    ##                                                             Df Sum Sq
    ## APOP_PLOT_4_granular_hemocytes_BAD_REMOVED_CHALLENGE$FAMILY  5 0.1915
    ## Residuals                                                   38 0.2310
    ##                                                             Mean Sq
    ## APOP_PLOT_4_granular_hemocytes_BAD_REMOVED_CHALLENGE$FAMILY 0.03831
    ## Residuals                                                   0.00608
    ##                                                             F value
    ## APOP_PLOT_4_granular_hemocytes_BAD_REMOVED_CHALLENGE$FAMILY   6.302
    ## Residuals                                                          
    ##                                                               Pr(>F)    
    ## APOP_PLOT_4_granular_hemocytes_BAD_REMOVED_CHALLENGE$FAMILY 0.000238 ***
    ## Residuals                                                               
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

``` r
TukeyHSD(APOP_PLOT_4_granular_oneway_aov)
```

    ##   Tukey multiple comparisons of means
    ##     95% family-wise confidence level
    ## 
    ## Fit: aov(formula = APOP_PLOT_4_granular_hemocytes_BAD_REMOVED_CHALLENGE$Q2.LL_Arcsine ~ APOP_PLOT_4_granular_hemocytes_BAD_REMOVED_CHALLENGE$FAMILY, data = APOP_PLOT_4_granular_hemocytes_BAD_REMOVED_CHALLENGE)
    ## 
    ## $`APOP_PLOT_4_granular_hemocytes_BAD_REMOVED_CHALLENGE$FAMILY`
    ##            diff           lwr         upr     p adj
    ## B-A -0.16229016 -0.2833430228 -0.04123730 0.0033594
    ## D-A -0.10391651 -0.2302349804  0.02240195 0.1594886
    ## E-A -0.03637702 -0.1574298779  0.08467585 0.9437344
    ## J-A -0.09038835 -0.2040415510  0.02326484 0.1868877
    ## L-A  0.03697852 -0.0840743460  0.15803138 0.9398690
    ## D-B  0.05837365 -0.0717542694  0.18850156 0.7579535
    ## E-B  0.12591314  0.0008902869  0.25093600 0.0475223
    ## J-B  0.07190181 -0.0459708738  0.18977449 0.4595338
    ## L-B  0.19926868  0.0742458188  0.32429153 0.0003552
    ## E-D  0.06753950 -0.0625884184  0.19766741 0.6307020
    ## J-D  0.01352816 -0.1097460403  0.13680236 0.9994433
    ## L-D  0.14089503  0.0107671135  0.27102295 0.0272260
    ## J-E -0.05401134 -0.1718840187  0.06386134 0.7414951
    ## L-E  0.07335553 -0.0516673261  0.19837839 0.5024573
    ## L-J  0.12736687  0.0094941887  0.24523955 0.0276818

#### Percent Live Agranular Hemocytes

Plotting
--------

``` r
ggplot(data=APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED, aes(x=FAMILY, y=Q1.LL_PERCENT_OF_THIS_PLOT, color=GROUP, by=GROUP)) + geom_boxplot() + ggtitle("Percent of Live Agranular Hemocytes \nLow Quality Removed") +
  xlab("Family") + ylab("Percent of Hemocyte Events") + ylim(0,100)
```

![](Dermo_Apoptosis_Assay_Data_analysis_files/figure-markdown_github/live_agranular_plotting-1.png)

### Family A

``` r
APOP_PLOT_7_live_agranular_FAMILY_A_AOV_BAD_REMOVED <- aov(APOP_PLOT_7_agranular_FAMILY_A_BAD_REMOVED$Q1.LL_Arcsine ~ APOP_PLOT_7_agranular_FAMILY_A_BAD_REMOVED$GROUP, data=APOP_PLOT_7_agranular_FAMILY_A_BAD_REMOVED)
summary(APOP_PLOT_7_live_agranular_FAMILY_A_AOV_BAD_REMOVED)  
```

    ##                                                  Df  Sum Sq Mean Sq
    ## APOP_PLOT_7_agranular_FAMILY_A_BAD_REMOVED$GROUP  1 0.00065 0.00065
    ## Residuals                                         9 0.21631 0.02404
    ##                                                  F value Pr(>F)
    ## APOP_PLOT_7_agranular_FAMILY_A_BAD_REMOVED$GROUP   0.027  0.873
    ## Residuals

### Family B

``` r
APOP_PLOT_7_live_agranular_FAMILY_B_AOV_BAD_REMOVED <- aov(APOP_PLOT_7_agranular_FAMILY_B_BAD_REMOVED$Q1.LL_Arcsine ~ APOP_PLOT_7_agranular_FAMILY_B_BAD_REMOVED$GROUP, data=APOP_PLOT_7_agranular_FAMILY_B_BAD_REMOVED)
summary(APOP_PLOT_7_live_agranular_FAMILY_B_AOV_BAD_REMOVED)  
```

    ##                                                  Df  Sum Sq Mean Sq
    ## APOP_PLOT_7_agranular_FAMILY_B_BAD_REMOVED$GROUP  1 0.01355 0.01355
    ## Residuals                                         7 0.28958 0.04137
    ##                                                  F value Pr(>F)
    ## APOP_PLOT_7_agranular_FAMILY_B_BAD_REMOVED$GROUP   0.328  0.585
    ## Residuals

### Family D

``` r
APOP_PLOT_7_live_agranular_FAMILY_D_AOV_BAD_REMOVED <- aov(APOP_PLOT_7_agranular_FAMILY_D_BAD_REMOVED$Q1.LL_Arcsine ~ APOP_PLOT_7_agranular_FAMILY_D_BAD_REMOVED$GROUP, data=APOP_PLOT_7_agranular_FAMILY_D_BAD_REMOVED)
summary(APOP_PLOT_7_live_agranular_FAMILY_D_AOV_BAD_REMOVED)  
```

    ##                                                  Df  Sum Sq  Mean Sq
    ## APOP_PLOT_7_agranular_FAMILY_D_BAD_REMOVED$GROUP  1 0.00173 0.001728
    ## Residuals                                         6 0.03175 0.005292
    ##                                                  F value Pr(>F)
    ## APOP_PLOT_7_agranular_FAMILY_D_BAD_REMOVED$GROUP   0.326  0.589
    ## Residuals

### Family E

``` r
APOP_PLOT_7_live_agranular_FAMILY_E_AOV_BAD_REMOVED <- aov(APOP_PLOT_7_agranular_FAMILY_E_BAD_REMOVED$Q1.LL_Arcsine ~ APOP_PLOT_7_agranular_FAMILY_E_BAD_REMOVED$GROUP, data=APOP_PLOT_7_agranular_FAMILY_E_BAD_REMOVED)
summary(APOP_PLOT_7_live_agranular_FAMILY_E_AOV_BAD_REMOVED)  
```

    ##                                                  Df Sum Sq Mean Sq F value
    ## APOP_PLOT_7_agranular_FAMILY_E_BAD_REMOVED$GROUP  1 0.1500 0.15001   2.944
    ## Residuals                                         7 0.3567 0.05096        
    ##                                                  Pr(>F)
    ## APOP_PLOT_7_agranular_FAMILY_E_BAD_REMOVED$GROUP   0.13
    ## Residuals

### Family J

``` r
APOP_PLOT_7_live_agranular_FAMILY_J_AOV_BAD_REMOVED <- aov(APOP_PLOT_7_agranular_FAMILY_J_BAD_REMOVED$Q1.LL_Arcsine ~ APOP_PLOT_7_agranular_FAMILY_J_BAD_REMOVED$GROUP, data=APOP_PLOT_7_agranular_FAMILY_J_BAD_REMOVED)
summary(APOP_PLOT_7_live_agranular_FAMILY_J_AOV_BAD_REMOVED)  
```

    ##                                                  Df  Sum Sq  Mean Sq
    ## APOP_PLOT_7_agranular_FAMILY_J_BAD_REMOVED$GROUP  1 0.00087 0.000873
    ## Residuals                                         9 0.18129 0.020143
    ##                                                  F value Pr(>F)
    ## APOP_PLOT_7_agranular_FAMILY_J_BAD_REMOVED$GROUP   0.043   0.84
    ## Residuals

### Family L

``` r
APOP_PLOT_7_live_agranular_FAMILY_L_AOV_BAD_REMOVED <- aov(APOP_PLOT_7_agranular_FAMILY_L_BAD_REMOVED$Q1.LL_Arcsine ~ APOP_PLOT_7_agranular_FAMILY_L_BAD_REMOVED$GROUP, data=APOP_PLOT_7_agranular_FAMILY_L_BAD_REMOVED)
summary(APOP_PLOT_7_live_agranular_FAMILY_L_AOV_BAD_REMOVED)  
```

    ##                                                  Df Sum Sq  Mean Sq
    ## APOP_PLOT_7_agranular_FAMILY_L_BAD_REMOVED$GROUP  1 0.0078 0.007798
    ## Residuals                                         7 0.1655 0.023646
    ##                                                  F value Pr(>F)
    ## APOP_PLOT_7_agranular_FAMILY_L_BAD_REMOVED$GROUP    0.33  0.584
    ## Residuals

### Two- Way ANOVA

``` r
APOP_PLOT_7_live_agranular_FAMILY_BAD_REMOVED_lm <- lm(APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$Q1.LL_Arcsine ~APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$GROUP + APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILY, data=APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED)
Anova(APOP_PLOT_7_live_agranular_FAMILY_BAD_REMOVED_lm, type="II") # Family is significant
```

    ## Anova Table (Type II tests)
    ## 
    ## Response: APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$Q1.LL_Arcsine
    ##                                                    Sum Sq Df F value
    ## APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$GROUP  0.05830  1  2.1473
    ## APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILY 0.51747  5  3.8119
    ## Residuals                                         1.35750 50        
    ##                                                     Pr(>F)   
    ## APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$GROUP  0.149085   
    ## APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILY 0.005295 **
    ## Residuals                                                    
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

``` r
summary(APOP_PLOT_7_live_agranular_FAMILY_BAD_REMOVED_lm) 
```

    ## 
    ## Call:
    ## lm(formula = APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$Q1.LL_Arcsine ~ 
    ##     APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$GROUP + APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILY, 
    ##     data = APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED)
    ## 
    ## Residuals:
    ##      Min       1Q   Median       3Q      Max 
    ## -0.46663 -0.09169 -0.03604  0.13430  0.30197 
    ## 
    ## Coefficients:
    ##                                                           Estimate
    ## (Intercept)                                                0.97216
    ## APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$GROUPtreatment  0.07641
    ## APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYB        -0.11495
    ## APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYD        -0.22558
    ## APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYE        -0.13548
    ## APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYJ        -0.10819
    ## APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYL         0.07992
    ##                                                           Std. Error
    ## (Intercept)                                                  0.06250
    ## APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$GROUPtreatment    0.05215
    ## APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYB           0.07411
    ## APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYD           0.07657
    ## APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYE           0.07411
    ## APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYJ           0.07042
    ## APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYL           0.07411
    ##                                                           t value Pr(>|t|)
    ## (Intercept)                                                15.554  < 2e-16
    ## APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$GROUPtreatment   1.465  0.14908
    ## APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYB         -1.551  0.12718
    ## APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYD         -2.946  0.00488
    ## APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYE         -1.828  0.07350
    ## APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYJ         -1.536  0.13076
    ## APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYL          1.078  0.28600
    ##                                                              
    ## (Intercept)                                               ***
    ## APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$GROUPtreatment    
    ## APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYB           
    ## APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYD        ** 
    ## APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYE        .  
    ## APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYJ           
    ## APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYL           
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
    ## 
    ## Residual standard error: 0.1648 on 50 degrees of freedom
    ## Multiple R-squared:  0.2966, Adjusted R-squared:  0.2122 
    ## F-statistic: 3.514 on 6 and 50 DF,  p-value: 0.005603

``` r
# Interaction
APOP_PLOT_7_live_agranular_FAMILY_BAD_REMOVED_lm_interaction <- lm(APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$Q1.LL_Arcsine ~APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$GROUP + APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILY + APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$GROUP:APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILY , data=APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED)
Anova(APOP_PLOT_7_live_agranular_FAMILY_BAD_REMOVED_lm_interaction, type="II") # Family is significant
```

    ## Anova Table (Type II tests)
    ## 
    ## Response: APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$Q1.LL_Arcsine
    ##                                                                                                     Sum Sq
    ## APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$GROUP                                                   0.05830
    ## APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILY                                                  0.51747
    ## APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$GROUP:APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILY 0.11632
    ## Residuals                                                                                          1.24118
    ##                                                                                                    Df
    ## APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$GROUP                                                    1
    ## APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILY                                                   5
    ## APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$GROUP:APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILY  5
    ## Residuals                                                                                          45
    ##                                                                                                    F value
    ## APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$GROUP                                                    2.1136
    ## APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILY                                                   3.7522
    ## APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$GROUP:APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILY  0.8434
    ## Residuals                                                                                                 
    ##                                                                                                      Pr(>F)
    ## APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$GROUP                                                   0.152931
    ## APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILY                                                  0.006341
    ## APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$GROUP:APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILY 0.526227
    ## Residuals                                                                                                  
    ##                                                                                                      
    ## APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$GROUP                                                     
    ## APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILY                                                  **
    ## APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$GROUP:APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILY   
    ## Residuals                                                                                            
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

``` r
summary(APOP_PLOT_7_live_agranular_FAMILY_BAD_REMOVED_lm_interaction) 
```

    ## 
    ## Call:
    ## lm(formula = APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$Q1.LL_Arcsine ~ 
    ##     APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$GROUP + APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILY + 
    ##         APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$GROUP:APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILY, 
    ##     data = APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED)
    ## 
    ## Residuals:
    ##      Min       1Q   Median       3Q      Max 
    ## -0.28453 -0.10344 -0.03612  0.12916  0.28453 
    ## 
    ## Coefficients:
    ##                                                                                                               Estimate
    ## (Intercept)                                                                                                   1.015176
    ## APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$GROUPtreatment                                                     0.017264
    ## APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYB                                                           -0.171131
    ## APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYD                                                           -0.185832
    ## APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYE                                                           -0.360597
    ## APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYJ                                                           -0.107581
    ## APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYL                                                            0.041267
    ## APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$GROUPtreatment:APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYB  0.076077
    ## APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$GROUPtreatment:APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYD -0.051201
    ## APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$GROUPtreatment:APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYE  0.293280
    ## APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$GROUPtreatment:APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYJ  0.005832
    ## APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$GROUPtreatment:APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYL  0.053539
    ##                                                                                                              Std. Error
    ## (Intercept)                                                                                                    0.095885
    ## APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$GROUPtreatment                                                      0.112435
    ## APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYB                                                             0.151608
    ## APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYD                                                             0.151608
    ## APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYE                                                             0.151608
    ## APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYJ                                                             0.151608
    ## APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYL                                                             0.151608
    ## APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$GROUPtreatment:APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYB   0.174278
    ## APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$GROUPtreatment:APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYD   0.176152
    ## APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$GROUPtreatment:APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYE   0.174278
    ## APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$GROUPtreatment:APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYJ   0.171748
    ## APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$GROUPtreatment:APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYL   0.174278
    ##                                                                                                              t value
    ## (Intercept)                                                                                                   10.587
    ## APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$GROUPtreatment                                                      0.154
    ## APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYB                                                            -1.129
    ## APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYD                                                            -1.226
    ## APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYE                                                            -2.378
    ## APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYJ                                                            -0.710
    ## APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYL                                                             0.272
    ## APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$GROUPtreatment:APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYB   0.437
    ## APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$GROUPtreatment:APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYD  -0.291
    ## APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$GROUPtreatment:APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYE   1.683
    ## APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$GROUPtreatment:APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYJ   0.034
    ## APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$GROUPtreatment:APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYL   0.307
    ##                                                                                                              Pr(>|t|)
    ## (Intercept)                                                                                                  8.44e-14
    ## APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$GROUPtreatment                                                      0.8787
    ## APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYB                                                             0.2650
    ## APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYD                                                             0.2267
    ## APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYE                                                             0.0217
    ## APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYJ                                                             0.4816
    ## APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYL                                                             0.7867
    ## APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$GROUPtreatment:APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYB   0.6645
    ## APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$GROUPtreatment:APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYD   0.7726
    ## APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$GROUPtreatment:APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYE   0.0993
    ## APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$GROUPtreatment:APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYJ   0.9731
    ## APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$GROUPtreatment:APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYL   0.7601
    ##                                                                                                                 
    ## (Intercept)                                                                                                  ***
    ## APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$GROUPtreatment                                                       
    ## APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYB                                                              
    ## APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYD                                                              
    ## APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYE                                                           *  
    ## APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYJ                                                              
    ## APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYL                                                              
    ## APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$GROUPtreatment:APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYB    
    ## APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$GROUPtreatment:APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYD    
    ## APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$GROUPtreatment:APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYE .  
    ## APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$GROUPtreatment:APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYJ    
    ## APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$GROUPtreatment:APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILYL    
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
    ## 
    ## Residual standard error: 0.1661 on 45 degrees of freedom
    ## Multiple R-squared:  0.3569, Adjusted R-squared:  0.1996 
    ## F-statistic:  2.27 on 11 and 45 DF,  p-value: 0.02653

``` r
APOP_PLOT_7_live_agranular_FAMILY_BAD_REMOVED_lm_interaction_leastsquares <-lsmeans(APOP_PLOT_7_live_agranular_FAMILY_BAD_REMOVED_lm_interaction, "APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILY", adjust="tukey")
cld(APOP_PLOT_7_live_agranular_FAMILY_BAD_REMOVED_lm_interaction_leastsquares, alpha=0.05, Letters=letters)
```

    ##  APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$FAMILY    lsmean         SE df
    ##  L                                                 0.9762813 0.05730227 45
    ##  J                                                 1.0151764 0.09588504 45
    ##  A                                                 1.0324399 0.05871736 45
    ##  B                                                 1.0324399 0.05871736 45
    ##  D                                                 1.0324399 0.05871736 45
    ##  E                                                 1.0324399 0.05871736 45
    ##   lower.CL upper.CL .group
    ##  0.8608686 1.091694  a    
    ##  0.8220540 1.208299  a    
    ##  0.9141771 1.150703  a    
    ##  0.9141771 1.150703  a    
    ##  0.9141771 1.150703  a    
    ##  0.9141771 1.150703  a    
    ## 
    ## Results are averaged over the levels of: APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$GROUP 
    ## Confidence level used: 0.95 
    ## P value adjustment: tukey method for comparing a family of 6 estimates 
    ## significance level used: alpha = 0.05

### One-Way Anova of just challenged

``` r
APOP_PLOT_7_live_agranular_hemocytes_BAD_REMOVED_CHALLENGE <- APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED[!grepl("control",APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$GROUP),]

APOP_PLOT_7_live_agranular_oneway_aov <- aov(APOP_PLOT_7_live_agranular_hemocytes_BAD_REMOVED_CHALLENGE$Q1.LL_Arcsine ~ APOP_PLOT_7_live_agranular_hemocytes_BAD_REMOVED_CHALLENGE$FAMILY, data=APOP_PLOT_7_live_agranular_hemocytes_BAD_REMOVED_CHALLENGE)
summary(APOP_PLOT_7_live_agranular_oneway_aov) # significantly different between families 
```

    ##                                                                   Df
    ## APOP_PLOT_7_live_agranular_hemocytes_BAD_REMOVED_CHALLENGE$FAMILY  5
    ## Residuals                                                         38
    ##                                                                   Sum Sq
    ## APOP_PLOT_7_live_agranular_hemocytes_BAD_REMOVED_CHALLENGE$FAMILY 0.4086
    ## Residuals                                                         0.9343
    ##                                                                   Mean Sq
    ## APOP_PLOT_7_live_agranular_hemocytes_BAD_REMOVED_CHALLENGE$FAMILY 0.08172
    ## Residuals                                                         0.02459
    ##                                                                   F value
    ## APOP_PLOT_7_live_agranular_hemocytes_BAD_REMOVED_CHALLENGE$FAMILY   3.324
    ## Residuals                                                                
    ##                                                                   Pr(>F)  
    ## APOP_PLOT_7_live_agranular_hemocytes_BAD_REMOVED_CHALLENGE$FAMILY 0.0138 *
    ## Residuals                                                                 
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

``` r
TukeyHSD(APOP_PLOT_7_live_agranular_oneway_aov)
```

    ##   Tukey multiple comparisons of means
    ##     95% family-wise confidence level
    ## 
    ## Fit: aov(formula = APOP_PLOT_7_live_agranular_hemocytes_BAD_REMOVED_CHALLENGE$Q1.LL_Arcsine ~ APOP_PLOT_7_live_agranular_hemocytes_BAD_REMOVED_CHALLENGE$FAMILY, data = APOP_PLOT_7_live_agranular_hemocytes_BAD_REMOVED_CHALLENGE)
    ## 
    ## $`APOP_PLOT_7_live_agranular_hemocytes_BAD_REMOVED_CHALLENGE$FAMILY`
    ##             diff         lwr        upr     p adj
    ## B-A -0.095053656 -0.33850829 0.14840098 0.8475067
    ## D-A -0.237033071 -0.49107759 0.01701145 0.0794337
    ## E-A -0.067317004 -0.31077164 0.17613763 0.9601120
    ## J-A -0.101749623 -0.33032247 0.12682323 0.7637270
    ## L-A  0.094805633 -0.14864900 0.33826027 0.8489020
    ## D-B -0.141979416 -0.40368528 0.11972645 0.5861344
    ## E-B  0.027736652 -0.22370221 0.27917552 0.9994291
    ## J-B -0.006695967 -0.24375480 0.23036287 0.9999993
    ## L-B  0.189859289 -0.06157958 0.44129815 0.2332973
    ## E-D  0.169716067 -0.09198980 0.43142194 0.3915765
    ## J-D  0.135283448 -0.11263862 0.38320551 0.5801318
    ## L-D  0.331838704  0.07013284 0.59354457 0.0062121
    ## J-E -0.034432619 -0.27149145 0.20262622 0.9978498
    ## L-E  0.162122637 -0.08931623 0.41356150 0.3979368
    ## L-J  0.196555256 -0.04050358 0.43361409 0.1534704

### Two-Way ANOVA of Live Granular vs. Agranular

``` r
live_granular <- APOP_PLOT4_GRANULAR_QUAD_PLOT_GATE_ADDED_BAD_REMOVED %>% filter(GATE=="Q2_LL")
live_agranular <- APOP_PLOT7_AGRANULAR_QUAD_PLOT_GATE_ADDED_BAD_REMOVED %>% filter(GATE=="Q1_LL")
live_granular_agranular_combined <- rbind(live_granular,live_agranular)

ggplot(live_granular_agranular_combined, aes(x=GROUP, y=PERCENT_OF_THIS_PLOT, fill=GATE)) + facet_grid(.~FAMILY+GROUP, scales="free") + geom_boxplot() + ggtitle("Percent of Granular and Agranular Live Hemocytes (low quality removed)") + ylab("Percent of Hemocyte Events in each quad plot") + scale_fill_manual(name="Hemocyte Type", labels=c("Live Granular", "Live Agranular"), values=c("Q2_LL"="#99a765","Q1_LL"="#96578a")) 
```

![](Dermo_Apoptosis_Assay_Data_analysis_files/figure-markdown_github/two_way_aov_granular_agranular-1.png)

``` r
# Two way ANOVA
live_granular_agranular_aov <- lm(live_granular_agranular_combined$Arcsine ~live_granular_agranular_combined$FAMILY + live_granular_agranular_combined$GATE, data=live_granular_agranular_combined)
Anova(live_granular_agranular_aov, type="II") #GATE and Family are significant
```

    ## Anova Table (Type II tests)
    ## 
    ## Response: live_granular_agranular_combined$Arcsine
    ##                                          Sum Sq  Df  F value    Pr(>F)    
    ## live_granular_agranular_combined$FAMILY 0.61228   5   6.8995 1.282e-05 ***
    ## live_granular_agranular_combined$GATE   2.59157   1 146.0157 < 2.2e-16 ***
    ## Residuals                               1.89910 107                       
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

``` r
summary(live_granular_agranular_aov)
```

    ## 
    ## Call:
    ## lm(formula = live_granular_agranular_combined$Arcsine ~ live_granular_agranular_combined$FAMILY + 
    ##     live_granular_agranular_combined$GATE, data = live_granular_agranular_combined)
    ## 
    ## Residuals:
    ##      Min       1Q   Median       3Q      Max 
    ## -0.55498 -0.08982 -0.00307  0.08839  0.29957 
    ## 
    ## Coefficients:
    ##                                            Estimate Std. Error t value
    ## (Intercept)                                 1.31145    0.03102  42.273
    ## live_granular_agranular_combined$FAMILYB   -0.12718    0.04234  -3.004
    ## live_granular_agranular_combined$FAMILYD   -0.14435    0.04377  -3.298
    ## live_granular_agranular_combined$FAMILYE   -0.08486    0.04234  -2.004
    ## live_granular_agranular_combined$FAMILYJ   -0.08251    0.04017  -2.054
    ## live_granular_agranular_combined$FAMILYL    0.07251    0.04234   1.713
    ## live_granular_agranular_combined$GATEQ1_LL -0.30155    0.02496 -12.084
    ##                                            Pr(>|t|)    
    ## (Intercept)                                 < 2e-16 ***
    ## live_granular_agranular_combined$FAMILYB    0.00332 ** 
    ## live_granular_agranular_combined$FAMILYD    0.00132 ** 
    ## live_granular_agranular_combined$FAMILYE    0.04757 *  
    ## live_granular_agranular_combined$FAMILYJ    0.04241 *  
    ## live_granular_agranular_combined$FAMILYL    0.08968 .  
    ## live_granular_agranular_combined$GATEQ1_LL  < 2e-16 ***
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
    ## 
    ## Residual standard error: 0.1332 on 107 degrees of freedom
    ## Multiple R-squared:  0.6278, Adjusted R-squared:  0.607 
    ## F-statistic: 30.09 on 6 and 107 DF,  p-value: < 2.2e-16

``` r
# Two- Way ANOVA 
live_granular_agranular_aov_interaction <- lm(live_granular_agranular_combined$Arcsine ~live_granular_agranular_combined$FAMILY + live_granular_agranular_combined$GATE + live_granular_agranular_combined$FAMILY:live_granular_agranular_combined$GATE, data=live_granular_agranular_combined)
Anova(live_granular_agranular_aov_interaction, type="II") #GATE and Family are significant
```

    ## Anova Table (Type II tests)
    ## 
    ## Response: live_granular_agranular_combined$Arcsine
    ##                                                                                Sum Sq
    ## live_granular_agranular_combined$FAMILY                                       0.61228
    ## live_granular_agranular_combined$GATE                                         2.59157
    ## live_granular_agranular_combined$FAMILY:live_granular_agranular_combined$GATE 0.11886
    ## Residuals                                                                     1.78024
    ##                                                                                Df
    ## live_granular_agranular_combined$FAMILY                                         5
    ## live_granular_agranular_combined$GATE                                           1
    ## live_granular_agranular_combined$FAMILY:live_granular_agranular_combined$GATE   5
    ## Residuals                                                                     102
    ##                                                                                F value
    ## live_granular_agranular_combined$FAMILY                                         7.0162
    ## live_granular_agranular_combined$GATE                                         148.4859
    ## live_granular_agranular_combined$FAMILY:live_granular_agranular_combined$GATE   1.3620
    ## Residuals                                                                             
    ##                                                                                  Pr(>F)
    ## live_granular_agranular_combined$FAMILY                                       1.133e-05
    ## live_granular_agranular_combined$GATE                                         < 2.2e-16
    ## live_granular_agranular_combined$FAMILY:live_granular_agranular_combined$GATE    0.2449
    ## Residuals                                                                              
    ##                                                                                  
    ## live_granular_agranular_combined$FAMILY                                       ***
    ## live_granular_agranular_combined$GATE                                         ***
    ## live_granular_agranular_combined$FAMILY:live_granular_agranular_combined$GATE    
    ## Residuals                                                                        
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

``` r
summary(live_granular_agranular_aov_interaction)
```

    ## 
    ## Call:
    ## lm(formula = live_granular_agranular_combined$Arcsine ~ live_granular_agranular_combined$FAMILY + 
    ##     live_granular_agranular_combined$GATE + live_granular_agranular_combined$FAMILY:live_granular_agranular_combined$GATE, 
    ##     data = live_granular_agranular_combined)
    ## 
    ## Residuals:
    ##      Min       1Q   Median       3Q      Max 
    ## -0.52606 -0.08598 -0.00238  0.07106  0.31895 
    ## 
    ## Coefficients:
    ##                                                                                     Estimate
    ## (Intercept)                                                                          1.29361
    ## live_granular_agranular_combined$FAMILYB                                            -0.14328
    ## live_granular_agranular_combined$FAMILYD                                            -0.06486
    ## live_granular_agranular_combined$FAMILYE                                            -0.03810
    ## live_granular_agranular_combined$FAMILYJ                                            -0.06377
    ## live_granular_agranular_combined$FAMILYL                                             0.06125
    ## live_granular_agranular_combined$GATEQ1_LL                                          -0.26588
    ## live_granular_agranular_combined$FAMILYB:live_granular_agranular_combined$GATEQ1_LL  0.03219
    ## live_granular_agranular_combined$FAMILYD:live_granular_agranular_combined$GATEQ1_LL -0.15898
    ## live_granular_agranular_combined$FAMILYE:live_granular_agranular_combined$GATEQ1_LL -0.09351
    ## live_granular_agranular_combined$FAMILYJ:live_granular_agranular_combined$GATEQ1_LL -0.03747
    ## live_granular_agranular_combined$FAMILYL:live_granular_agranular_combined$GATEQ1_LL  0.02253
    ##                                                                                     Std. Error
    ## (Intercept)                                                                            0.03983
    ## live_granular_agranular_combined$FAMILYB                                               0.05938
    ## live_granular_agranular_combined$FAMILYD                                               0.06139
    ## live_granular_agranular_combined$FAMILYE                                               0.05938
    ## live_granular_agranular_combined$FAMILYJ                                               0.05633
    ## live_granular_agranular_combined$FAMILYL                                               0.05938
    ## live_granular_agranular_combined$GATEQ1_LL                                             0.05633
    ## live_granular_agranular_combined$FAMILYB:live_granular_agranular_combined$GATEQ1_LL    0.08398
    ## live_granular_agranular_combined$FAMILYD:live_granular_agranular_combined$GATEQ1_LL    0.08681
    ## live_granular_agranular_combined$FAMILYE:live_granular_agranular_combined$GATEQ1_LL    0.08398
    ## live_granular_agranular_combined$FAMILYJ:live_granular_agranular_combined$GATEQ1_LL    0.07967
    ## live_granular_agranular_combined$FAMILYL:live_granular_agranular_combined$GATEQ1_LL    0.08398
    ##                                                                                     t value
    ## (Intercept)                                                                          32.476
    ## live_granular_agranular_combined$FAMILYB                                             -2.413
    ## live_granular_agranular_combined$FAMILYD                                             -1.057
    ## live_granular_agranular_combined$FAMILYE                                             -0.642
    ## live_granular_agranular_combined$FAMILYJ                                             -1.132
    ## live_granular_agranular_combined$FAMILYL                                              1.031
    ## live_granular_agranular_combined$GATEQ1_LL                                           -4.720
    ## live_granular_agranular_combined$FAMILYB:live_granular_agranular_combined$GATEQ1_LL   0.383
    ## live_granular_agranular_combined$FAMILYD:live_granular_agranular_combined$GATEQ1_LL  -1.831
    ## live_granular_agranular_combined$FAMILYE:live_granular_agranular_combined$GATEQ1_LL  -1.114
    ## live_granular_agranular_combined$FAMILYJ:live_granular_agranular_combined$GATEQ1_LL  -0.470
    ## live_granular_agranular_combined$FAMILYL:live_granular_agranular_combined$GATEQ1_LL   0.268
    ##                                                                                     Pr(>|t|)
    ## (Intercept)                                                                          < 2e-16
    ## live_granular_agranular_combined$FAMILYB                                              0.0176
    ## live_granular_agranular_combined$FAMILYD                                              0.2932
    ## live_granular_agranular_combined$FAMILYE                                              0.5225
    ## live_granular_agranular_combined$FAMILYJ                                              0.2603
    ## live_granular_agranular_combined$FAMILYL                                              0.3047
    ## live_granular_agranular_combined$GATEQ1_LL                                          7.54e-06
    ## live_granular_agranular_combined$FAMILYB:live_granular_agranular_combined$GATEQ1_LL   0.7023
    ## live_granular_agranular_combined$FAMILYD:live_granular_agranular_combined$GATEQ1_LL   0.0700
    ## live_granular_agranular_combined$FAMILYE:live_granular_agranular_combined$GATEQ1_LL   0.2681
    ## live_granular_agranular_combined$FAMILYJ:live_granular_agranular_combined$GATEQ1_LL   0.6391
    ## live_granular_agranular_combined$FAMILYL:live_granular_agranular_combined$GATEQ1_LL   0.7890
    ##                                                                                        
    ## (Intercept)                                                                         ***
    ## live_granular_agranular_combined$FAMILYB                                            *  
    ## live_granular_agranular_combined$FAMILYD                                               
    ## live_granular_agranular_combined$FAMILYE                                               
    ## live_granular_agranular_combined$FAMILYJ                                               
    ## live_granular_agranular_combined$FAMILYL                                               
    ## live_granular_agranular_combined$GATEQ1_LL                                          ***
    ## live_granular_agranular_combined$FAMILYB:live_granular_agranular_combined$GATEQ1_LL    
    ## live_granular_agranular_combined$FAMILYD:live_granular_agranular_combined$GATEQ1_LL .  
    ## live_granular_agranular_combined$FAMILYE:live_granular_agranular_combined$GATEQ1_LL    
    ## live_granular_agranular_combined$FAMILYJ:live_granular_agranular_combined$GATEQ1_LL    
    ## live_granular_agranular_combined$FAMILYL:live_granular_agranular_combined$GATEQ1_LL    
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
    ## 
    ## Residual standard error: 0.1321 on 102 degrees of freedom
    ## Multiple R-squared:  0.6511, Adjusted R-squared:  0.6135 
    ## F-statistic: 17.31 on 11 and 102 DF,  p-value: < 2.2e-16

``` r
live_granular_agranula_aov_interaction_leastsquares <- lsmeans(live_granular_agranular_aov_interaction, "live_granular_agranular_combined$GATE", adjust="tukey")
cld(live_granular_agranula_aov_interaction_leastsquares, alpha=0.05, Letters=letters) # the means of the two groups are significantly different 
```

    ##  live_granular_agranular_combined$GATE   lsmean         SE  df lower.CL
    ##  Q1_LL                                 1.269733 0.03399589 102 1.202302
    ##  Q2_LL                                 1.293613 0.03983299 102 1.214605
    ##  upper.CL .group
    ##  1.337164  a    
    ##  1.372622   b   
    ## 
    ## Results are averaged over the levels of: live_granular_agranular_combined$FAMILY 
    ## Confidence level used: 0.95 
    ## significance level used: alpha = 0.05

``` r
live_granular_agranula_aov_interaction_leastsquares_family <- lsmeans(live_granular_agranular_aov_interaction, "live_granular_agranular_combined$FAMILY", adjust="tukey")
cld(live_granular_agranula_aov_interaction_leastsquares_family, alpha=0.05, Letters=letters) # the means of the two groups are not significantly different 
```

    ##  live_granular_agranular_combined$FAMILY   lsmean         SE  df lower.CL
    ##  L                                       1.221973 0.02968976 102 1.163083
    ##  A                                       1.293613 0.03983299 102 1.214605
    ##  B                                       1.293613 0.03983299 102 1.214605
    ##  D                                       1.293613 0.03983299 102 1.214605
    ##  E                                       1.293613 0.03983299 102 1.214605
    ##  J                                       1.293613 0.03983299 102 1.214605
    ##  upper.CL .group
    ##  1.280862  a    
    ##  1.372622  a    
    ##  1.372622  a    
    ##  1.372622  a    
    ##  1.372622  a    
    ##  1.372622  a    
    ## 
    ## Results are averaged over the levels of: live_granular_agranular_combined$GATE 
    ## Confidence level used: 0.95 
    ## P value adjustment: tukey method for comparing a family of 6 estimates 
    ## significance level used: alpha = 0.05

#### Calculate Summary Statistics

``` r
full_combined <- rbind(APOP_PLOT4_GRANULAR_QUAD_PLOT_GATE_ADDED_BAD_REMOVED, APOP_PLOT7_AGRANULAR_QUAD_PLOT_GATE_ADDED_BAD_REMOVED)

full_statistics <- summarySE(data=full_combined, "PERCENT_OF_THIS_PLOT", groupvars=c("GATE", "GROUP", "cell","FAMILY"), conf.interval= 0.95)
```

#### DAY 50 APOPTOSIS DATA ANALYSIS

Load in data for each plot
--------------------------

``` r
#Load in the Data for each plot on a separate spreadsheet

DAY50_APOP_PLOT3_P1_GATE <- read.csv(file="../ANALYSIS_CSVs/APOPTOSIS_ASSAY/DAY50/PLOT3.csv", header=TRUE)
DAY50_APOP_PLOT8_GRANULAR_AGRANULAR <- read.csv(file="../ANALYSIS_CSVs/APOPTOSIS_ASSAY/DAY50/PLOT8.csv", header=TRUE)
DAY50_APOP_PLOT4_GRANULAR_QUAD_PLOT <-read.csv(file="../ANALYSIS_CSVs/APOPTOSIS_ASSAY/DAY50/PLOT4.csv", header=TRUE)
DAY50_APOP_PLOT7_AGRANULAR_QUAD_PLOT <- read.csv(file="../ANALYSIS_CSVs/APOPTOSIS_ASSAY/DAY50/PLOT7.csv", header=TRUE)

#Remove empty rows
DAY50_APOP_PLOT3_P1_GATE <- na.omit(DAY50_APOP_PLOT3_P1_GATE)
DAY50_APOP_PLOT8_GRANULAR_AGRANULAR <- na.omit(DAY50_APOP_PLOT8_GRANULAR_AGRANULAR)
DAY50_APOP_PLOT4_GRANULAR_QUAD_PLOT <- na.omit(DAY50_APOP_PLOT4_GRANULAR_QUAD_PLOT)
DAY50_APOP_PLOT7_AGRANULAR_QUAD_PLOT<- na.omit(DAY50_APOP_PLOT7_AGRANULAR_QUAD_PLOT)

## Remove percent symbol from columns 
DAY50_APOP_PLOT3_P1_GATE$P1_PERCENT_OF_THIS_PLOT <- as.numeric(gsub("\\%", "", DAY50_APOP_PLOT3_P1_GATE$P1_PERCENT_OF_THIS_PLOT))

DAY50_APOP_PLOT8_GRANULAR_AGRANULAR$P3_PERCENT_OF_THIS_PLOT<- as.numeric(gsub("\\%", "", DAY50_APOP_PLOT8_GRANULAR_AGRANULAR$P3_PERCENT_OF_THIS_PLOT))

DAY50_APOP_PLOT8_GRANULAR_AGRANULAR$P4_PERCENT_OF_THIS_PLOT<- as.numeric(gsub("\\%", "", DAY50_APOP_PLOT8_GRANULAR_AGRANULAR$P4_PERCENT_OF_THIS_PLOT))

DAY50_APOP_PLOT4_GRANULAR_QUAD_PLOT$PERCENT_OF_THIS_PLOT <- as.numeric(gsub("\\%", "", DAY50_APOP_PLOT4_GRANULAR_QUAD_PLOT$PERCENT_OF_THIS_PLOT))

DAY50_APOP_PLOT7_AGRANULAR_QUAD_PLOT$PERCENT_OF_THIS_PLOT <- as.numeric(gsub("\\%", "", DAY50_APOP_PLOT7_AGRANULAR_QUAD_PLOT$PERCENT_OF_THIS_PLOT))

# Load in Data for the samples to remove 
APOPTOSIS_Samples_Remove_day50 <- read.csv(file="../ANALYSIS_CSVs/APOPTOSIS_ASSAY/DAY50/Apoptosis_assay_remove.csv", header=TRUE)

# Data Frame with bad samples removed
DAY50_APOP_PLOT3_P1_GATE_BAD_REMOVED <- DAY50_APOP_PLOT3_P1_GATE[!DAY50_APOP_PLOT3_P1_GATE$SAMPLE_ID %in% APOPTOSIS_Samples_Remove_day50$SAMPLE_ID, , drop=FALSE]

DAY50_APOP_PLOT8_GRANULAR_AGRANULAR_BAD_REMOVED <- DAY50_APOP_PLOT8_GRANULAR_AGRANULAR[!DAY50_APOP_PLOT8_GRANULAR_AGRANULAR$SAMPLE_ID %in% APOPTOSIS_Samples_Remove_day50$SAMPLE_ID, , drop=FALSE]

DAY50_APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED <- DAY50_APOP_PLOT4_GRANULAR_QUAD_PLOT[!DAY50_APOP_PLOT4_GRANULAR_QUAD_PLOT$SAMPLE_ID %in% APOPTOSIS_Samples_Remove_day50$SAMPLE_ID, , drop=FALSE]

DAY50_APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED <- DAY50_APOP_PLOT7_AGRANULAR_QUAD_PLOT[!DAY50_APOP_PLOT7_AGRANULAR_QUAD_PLOT$SAMPLE_ID %in% APOPTOSIS_Samples_Remove_day50$SAMPLE_ID, , drop=FALSE]
```

Arc sine Percentage data
========================

``` r
# NOTE: NA's produced whenever the percentages were above 100%
DAY50_APOP_PLOT3_P1_GATE$Arcsine<- transf.arcsin(DAY50_APOP_PLOT3_P1_GATE$P1_PERCENT_OF_THIS_PLOT*0.01)
DAY50_APOP_PLOT8_GRANULAR_AGRANULAR$P3_Arcsine <- transf.arcsin(DAY50_APOP_PLOT8_GRANULAR_AGRANULAR$P3_PERCENT_OF_THIS_PLOT *0.01)
DAY50_APOP_PLOT8_GRANULAR_AGRANULAR$P4_Arcsine <- transf.arcsin(DAY50_APOP_PLOT8_GRANULAR_AGRANULAR$P4_PERCENT_OF_THIS_PLOT*0.01)
DAY50_APOP_PLOT4_GRANULAR_QUAD_PLOT$Arcsine <- transf.arcsin(DAY50_APOP_PLOT4_GRANULAR_QUAD_PLOT$PERCENT_OF_THIS_PLOT*0.01)
DAY50_APOP_PLOT7_AGRANULAR_QUAD_PLOT$Arcsine <- transf.arcsin(DAY50_APOP_PLOT7_AGRANULAR_QUAD_PLOT$PERCENT_OF_THIS_PLOT*0.01)

# Bad removed 
DAY50_APOP_PLOT3_P1_GATE_BAD_REMOVED$Arcsine<- transf.arcsin(DAY50_APOP_PLOT3_P1_GATE_BAD_REMOVED$P1_PERCENT_OF_THIS_PLOT*0.01)
DAY50_APOP_PLOT8_GRANULAR_AGRANULAR_BAD_REMOVED$P3_Arcsine <- transf.arcsin(DAY50_APOP_PLOT8_GRANULAR_AGRANULAR_BAD_REMOVED$P3_PERCENT_OF_THIS_PLOT *0.01)
DAY50_APOP_PLOT8_GRANULAR_AGRANULAR_BAD_REMOVED$P4_Arcsine <- transf.arcsin(DAY50_APOP_PLOT8_GRANULAR_AGRANULAR_BAD_REMOVED$P4_PERCENT_OF_THIS_PLOT*0.01)
DAY50_APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$Arcsine <- transf.arcsin(DAY50_APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$PERCENT_OF_THIS_PLOT*0.01)
DAY50_APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$Arcsine <- transf.arcsin(DAY50_APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$PERCENT_OF_THIS_PLOT*0.01)
```

% LIVE apoptotic granular hemocytes (PLOT4, Q2-LR)
==================================================

Percent LIVE apoptotic granular hemocytes (PLOT4, Q2-LR)
--------------------------------------------------------

``` r
DAY50_live_granular <- DAY50_APOP_PLOT4_GRANULAR_QUAD_PLOT %>% filter(GATE=="Q2_LR")
DAY50_APOP_live_apoptotic_granular_BAD_NOT_REMOVED <- ggplot(data=DAY50_live_granular, aes(x=GROUP, y=PERCENT_OF_THIS_PLOT, fill=GROUP)) + geom_boxplot() + ggtitle("Percent of Live Apoptotic Granular Hemocytes at Day 50 \n Low Quality Not Removed") +
    xlab("Family") + ylab("Percent of Hemocyte Events") + ylim(0,100)+ facet_grid(.~FAMILY+GROUP, scales="free") 

DAY50_live_granular_BAD_REMOVED <- DAY50_APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED %>% filter(GATE=="Q2_LR")
DAY50_APOP_live_apoptotic_granular_BAD_REMOVED <- ggplot(data= DAY50_live_granular_BAD_REMOVED, aes(x=GROUP, y=PERCENT_OF_THIS_PLOT, fill=GROUP)) + geom_boxplot() + ggtitle("Percent of Live Apoptotic Granular Hemocytes at Day 50 \nLow Quality Removed") + xlab("Family") + ylab("Percent of Hemocyte Events") + ylim(0,100)+ facet_grid(.~FAMILY+GROUP, scales="free") 
DAY50_APOP_live_apoptotic_granular_BAD_REMOVED
```

![](Dermo_Apoptosis_Assay_Data_analysis_files/figure-markdown_github/LIVE_apoptotic_Granular_day50-1.png)

### FAMILY A

``` r
DAY50_live_granular_FAMILY_A <- DAY50_live_granular %>% filter(FAMILY=="A")

DAY50_live_granular_FAMILY_A_aov <- aov(DAY50_live_granular_FAMILY_A$Arcsine ~ DAY50_live_granular_FAMILY_A$GROUP, data=DAY50_live_granular_FAMILY_A)
summary(DAY50_live_granular_FAMILY_A_aov)
```

    ##                                    Df  Sum Sq  Mean Sq F value Pr(>F)
    ## DAY50_live_granular_FAMILY_A$GROUP  1 0.00010 0.000095   0.024   0.88
    ## Residuals                          12 0.04815 0.004013

``` r
DAY50_live_granular_BAD_REMOVED_FAMILY_A <- DAY50_live_granular_BAD_REMOVED %>% filter(FAMILY=="A") 
DAY50_live_granular_BAD_REMOVED_FAMILY_A_aov <- aov(DAY50_live_granular_BAD_REMOVED_FAMILY_A$Arcsine ~ DAY50_live_granular_BAD_REMOVED_FAMILY_A$GROUP, data=DAY50_live_granular_BAD_REMOVED_FAMILY_A)
summary(DAY50_live_granular_BAD_REMOVED_FAMILY_A_aov)
```

    ##                                                Df  Sum Sq  Mean Sq F value
    ## DAY50_live_granular_BAD_REMOVED_FAMILY_A$GROUP  1 0.00010 0.000095   0.024
    ## Residuals                                      12 0.04815 0.004013        
    ##                                                Pr(>F)
    ## DAY50_live_granular_BAD_REMOVED_FAMILY_A$GROUP   0.88
    ## Residuals

### FAMILY B

``` r
DAY50_live_granular_FAMILY_B <- DAY50_live_granular %>% filter(FAMILY=="B")

DAY50_live_granular_FAMILY_B_aov <- aov(DAY50_live_granular_FAMILY_B$Arcsine ~ DAY50_live_granular_FAMILY_B$GROUP, data=DAY50_live_granular_FAMILY_B)
summary(DAY50_live_granular_FAMILY_B_aov)
```

    ##                                    Df   Sum Sq  Mean Sq F value Pr(>F)
    ## DAY50_live_granular_FAMILY_B$GROUP  1 0.003212 0.003212   1.284  0.279
    ## Residuals                          12 0.030030 0.002503

``` r
DAY50_live_granular_BAD_REMOVED_FAMILY_B <- DAY50_live_granular_BAD_REMOVED %>% filter(FAMILY=="B") 
DAY50_live_granular_BAD_REMOVED_FAMILY_B_aov <- aov(DAY50_live_granular_BAD_REMOVED_FAMILY_B$Arcsine ~ DAY50_live_granular_BAD_REMOVED_FAMILY_B$GROUP, data=DAY50_live_granular_BAD_REMOVED_FAMILY_B)
summary(DAY50_live_granular_BAD_REMOVED_FAMILY_B_aov)
```

    ##                                                Df   Sum Sq  Mean Sq
    ## DAY50_live_granular_BAD_REMOVED_FAMILY_B$GROUP  1 0.004414 0.004414
    ## Residuals                                      11 0.027207 0.002473
    ##                                                F value Pr(>F)
    ## DAY50_live_granular_BAD_REMOVED_FAMILY_B$GROUP   1.784  0.209
    ## Residuals

### FAMILY D

``` r
DAY50_live_granular_FAMILY_D <- DAY50_live_granular %>% filter(FAMILY=="D")

DAY50_live_granular_FAMILY_D_aov <- aov(DAY50_live_granular_FAMILY_D$Arcsine ~ DAY50_live_granular_FAMILY_D$GROUP, data=DAY50_live_granular_FAMILY_D)
summary(DAY50_live_granular_FAMILY_D_aov)
```

    ##                                    Df  Sum Sq  Mean Sq F value Pr(>F)
    ## DAY50_live_granular_FAMILY_D$GROUP  1 0.00038 0.000385   0.112  0.744
    ## Residuals                          12 0.04132 0.003444

``` r
DAY50_live_granular_BAD_REMOVED_FAMILY_D <- DAY50_live_granular_BAD_REMOVED %>% filter(FAMILY=="D") 
DAY50_live_granular_BAD_REMOVED_FAMILY_D_aov <- aov(DAY50_live_granular_BAD_REMOVED_FAMILY_D$Arcsine ~ DAY50_live_granular_BAD_REMOVED_FAMILY_D$GROUP, data=DAY50_live_granular_BAD_REMOVED_FAMILY_D)
summary(DAY50_live_granular_BAD_REMOVED_FAMILY_D_aov)
```

    ##                                                Df  Sum Sq  Mean Sq F value
    ## DAY50_live_granular_BAD_REMOVED_FAMILY_D$GROUP  1 0.00018 0.000182   0.045
    ## Residuals                                      10 0.04036 0.004036        
    ##                                                Pr(>F)
    ## DAY50_live_granular_BAD_REMOVED_FAMILY_D$GROUP  0.836
    ## Residuals

### FAMILY E

``` r
DAY50_live_granular_FAMILY_E <- DAY50_live_granular %>% filter(FAMILY=="E")

DAY50_live_granular_FAMILY_E_aov <- aov(DAY50_live_granular_FAMILY_E$Arcsine ~ DAY50_live_granular_FAMILY_E$GROUP, data=DAY50_live_granular_FAMILY_E)
summary(DAY50_live_granular_FAMILY_E_aov)
```

    ##                                    Df   Sum Sq  Mean Sq F value Pr(>F)
    ## DAY50_live_granular_FAMILY_E$GROUP  1 0.003813 0.003813   2.395  0.146
    ## Residuals                          13 0.020697 0.001592

``` r
DAY50_live_granular_BAD_REMOVED_FAMILY_E <- DAY50_live_granular_BAD_REMOVED %>% filter(FAMILY=="E") 
DAY50_live_granular_BAD_REMOVED_FAMILY_E_aov <- aov(DAY50_live_granular_BAD_REMOVED_FAMILY_E$Arcsine ~ DAY50_live_granular_BAD_REMOVED_FAMILY_E$GROUP, data=DAY50_live_granular_BAD_REMOVED_FAMILY_E)
summary(DAY50_live_granular_BAD_REMOVED_FAMILY_E_aov)
```

    ##                                                Df   Sum Sq  Mean Sq
    ## DAY50_live_granular_BAD_REMOVED_FAMILY_E$GROUP  1 0.003025 0.003025
    ## Residuals                                      12 0.020664 0.001722
    ##                                                F value Pr(>F)
    ## DAY50_live_granular_BAD_REMOVED_FAMILY_E$GROUP   1.757   0.21
    ## Residuals

### FAMILY J

``` r
DAY50_live_granular_FAMILY_J <- DAY50_live_granular %>% filter(FAMILY=="J")

DAY50_live_granular_FAMILY_J_aov <- aov(DAY50_live_granular_FAMILY_J$Arcsine ~ DAY50_live_granular_FAMILY_J$GROUP, data=DAY50_live_granular_FAMILY_J)
summary(DAY50_live_granular_FAMILY_J_aov)
```

    ##                                    Df  Sum Sq  Mean Sq F value Pr(>F)
    ## DAY50_live_granular_FAMILY_J$GROUP  1 0.00673 0.006732   1.681  0.221
    ## Residuals                          11 0.04405 0.004004

``` r
DAY50_live_granular_BAD_REMOVED_FAMILY_J <- DAY50_live_granular_BAD_REMOVED %>% filter(FAMILY=="J") 
DAY50_live_granular_BAD_REMOVED_FAMILY_J_aov <- aov(DAY50_live_granular_BAD_REMOVED_FAMILY_J$Arcsine ~ DAY50_live_granular_BAD_REMOVED_FAMILY_J$GROUP, data=DAY50_live_granular_BAD_REMOVED_FAMILY_J)
summary(DAY50_live_granular_BAD_REMOVED_FAMILY_J_aov)
```

    ##                                                Df  Sum Sq  Mean Sq F value
    ## DAY50_live_granular_BAD_REMOVED_FAMILY_J$GROUP  1 0.00814 0.008142   1.824
    ## Residuals                                       9 0.04018 0.004464        
    ##                                                Pr(>F)
    ## DAY50_live_granular_BAD_REMOVED_FAMILY_J$GROUP   0.21
    ## Residuals

### FAMILY L

``` r
DAY50_live_granular_FAMILY_L <- DAY50_live_granular %>% filter(FAMILY=="L")

DAY50_live_granular_FAMILY_L_aov <- aov(DAY50_live_granular_FAMILY_L$Arcsine ~ DAY50_live_granular_FAMILY_L$GROUP, data=DAY50_live_granular_FAMILY_L)
summary(DAY50_live_granular_FAMILY_L_aov)
```

    ##                                    Df  Sum Sq  Mean Sq F value Pr(>F)
    ## DAY50_live_granular_FAMILY_L$GROUP  1 0.00364 0.003641   0.627  0.449
    ## Residuals                           9 0.05225 0.005806

``` r
DAY50_live_granular_BAD_REMOVED_FAMILY_L <- DAY50_live_granular_BAD_REMOVED %>% filter(FAMILY=="L") 
DAY50_live_granular_BAD_REMOVED_FAMILY_L_aov <- aov(DAY50_live_granular_BAD_REMOVED_FAMILY_L$Arcsine ~ DAY50_live_granular_BAD_REMOVED_FAMILY_L$GROUP, data=DAY50_live_granular_BAD_REMOVED_FAMILY_L)
summary(DAY50_live_granular_BAD_REMOVED_FAMILY_L_aov)
```

    ##                                                Df  Sum Sq  Mean Sq F value
    ## DAY50_live_granular_BAD_REMOVED_FAMILY_L$GROUP  1 0.00364 0.003641   0.627
    ## Residuals                                       9 0.05225 0.005806        
    ##                                                Pr(>F)
    ## DAY50_live_granular_BAD_REMOVED_FAMILY_L$GROUP  0.449
    ## Residuals

### Two Way ANOVA of Live Apoptotic Granular

``` r
DAY50_APOP_PLOT4_live_granular_FAMILY_BAD_REMOVED_lm <- lm(DAY50_live_granular_BAD_REMOVED$Arcsine ~DAY50_live_granular_BAD_REMOVED$GROUP + DAY50_live_granular_BAD_REMOVED$FAMILY, data=DAY50_live_granular_BAD_REMOVED)

Anova(DAY50_APOP_PLOT4_live_granular_FAMILY_BAD_REMOVED_lm, type="II") # Family is significant
```

    ## Anova Table (Type II tests)
    ## 
    ## Response: DAY50_live_granular_BAD_REMOVED$Arcsine
    ##                                          Sum Sq Df F value   Pr(>F)   
    ## DAY50_live_granular_BAD_REMOVED$GROUP  0.000013  1  0.0036 0.952558   
    ## DAY50_live_granular_BAD_REMOVED$FAMILY 0.071680  5  3.9260 0.003469 **
    ## Residuals                              0.248304 68                    
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

``` r
summary(DAY50_APOP_PLOT4_live_granular_FAMILY_BAD_REMOVED_lm) # NO significant differences
```

    ## 
    ## Call:
    ## lm(formula = DAY50_live_granular_BAD_REMOVED$Arcsine ~ DAY50_live_granular_BAD_REMOVED$GROUP + 
    ##     DAY50_live_granular_BAD_REMOVED$FAMILY, data = DAY50_live_granular_BAD_REMOVED)
    ## 
    ## Residuals:
    ##       Min        1Q    Median        3Q       Max 
    ## -0.134763 -0.037514  0.000234  0.036758  0.134040 
    ## 
    ## Coefficients:
    ##                                                 Estimate Std. Error
    ## (Intercept)                                    0.2632045  0.0193889
    ## DAY50_live_granular_BAD_REMOVED$GROUPtreatment 0.0008969  0.0150203
    ## DAY50_live_granular_BAD_REMOVED$FAMILYB        0.0631644  0.0233220
    ## DAY50_live_granular_BAD_REMOVED$FAMILYD        0.0637725  0.0237830
    ## DAY50_live_granular_BAD_REMOVED$FAMILYE        0.0687575  0.0228396
    ## DAY50_live_granular_BAD_REMOVED$FAMILYJ        0.0870249  0.0243479
    ## DAY50_live_granular_BAD_REMOVED$FAMILYL        0.0929411  0.0243752
    ##                                                t value Pr(>|t|)    
    ## (Intercept)                                     13.575  < 2e-16 ***
    ## DAY50_live_granular_BAD_REMOVED$GROUPtreatment   0.060 0.952558    
    ## DAY50_live_granular_BAD_REMOVED$FAMILYB          2.708 0.008546 ** 
    ## DAY50_live_granular_BAD_REMOVED$FAMILYD          2.681 0.009192 ** 
    ## DAY50_live_granular_BAD_REMOVED$FAMILYE          3.010 0.003658 ** 
    ## DAY50_live_granular_BAD_REMOVED$FAMILYJ          3.574 0.000652 ***
    ## DAY50_live_granular_BAD_REMOVED$FAMILYL          3.813 0.000298 ***
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
    ## 
    ## Residual standard error: 0.06043 on 68 degrees of freedom
    ## Multiple R-squared:  0.224,  Adjusted R-squared:  0.1556 
    ## F-statistic: 3.272 on 6 and 68 DF,  p-value: 0.006914

### One-Way Anova of just challenged

``` r
DAY50_PLOT4_live_apoptotic_granular_BAD_REMOVED_CHALLENGE <- DAY50_live_granular_BAD_REMOVED[!grepl("control",DAY50_live_granular_BAD_REMOVED$GROUP),]

DAY50_PLOT4_live_apoptotic_granular_oneway_aov <- aov(DAY50_PLOT4_live_apoptotic_granular_BAD_REMOVED_CHALLENGE$Arcsine ~ DAY50_PLOT4_live_apoptotic_granular_BAD_REMOVED_CHALLENGE$FAMILY, data=DAY50_PLOT4_live_apoptotic_granular_BAD_REMOVED_CHALLENGE)
summary(DAY50_PLOT4_live_apoptotic_granular_oneway_aov) # significantly different between families 
```

    ##                                                                  Df
    ## DAY50_PLOT4_live_apoptotic_granular_BAD_REMOVED_CHALLENGE$FAMILY  5
    ## Residuals                                                        45
    ##                                                                   Sum Sq
    ## DAY50_PLOT4_live_apoptotic_granular_BAD_REMOVED_CHALLENGE$FAMILY 0.06561
    ## Residuals                                                        0.15224
    ##                                                                   Mean Sq
    ## DAY50_PLOT4_live_apoptotic_granular_BAD_REMOVED_CHALLENGE$FAMILY 0.013121
    ## Residuals                                                        0.003383
    ##                                                                  F value
    ## DAY50_PLOT4_live_apoptotic_granular_BAD_REMOVED_CHALLENGE$FAMILY   3.879
    ## Residuals                                                               
    ##                                                                   Pr(>F)
    ## DAY50_PLOT4_live_apoptotic_granular_BAD_REMOVED_CHALLENGE$FAMILY 0.00524
    ## Residuals                                                               
    ##                                                                    
    ## DAY50_PLOT4_live_apoptotic_granular_BAD_REMOVED_CHALLENGE$FAMILY **
    ## Residuals                                                          
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

``` r
TukeyHSD(DAY50_PLOT4_live_apoptotic_granular_oneway_aov)
```

    ##   Tukey multiple comparisons of means
    ##     95% family-wise confidence level
    ## 
    ## Fit: aov(formula = DAY50_PLOT4_live_apoptotic_granular_BAD_REMOVED_CHALLENGE$Arcsine ~ DAY50_PLOT4_live_apoptotic_granular_BAD_REMOVED_CHALLENGE$FAMILY, data = DAY50_PLOT4_live_apoptotic_granular_BAD_REMOVED_CHALLENGE)
    ## 
    ## $`DAY50_PLOT4_live_apoptotic_granular_BAD_REMOVED_CHALLENGE$FAMILY`
    ##             diff         lwr        upr     p adj
    ## B-A  0.046858428 -0.03524726 0.12896412 0.5399614
    ## D-A  0.059323651 -0.02278204 0.14142934 0.2811102
    ## E-A  0.057810825 -0.01959916 0.13522081 0.2479443
    ## J-A  0.102046262  0.01994057 0.18415195 0.0072854
    ## L-A  0.104974521  0.01967287 0.19027617 0.0080841
    ## D-B  0.012465223 -0.07408178 0.09901222 0.9980368
    ## E-B  0.010952397 -0.07115330 0.09305809 0.9986408
    ## J-B  0.055187834 -0.03135917 0.14173483 0.4168360
    ## L-B  0.058116093 -0.03146856 0.14770075 0.3975858
    ## E-D -0.001512826 -0.08361852 0.08059287 0.9999999
    ## J-D  0.042722611 -0.04382439 0.12926961 0.6851545
    ## L-D  0.045650870 -0.04393378 0.13523552 0.6556919
    ## J-E  0.044235437 -0.03787026 0.12634113 0.6006860
    ## L-E  0.047163696 -0.03813796 0.13246535 0.5737874
    ## L-J  0.002928259 -0.08665640 0.09251291 0.9999987

### Live Apoptotic Agranular

Percent LIVE apoptotic agranular hemocytes (PLOT4, Q2-LR)
---------------------------------------------------------

``` r
DAY50_live_agranular <- DAY50_APOP_PLOT7_AGRANULAR_QUAD_PLOT %>% filter(GATE=="Q1_LR")
DAY50_APOP_live_apoptotic_agranular_BAD_NOT_REMOVED <- ggplot(data=DAY50_live_agranular, aes(x=GROUP, y=PERCENT_OF_THIS_PLOT, fill=GROUP)) + geom_boxplot() + ggtitle("Percent of Live Apoptotic Agranular Hemocytes at Day 50 \n Low Quality Not Removed") +
    xlab("Family") + ylab("Percent of Hemocyte Events") + ylim(0,100)+ facet_grid(.~FAMILY+GROUP, scales="free") 

DAY50_live_agranular_BAD_REMOVED <- DAY50_APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED %>% filter(GATE=="Q1_LR")
DAY50_APOP_live_apoptotic_agranular_BAD_REMOVED <- ggplot(data= DAY50_live_agranular_BAD_REMOVED, aes(x=GROUP, y=PERCENT_OF_THIS_PLOT, fill=GROUP)) + geom_boxplot() + ggtitle("Percent of Live Apoptotic Agranular Hemocytes at Day 50 \nLow Quality Removed") + xlab("Family") + ylab("Percent of Hemocyte Events") + ylim(0,100)+ facet_grid(.~FAMILY+GROUP, scales="free") 
DAY50_APOP_live_apoptotic_agranular_BAD_REMOVED
```

![](Dermo_Apoptosis_Assay_Data_analysis_files/figure-markdown_github/LIVE_apoptotic_agrranular-1.png)

### FAMILY A

``` r
DAY50_live_agranular_FAMILY_A <- DAY50_live_agranular %>% filter(FAMILY=="A")

DAY50_live_agranular_FAMILY_A_aov <- aov(DAY50_live_agranular_FAMILY_A$Arcsine ~ DAY50_live_agranular_FAMILY_A$GROUP, data=DAY50_live_agranular_FAMILY_A)
summary(DAY50_live_agranular_FAMILY_A_aov)
```

    ##                                     Df  Sum Sq   Mean Sq F value Pr(>F)
    ## DAY50_live_agranular_FAMILY_A$GROUP  1 0.00041 0.0004119   0.135   0.72
    ## Residuals                           12 0.03661 0.0030506

``` r
DAY50_live_agranular_BAD_REMOVED_FAMILY_A <- DAY50_live_agranular_BAD_REMOVED %>% filter(FAMILY=="A") 
DAY50_live_agranular_BAD_REMOVED_FAMILY_A_aov <- aov(DAY50_live_agranular_BAD_REMOVED_FAMILY_A$Arcsine ~ DAY50_live_agranular_BAD_REMOVED_FAMILY_A$GROUP, data=DAY50_live_agranular_BAD_REMOVED_FAMILY_A)
summary(DAY50_live_agranular_BAD_REMOVED_FAMILY_A_aov)
```

    ##                                                 Df  Sum Sq   Mean Sq
    ## DAY50_live_agranular_BAD_REMOVED_FAMILY_A$GROUP  1 0.00041 0.0004119
    ## Residuals                                       12 0.03661 0.0030506
    ##                                                 F value Pr(>F)
    ## DAY50_live_agranular_BAD_REMOVED_FAMILY_A$GROUP   0.135   0.72
    ## Residuals

### FAMILY B

``` r
DAY50_live_agranular_FAMILY_B <- DAY50_live_agranular %>% filter(FAMILY=="B")

DAY50_live_agranular_FAMILY_B_aov <- aov(DAY50_live_agranular_FAMILY_B$Arcsine ~ DAY50_live_granular_FAMILY_B$GROUP, data=DAY50_live_agranular_FAMILY_B)
summary(DAY50_live_agranular_FAMILY_B_aov)
```

    ##                                    Df  Sum Sq  Mean Sq F value Pr(>F)
    ## DAY50_live_granular_FAMILY_B$GROUP  1 0.01175 0.011751   1.595  0.231
    ## Residuals                          12 0.08841 0.007367

``` r
DAY50_live_agranular_BAD_REMOVED_FAMILY_B <- DAY50_live_agranular_BAD_REMOVED %>% filter(FAMILY=="B") 
DAY50_live_agranular_BAD_REMOVED_FAMILY_B_aov <- aov(DAY50_live_agranular_BAD_REMOVED_FAMILY_B$Arcsine ~ DAY50_live_agranular_BAD_REMOVED_FAMILY_B$GROUP, data=DAY50_live_agranular_BAD_REMOVED_FAMILY_B)
summary(DAY50_live_agranular_BAD_REMOVED_FAMILY_B_aov)
```

    ##                                                 Df  Sum Sq  Mean Sq
    ## DAY50_live_agranular_BAD_REMOVED_FAMILY_B$GROUP  1 0.01733 0.017329
    ## Residuals                                       11 0.07310 0.006646
    ##                                                 F value Pr(>F)
    ## DAY50_live_agranular_BAD_REMOVED_FAMILY_B$GROUP   2.608  0.135
    ## Residuals

### FAMILY D

``` r
DAY50_live_agranular_FAMILY_D <- DAY50_live_agranular %>% filter(FAMILY=="D")

DAY50_live_agranular_FAMILY_D_aov <- aov(DAY50_live_agranular_FAMILY_D$Arcsine ~ DAY50_live_agranular_FAMILY_D$GROUP, data=DAY50_live_agranular_FAMILY_D)
summary(DAY50_live_agranular_FAMILY_D_aov)
```

    ##                                     Df  Sum Sq  Mean Sq F value Pr(>F)
    ## DAY50_live_agranular_FAMILY_D$GROUP  1 0.01015 0.010154    2.27  0.158
    ## Residuals                           12 0.05368 0.004473

``` r
DAY50_live_agranular_BAD_REMOVED_FAMILY_D <- DAY50_live_agranular_BAD_REMOVED %>% filter(FAMILY=="D") 
DAY50_live_agranular_BAD_REMOVED_FAMILY_D_aov <- aov(DAY50_live_agranular_BAD_REMOVED_FAMILY_D$Arcsine ~ DAY50_live_agranular_BAD_REMOVED_FAMILY_D$GROUP, data=DAY50_live_agranular_BAD_REMOVED_FAMILY_D)
summary(DAY50_live_agranular_BAD_REMOVED_FAMILY_D_aov)
```

    ##                                                 Df  Sum Sq  Mean Sq
    ## DAY50_live_agranular_BAD_REMOVED_FAMILY_D$GROUP  1 0.00469 0.004692
    ## Residuals                                       10 0.04011 0.004011
    ##                                                 F value Pr(>F)
    ## DAY50_live_agranular_BAD_REMOVED_FAMILY_D$GROUP    1.17  0.305
    ## Residuals

### FAMILY E

``` r
DAY50_live_agranular_FAMILY_E <- DAY50_live_agranular %>% filter(FAMILY=="E")

DAY50_live_agranular_FAMILY_E_aov <- aov(DAY50_live_agranular_FAMILY_E$Arcsine ~ DAY50_live_agranular_FAMILY_E$GROUP, data=DAY50_live_agranular_FAMILY_E)
summary(DAY50_live_agranular_FAMILY_E_aov)
```

    ##                                     Df  Sum Sq  Mean Sq F value Pr(>F)
    ## DAY50_live_agranular_FAMILY_E$GROUP  1 0.00556 0.005565    1.94  0.187
    ## Residuals                           13 0.03729 0.002869

``` r
DAY50_live_agranular_BAD_REMOVED_FAMILY_E <- DAY50_live_agranular_BAD_REMOVED %>% filter(FAMILY=="E") 
DAY50_live_agranular_BAD_REMOVED_FAMILY_E_aov <- aov(DAY50_live_agranular_BAD_REMOVED_FAMILY_E$Arcsine ~ DAY50_live_agranular_BAD_REMOVED_FAMILY_E$GROUP, data=DAY50_live_agranular_BAD_REMOVED_FAMILY_E)
summary(DAY50_live_agranular_BAD_REMOVED_FAMILY_E_aov)
```

    ##                                                 Df  Sum Sq  Mean Sq
    ## DAY50_live_agranular_BAD_REMOVED_FAMILY_E$GROUP  1 0.00224 0.002240
    ## Residuals                                       12 0.03398 0.002832
    ##                                                 F value Pr(>F)
    ## DAY50_live_agranular_BAD_REMOVED_FAMILY_E$GROUP   0.791  0.391
    ## Residuals

### FAMILY J

``` r
DAY50_live_agranular_FAMILY_J <- DAY50_live_agranular %>% filter(FAMILY=="J")

DAY50_live_agranular_FAMILY_J_aov <- aov(DAY50_live_agranular_FAMILY_J$Arcsine ~ DAY50_live_agranular_FAMILY_J$GROUP, data=DAY50_live_agranular_FAMILY_J)
summary(DAY50_live_agranular_FAMILY_J_aov)
```

    ##                                     Df  Sum Sq  Mean Sq F value Pr(>F)
    ## DAY50_live_agranular_FAMILY_J$GROUP  1 0.00004 0.000039   0.005  0.942
    ## Residuals                           11 0.07731 0.007028

``` r
DAY50_live_agranular_BAD_REMOVED_FAMILY_J <- DAY50_live_agranular_BAD_REMOVED %>% filter(FAMILY=="J") 
DAY50_live_agranular_BAD_REMOVED_FAMILY_J_aov <- aov(DAY50_live_agranular_BAD_REMOVED_FAMILY_J$Arcsine ~ DAY50_live_agranular_BAD_REMOVED_FAMILY_J$GROUP, data=DAY50_live_agranular_BAD_REMOVED_FAMILY_J)
summary(DAY50_live_agranular_BAD_REMOVED_FAMILY_J_aov)
```

    ##                                                 Df  Sum Sq  Mean Sq
    ## DAY50_live_agranular_BAD_REMOVED_FAMILY_J$GROUP  1 0.00069 0.000689
    ## Residuals                                        9 0.05439 0.006043
    ##                                                 F value Pr(>F)
    ## DAY50_live_agranular_BAD_REMOVED_FAMILY_J$GROUP   0.114  0.743
    ## Residuals

### FAMILY L

``` r
DAY50_live_agranular_FAMILY_L <- DAY50_live_agranular %>% filter(FAMILY=="L")

DAY50_live_agranular_FAMILY_L_aov <- aov(DAY50_live_agranular_FAMILY_L$Arcsine ~ DAY50_live_agranular_FAMILY_L$GROUP, data=DAY50_live_agranular_FAMILY_L)
summary(DAY50_live_agranular_FAMILY_L_aov)
```

    ##                                     Df  Sum Sq  Mean Sq F value Pr(>F)
    ## DAY50_live_agranular_FAMILY_L$GROUP  1 0.00689 0.006893   0.807  0.392
    ## Residuals                            9 0.07688 0.008543

``` r
DAY50_live_agranular_BAD_REMOVED_FAMILY_L <- DAY50_live_agranular_BAD_REMOVED %>% filter(FAMILY=="L") 
DAY50_live_agranular_BAD_REMOVED_FAMILY_L_aov <- aov(DAY50_live_agranular_BAD_REMOVED_FAMILY_L$Arcsine ~ DAY50_live_agranular_BAD_REMOVED_FAMILY_L$GROUP, data=DAY50_live_agranular_BAD_REMOVED_FAMILY_L)
summary(DAY50_live_agranular_BAD_REMOVED_FAMILY_L_aov)
```

    ##                                                 Df  Sum Sq  Mean Sq
    ## DAY50_live_agranular_BAD_REMOVED_FAMILY_L$GROUP  1 0.00689 0.006893
    ## Residuals                                        9 0.07688 0.008543
    ##                                                 F value Pr(>F)
    ## DAY50_live_agranular_BAD_REMOVED_FAMILY_L$GROUP   0.807  0.392
    ## Residuals

### Two Way ANOVA of Live Apoptotic Agranular

``` r
DAY50_APOP_PLOT7_live_apoptotic_agranular_BAD_REMOVED_lm <- lm(DAY50_live_agranular_BAD_REMOVED$Arcsine ~DAY50_live_agranular_BAD_REMOVED$GROUP +DAY50_live_agranular_BAD_REMOVED$FAMILY, data=DAY50_live_agranular_BAD_REMOVED)

Anova(DAY50_APOP_PLOT7_live_apoptotic_agranular_BAD_REMOVED_lm, type="II") # Family is significant
```

    ## Anova Table (Type II tests)
    ## 
    ## Response: DAY50_live_agranular_BAD_REMOVED$Arcsine
    ##                                          Sum Sq Df F value    Pr(>F)    
    ## DAY50_live_agranular_BAD_REMOVED$GROUP  0.00292  1  0.5755    0.4507    
    ## DAY50_live_agranular_BAD_REMOVED$FAMILY 0.29108  5 11.4940 4.626e-08 ***
    ## Residuals                               0.34441 68                      
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

``` r
summary(DAY50_APOP_PLOT7_live_apoptotic_agranular_BAD_REMOVED_lm) # Family is significant
```

    ## 
    ## Call:
    ## lm(formula = DAY50_live_agranular_BAD_REMOVED$Arcsine ~ DAY50_live_agranular_BAD_REMOVED$GROUP + 
    ##     DAY50_live_agranular_BAD_REMOVED$FAMILY, data = DAY50_live_agranular_BAD_REMOVED)
    ## 
    ## Residuals:
    ##      Min       1Q   Median       3Q      Max 
    ## -0.14162 -0.04767  0.00006  0.03971  0.16363 
    ## 
    ## Coefficients:
    ##                                                 Estimate Std. Error
    ## (Intercept)                                      0.18323    0.02283
    ## DAY50_live_agranular_BAD_REMOVED$GROUPtreatment -0.01342    0.01769
    ## DAY50_live_agranular_BAD_REMOVED$FAMILYB         0.09582    0.02747
    ## DAY50_live_agranular_BAD_REMOVED$FAMILYD         0.02465    0.02801
    ## DAY50_live_agranular_BAD_REMOVED$FAMILYE         0.08362    0.02690
    ## DAY50_live_agranular_BAD_REMOVED$FAMILYJ         0.07473    0.02868
    ## DAY50_live_agranular_BAD_REMOVED$FAMILYL         0.20152    0.02871
    ##                                                 t value Pr(>|t|)    
    ## (Intercept)                                       8.024 1.98e-11 ***
    ## DAY50_live_agranular_BAD_REMOVED$GROUPtreatment  -0.759 0.450688    
    ## DAY50_live_agranular_BAD_REMOVED$FAMILYB          3.489 0.000856 ***
    ## DAY50_live_agranular_BAD_REMOVED$FAMILYD          0.880 0.381954    
    ## DAY50_live_agranular_BAD_REMOVED$FAMILYE          3.109 0.002744 ** 
    ## DAY50_live_agranular_BAD_REMOVED$FAMILYJ          2.606 0.011243 *  
    ## DAY50_live_agranular_BAD_REMOVED$FAMILYL          7.020 1.31e-09 ***
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
    ## 
    ## Residual standard error: 0.07117 on 68 degrees of freedom
    ## Multiple R-squared:  0.4634, Adjusted R-squared:  0.416 
    ## F-statistic: 9.786 on 6 and 68 DF,  p-value: 9.304e-08

``` r
# Interaction
DAY50_APOP_PLOT7_live_apoptotic_agranular_BAD_REMOVED_lm <- lm(DAY50_live_agranular_BAD_REMOVED$Arcsine ~DAY50_live_agranular_BAD_REMOVED$GROUP + DAY50_live_agranular_BAD_REMOVED$FAMILY + DAY50_live_agranular_BAD_REMOVED$GROUP:DAY50_live_agranular_BAD_REMOVED$FAMILY , data=DAY50_live_agranular_BAD_REMOVED)
Anova(DAY50_APOP_PLOT7_live_apoptotic_agranular_BAD_REMOVED_lm, type="II") # Family is significant
```

    ## Anova Table (Type II tests)
    ## 
    ## Response: DAY50_live_agranular_BAD_REMOVED$Arcsine
    ##                                                                                  Sum Sq
    ## DAY50_live_agranular_BAD_REMOVED$GROUP                                         0.002915
    ## DAY50_live_agranular_BAD_REMOVED$FAMILY                                        0.291077
    ## DAY50_live_agranular_BAD_REMOVED$GROUP:DAY50_live_agranular_BAD_REMOVED$FAMILY 0.029339
    ## Residuals                                                                      0.315070
    ##                                                                                Df
    ## DAY50_live_agranular_BAD_REMOVED$GROUP                                          1
    ## DAY50_live_agranular_BAD_REMOVED$FAMILY                                         5
    ## DAY50_live_agranular_BAD_REMOVED$GROUP:DAY50_live_agranular_BAD_REMOVED$FAMILY  5
    ## Residuals                                                                      63
    ##                                                                                F value
    ## DAY50_live_agranular_BAD_REMOVED$GROUP                                          0.5829
    ## DAY50_live_agranular_BAD_REMOVED$FAMILY                                        11.6405
    ## DAY50_live_agranular_BAD_REMOVED$GROUP:DAY50_live_agranular_BAD_REMOVED$FAMILY  1.1733
    ## Residuals                                                                             
    ##                                                                                   Pr(>F)
    ## DAY50_live_agranular_BAD_REMOVED$GROUP                                            0.4480
    ## DAY50_live_agranular_BAD_REMOVED$FAMILY                                        5.513e-08
    ## DAY50_live_agranular_BAD_REMOVED$GROUP:DAY50_live_agranular_BAD_REMOVED$FAMILY    0.3323
    ## Residuals                                                                               
    ##                                                                                   
    ## DAY50_live_agranular_BAD_REMOVED$GROUP                                            
    ## DAY50_live_agranular_BAD_REMOVED$FAMILY                                        ***
    ## DAY50_live_agranular_BAD_REMOVED$GROUP:DAY50_live_agranular_BAD_REMOVED$FAMILY    
    ## Residuals                                                                         
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

``` r
summary(DAY50_APOP_PLOT7_live_apoptotic_agranular_BAD_REMOVED_lm) 
```

    ## 
    ## Call:
    ## lm(formula = DAY50_live_agranular_BAD_REMOVED$Arcsine ~ DAY50_live_agranular_BAD_REMOVED$GROUP + 
    ##     DAY50_live_agranular_BAD_REMOVED$FAMILY + DAY50_live_agranular_BAD_REMOVED$GROUP:DAY50_live_agranular_BAD_REMOVED$FAMILY, 
    ##     data = DAY50_live_agranular_BAD_REMOVED)
    ## 
    ## Residuals:
    ##      Min       1Q   Median       3Q      Max 
    ## -0.12924 -0.04299 -0.01047  0.04263  0.14373 
    ## 
    ## Coefficients:
    ##                                                                                           Estimate
    ## (Intercept)                                                                               0.165066
    ## DAY50_live_agranular_BAD_REMOVED$GROUPtreatment                                           0.012007
    ## DAY50_live_agranular_BAD_REMOVED$FAMILYB                                                  0.151907
    ## DAY50_live_agranular_BAD_REMOVED$FAMILYD                                                  0.061828
    ## DAY50_live_agranular_BAD_REMOVED$FAMILYE                                                  0.112193
    ## DAY50_live_agranular_BAD_REMOVED$FAMILYJ                                                  0.070205
    ## DAY50_live_agranular_BAD_REMOVED$FAMILYL                                                  0.178026
    ## DAY50_live_agranular_BAD_REMOVED$GROUPtreatment:DAY50_live_agranular_BAD_REMOVED$FAMILYB -0.087053
    ## DAY50_live_agranular_BAD_REMOVED$GROUPtreatment:DAY50_live_agranular_BAD_REMOVED$FAMILYD -0.053952
    ## DAY50_live_agranular_BAD_REMOVED$GROUPtreatment:DAY50_live_agranular_BAD_REMOVED$FAMILYE -0.040004
    ## DAY50_live_agranular_BAD_REMOVED$GROUPtreatment:DAY50_live_agranular_BAD_REMOVED$FAMILYJ  0.005768
    ## DAY50_live_agranular_BAD_REMOVED$GROUPtreatment:DAY50_live_agranular_BAD_REMOVED$FAMILYL  0.040031
    ##                                                                                          Std. Error
    ## (Intercept)                                                                                0.035359
    ## DAY50_live_agranular_BAD_REMOVED$GROUPtreatment                                            0.041838
    ## DAY50_live_agranular_BAD_REMOVED$FAMILYB                                                   0.047439
    ## DAY50_live_agranular_BAD_REMOVED$FAMILYD                                                   0.050006
    ## DAY50_live_agranular_BAD_REMOVED$FAMILYE                                                   0.050006
    ## DAY50_live_agranular_BAD_REMOVED$FAMILYJ                                                   0.054012
    ## DAY50_live_agranular_BAD_REMOVED$FAMILYL                                                   0.050006
    ## DAY50_live_agranular_BAD_REMOVED$GROUPtreatment:DAY50_live_agranular_BAD_REMOVED$FAMILYB   0.058101
    ## DAY50_live_agranular_BAD_REMOVED$GROUPtreatment:DAY50_live_agranular_BAD_REMOVED$FAMILYD   0.060215
    ## DAY50_live_agranular_BAD_REMOVED$GROUPtreatment:DAY50_live_agranular_BAD_REMOVED$FAMILYE   0.059167
    ## DAY50_live_agranular_BAD_REMOVED$GROUPtreatment:DAY50_live_agranular_BAD_REMOVED$FAMILYJ   0.063581
    ## DAY50_live_agranular_BAD_REMOVED$GROUPtreatment:DAY50_live_agranular_BAD_REMOVED$FAMILYL   0.060952
    ##                                                                                          t value
    ## (Intercept)                                                                                4.668
    ## DAY50_live_agranular_BAD_REMOVED$GROUPtreatment                                            0.287
    ## DAY50_live_agranular_BAD_REMOVED$FAMILYB                                                   3.202
    ## DAY50_live_agranular_BAD_REMOVED$FAMILYD                                                   1.236
    ## DAY50_live_agranular_BAD_REMOVED$FAMILYE                                                   2.244
    ## DAY50_live_agranular_BAD_REMOVED$FAMILYJ                                                   1.300
    ## DAY50_live_agranular_BAD_REMOVED$FAMILYL                                                   3.560
    ## DAY50_live_agranular_BAD_REMOVED$GROUPtreatment:DAY50_live_agranular_BAD_REMOVED$FAMILYB  -1.498
    ## DAY50_live_agranular_BAD_REMOVED$GROUPtreatment:DAY50_live_agranular_BAD_REMOVED$FAMILYD  -0.896
    ## DAY50_live_agranular_BAD_REMOVED$GROUPtreatment:DAY50_live_agranular_BAD_REMOVED$FAMILYE  -0.676
    ## DAY50_live_agranular_BAD_REMOVED$GROUPtreatment:DAY50_live_agranular_BAD_REMOVED$FAMILYJ   0.091
    ## DAY50_live_agranular_BAD_REMOVED$GROUPtreatment:DAY50_live_agranular_BAD_REMOVED$FAMILYL   0.657
    ##                                                                                          Pr(>|t|)
    ## (Intercept)                                                                              1.64e-05
    ## DAY50_live_agranular_BAD_REMOVED$GROUPtreatment                                          0.775064
    ## DAY50_live_agranular_BAD_REMOVED$FAMILYB                                                 0.002139
    ## DAY50_live_agranular_BAD_REMOVED$FAMILYD                                                 0.220891
    ## DAY50_live_agranular_BAD_REMOVED$FAMILYE                                                 0.028382
    ## DAY50_live_agranular_BAD_REMOVED$FAMILYJ                                                 0.198403
    ## DAY50_live_agranular_BAD_REMOVED$FAMILYL                                                 0.000712
    ## DAY50_live_agranular_BAD_REMOVED$GROUPtreatment:DAY50_live_agranular_BAD_REMOVED$FAMILYB 0.139052
    ## DAY50_live_agranular_BAD_REMOVED$GROUPtreatment:DAY50_live_agranular_BAD_REMOVED$FAMILYD 0.373663
    ## DAY50_live_agranular_BAD_REMOVED$GROUPtreatment:DAY50_live_agranular_BAD_REMOVED$FAMILYE 0.501447
    ## DAY50_live_agranular_BAD_REMOVED$GROUPtreatment:DAY50_live_agranular_BAD_REMOVED$FAMILYJ 0.928006
    ## DAY50_live_agranular_BAD_REMOVED$GROUPtreatment:DAY50_live_agranular_BAD_REMOVED$FAMILYL 0.513727
    ##                                                                                             
    ## (Intercept)                                                                              ***
    ## DAY50_live_agranular_BAD_REMOVED$GROUPtreatment                                             
    ## DAY50_live_agranular_BAD_REMOVED$FAMILYB                                                 ** 
    ## DAY50_live_agranular_BAD_REMOVED$FAMILYD                                                    
    ## DAY50_live_agranular_BAD_REMOVED$FAMILYE                                                 *  
    ## DAY50_live_agranular_BAD_REMOVED$FAMILYJ                                                    
    ## DAY50_live_agranular_BAD_REMOVED$FAMILYL                                                 ***
    ## DAY50_live_agranular_BAD_REMOVED$GROUPtreatment:DAY50_live_agranular_BAD_REMOVED$FAMILYB    
    ## DAY50_live_agranular_BAD_REMOVED$GROUPtreatment:DAY50_live_agranular_BAD_REMOVED$FAMILYD    
    ## DAY50_live_agranular_BAD_REMOVED$GROUPtreatment:DAY50_live_agranular_BAD_REMOVED$FAMILYE    
    ## DAY50_live_agranular_BAD_REMOVED$GROUPtreatment:DAY50_live_agranular_BAD_REMOVED$FAMILYJ    
    ## DAY50_live_agranular_BAD_REMOVED$GROUPtreatment:DAY50_live_agranular_BAD_REMOVED$FAMILYL    
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
    ## 
    ## Residual standard error: 0.07072 on 63 degrees of freedom
    ## Multiple R-squared:  0.5091, Adjusted R-squared:  0.4234 
    ## F-statistic: 5.939 on 11 and 63 DF,  p-value: 1.559e-06

``` r
DAY50_APOP_PLOT7_live_apoptotic_agranular_FAMILY_BAD_REMOVED_lm_interaction_leastsquares <-lsmeans(DAY50_APOP_PLOT7_live_apoptotic_agranular_BAD_REMOVED_lm, "DAY50_live_agranular_BAD_REMOVED$FAMILY", adjust="tukey")
cld(DAY50_APOP_PLOT7_live_apoptotic_agranular_FAMILY_BAD_REMOVED_lm_interaction_leastsquares, alpha=0.05, Letters=letters)
```

    ##  DAY50_live_agranular_BAD_REMOVED$FAMILY    lsmean         SE df
    ##  A                                       0.1650656 0.03535926 63
    ##  B                                       0.1650656 0.03535926 63
    ##  D                                       0.1770725 0.02236316 63
    ##  E                                       0.1770725 0.02236316 63
    ##  J                                       0.1770725 0.02236316 63
    ##  L                                       0.1770725 0.02236316 63
    ##    lower.CL  upper.CL .group
    ##  0.09440578 0.2357255  a    
    ##  0.09440578 0.2357255  a    
    ##  0.13238327 0.2217617  a    
    ##  0.13238327 0.2217617  a    
    ##  0.13238327 0.2217617  a    
    ##  0.13238327 0.2217617  a    
    ## 
    ## Results are averaged over the levels of: DAY50_live_agranular_BAD_REMOVED$GROUP 
    ## Confidence level used: 0.95 
    ## P value adjustment: tukey method for comparing a family of 6 estimates 
    ## significance level used: alpha = 0.05

### One-Way Anova of just challenged

``` r
DAY50_PLOT7_live_apoptotic_agranular_BAD_REMOVED_CHALLENGE <- DAY50_live_agranular_BAD_REMOVED[!grepl("control",DAY50_live_agranular_BAD_REMOVED$GROUP),]

DAY50_PLOT7_live_apoptotic_agranular_oneway_aov <- aov(DAY50_PLOT7_live_apoptotic_agranular_BAD_REMOVED_CHALLENGE$Arcsine ~ DAY50_PLOT7_live_apoptotic_agranular_BAD_REMOVED_CHALLENGE$FAMILY, data=DAY50_PLOT7_live_apoptotic_agranular_BAD_REMOVED_CHALLENGE)
summary(DAY50_PLOT7_live_apoptotic_agranular_oneway_aov) 
```

    ##                                                                   Df
    ## DAY50_PLOT7_live_apoptotic_agranular_BAD_REMOVED_CHALLENGE$FAMILY  5
    ## Residuals                                                         45
    ##                                                                   Sum Sq
    ## DAY50_PLOT7_live_apoptotic_agranular_BAD_REMOVED_CHALLENGE$FAMILY 0.2335
    ## Residuals                                                         0.2455
    ##                                                                   Mean Sq
    ## DAY50_PLOT7_live_apoptotic_agranular_BAD_REMOVED_CHALLENGE$FAMILY 0.04670
    ## Residuals                                                         0.00545
    ##                                                                   F value
    ## DAY50_PLOT7_live_apoptotic_agranular_BAD_REMOVED_CHALLENGE$FAMILY   8.563
    ## Residuals                                                                
    ##                                                                     Pr(>F)
    ## DAY50_PLOT7_live_apoptotic_agranular_BAD_REMOVED_CHALLENGE$FAMILY 9.28e-06
    ## Residuals                                                                 
    ##                                                                      
    ## DAY50_PLOT7_live_apoptotic_agranular_BAD_REMOVED_CHALLENGE$FAMILY ***
    ## Residuals                                                            
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

``` r
TukeyHSD(DAY50_PLOT7_live_apoptotic_agranular_oneway_aov)
```

    ##   Tukey multiple comparisons of means
    ##     95% family-wise confidence level
    ## 
    ## Fit: aov(formula = DAY50_PLOT7_live_apoptotic_agranular_BAD_REMOVED_CHALLENGE$Arcsine ~ DAY50_PLOT7_live_apoptotic_agranular_BAD_REMOVED_CHALLENGE$FAMILY, data = DAY50_PLOT7_live_apoptotic_agranular_BAD_REMOVED_CHALLENGE)
    ## 
    ## $`DAY50_PLOT7_live_apoptotic_agranular_BAD_REMOVED_CHALLENGE$FAMILY`
    ##             diff         lwr        upr     p adj
    ## B-A  0.064854781 -0.03939966 0.16910922 0.4445813
    ## D-A  0.007875618 -0.09637882 0.11213006 0.9999155
    ## E-A  0.072189225 -0.02610281 0.17048126 0.2645087
    ## J-A  0.075973146 -0.02828130 0.18022759 0.2723855
    ## L-A  0.218057093  0.10974455 0.32636964 0.0000046
    ## D-B -0.056979162 -0.16687299 0.05291467 0.6390137
    ## E-B  0.007334445 -0.09692000 0.11158889 0.9999406
    ## J-B  0.011118366 -0.09877547 0.12101220 0.9996446
    ## L-B  0.153202312  0.03945139 0.26695323 0.0029387
    ## E-D  0.064313607 -0.03994083 0.16856805 0.4539740
    ## J-D  0.068097528 -0.04179630 0.17799136 0.4489428
    ## L-D  0.210181475  0.09643055 0.32393240 0.0000245
    ## J-E  0.003783921 -0.10047052 0.10803836 0.9999978
    ## L-E  0.145867868  0.03755533 0.25418041 0.0029411
    ## L-J  0.142083946  0.02833302 0.25583487 0.0069088

### Two Way ANOVA of Live Apoptotic Cells

``` r
DAY50_live_granular_agranular_combined <- rbind(DAY50_live_agranular_BAD_REMOVED,DAY50_live_granular_BAD_REMOVED)

ggplot(DAY50_live_granular_agranular_combined, aes(x=GROUP, y=PERCENT_OF_THIS_PLOT, fill=GATE)) + facet_grid(.~FAMILY+GROUP, scales="free") + geom_boxplot() + ggtitle("Percent of Granular and Agranular Live Apoptotic Hemocytes at Day 50 (low quality removed)") + ylab("Percent of Hemocyte Events in each quad plot") + scale_fill_manual(name="Hemocyte Type", labels=c("Live Agranular", "Live Granular"), values=c("Q1_LR"="#99a765","Q2_LR"="#96578a")) 
```

![](Dermo_Apoptosis_Assay_Data_analysis_files/figure-markdown_github/day50_live_apoptotic_cells_twoway-1.png)

``` r
# Two way ANOVA
DAY50_live_granular_agranular_aov <- lm(DAY50_live_granular_agranular_combined$Arcsine ~DAY50_live_granular_agranular_combined$FAMILY + DAY50_live_granular_agranular_combined$GATE, data=DAY50_live_granular_agranular_combined)
Anova(DAY50_live_granular_agranular_aov, type="II") #GATE and Family are significant
```

    ## Anova Table (Type II tests)
    ## 
    ## Response: DAY50_live_granular_agranular_combined$Arcsine
    ##                                                Sum Sq  Df F value
    ## DAY50_live_granular_agranular_combined$FAMILY 0.29174   5  12.452
    ## DAY50_live_granular_agranular_combined$GATE   0.20212   1  43.135
    ## Residuals                                     0.67007 143        
    ##                                                  Pr(>F)    
    ## DAY50_live_granular_agranular_combined$FAMILY 4.889e-10 ***
    ## DAY50_live_granular_agranular_combined$GATE   8.819e-10 ***
    ## Residuals                                                  
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

``` r
summary(DAY50_live_granular_agranular_aov)
```

    ## 
    ## Call:
    ## lm(formula = DAY50_live_granular_agranular_combined$Arcsine ~ 
    ##     DAY50_live_granular_agranular_combined$FAMILY + DAY50_live_granular_agranular_combined$GATE, 
    ##     data = DAY50_live_granular_agranular_combined)
    ## 
    ## Residuals:
    ##       Min        1Q    Median        3Q       Max 
    ## -0.180890 -0.044606  0.002478  0.035771  0.205203 
    ## 
    ## Coefficients:
    ##                                                  Estimate Std. Error
    ## (Intercept)                                       0.18204    0.01409
    ## DAY50_live_granular_agranular_combined$FAMILYB    0.08011    0.01864
    ## DAY50_live_granular_agranular_combined$FAMILYD    0.04451    0.01904
    ## DAY50_live_granular_agranular_combined$FAMILYE    0.07619    0.01829
    ## DAY50_live_granular_agranular_combined$FAMILYJ    0.08080    0.01950
    ## DAY50_live_granular_agranular_combined$FAMILYL    0.14772    0.01950
    ## DAY50_live_granular_agranular_combined$GATEQ2_LR  0.07342    0.01118
    ##                                                  t value Pr(>|t|)    
    ## (Intercept)                                       12.918  < 2e-16 ***
    ## DAY50_live_granular_agranular_combined$FAMILYB     4.297 3.18e-05 ***
    ## DAY50_live_granular_agranular_combined$FAMILYD     2.337   0.0208 *  
    ## DAY50_live_granular_agranular_combined$FAMILYE     4.164 5.37e-05 ***
    ## DAY50_live_granular_agranular_combined$FAMILYJ     4.143 5.84e-05 ***
    ## DAY50_live_granular_agranular_combined$FAMILYL     7.574 4.10e-12 ***
    ## DAY50_live_granular_agranular_combined$GATEQ2_LR   6.568 8.82e-10 ***
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
    ## 
    ## Residual standard error: 0.06845 on 143 degrees of freedom
    ## Multiple R-squared:  0.4243, Adjusted R-squared:  0.4001 
    ## F-statistic: 17.57 on 6 and 143 DF,  p-value: 3.557e-15

``` r
# Two- Way ANOVA 
DAY50_live_granular_agranular_aov_interaction <- lm(DAY50_live_granular_agranular_combined$Arcsine ~DAY50_live_granular_agranular_combined$FAMILY + DAY50_live_granular_agranular_combined$GATE + DAY50_live_granular_agranular_combined$FAMILY:DAY50_live_granular_agranular_combined$GATE, data=DAY50_live_granular_agranular_combined)
Anova(DAY50_live_granular_agranular_aov_interaction, type="II") #GATE,Family, and interaction are significant
```

    ## Anova Table (Type II tests)
    ## 
    ## Response: DAY50_live_granular_agranular_combined$Arcsine
    ##                                                                                            Sum Sq
    ## DAY50_live_granular_agranular_combined$FAMILY                                             0.29174
    ## DAY50_live_granular_agranular_combined$GATE                                               0.20212
    ## DAY50_live_granular_agranular_combined$FAMILY:DAY50_live_granular_agranular_combined$GATE 0.07443
    ## Residuals                                                                                 0.59564
    ##                                                                                            Df
    ## DAY50_live_granular_agranular_combined$FAMILY                                               5
    ## DAY50_live_granular_agranular_combined$GATE                                                 1
    ## DAY50_live_granular_agranular_combined$FAMILY:DAY50_live_granular_agranular_combined$GATE   5
    ## Residuals                                                                                 138
    ##                                                                                           F value
    ## DAY50_live_granular_agranular_combined$FAMILY                                             13.5181
    ## DAY50_live_granular_agranular_combined$GATE                                               46.8280
    ## DAY50_live_granular_agranular_combined$FAMILY:DAY50_live_granular_agranular_combined$GATE  3.4487
    ## Residuals                                                                                        
    ##                                                                                              Pr(>F)
    ## DAY50_live_granular_agranular_combined$FAMILY                                             9.885e-11
    ## DAY50_live_granular_agranular_combined$GATE                                               2.319e-10
    ## DAY50_live_granular_agranular_combined$FAMILY:DAY50_live_granular_agranular_combined$GATE  0.005736
    ## Residuals                                                                                          
    ##                                                                                              
    ## DAY50_live_granular_agranular_combined$FAMILY                                             ***
    ## DAY50_live_granular_agranular_combined$GATE                                               ***
    ## DAY50_live_granular_agranular_combined$FAMILY:DAY50_live_granular_agranular_combined$GATE ** 
    ## Residuals                                                                                    
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

``` r
summary(DAY50_live_granular_agranular_aov_interaction)
```

    ## 
    ## Call:
    ## lm(formula = DAY50_live_granular_agranular_combined$Arcsine ~ 
    ##     DAY50_live_granular_agranular_combined$FAMILY + DAY50_live_granular_agranular_combined$GATE + 
    ##         DAY50_live_granular_agranular_combined$FAMILY:DAY50_live_granular_agranular_combined$GATE, 
    ##     data = DAY50_live_granular_agranular_combined)
    ## 
    ## Residuals:
    ##       Min        1Q    Median        3Q       Max 
    ## -0.146780 -0.038538  0.000541  0.037350  0.158750 
    ## 
    ## Coefficients:
    ##                                                                                                 Estimate
    ## (Intercept)                                                                                      0.17364
    ## DAY50_live_granular_agranular_combined$FAMILYB                                                   0.09715
    ## DAY50_live_granular_agranular_combined$FAMILYD                                                   0.02529
    ## DAY50_live_granular_agranular_combined$FAMILYE                                                   0.08362
    ## DAY50_live_granular_agranular_combined$FAMILYJ                                                   0.07456
    ## DAY50_live_granular_agranular_combined$FAMILYL                                                   0.20256
    ## DAY50_live_granular_agranular_combined$GATEQ2_LR                                                 0.09020
    ## DAY50_live_granular_agranular_combined$FAMILYB:DAY50_live_granular_agranular_combined$GATEQ2_LR -0.03407
    ## DAY50_live_granular_agranular_combined$FAMILYD:DAY50_live_granular_agranular_combined$GATEQ2_LR  0.03844
    ## DAY50_live_granular_agranular_combined$FAMILYE:DAY50_live_granular_agranular_combined$GATEQ2_LR -0.01486
    ## DAY50_live_granular_agranular_combined$FAMILYJ:DAY50_live_granular_agranular_combined$GATEQ2_LR  0.01248
    ## DAY50_live_granular_agranular_combined$FAMILYL:DAY50_live_granular_agranular_combined$GATEQ2_LR -0.10969
    ##                                                                                                 Std. Error
    ## (Intercept)                                                                                        0.01756
    ## DAY50_live_granular_agranular_combined$FAMILYB                                                     0.02530
    ## DAY50_live_granular_agranular_combined$FAMILYD                                                     0.02585
    ## DAY50_live_granular_agranular_combined$FAMILYE                                                     0.02483
    ## DAY50_live_granular_agranular_combined$FAMILYJ                                                     0.02647
    ## DAY50_live_granular_agranular_combined$FAMILYL                                                     0.02647
    ## DAY50_live_granular_agranular_combined$GATEQ2_LR                                                   0.02483
    ## DAY50_live_granular_agranular_combined$FAMILYB:DAY50_live_granular_agranular_combined$GATEQ2_LR    0.03579
    ## DAY50_live_granular_agranular_combined$FAMILYD:DAY50_live_granular_agranular_combined$GATEQ2_LR    0.03655
    ## DAY50_live_granular_agranular_combined$FAMILYE:DAY50_live_granular_agranular_combined$GATEQ2_LR    0.03512
    ## DAY50_live_granular_agranular_combined$FAMILYJ:DAY50_live_granular_agranular_combined$GATEQ2_LR    0.03743
    ## DAY50_live_granular_agranular_combined$FAMILYL:DAY50_live_granular_agranular_combined$GATEQ2_LR    0.03743
    ##                                                                                                 t value
    ## (Intercept)                                                                                       9.889
    ## DAY50_live_granular_agranular_combined$FAMILYB                                                    3.839
    ## DAY50_live_granular_agranular_combined$FAMILYD                                                    0.978
    ## DAY50_live_granular_agranular_combined$FAMILYE                                                    3.367
    ## DAY50_live_granular_agranular_combined$FAMILYJ                                                    2.817
    ## DAY50_live_granular_agranular_combined$FAMILYL                                                    7.652
    ## DAY50_live_granular_agranular_combined$GATEQ2_LR                                                  3.633
    ## DAY50_live_granular_agranular_combined$FAMILYB:DAY50_live_granular_agranular_combined$GATEQ2_LR  -0.952
    ## DAY50_live_granular_agranular_combined$FAMILYD:DAY50_live_granular_agranular_combined$GATEQ2_LR   1.052
    ## DAY50_live_granular_agranular_combined$FAMILYE:DAY50_live_granular_agranular_combined$GATEQ2_LR  -0.423
    ## DAY50_live_granular_agranular_combined$FAMILYJ:DAY50_live_granular_agranular_combined$GATEQ2_LR   0.333
    ## DAY50_live_granular_agranular_combined$FAMILYL:DAY50_live_granular_agranular_combined$GATEQ2_LR  -2.930
    ##                                                                                                 Pr(>|t|)
    ## (Intercept)                                                                                      < 2e-16
    ## DAY50_live_granular_agranular_combined$FAMILYB                                                  0.000187
    ## DAY50_live_granular_agranular_combined$FAMILYD                                                  0.329574
    ## DAY50_live_granular_agranular_combined$FAMILYE                                                  0.000983
    ## DAY50_live_granular_agranular_combined$FAMILYJ                                                  0.005566
    ## DAY50_live_granular_agranular_combined$FAMILYL                                                  3.07e-12
    ## DAY50_live_granular_agranular_combined$GATEQ2_LR                                                0.000395
    ## DAY50_live_granular_agranular_combined$FAMILYB:DAY50_live_granular_agranular_combined$GATEQ2_LR 0.342691
    ## DAY50_live_granular_agranular_combined$FAMILYD:DAY50_live_granular_agranular_combined$GATEQ2_LR 0.294762
    ## DAY50_live_granular_agranular_combined$FAMILYE:DAY50_live_granular_agranular_combined$GATEQ2_LR 0.672814
    ## DAY50_live_granular_agranular_combined$FAMILYJ:DAY50_live_granular_agranular_combined$GATEQ2_LR 0.739345
    ## DAY50_live_granular_agranular_combined$FAMILYL:DAY50_live_granular_agranular_combined$GATEQ2_LR 0.003965
    ##                                                                                                    
    ## (Intercept)                                                                                     ***
    ## DAY50_live_granular_agranular_combined$FAMILYB                                                  ***
    ## DAY50_live_granular_agranular_combined$FAMILYD                                                     
    ## DAY50_live_granular_agranular_combined$FAMILYE                                                  ***
    ## DAY50_live_granular_agranular_combined$FAMILYJ                                                  ** 
    ## DAY50_live_granular_agranular_combined$FAMILYL                                                  ***
    ## DAY50_live_granular_agranular_combined$GATEQ2_LR                                                ***
    ## DAY50_live_granular_agranular_combined$FAMILYB:DAY50_live_granular_agranular_combined$GATEQ2_LR    
    ## DAY50_live_granular_agranular_combined$FAMILYD:DAY50_live_granular_agranular_combined$GATEQ2_LR    
    ## DAY50_live_granular_agranular_combined$FAMILYE:DAY50_live_granular_agranular_combined$GATEQ2_LR    
    ## DAY50_live_granular_agranular_combined$FAMILYJ:DAY50_live_granular_agranular_combined$GATEQ2_LR    
    ## DAY50_live_granular_agranular_combined$FAMILYL:DAY50_live_granular_agranular_combined$GATEQ2_LR ** 
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
    ## 
    ## Residual standard error: 0.0657 on 138 degrees of freedom
    ## Multiple R-squared:  0.4882, Adjusted R-squared:  0.4475 
    ## F-statistic: 11.97 on 11 and 138 DF,  p-value: 1.534e-15

``` r
DAY50_live_granular_agranula_aov_interaction_leastsquares <- lsmeans(DAY50_live_granular_agranular_aov_interaction, pairwise ~ DAY50_live_granular_agranular_combined$FAMILY:DAY50_live_granular_agranular_combined$GATE, adjust="tukey")
cld(DAY50_live_granular_agranula_aov_interaction_leastsquares, alpha=0.05, Letters=letters) # the means of the two groups are significantly different 
```

    ##  DAY50_live_granular_agranular_combined$FAMILY
    ##  A                                            
    ##  B                                            
    ##  D                                            
    ##  E                                            
    ##  J                                            
    ##  L                                            
    ##  A                                            
    ##  B                                            
    ##  D                                            
    ##  E                                            
    ##  J                                            
    ##  L                                            
    ##  DAY50_live_granular_agranular_combined$GATE    lsmean         SE  df
    ##  Q1_LR                                       0.1736419 0.01755856 138
    ##  Q1_LR                                       0.1736419 0.01755856 138
    ##  Q1_LR                                       0.1736419 0.01755856 138
    ##  Q1_LR                                       0.1736419 0.01755856 138
    ##  Q1_LR                                       0.1736419 0.01755856 138
    ##  Q1_LR                                       0.1736419 0.01755856 138
    ##  Q2_LR                                       0.1736419 0.01755856 138
    ##  Q2_LR                                       0.1736419 0.01755856 138
    ##  Q2_LR                                       0.1736419 0.01755856 138
    ##  Q2_LR                                       0.1736419 0.01755856 138
    ##  Q2_LR                                       0.1736419 0.01755856 138
    ##  Q2_LR                                       0.1736419 0.01755856 138
    ##   lower.CL  upper.CL .group
    ##  0.1389234 0.2083605  a    
    ##  0.1389234 0.2083605  a    
    ##  0.1389234 0.2083605  a    
    ##  0.1389234 0.2083605  a    
    ##  0.1389234 0.2083605  a    
    ##  0.1389234 0.2083605  a    
    ##  0.1389234 0.2083605  a    
    ##  0.1389234 0.2083605  a    
    ##  0.1389234 0.2083605  a    
    ##  0.1389234 0.2083605  a    
    ##  0.1389234 0.2083605  a    
    ##  0.1389234 0.2083605  a    
    ## 
    ## Confidence level used: 0.95 
    ## P value adjustment: tukey method for comparing a family of 12 estimates 
    ## significance level used: alpha = 0.05

``` r
DAY50_live_granular_agranula_aov_interaction_leastsquares_family <- lsmeans(DAY50_live_granular_agranular_aov_interaction, "DAY50_live_granular_agranular_combined$FAMILY", adjust="tukey")
cld(DAY50_live_granular_agranula_aov_interaction_leastsquares_family, alpha=0.05, Letters=letters) # the means of the groups are not significantly different 
```

    ##  DAY50_live_granular_agranular_combined$FAMILY    lsmean         SE  df
    ##  A                                             0.1736419 0.01755856 138
    ##  B                                             0.1736419 0.01755856 138
    ##  D                                             0.1736419 0.01755856 138
    ##  E                                             0.1736419 0.01755856 138
    ##  J                                             0.1736419 0.01755856 138
    ##  L                                             0.1736419 0.01755856 138
    ##   lower.CL  upper.CL .group
    ##  0.1389234 0.2083605  a    
    ##  0.1389234 0.2083605  a    
    ##  0.1389234 0.2083605  a    
    ##  0.1389234 0.2083605  a    
    ##  0.1389234 0.2083605  a    
    ##  0.1389234 0.2083605  a    
    ## 
    ## Results are averaged over the levels of: DAY50_live_granular_agranular_combined$GATE 
    ## Confidence level used: 0.95 
    ## P value adjustment: tukey method for comparing a family of 6 estimates 
    ## significance level used: alpha = 0.05

``` r
DAY50_live_granular_agranula_aov_interaction_leastsquares_GATE <- lsmeans(DAY50_live_granular_agranular_aov_interaction, "DAY50_live_granular_agranular_combined$GATE", adjust="tukey")
cld(DAY50_live_granular_agranula_aov_interaction_leastsquares_GATE, alpha=0.05, Letters=letters) # the means of the groups are not significantly different 
```

    ##  DAY50_live_granular_agranular_combined$GATE    lsmean         SE  df
    ##  Q1_LR                                       0.1736419 0.01755856 138
    ##  Q2_LR                                       0.1736419 0.01755856 138
    ##   lower.CL  upper.CL .group
    ##  0.1389234 0.2083605  a    
    ##  0.1389234 0.2083605  a    
    ## 
    ## Results are averaged over the levels of: DAY50_live_granular_agranular_combined$FAMILY 
    ## Confidence level used: 0.95 
    ## significance level used: alpha = 0.05

### % Dead Apoptotic Granular Hemocytes

Percent Dead apoptotic granular hemocytes (PLOT4, Q2-LR)
--------------------------------------------------------

``` r
DAY50_dead_granular <- DAY50_APOP_PLOT4_GRANULAR_QUAD_PLOT %>% filter(GATE=="Q2_UR")
DAY50_APOP_dead_apoptotic_granular_BAD_NOT_REMOVED <- ggplot(data=DAY50_dead_granular, aes(x=GROUP, y=PERCENT_OF_THIS_PLOT, fill=GROUP)) + geom_boxplot() + ggtitle("Percent of Dead Apoptotic Granular Hemocytes at Day 50 \n Low Quality Not Removed") +
    xlab("Family") + ylab("Percent of Hemocyte Events") + ylim(0,100)+ facet_grid(.~FAMILY+GROUP, scales="free") 

DAY50_dead_granular_BAD_REMOVED <- DAY50_APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED %>% filter(GATE=="Q2_UR")
DAY50_APOP_dead_apoptotic_granular_BAD_REMOVED <- ggplot(data= DAY50_dead_granular_BAD_REMOVED, aes(x=GROUP, y=PERCENT_OF_THIS_PLOT, fill=GROUP)) + geom_boxplot() + ggtitle("Percent of Dead Apoptotic Granular Hemocytes at Day 50 \nLow Quality Removed") + xlab("Family") + ylab("Percent of Hemocyte Events") + ylim(0,100)+ facet_grid(.~FAMILY+GROUP, scales="free") 
DAY50_APOP_dead_apoptotic_granular_BAD_REMOVED
```

![](Dermo_Apoptosis_Assay_Data_analysis_files/figure-markdown_github/dead_apoptotic_granular_day50-1.png)

### FAMILY A

``` r
DAY50_dead_granular_FAMILY_A <- DAY50_dead_granular %>% filter(FAMILY=="A")

DAY50_dead_granular_FAMILY_A_aov <- aov(DAY50_dead_granular_FAMILY_A$Arcsine ~ DAY50_dead_granular_FAMILY_A$GROUP, data=DAY50_dead_granular_FAMILY_A)
summary(DAY50_dead_granular_FAMILY_A_aov)
```

    ##                                    Df   Sum Sq  Mean Sq F value Pr(>F)
    ## DAY50_dead_granular_FAMILY_A$GROUP  1 0.001685 0.001685   1.279   0.28
    ## Residuals                          12 0.015813 0.001318

``` r
DAY50_dead_granular_BAD_REMOVED_FAMILY_A <- DAY50_dead_granular_BAD_REMOVED %>% filter(FAMILY=="A") 
DAY50_dead_granular_BAD_REMOVED_FAMILY_A_aov <- aov(DAY50_dead_granular_BAD_REMOVED_FAMILY_A$Arcsine ~ DAY50_dead_granular_BAD_REMOVED_FAMILY_A$GROUP, data=DAY50_dead_granular_BAD_REMOVED_FAMILY_A)
summary(DAY50_dead_granular_BAD_REMOVED_FAMILY_A_aov)
```

    ##                                                Df   Sum Sq  Mean Sq
    ## DAY50_dead_granular_BAD_REMOVED_FAMILY_A$GROUP  1 0.001685 0.001685
    ## Residuals                                      12 0.015813 0.001318
    ##                                                F value Pr(>F)
    ## DAY50_dead_granular_BAD_REMOVED_FAMILY_A$GROUP   1.279   0.28
    ## Residuals

### FAMILY B

``` r
DAY50_dead_granular_FAMILY_B <- DAY50_dead_granular %>% filter(FAMILY=="B")

DAY50_dead_granular_FAMILY_B_aov <- aov(DAY50_dead_granular_FAMILY_B$Arcsine ~ DAY50_dead_granular_FAMILY_B$GROUP, data=DAY50_dead_granular_FAMILY_B)
summary(DAY50_dead_granular_FAMILY_B_aov)
```

    ##                                    Df   Sum Sq   Mean Sq F value Pr(>F)
    ## DAY50_dead_granular_FAMILY_B$GROUP  1 0.000323 0.0003234   0.195  0.667
    ## Residuals                          12 0.019896 0.0016580

``` r
DAY50_dead_granular_BAD_REMOVED_FAMILY_B <- DAY50_dead_granular_BAD_REMOVED %>% filter(FAMILY=="B") 
DAY50_dead_granular_BAD_REMOVED_FAMILY_B_aov <- aov(DAY50_dead_granular_BAD_REMOVED_FAMILY_B$Arcsine ~ DAY50_dead_granular_BAD_REMOVED_FAMILY_B$GROUP, data=DAY50_dead_granular_BAD_REMOVED_FAMILY_B)
summary(DAY50_dead_granular_BAD_REMOVED_FAMILY_B_aov)
```

    ##                                                Df   Sum Sq   Mean Sq
    ## DAY50_dead_granular_BAD_REMOVED_FAMILY_B$GROUP  1 0.000009 0.0000092
    ## Residuals                                      11 0.014934 0.0013576
    ##                                                F value Pr(>F)
    ## DAY50_dead_granular_BAD_REMOVED_FAMILY_B$GROUP   0.007  0.936
    ## Residuals

### FAMILY D

``` r
DAY50_dead_granular_FAMILY_D <- DAY50_dead_granular %>% filter(FAMILY=="D")

DAY50_dead_granular_FAMILY_D_aov <- aov(DAY50_dead_granular_FAMILY_D$Arcsine ~ DAY50_dead_granular_FAMILY_D$GROUP, data=DAY50_dead_granular_FAMILY_D)
summary(DAY50_dead_granular_FAMILY_D_aov)
```

    ##                                    Df  Sum Sq  Mean Sq F value Pr(>F)
    ## DAY50_dead_granular_FAMILY_D$GROUP  1 0.00152 0.001522    0.34  0.571
    ## Residuals                          12 0.05377 0.004481

``` r
DAY50_dead_granular_BAD_REMOVED_FAMILY_D <- DAY50_dead_granular_BAD_REMOVED %>% filter(FAMILY=="D") 
DAY50_dead_granular_BAD_REMOVED_FAMILY_D_aov <- aov(DAY50_dead_granular_BAD_REMOVED_FAMILY_D$Arcsine ~ DAY50_dead_granular_BAD_REMOVED_FAMILY_D$GROUP, data=DAY50_dead_granular_BAD_REMOVED_FAMILY_D)
summary(DAY50_dead_granular_BAD_REMOVED_FAMILY_D_aov)
```

    ##                                                Df  Sum Sq  Mean Sq F value
    ## DAY50_dead_granular_BAD_REMOVED_FAMILY_D$GROUP  1 0.00536 0.005355   1.234
    ## Residuals                                      10 0.04341 0.004341        
    ##                                                Pr(>F)
    ## DAY50_dead_granular_BAD_REMOVED_FAMILY_D$GROUP  0.293
    ## Residuals

### FAMILY E

``` r
DAY50_dead_granular_FAMILY_E <- DAY50_dead_granular %>% filter(FAMILY=="E")

DAY50_dead_granular_FAMILY_E_aov <- aov(DAY50_dead_granular_FAMILY_E$Arcsine ~ DAY50_dead_granular_FAMILY_E$GROUP, data=DAY50_dead_granular_FAMILY_E)
summary(DAY50_dead_granular_FAMILY_E_aov)
```

    ##                                    Df  Sum Sq Mean Sq F value Pr(>F)
    ## DAY50_dead_granular_FAMILY_E$GROUP  1 0.00001 6.4e-06   0.002  0.963
    ## Residuals                          13 0.03770 2.9e-03

``` r
DAY50_dead_granular_BAD_REMOVED_FAMILY_E <- DAY50_dead_granular_BAD_REMOVED %>% filter(FAMILY=="E") 
DAY50_dead_granular_BAD_REMOVED_FAMILY_E_aov <- aov(DAY50_dead_granular_BAD_REMOVED_FAMILY_E$Arcsine ~ DAY50_dead_granular_BAD_REMOVED_FAMILY_E$GROUP, data=DAY50_dead_granular_BAD_REMOVED_FAMILY_E)
summary(DAY50_dead_granular_BAD_REMOVED_FAMILY_E_aov)
```

    ##                                                Df  Sum Sq   Mean Sq
    ## DAY50_dead_granular_BAD_REMOVED_FAMILY_E$GROUP  1 0.00038 0.0003755
    ## Residuals                                      12 0.03440 0.0028663
    ##                                                F value Pr(>F)
    ## DAY50_dead_granular_BAD_REMOVED_FAMILY_E$GROUP   0.131  0.724
    ## Residuals

### FAMILY J

``` r
DAY50_dead_granular_FAMILY_J <- DAY50_dead_granular %>% filter(FAMILY=="J")

DAY50_dead_granular_FAMILY_J_aov <- aov(DAY50_dead_granular_FAMILY_J$Arcsine ~ DAY50_dead_granular_FAMILY_J$GROUP, data=DAY50_dead_granular_FAMILY_J)
summary(DAY50_dead_granular_FAMILY_J_aov)
```

    ##                                    Df  Sum Sq  Mean Sq F value Pr(>F)
    ## DAY50_dead_granular_FAMILY_J$GROUP  1 0.00221 0.002213   0.474  0.506
    ## Residuals                          11 0.05140 0.004673

``` r
DAY50_dead_granular_BAD_REMOVED_FAMILY_J <- DAY50_dead_granular_BAD_REMOVED %>% filter(FAMILY=="J") 
DAY50_dead_granular_BAD_REMOVED_FAMILY_J_aov <- aov(DAY50_dead_granular_BAD_REMOVED_FAMILY_J$Arcsine ~ DAY50_dead_granular_BAD_REMOVED_FAMILY_J$GROUP, data=DAY50_dead_granular_BAD_REMOVED_FAMILY_J)
summary(DAY50_dead_granular_BAD_REMOVED_FAMILY_J_aov)
```

    ##                                                Df  Sum Sq  Mean Sq F value
    ## DAY50_dead_granular_BAD_REMOVED_FAMILY_J$GROUP  1 0.00344 0.003436   0.929
    ## Residuals                                       9 0.03330 0.003700        
    ##                                                Pr(>F)
    ## DAY50_dead_granular_BAD_REMOVED_FAMILY_J$GROUP   0.36
    ## Residuals

### FAMILY L

``` r
DAY50_dead_granular_FAMILY_L <- DAY50_dead_granular %>% filter(FAMILY=="L")

DAY50_dead_granular_FAMILY_L_aov <- aov(DAY50_dead_granular_FAMILY_L$Arcsine ~ DAY50_dead_granular_FAMILY_L$GROUP, data=DAY50_dead_granular_FAMILY_L)
summary(DAY50_dead_granular_FAMILY_L_aov)
```

    ##                                    Df   Sum Sq   Mean Sq F value Pr(>F)
    ## DAY50_dead_granular_FAMILY_L$GROUP  1 0.000364 0.0003639   0.153  0.705
    ## Residuals                           9 0.021468 0.0023854

``` r
DAY50_dead_granular_BAD_REMOVED_FAMILY_L <- DAY50_dead_granular_BAD_REMOVED %>% filter(FAMILY=="L") 
DAY50_dead_granular_BAD_REMOVED_FAMILY_L_aov <- aov(DAY50_dead_granular_BAD_REMOVED_FAMILY_L$Arcsine ~ DAY50_dead_granular_BAD_REMOVED_FAMILY_L$GROUP, data=DAY50_dead_granular_BAD_REMOVED_FAMILY_L)
summary(DAY50_dead_granular_BAD_REMOVED_FAMILY_L_aov)
```

    ##                                                Df   Sum Sq   Mean Sq
    ## DAY50_dead_granular_BAD_REMOVED_FAMILY_L$GROUP  1 0.000364 0.0003639
    ## Residuals                                       9 0.021468 0.0023854
    ##                                                F value Pr(>F)
    ## DAY50_dead_granular_BAD_REMOVED_FAMILY_L$GROUP   0.153  0.705
    ## Residuals

### Two-Way ANOVA of Dead Apoptotic Granular

``` r
DAY50_PLOT4_dead_apoptotic_granular_BAD_REMOVED_lm <- lm(DAY50_dead_granular_BAD_REMOVED$Arcsine ~DAY50_dead_granular_BAD_REMOVED$GROUP +DAY50_dead_granular_BAD_REMOVED$FAMILY, data=DAY50_dead_granular_BAD_REMOVED)

Anova(DAY50_PLOT4_dead_apoptotic_granular_BAD_REMOVED_lm, type="II") # Family is significant
```

    ## Anova Table (Type II tests)
    ## 
    ## Response: DAY50_dead_granular_BAD_REMOVED$Arcsine
    ##                                          Sum Sq Df F value    Pr(>F)    
    ## DAY50_dead_granular_BAD_REMOVED$GROUP  0.004952  1  1.9855 0.1633639    
    ## DAY50_dead_granular_BAD_REMOVED$FAMILY 0.062746  5  5.0316 0.0005563 ***
    ## Residuals                              0.169596 68                      
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

``` r
summary(DAY50_PLOT4_dead_apoptotic_granular_BAD_REMOVED_lm) # Family is significant
```

    ## 
    ## Call:
    ## lm(formula = DAY50_dead_granular_BAD_REMOVED$Arcsine ~ DAY50_dead_granular_BAD_REMOVED$GROUP + 
    ##     DAY50_dead_granular_BAD_REMOVED$FAMILY, data = DAY50_dead_granular_BAD_REMOVED)
    ## 
    ## Residuals:
    ##       Min        1Q    Median        3Q       Max 
    ## -0.101656 -0.032182 -0.000046  0.028324  0.172513 
    ## 
    ## Coefficients:
    ##                                                 Estimate Std. Error
    ## (Intercept)                                     0.156089   0.016024
    ## DAY50_dead_granular_BAD_REMOVED$GROUPtreatment  0.017492   0.012414
    ## DAY50_dead_granular_BAD_REMOVED$FAMILYB        -0.052416   0.019274
    ## DAY50_dead_granular_BAD_REMOVED$FAMILYD         0.035527   0.019655
    ## DAY50_dead_granular_BAD_REMOVED$FAMILYE         0.018807   0.018876
    ## DAY50_dead_granular_BAD_REMOVED$FAMILYJ         0.001579   0.020122
    ## DAY50_dead_granular_BAD_REMOVED$FAMILYL        -0.027188   0.020145
    ##                                                t value Pr(>|t|)    
    ## (Intercept)                                      9.741 1.58e-14 ***
    ## DAY50_dead_granular_BAD_REMOVED$GROUPtreatment   1.409  0.16336    
    ## DAY50_dead_granular_BAD_REMOVED$FAMILYB         -2.719  0.00829 ** 
    ## DAY50_dead_granular_BAD_REMOVED$FAMILYD          1.807  0.07511 .  
    ## DAY50_dead_granular_BAD_REMOVED$FAMILYE          0.996  0.32262    
    ## DAY50_dead_granular_BAD_REMOVED$FAMILYJ          0.078  0.93770    
    ## DAY50_dead_granular_BAD_REMOVED$FAMILYL         -1.350  0.18161    
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
    ## 
    ## Residual standard error: 0.04994 on 68 degrees of freedom
    ## Multiple R-squared:  0.2925, Adjusted R-squared:  0.2301 
    ## F-statistic: 4.685 on 6 and 68 DF,  p-value: 0.0004811

``` r
# Interaction
DAY50_PLOT4_dead_apoptotic_granular_BAD_REMOVED_lm <- lm(DAY50_dead_granular_BAD_REMOVED$Arcsine ~DAY50_dead_granular_BAD_REMOVED$GROUP + DAY50_dead_granular_BAD_REMOVED$FAMILY + DAY50_dead_granular_BAD_REMOVED$GROUP:DAY50_dead_granular_BAD_REMOVED$FAMILY , data=DAY50_dead_granular_BAD_REMOVED)
Anova(DAY50_PLOT4_dead_apoptotic_granular_BAD_REMOVED_lm, type="II") # Family is significant
```

    ## Anova Table (Type II tests)
    ## 
    ## Response: DAY50_dead_granular_BAD_REMOVED$Arcsine
    ##                                                                                Sum Sq
    ## DAY50_dead_granular_BAD_REMOVED$GROUP                                        0.004952
    ## DAY50_dead_granular_BAD_REMOVED$FAMILY                                       0.062746
    ## DAY50_dead_granular_BAD_REMOVED$GROUP:DAY50_dead_granular_BAD_REMOVED$FAMILY 0.006273
    ## Residuals                                                                    0.163323
    ##                                                                              Df
    ## DAY50_dead_granular_BAD_REMOVED$GROUP                                         1
    ## DAY50_dead_granular_BAD_REMOVED$FAMILY                                        5
    ## DAY50_dead_granular_BAD_REMOVED$GROUP:DAY50_dead_granular_BAD_REMOVED$FAMILY  5
    ## Residuals                                                                    63
    ##                                                                              F value
    ## DAY50_dead_granular_BAD_REMOVED$GROUP                                         1.9102
    ## DAY50_dead_granular_BAD_REMOVED$FAMILY                                        4.8407
    ## DAY50_dead_granular_BAD_REMOVED$GROUP:DAY50_dead_granular_BAD_REMOVED$FAMILY  0.4839
    ## Residuals                                                                           
    ##                                                                                 Pr(>F)
    ## DAY50_dead_granular_BAD_REMOVED$GROUP                                        0.1718213
    ## DAY50_dead_granular_BAD_REMOVED$FAMILY                                       0.0008272
    ## DAY50_dead_granular_BAD_REMOVED$GROUP:DAY50_dead_granular_BAD_REMOVED$FAMILY 0.7869576
    ## Residuals                                                                             
    ##                                                                                 
    ## DAY50_dead_granular_BAD_REMOVED$GROUP                                           
    ## DAY50_dead_granular_BAD_REMOVED$FAMILY                                       ***
    ## DAY50_dead_granular_BAD_REMOVED$GROUP:DAY50_dead_granular_BAD_REMOVED$FAMILY    
    ## Residuals                                                                       
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

``` r
summary(DAY50_PLOT4_dead_apoptotic_granular_BAD_REMOVED_lm) 
```

    ## 
    ## Call:
    ## lm(formula = DAY50_dead_granular_BAD_REMOVED$Arcsine ~ DAY50_dead_granular_BAD_REMOVED$GROUP + 
    ##     DAY50_dead_granular_BAD_REMOVED$FAMILY + DAY50_dead_granular_BAD_REMOVED$GROUP:DAY50_dead_granular_BAD_REMOVED$FAMILY, 
    ##     data = DAY50_dead_granular_BAD_REMOVED)
    ## 
    ## Residuals:
    ##       Min        1Q    Median        3Q       Max 
    ## -0.090947 -0.034931 -0.005589  0.032701  0.163406 
    ## 
    ## Coefficients:
    ##                                                                                         Estimate
    ## (Intercept)                                                                             0.151236
    ## DAY50_dead_granular_BAD_REMOVED$GROUPtreatment                                          0.024285
    ## DAY50_dead_granular_BAD_REMOVED$FAMILYB                                                -0.037863
    ## DAY50_dead_granular_BAD_REMOVED$FAMILYD                                                 0.022165
    ## DAY50_dead_granular_BAD_REMOVED$FAMILYE                                                 0.027965
    ## DAY50_dead_granular_BAD_REMOVED$FAMILYJ                                                -0.009709
    ## DAY50_dead_granular_BAD_REMOVED$FAMILYL                                                -0.003595
    ## DAY50_dead_granular_BAD_REMOVED$GROUPtreatment:DAY50_dead_granular_BAD_REMOVED$FAMILYB -0.022557
    ## DAY50_dead_granular_BAD_REMOVED$GROUPtreatment:DAY50_dead_granular_BAD_REMOVED$FAMILYD  0.020528
    ## DAY50_dead_granular_BAD_REMOVED$GROUPtreatment:DAY50_dead_granular_BAD_REMOVED$FAMILYE -0.012822
    ## DAY50_dead_granular_BAD_REMOVED$GROUPtreatment:DAY50_dead_granular_BAD_REMOVED$FAMILYJ  0.015399
    ## DAY50_dead_granular_BAD_REMOVED$GROUPtreatment:DAY50_dead_granular_BAD_REMOVED$FAMILYL -0.036243
    ##                                                                                        Std. Error
    ## (Intercept)                                                                              0.025458
    ## DAY50_dead_granular_BAD_REMOVED$GROUPtreatment                                           0.030122
    ## DAY50_dead_granular_BAD_REMOVED$FAMILYB                                                  0.034155
    ## DAY50_dead_granular_BAD_REMOVED$FAMILYD                                                  0.036003
    ## DAY50_dead_granular_BAD_REMOVED$FAMILYE                                                  0.036003
    ## DAY50_dead_granular_BAD_REMOVED$FAMILYJ                                                  0.038888
    ## DAY50_dead_granular_BAD_REMOVED$FAMILYL                                                  0.036003
    ## DAY50_dead_granular_BAD_REMOVED$GROUPtreatment:DAY50_dead_granular_BAD_REMOVED$FAMILYB   0.041832
    ## DAY50_dead_granular_BAD_REMOVED$GROUPtreatment:DAY50_dead_granular_BAD_REMOVED$FAMILYD   0.043353
    ## DAY50_dead_granular_BAD_REMOVED$GROUPtreatment:DAY50_dead_granular_BAD_REMOVED$FAMILYE   0.042599
    ## DAY50_dead_granular_BAD_REMOVED$GROUPtreatment:DAY50_dead_granular_BAD_REMOVED$FAMILYJ   0.045777
    ## DAY50_dead_granular_BAD_REMOVED$GROUPtreatment:DAY50_dead_granular_BAD_REMOVED$FAMILYL   0.043884
    ##                                                                                        t value
    ## (Intercept)                                                                              5.941
    ## DAY50_dead_granular_BAD_REMOVED$GROUPtreatment                                           0.806
    ## DAY50_dead_granular_BAD_REMOVED$FAMILYB                                                 -1.109
    ## DAY50_dead_granular_BAD_REMOVED$FAMILYD                                                  0.616
    ## DAY50_dead_granular_BAD_REMOVED$FAMILYE                                                  0.777
    ## DAY50_dead_granular_BAD_REMOVED$FAMILYJ                                                 -0.250
    ## DAY50_dead_granular_BAD_REMOVED$FAMILYL                                                 -0.100
    ## DAY50_dead_granular_BAD_REMOVED$GROUPtreatment:DAY50_dead_granular_BAD_REMOVED$FAMILYB  -0.539
    ## DAY50_dead_granular_BAD_REMOVED$GROUPtreatment:DAY50_dead_granular_BAD_REMOVED$FAMILYD   0.474
    ## DAY50_dead_granular_BAD_REMOVED$GROUPtreatment:DAY50_dead_granular_BAD_REMOVED$FAMILYE  -0.301
    ## DAY50_dead_granular_BAD_REMOVED$GROUPtreatment:DAY50_dead_granular_BAD_REMOVED$FAMILYJ   0.336
    ## DAY50_dead_granular_BAD_REMOVED$GROUPtreatment:DAY50_dead_granular_BAD_REMOVED$FAMILYL  -0.826
    ##                                                                                        Pr(>|t|)
    ## (Intercept)                                                                            1.34e-07
    ## DAY50_dead_granular_BAD_REMOVED$GROUPtreatment                                            0.423
    ## DAY50_dead_granular_BAD_REMOVED$FAMILYB                                                   0.272
    ## DAY50_dead_granular_BAD_REMOVED$FAMILYD                                                   0.540
    ## DAY50_dead_granular_BAD_REMOVED$FAMILYE                                                   0.440
    ## DAY50_dead_granular_BAD_REMOVED$FAMILYJ                                                   0.804
    ## DAY50_dead_granular_BAD_REMOVED$FAMILYL                                                   0.921
    ## DAY50_dead_granular_BAD_REMOVED$GROUPtreatment:DAY50_dead_granular_BAD_REMOVED$FAMILYB    0.592
    ## DAY50_dead_granular_BAD_REMOVED$GROUPtreatment:DAY50_dead_granular_BAD_REMOVED$FAMILYD    0.637
    ## DAY50_dead_granular_BAD_REMOVED$GROUPtreatment:DAY50_dead_granular_BAD_REMOVED$FAMILYE    0.764
    ## DAY50_dead_granular_BAD_REMOVED$GROUPtreatment:DAY50_dead_granular_BAD_REMOVED$FAMILYJ    0.738
    ## DAY50_dead_granular_BAD_REMOVED$GROUPtreatment:DAY50_dead_granular_BAD_REMOVED$FAMILYL    0.412
    ##                                                                                           
    ## (Intercept)                                                                            ***
    ## DAY50_dead_granular_BAD_REMOVED$GROUPtreatment                                            
    ## DAY50_dead_granular_BAD_REMOVED$FAMILYB                                                   
    ## DAY50_dead_granular_BAD_REMOVED$FAMILYD                                                   
    ## DAY50_dead_granular_BAD_REMOVED$FAMILYE                                                   
    ## DAY50_dead_granular_BAD_REMOVED$FAMILYJ                                                   
    ## DAY50_dead_granular_BAD_REMOVED$FAMILYL                                                   
    ## DAY50_dead_granular_BAD_REMOVED$GROUPtreatment:DAY50_dead_granular_BAD_REMOVED$FAMILYB    
    ## DAY50_dead_granular_BAD_REMOVED$GROUPtreatment:DAY50_dead_granular_BAD_REMOVED$FAMILYD    
    ## DAY50_dead_granular_BAD_REMOVED$GROUPtreatment:DAY50_dead_granular_BAD_REMOVED$FAMILYE    
    ## DAY50_dead_granular_BAD_REMOVED$GROUPtreatment:DAY50_dead_granular_BAD_REMOVED$FAMILYJ    
    ## DAY50_dead_granular_BAD_REMOVED$GROUPtreatment:DAY50_dead_granular_BAD_REMOVED$FAMILYL    
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
    ## 
    ## Residual standard error: 0.05092 on 63 degrees of freedom
    ## Multiple R-squared:  0.3187, Adjusted R-squared:  0.1997 
    ## F-statistic: 2.679 on 11 and 63 DF,  p-value: 0.006911

``` r
DAY50_PLOT4_dead_apoptotic_granular_FAMILY_BAD_REMOVED_lm_interaction_leastsquares <-lsmeans(DAY50_PLOT4_dead_apoptotic_granular_BAD_REMOVED_lm, "DAY50_dead_granular_BAD_REMOVED$FAMILY", adjust="tukey")
cld(DAY50_PLOT4_dead_apoptotic_granular_FAMILY_BAD_REMOVED_lm_interaction_leastsquares, alpha=0.05, Letters=letters)
```

    ##  DAY50_dead_granular_BAD_REMOVED$FAMILY    lsmean         SE df  lower.CL
    ##  A                                      0.1512359 0.02545793 63 0.1003623
    ##  B                                      0.1512359 0.02545793 63 0.1003623
    ##  D                                      0.1755214 0.01610101 63 0.1433461
    ##  E                                      0.1755214 0.01610101 63 0.1433461
    ##  J                                      0.1755214 0.01610101 63 0.1433461
    ##  L                                      0.1755214 0.01610101 63 0.1433461
    ##   upper.CL .group
    ##  0.2021095  a    
    ##  0.2021095  a    
    ##  0.2076967  a    
    ##  0.2076967  a    
    ##  0.2076967  a    
    ##  0.2076967  a    
    ## 
    ## Results are averaged over the levels of: DAY50_dead_granular_BAD_REMOVED$GROUP 
    ## Confidence level used: 0.95 
    ## P value adjustment: tukey method for comparing a family of 6 estimates 
    ## significance level used: alpha = 0.05

### One-Way Anova of just challenged

``` r
DAY50_PLOT4_dead_apoptotic_granular_BAD_REMOVED_CHALLENGE <- DAY50_dead_granular_BAD_REMOVED[!grepl("control",DAY50_dead_granular_BAD_REMOVED$GROUP),]

DAY50_PLOT4_dead_apoptotic_granular_oneway_aov <- aov(DAY50_PLOT4_dead_apoptotic_granular_BAD_REMOVED_CHALLENGE$Arcsine ~ DAY50_PLOT4_dead_apoptotic_granular_BAD_REMOVED_CHALLENGE$FAMILY, data=DAY50_PLOT4_dead_apoptotic_granular_BAD_REMOVED_CHALLENGE)
summary(DAY50_PLOT4_dead_apoptotic_granular_oneway_aov) # significantly different between families 
```

    ##                                                                  Df
    ## DAY50_PLOT4_dead_apoptotic_granular_BAD_REMOVED_CHALLENGE$FAMILY  5
    ## Residuals                                                        45
    ##                                                                   Sum Sq
    ## DAY50_PLOT4_dead_apoptotic_granular_BAD_REMOVED_CHALLENGE$FAMILY 0.05647
    ## Residuals                                                        0.12109
    ##                                                                   Mean Sq
    ## DAY50_PLOT4_dead_apoptotic_granular_BAD_REMOVED_CHALLENGE$FAMILY 0.011293
    ## Residuals                                                        0.002691
    ##                                                                  F value
    ## DAY50_PLOT4_dead_apoptotic_granular_BAD_REMOVED_CHALLENGE$FAMILY   4.197
    ## Residuals                                                               
    ##                                                                   Pr(>F)
    ## DAY50_PLOT4_dead_apoptotic_granular_BAD_REMOVED_CHALLENGE$FAMILY 0.00325
    ## Residuals                                                               
    ##                                                                    
    ## DAY50_PLOT4_dead_apoptotic_granular_BAD_REMOVED_CHALLENGE$FAMILY **
    ## Residuals                                                          
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

``` r
TukeyHSD(DAY50_PLOT4_dead_apoptotic_granular_oneway_aov)
```

    ##   Tukey multiple comparisons of means
    ##     95% family-wise confidence level
    ## 
    ## Fit: aov(formula = DAY50_PLOT4_dead_apoptotic_granular_BAD_REMOVED_CHALLENGE$Arcsine ~ DAY50_PLOT4_dead_apoptotic_granular_BAD_REMOVED_CHALLENGE$FAMILY, data = DAY50_PLOT4_dead_apoptotic_granular_BAD_REMOVED_CHALLENGE)
    ## 
    ## $`DAY50_PLOT4_dead_apoptotic_granular_BAD_REMOVED_CHALLENGE$FAMILY`
    ##             diff          lwr          upr     p adj
    ## B-A -0.060420257 -0.133647374  0.012806860 0.1595580
    ## D-A  0.042693083 -0.030534034  0.115920201 0.5167041
    ## E-A  0.015143194 -0.053895994  0.084182383 0.9860876
    ## J-A  0.005690055 -0.067537062  0.078917173 0.9999029
    ## L-A -0.039837661 -0.115915141  0.036239820 0.6293117
    ## D-B  0.103113340  0.025925181  0.180301499 0.0032398
    ## E-B  0.075563451  0.002336334  0.148790569 0.0395505
    ## J-B  0.066110312 -0.011077847  0.143298471 0.1317872
    ## L-B  0.020582596 -0.059314739  0.100479932 0.9717170
    ## E-D -0.027549889 -0.100777006  0.045677229 0.8706744
    ## J-D -0.037003028 -0.114191187  0.040185131 0.7109185
    ## L-D -0.082530744 -0.162428079 -0.002633408 0.0392410
    ## J-E -0.009453139 -0.082680257  0.063773978 0.9988392
    ## L-E -0.054980855 -0.131058335  0.021096625 0.2808720
    ## L-J -0.045527716 -0.125425051  0.034369620 0.5416309

### Dead Apoptotic Agranular cells

Percent Dead apoptotic agranular hemocytes (PLOT4, Q2-UR)
---------------------------------------------------------

``` r
DAY50_dead_agranular <- DAY50_APOP_PLOT7_AGRANULAR_QUAD_PLOT %>% filter(GATE=="Q1_UR")
DAY50_APOP_dead_apoptotic_agranular_BAD_NOT_REMOVED <- ggplot(data=DAY50_dead_agranular, aes(x=GROUP, y=PERCENT_OF_THIS_PLOT, fill=GROUP)) + geom_boxplot() + ggtitle("Percent of Dead Apoptotic Agranular Hemocytes at Day 50 \n Low Quality Not Removed") +
    xlab("Family") + ylab("Percent of Hemocyte Events") + ylim(0,100)+ facet_grid(.~FAMILY+GROUP, scales="free") 

DAY50_dead_agranular_BAD_REMOVED <- DAY50_APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED %>% filter(GATE=="Q1_UR")
DAY50_APOP_dead_apoptotic_agranular_BAD_REMOVED <- ggplot(data= DAY50_dead_agranular_BAD_REMOVED, aes(x=GROUP, y=PERCENT_OF_THIS_PLOT, fill=GROUP)) + geom_boxplot() + ggtitle("Percent of Dead Apoptotic Agranular Hemocytes at Day 50 \nLow Quality Removed") + xlab("Family") + ylab("Percent of Hemocyte Events") + ylim(0,100)+ facet_grid(.~FAMILY+GROUP, scales="free") 
DAY50_APOP_dead_apoptotic_agranular_BAD_REMOVED
```

![](Dermo_Apoptosis_Assay_Data_analysis_files/figure-markdown_github/DAY50_dead_apoptotic_agrranular-1.png)

### FAMILY A

### FAMILY A

``` r
DAY50_dead_agranular_FAMILY_A <- DAY50_dead_agranular %>% filter(FAMILY=="A")

DAY50_dead_agranular_FAMILY_A_aov <- aov(DAY50_dead_agranular_FAMILY_A$Arcsine ~ DAY50_dead_agranular_FAMILY_A$GROUP, data=DAY50_dead_agranular_FAMILY_A)
summary(DAY50_dead_agranular_FAMILY_A_aov)
```

    ##                                     Df  Sum Sq Mean Sq F value Pr(>F)
    ## DAY50_dead_agranular_FAMILY_A$GROUP  1 0.02244 0.02244   1.447  0.252
    ## Residuals                           12 0.18604 0.01550

``` r
DAY50_dead_agranular_BAD_REMOVED_FAMILY_A <- DAY50_dead_agranular_BAD_REMOVED %>% filter(FAMILY=="A") 
DAY50_dead_agranular_BAD_REMOVED_FAMILY_A_aov <- aov(DAY50_dead_agranular_BAD_REMOVED_FAMILY_A$Arcsine ~ DAY50_dead_agranular_BAD_REMOVED_FAMILY_A$GROUP, data=DAY50_dead_agranular_BAD_REMOVED_FAMILY_A)
summary(DAY50_dead_agranular_BAD_REMOVED_FAMILY_A_aov)
```

    ##                                                 Df  Sum Sq Mean Sq F value
    ## DAY50_dead_agranular_BAD_REMOVED_FAMILY_A$GROUP  1 0.02244 0.02244   1.447
    ## Residuals                                       12 0.18604 0.01550        
    ##                                                 Pr(>F)
    ## DAY50_dead_agranular_BAD_REMOVED_FAMILY_A$GROUP  0.252
    ## Residuals

### FAMILY B

``` r
DAY50_dead_agranular_FAMILY_B <- DAY50_dead_agranular %>% filter(FAMILY=="B")

DAY50_dead_agranular_FAMILY_B_aov <- aov(DAY50_dead_agranular_FAMILY_B$Arcsine ~ DAY50_dead_agranular_FAMILY_B$GROUP, data=DAY50_dead_agranular_FAMILY_B)
summary(DAY50_dead_agranular_FAMILY_B_aov)
```

    ##                                     Df  Sum Sq Mean Sq F value Pr(>F)
    ## DAY50_dead_agranular_FAMILY_B$GROUP  1 0.02122 0.02122   1.896  0.194
    ## Residuals                           12 0.13430 0.01119

``` r
DAY50_dead_agranular_BAD_REMOVED_FAMILY_B <- DAY50_dead_agranular_BAD_REMOVED %>% filter(FAMILY=="B") 
DAY50_dead_agranular_BAD_REMOVED_FAMILY_B_aov <- aov(DAY50_dead_agranular_BAD_REMOVED_FAMILY_B$Arcsine ~ DAY50_dead_agranular_BAD_REMOVED_FAMILY_B$GROUP, data=DAY50_dead_agranular_BAD_REMOVED_FAMILY_B)
summary(DAY50_dead_agranular_BAD_REMOVED_FAMILY_B_aov)
```

    ##                                                 Df  Sum Sq Mean Sq F value
    ## DAY50_dead_agranular_BAD_REMOVED_FAMILY_B$GROUP  1 0.03412 0.03412   4.051
    ## Residuals                                       11 0.09266 0.00842        
    ##                                                 Pr(>F)  
    ## DAY50_dead_agranular_BAD_REMOVED_FAMILY_B$GROUP 0.0693 .
    ## Residuals                                               
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

### FAMILY D

``` r
DAY50_dead_agranular_FAMILY_D <- DAY50_dead_agranular %>% filter(FAMILY=="D")

DAY50_dead_agranular_FAMILY_D_aov <- aov(DAY50_dead_agranular_FAMILY_D$Arcsine ~ DAY50_dead_agranular_FAMILY_D$GROUP, data=DAY50_dead_agranular_FAMILY_D)
summary(DAY50_dead_agranular_FAMILY_D_aov)
```

    ##                                     Df  Sum Sq  Mean Sq F value Pr(>F)
    ## DAY50_dead_agranular_FAMILY_D$GROUP  1 0.00485 0.004853   0.232  0.639
    ## Residuals                           12 0.25127 0.020939

``` r
DAY50_dead_agranular_BAD_REMOVED_FAMILY_D <- DAY50_dead_agranular_BAD_REMOVED %>% filter(FAMILY=="D") 
DAY50_dead_agranular_BAD_REMOVED_FAMILY_D_aov <- aov(DAY50_dead_agranular_BAD_REMOVED_FAMILY_D$Arcsine ~ DAY50_dead_agranular_BAD_REMOVED_FAMILY_D$GROUP, data=DAY50_dead_agranular_BAD_REMOVED_FAMILY_D)
summary(DAY50_dead_agranular_BAD_REMOVED_FAMILY_D_aov)
```

    ##                                                 Df  Sum Sq  Mean Sq
    ## DAY50_dead_agranular_BAD_REMOVED_FAMILY_D$GROUP  1 0.00048 0.000478
    ## Residuals                                       10 0.13707 0.013707
    ##                                                 F value Pr(>F)
    ## DAY50_dead_agranular_BAD_REMOVED_FAMILY_D$GROUP   0.035  0.856
    ## Residuals

### Family E

``` r
DAY50_dead_agranular_FAMILY_E <- DAY50_dead_agranular %>% filter(FAMILY=="E")

DAY50_dead_agranular_FAMILY_E_aov <- aov(DAY50_dead_agranular_FAMILY_E$Arcsine ~ DAY50_dead_agranular_FAMILY_E$GROUP, data=DAY50_dead_agranular_FAMILY_E)
summary(DAY50_dead_agranular_FAMILY_E_aov)
```

    ##                                     Df  Sum Sq  Mean Sq F value Pr(>F)
    ## DAY50_dead_agranular_FAMILY_E$GROUP  1 0.00078 0.000782   0.047  0.832
    ## Residuals                           13 0.21603 0.016618

``` r
DAY50_dead_agranular_BAD_REMOVED_FAMILY_E <- DAY50_dead_agranular_BAD_REMOVED %>% filter(FAMILY=="E") 
DAY50_dead_agranular_BAD_REMOVED_FAMILY_E_aov <- aov(DAY50_dead_agranular_BAD_REMOVED_FAMILY_E$Arcsine ~ DAY50_dead_agranular_BAD_REMOVED_FAMILY_E$GROUP, data=DAY50_dead_agranular_BAD_REMOVED_FAMILY_E)
summary(DAY50_dead_agranular_BAD_REMOVED_FAMILY_E_aov)
```

    ##                                                 Df Sum Sq  Mean Sq F value
    ## DAY50_dead_agranular_BAD_REMOVED_FAMILY_E$GROUP  1 0.0015 0.001501   0.096
    ## Residuals                                       12 0.1868 0.015565        
    ##                                                 Pr(>F)
    ## DAY50_dead_agranular_BAD_REMOVED_FAMILY_E$GROUP  0.761
    ## Residuals

### FAMILY J

``` r
DAY50_dead_agranular_FAMILY_J <- DAY50_dead_agranular %>% filter(FAMILY=="J")

DAY50_dead_agranular_FAMILY_J_aov <- aov(DAY50_dead_agranular_FAMILY_J$Arcsine ~ DAY50_dead_agranular_FAMILY_J$GROUP, data=DAY50_dead_agranular_FAMILY_J)
summary(DAY50_dead_agranular_FAMILY_J_aov)
```

    ##                                     Df  Sum Sq  Mean Sq F value Pr(>F)
    ## DAY50_dead_agranular_FAMILY_J$GROUP  1 0.00276 0.002759   0.126  0.729
    ## Residuals                           11 0.24067 0.021879

``` r
DAY50_dead_agranular_BAD_REMOVED_FAMILY_J <- DAY50_dead_agranular_BAD_REMOVED %>% filter(FAMILY=="J") 
DAY50_dead_agranular_BAD_REMOVED_FAMILY_J_aov <- aov(DAY50_dead_agranular_BAD_REMOVED_FAMILY_J$Arcsine ~ DAY50_dead_agranular_BAD_REMOVED_FAMILY_J$GROUP, data=DAY50_dead_agranular_BAD_REMOVED_FAMILY_J)
summary(DAY50_dead_agranular_BAD_REMOVED_FAMILY_J_aov)
```

    ##                                                 Df  Sum Sq  Mean Sq
    ## DAY50_dead_agranular_BAD_REMOVED_FAMILY_J$GROUP  1 0.00518 0.005179
    ## Residuals                                        9 0.07896 0.008774
    ##                                                 F value Pr(>F)
    ## DAY50_dead_agranular_BAD_REMOVED_FAMILY_J$GROUP    0.59  0.462
    ## Residuals

### FAMILY L

``` r
DAY50_dead_agranular_FAMILY_L <- DAY50_dead_agranular %>% filter(FAMILY=="L")

DAY50_dead_agranular_FAMILY_L_aov <- aov(DAY50_dead_agranular_FAMILY_L$Arcsine ~ DAY50_dead_agranular_FAMILY_L$GROUP, data=DAY50_dead_agranular_FAMILY_L)
summary(DAY50_dead_agranular_FAMILY_L_aov)
```

    ##                                     Df  Sum Sq Mean Sq F value Pr(>F)
    ## DAY50_dead_agranular_FAMILY_L$GROUP  1 0.00218 0.00218   0.195  0.669
    ## Residuals                            9 0.10065 0.01118

``` r
DAY50_dead_agranular_BAD_REMOVED_FAMILY_L <- DAY50_dead_agranular_BAD_REMOVED %>% filter(FAMILY=="L") 
DAY50_dead_agranular_BAD_REMOVED_FAMILY_L_aov <- aov(DAY50_dead_agranular_BAD_REMOVED_FAMILY_L$Arcsine ~ DAY50_dead_agranular_BAD_REMOVED_FAMILY_L$GROUP, data=DAY50_dead_agranular_BAD_REMOVED_FAMILY_L)
summary(DAY50_dead_agranular_BAD_REMOVED_FAMILY_L_aov)
```

    ##                                                 Df  Sum Sq Mean Sq F value
    ## DAY50_dead_agranular_BAD_REMOVED_FAMILY_L$GROUP  1 0.00218 0.00218   0.195
    ## Residuals                                        9 0.10065 0.01118        
    ##                                                 Pr(>F)
    ## DAY50_dead_agranular_BAD_REMOVED_FAMILY_L$GROUP  0.669
    ## Residuals

### Two-Way ANOVA of Dead Apoptotic Agranular Hemocytes

``` r
DAY50_PLOT4_dead_apoptotic_agranular_BAD_REMOVED_lm <- lm(DAY50_dead_agranular_BAD_REMOVED$Arcsine ~DAY50_dead_agranular_BAD_REMOVED$GROUP + DAY50_dead_agranular_BAD_REMOVED$FAMILY, data=DAY50_dead_agranular_BAD_REMOVED)

Anova(DAY50_PLOT4_dead_apoptotic_agranular_BAD_REMOVED_lm, type="II") # no significance
```

    ## Anova Table (Type II tests)
    ## 
    ## Response: DAY50_dead_agranular_BAD_REMOVED$Arcsine
    ##                                          Sum Sq Df F value Pr(>F)
    ## DAY50_dead_agranular_BAD_REMOVED$GROUP  0.01219  1  0.9919 0.3228
    ## DAY50_dead_agranular_BAD_REMOVED$FAMILY 0.02703  5  0.4398 0.8192
    ## Residuals                               0.83586 68

``` r
summary(DAY50_APOP_PLOT7_live_apoptotic_agranular_BAD_REMOVED_lm) # no significance
```

    ## 
    ## Call:
    ## lm(formula = DAY50_live_agranular_BAD_REMOVED$Arcsine ~ DAY50_live_agranular_BAD_REMOVED$GROUP + 
    ##     DAY50_live_agranular_BAD_REMOVED$FAMILY + DAY50_live_agranular_BAD_REMOVED$GROUP:DAY50_live_agranular_BAD_REMOVED$FAMILY, 
    ##     data = DAY50_live_agranular_BAD_REMOVED)
    ## 
    ## Residuals:
    ##      Min       1Q   Median       3Q      Max 
    ## -0.12924 -0.04299 -0.01047  0.04263  0.14373 
    ## 
    ## Coefficients:
    ##                                                                                           Estimate
    ## (Intercept)                                                                               0.165066
    ## DAY50_live_agranular_BAD_REMOVED$GROUPtreatment                                           0.012007
    ## DAY50_live_agranular_BAD_REMOVED$FAMILYB                                                  0.151907
    ## DAY50_live_agranular_BAD_REMOVED$FAMILYD                                                  0.061828
    ## DAY50_live_agranular_BAD_REMOVED$FAMILYE                                                  0.112193
    ## DAY50_live_agranular_BAD_REMOVED$FAMILYJ                                                  0.070205
    ## DAY50_live_agranular_BAD_REMOVED$FAMILYL                                                  0.178026
    ## DAY50_live_agranular_BAD_REMOVED$GROUPtreatment:DAY50_live_agranular_BAD_REMOVED$FAMILYB -0.087053
    ## DAY50_live_agranular_BAD_REMOVED$GROUPtreatment:DAY50_live_agranular_BAD_REMOVED$FAMILYD -0.053952
    ## DAY50_live_agranular_BAD_REMOVED$GROUPtreatment:DAY50_live_agranular_BAD_REMOVED$FAMILYE -0.040004
    ## DAY50_live_agranular_BAD_REMOVED$GROUPtreatment:DAY50_live_agranular_BAD_REMOVED$FAMILYJ  0.005768
    ## DAY50_live_agranular_BAD_REMOVED$GROUPtreatment:DAY50_live_agranular_BAD_REMOVED$FAMILYL  0.040031
    ##                                                                                          Std. Error
    ## (Intercept)                                                                                0.035359
    ## DAY50_live_agranular_BAD_REMOVED$GROUPtreatment                                            0.041838
    ## DAY50_live_agranular_BAD_REMOVED$FAMILYB                                                   0.047439
    ## DAY50_live_agranular_BAD_REMOVED$FAMILYD                                                   0.050006
    ## DAY50_live_agranular_BAD_REMOVED$FAMILYE                                                   0.050006
    ## DAY50_live_agranular_BAD_REMOVED$FAMILYJ                                                   0.054012
    ## DAY50_live_agranular_BAD_REMOVED$FAMILYL                                                   0.050006
    ## DAY50_live_agranular_BAD_REMOVED$GROUPtreatment:DAY50_live_agranular_BAD_REMOVED$FAMILYB   0.058101
    ## DAY50_live_agranular_BAD_REMOVED$GROUPtreatment:DAY50_live_agranular_BAD_REMOVED$FAMILYD   0.060215
    ## DAY50_live_agranular_BAD_REMOVED$GROUPtreatment:DAY50_live_agranular_BAD_REMOVED$FAMILYE   0.059167
    ## DAY50_live_agranular_BAD_REMOVED$GROUPtreatment:DAY50_live_agranular_BAD_REMOVED$FAMILYJ   0.063581
    ## DAY50_live_agranular_BAD_REMOVED$GROUPtreatment:DAY50_live_agranular_BAD_REMOVED$FAMILYL   0.060952
    ##                                                                                          t value
    ## (Intercept)                                                                                4.668
    ## DAY50_live_agranular_BAD_REMOVED$GROUPtreatment                                            0.287
    ## DAY50_live_agranular_BAD_REMOVED$FAMILYB                                                   3.202
    ## DAY50_live_agranular_BAD_REMOVED$FAMILYD                                                   1.236
    ## DAY50_live_agranular_BAD_REMOVED$FAMILYE                                                   2.244
    ## DAY50_live_agranular_BAD_REMOVED$FAMILYJ                                                   1.300
    ## DAY50_live_agranular_BAD_REMOVED$FAMILYL                                                   3.560
    ## DAY50_live_agranular_BAD_REMOVED$GROUPtreatment:DAY50_live_agranular_BAD_REMOVED$FAMILYB  -1.498
    ## DAY50_live_agranular_BAD_REMOVED$GROUPtreatment:DAY50_live_agranular_BAD_REMOVED$FAMILYD  -0.896
    ## DAY50_live_agranular_BAD_REMOVED$GROUPtreatment:DAY50_live_agranular_BAD_REMOVED$FAMILYE  -0.676
    ## DAY50_live_agranular_BAD_REMOVED$GROUPtreatment:DAY50_live_agranular_BAD_REMOVED$FAMILYJ   0.091
    ## DAY50_live_agranular_BAD_REMOVED$GROUPtreatment:DAY50_live_agranular_BAD_REMOVED$FAMILYL   0.657
    ##                                                                                          Pr(>|t|)
    ## (Intercept)                                                                              1.64e-05
    ## DAY50_live_agranular_BAD_REMOVED$GROUPtreatment                                          0.775064
    ## DAY50_live_agranular_BAD_REMOVED$FAMILYB                                                 0.002139
    ## DAY50_live_agranular_BAD_REMOVED$FAMILYD                                                 0.220891
    ## DAY50_live_agranular_BAD_REMOVED$FAMILYE                                                 0.028382
    ## DAY50_live_agranular_BAD_REMOVED$FAMILYJ                                                 0.198403
    ## DAY50_live_agranular_BAD_REMOVED$FAMILYL                                                 0.000712
    ## DAY50_live_agranular_BAD_REMOVED$GROUPtreatment:DAY50_live_agranular_BAD_REMOVED$FAMILYB 0.139052
    ## DAY50_live_agranular_BAD_REMOVED$GROUPtreatment:DAY50_live_agranular_BAD_REMOVED$FAMILYD 0.373663
    ## DAY50_live_agranular_BAD_REMOVED$GROUPtreatment:DAY50_live_agranular_BAD_REMOVED$FAMILYE 0.501447
    ## DAY50_live_agranular_BAD_REMOVED$GROUPtreatment:DAY50_live_agranular_BAD_REMOVED$FAMILYJ 0.928006
    ## DAY50_live_agranular_BAD_REMOVED$GROUPtreatment:DAY50_live_agranular_BAD_REMOVED$FAMILYL 0.513727
    ##                                                                                             
    ## (Intercept)                                                                              ***
    ## DAY50_live_agranular_BAD_REMOVED$GROUPtreatment                                             
    ## DAY50_live_agranular_BAD_REMOVED$FAMILYB                                                 ** 
    ## DAY50_live_agranular_BAD_REMOVED$FAMILYD                                                    
    ## DAY50_live_agranular_BAD_REMOVED$FAMILYE                                                 *  
    ## DAY50_live_agranular_BAD_REMOVED$FAMILYJ                                                    
    ## DAY50_live_agranular_BAD_REMOVED$FAMILYL                                                 ***
    ## DAY50_live_agranular_BAD_REMOVED$GROUPtreatment:DAY50_live_agranular_BAD_REMOVED$FAMILYB    
    ## DAY50_live_agranular_BAD_REMOVED$GROUPtreatment:DAY50_live_agranular_BAD_REMOVED$FAMILYD    
    ## DAY50_live_agranular_BAD_REMOVED$GROUPtreatment:DAY50_live_agranular_BAD_REMOVED$FAMILYE    
    ## DAY50_live_agranular_BAD_REMOVED$GROUPtreatment:DAY50_live_agranular_BAD_REMOVED$FAMILYJ    
    ## DAY50_live_agranular_BAD_REMOVED$GROUPtreatment:DAY50_live_agranular_BAD_REMOVED$FAMILYL    
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
    ## 
    ## Residual standard error: 0.07072 on 63 degrees of freedom
    ## Multiple R-squared:  0.5091, Adjusted R-squared:  0.4234 
    ## F-statistic: 5.939 on 11 and 63 DF,  p-value: 1.559e-06

One Way ANOVA of just challenged Dead Apoptotic Agranular
---------------------------------------------------------

``` r
DAY50_PLOT4_dead_apoptotic_agranular_BAD_REMOVED_CHALLENGE <- DAY50_dead_agranular_BAD_REMOVED[!grepl("control",DAY50_dead_agranular_BAD_REMOVED$GROUP),]

DAY50_PLOT4_dead_apoptotic_agranular_oneway_aov <- aov(DAY50_PLOT4_dead_apoptotic_agranular_BAD_REMOVED_CHALLENGE$Arcsine ~ DAY50_PLOT4_dead_apoptotic_agranular_BAD_REMOVED_CHALLENGE$FAMILY, data=DAY50_PLOT4_dead_apoptotic_agranular_BAD_REMOVED_CHALLENGE)
summary(DAY50_PLOT4_dead_apoptotic_agranular_oneway_aov) # significantly different between families 
```

    ##                                                                   Df
    ## DAY50_PLOT4_dead_apoptotic_agranular_BAD_REMOVED_CHALLENGE$FAMILY  5
    ## Residuals                                                         45
    ##                                                                   Sum Sq
    ## DAY50_PLOT4_dead_apoptotic_agranular_BAD_REMOVED_CHALLENGE$FAMILY 0.0419
    ## Residuals                                                         0.5361
    ##                                                                    Mean Sq
    ## DAY50_PLOT4_dead_apoptotic_agranular_BAD_REMOVED_CHALLENGE$FAMILY 0.008371
    ## Residuals                                                         0.011912
    ##                                                                   F value
    ## DAY50_PLOT4_dead_apoptotic_agranular_BAD_REMOVED_CHALLENGE$FAMILY   0.703
    ## Residuals                                                                
    ##                                                                   Pr(>F)
    ## DAY50_PLOT4_dead_apoptotic_agranular_BAD_REMOVED_CHALLENGE$FAMILY  0.624
    ## Residuals

### Two Way ANOVA of Dead Apoptotic Hemocytes

``` r
DAY50_dead_granular_agranular_combined <- rbind(DAY50_dead_agranular_BAD_REMOVED,DAY50_dead_granular_BAD_REMOVED)

ggplot(DAY50_dead_granular_agranular_combined, aes(x=GROUP, y=PERCENT_OF_THIS_PLOT, fill=GATE)) + facet_grid(.~FAMILY+GROUP, scales="free") + geom_boxplot() + ggtitle("Percent of Granular and Agranular Dead Apoptotic Hemocytes at Day 50 (low quality removed)") + ylab("Percent of Hemocyte Events in each quad plot")  +scale_fill_manual(name="Hemocyte Type", labels=c("Live Agranular", "Live Granular"), values=c("Q1_UR"="#99a765","Q2_UR"="#96578a")) 
```

![](Dermo_Apoptosis_Assay_Data_analysis_files/figure-markdown_github/day50_dead_apoptotic_cells_twoway-1.png)

``` r
# Two way ANOVA
DAY50_dead_granular_agranular_aov <- lm(DAY50_dead_granular_agranular_combined$Arcsine ~DAY50_dead_granular_agranular_combined$FAMILY + DAY50_dead_granular_agranular_combined$GATE, data=DAY50_dead_granular_agranular_combined)
Anova(DAY50_dead_granular_agranular_aov, type="II") #GATE is significant
```

    ## Anova Table (Type II tests)
    ## 
    ## Response: DAY50_dead_granular_agranular_combined$Arcsine
    ##                                                Sum Sq  Df  F value Pr(>F)
    ## DAY50_dead_granular_agranular_combined$FAMILY 0.04067   5   1.0839 0.3719
    ## DAY50_dead_granular_agranular_combined$GATE   1.55667   1 207.4443 <2e-16
    ## Residuals                                     1.07308 143                
    ##                                                  
    ## DAY50_dead_granular_agranular_combined$FAMILY    
    ## DAY50_dead_granular_agranular_combined$GATE   ***
    ## Residuals                                        
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

``` r
summary(DAY50_dead_granular_agranular_aov)
```

    ## 
    ## Call:
    ## lm(formula = DAY50_dead_granular_agranular_combined$Arcsine ~ 
    ##     DAY50_dead_granular_agranular_combined$FAMILY + DAY50_dead_granular_agranular_combined$GATE, 
    ##     data = DAY50_dead_granular_agranular_combined)
    ## 
    ## Residuals:
    ##       Min        1Q    Median        3Q       Max 
    ## -0.223984 -0.049652 -0.001375  0.046902  0.276992 
    ## 
    ## Coefficients:
    ##                                                    Estimate Std. Error
    ## (Intercept)                                       0.3725854  0.0178334
    ## DAY50_dead_granular_agranular_combined$FAMILYB   -0.0388057  0.0235928
    ## DAY50_dead_granular_agranular_combined$FAMILYD    0.0002717  0.0240971
    ## DAY50_dead_granular_agranular_combined$FAMILYE    0.0124734  0.0231518
    ## DAY50_dead_granular_agranular_combined$FAMILYJ    0.0015751  0.0246799
    ## DAY50_dead_granular_agranular_combined$FAMILYL   -0.0026068  0.0246799
    ## DAY50_dead_granular_agranular_combined$GATEQ2_UR -0.2037433  0.0141460
    ##                                                  t value Pr(>|t|)    
    ## (Intercept)                                       20.893   <2e-16 ***
    ## DAY50_dead_granular_agranular_combined$FAMILYB    -1.645    0.102    
    ## DAY50_dead_granular_agranular_combined$FAMILYD     0.011    0.991    
    ## DAY50_dead_granular_agranular_combined$FAMILYE     0.539    0.591    
    ## DAY50_dead_granular_agranular_combined$FAMILYJ     0.064    0.949    
    ## DAY50_dead_granular_agranular_combined$FAMILYL    -0.106    0.916    
    ## DAY50_dead_granular_agranular_combined$GATEQ2_UR -14.403   <2e-16 ***
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
    ## 
    ## Residual standard error: 0.08663 on 143 degrees of freedom
    ## Multiple R-squared:  0.5982, Adjusted R-squared:  0.5813 
    ## F-statistic: 35.48 on 6 and 143 DF,  p-value: < 2.2e-16

``` r
# Two- Way ANOVA with interaction
DAY50_dead_granular_agranular_aov_interaction <- lm(DAY50_dead_granular_agranular_combined$Arcsine ~DAY50_dead_granular_agranular_combined$FAMILY + DAY50_dead_granular_agranular_combined$GATE + DAY50_dead_granular_agranular_combined$FAMILY:DAY50_dead_granular_agranular_combined$GATE, data=DAY50_dead_granular_agranular_combined)
Anova(DAY50_dead_granular_agranular_aov_interaction, type="II") #GATE is significant
```

    ## Anova Table (Type II tests)
    ## 
    ## Response: DAY50_dead_granular_agranular_combined$Arcsine
    ##                                                                                            Sum Sq
    ## DAY50_dead_granular_agranular_combined$FAMILY                                             0.04067
    ## DAY50_dead_granular_agranular_combined$GATE                                               1.55667
    ## DAY50_dead_granular_agranular_combined$FAMILY:DAY50_dead_granular_agranular_combined$GATE 0.05048
    ## Residuals                                                                                 1.02260
    ##                                                                                            Df
    ## DAY50_dead_granular_agranular_combined$FAMILY                                               5
    ## DAY50_dead_granular_agranular_combined$GATE                                                 1
    ## DAY50_dead_granular_agranular_combined$FAMILY:DAY50_dead_granular_agranular_combined$GATE   5
    ## Residuals                                                                                 138
    ##                                                                                            F value
    ## DAY50_dead_granular_agranular_combined$FAMILY                                               1.0977
    ## DAY50_dead_granular_agranular_combined$GATE                                               210.0729
    ## DAY50_dead_granular_agranular_combined$FAMILY:DAY50_dead_granular_agranular_combined$GATE   1.3624
    ## Residuals                                                                                         
    ##                                                                                           Pr(>F)
    ## DAY50_dead_granular_agranular_combined$FAMILY                                             0.3646
    ## DAY50_dead_granular_agranular_combined$GATE                                               <2e-16
    ## DAY50_dead_granular_agranular_combined$FAMILY:DAY50_dead_granular_agranular_combined$GATE 0.2422
    ## Residuals                                                                                       
    ##                                                                                              
    ## DAY50_dead_granular_agranular_combined$FAMILY                                                
    ## DAY50_dead_granular_agranular_combined$GATE                                               ***
    ## DAY50_dead_granular_agranular_combined$FAMILY:DAY50_dead_granular_agranular_combined$GATE    
    ## Residuals                                                                                    
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

``` r
summary(DAY50_dead_granular_agranular_aov_interaction)
```

    ## 
    ## Call:
    ## lm(formula = DAY50_dead_granular_agranular_combined$Arcsine ~ 
    ##     DAY50_dead_granular_agranular_combined$FAMILY + DAY50_dead_granular_agranular_combined$GATE + 
    ##         DAY50_dead_granular_agranular_combined$FAMILY:DAY50_dead_granular_agranular_combined$GATE, 
    ##     data = DAY50_dead_granular_agranular_combined)
    ## 
    ## Residuals:
    ##       Min        1Q    Median        3Q       Max 
    ## -0.198811 -0.047581  0.000162  0.043620  0.283066 
    ## 
    ## Coefficients:
    ##                                                                                                   Estimate
    ## (Intercept)                                                                                      0.3728448
    ## DAY50_dead_granular_agranular_combined$FAMILYB                                                  -0.0234653
    ## DAY50_dead_granular_agranular_combined$FAMILYD                                                  -0.0341504
    ## DAY50_dead_granular_agranular_combined$FAMILYE                                                   0.0061401
    ## DAY50_dead_granular_agranular_combined$FAMILYJ                                                   0.0013444
    ## DAY50_dead_granular_agranular_combined$FAMILYL                                                   0.0233374
    ## DAY50_dead_granular_agranular_combined$GATEQ2_UR                                                -0.2042622
    ## DAY50_dead_granular_agranular_combined$FAMILYB:DAY50_dead_granular_agranular_combined$GATEQ2_UR -0.0306809
    ## DAY50_dead_granular_agranular_combined$FAMILYD:DAY50_dead_granular_agranular_combined$GATEQ2_UR  0.0688443
    ## DAY50_dead_granular_agranular_combined$FAMILYE:DAY50_dead_granular_agranular_combined$GATEQ2_UR  0.0126665
    ## DAY50_dead_granular_agranular_combined$FAMILYJ:DAY50_dead_granular_agranular_combined$GATEQ2_UR  0.0004614
    ## DAY50_dead_granular_agranular_combined$FAMILYL:DAY50_dead_granular_agranular_combined$GATEQ2_UR -0.0518883
    ##                                                                                                 Std. Error
    ## (Intercept)                                                                                      0.0230065
    ## DAY50_dead_granular_agranular_combined$FAMILYB                                                   0.0331558
    ## DAY50_dead_granular_agranular_combined$FAMILYD                                                   0.0338646
    ## DAY50_dead_granular_agranular_combined$FAMILYE                                                   0.0325361
    ## DAY50_dead_granular_agranular_combined$FAMILYJ                                                   0.0346836
    ## DAY50_dead_granular_agranular_combined$FAMILYL                                                   0.0346836
    ## DAY50_dead_granular_agranular_combined$GATEQ2_UR                                                 0.0325361
    ## DAY50_dead_granular_agranular_combined$FAMILYB:DAY50_dead_granular_agranular_combined$GATEQ2_UR  0.0468894
    ## DAY50_dead_granular_agranular_combined$FAMILYD:DAY50_dead_granular_agranular_combined$GATEQ2_UR  0.0478918
    ## DAY50_dead_granular_agranular_combined$FAMILYE:DAY50_dead_granular_agranular_combined$GATEQ2_UR  0.0460129
    ## DAY50_dead_granular_agranular_combined$FAMILYJ:DAY50_dead_granular_agranular_combined$GATEQ2_UR  0.0490500
    ## DAY50_dead_granular_agranular_combined$FAMILYL:DAY50_dead_granular_agranular_combined$GATEQ2_UR  0.0490500
    ##                                                                                                 t value
    ## (Intercept)                                                                                      16.206
    ## DAY50_dead_granular_agranular_combined$FAMILYB                                                   -0.708
    ## DAY50_dead_granular_agranular_combined$FAMILYD                                                   -1.008
    ## DAY50_dead_granular_agranular_combined$FAMILYE                                                    0.189
    ## DAY50_dead_granular_agranular_combined$FAMILYJ                                                    0.039
    ## DAY50_dead_granular_agranular_combined$FAMILYL                                                    0.673
    ## DAY50_dead_granular_agranular_combined$GATEQ2_UR                                                 -6.278
    ## DAY50_dead_granular_agranular_combined$FAMILYB:DAY50_dead_granular_agranular_combined$GATEQ2_UR  -0.654
    ## DAY50_dead_granular_agranular_combined$FAMILYD:DAY50_dead_granular_agranular_combined$GATEQ2_UR   1.437
    ## DAY50_dead_granular_agranular_combined$FAMILYE:DAY50_dead_granular_agranular_combined$GATEQ2_UR   0.275
    ## DAY50_dead_granular_agranular_combined$FAMILYJ:DAY50_dead_granular_agranular_combined$GATEQ2_UR   0.009
    ## DAY50_dead_granular_agranular_combined$FAMILYL:DAY50_dead_granular_agranular_combined$GATEQ2_UR  -1.058
    ##                                                                                                 Pr(>|t|)
    ## (Intercept)                                                                                      < 2e-16
    ## DAY50_dead_granular_agranular_combined$FAMILYB                                                     0.480
    ## DAY50_dead_granular_agranular_combined$FAMILYD                                                     0.315
    ## DAY50_dead_granular_agranular_combined$FAMILYE                                                     0.851
    ## DAY50_dead_granular_agranular_combined$FAMILYJ                                                     0.969
    ## DAY50_dead_granular_agranular_combined$FAMILYL                                                     0.502
    ## DAY50_dead_granular_agranular_combined$GATEQ2_UR                                                4.16e-09
    ## DAY50_dead_granular_agranular_combined$FAMILYB:DAY50_dead_granular_agranular_combined$GATEQ2_UR    0.514
    ## DAY50_dead_granular_agranular_combined$FAMILYD:DAY50_dead_granular_agranular_combined$GATEQ2_UR    0.153
    ## DAY50_dead_granular_agranular_combined$FAMILYE:DAY50_dead_granular_agranular_combined$GATEQ2_UR    0.784
    ## DAY50_dead_granular_agranular_combined$FAMILYJ:DAY50_dead_granular_agranular_combined$GATEQ2_UR    0.993
    ## DAY50_dead_granular_agranular_combined$FAMILYL:DAY50_dead_granular_agranular_combined$GATEQ2_UR    0.292
    ##                                                                                                    
    ## (Intercept)                                                                                     ***
    ## DAY50_dead_granular_agranular_combined$FAMILYB                                                     
    ## DAY50_dead_granular_agranular_combined$FAMILYD                                                     
    ## DAY50_dead_granular_agranular_combined$FAMILYE                                                     
    ## DAY50_dead_granular_agranular_combined$FAMILYJ                                                     
    ## DAY50_dead_granular_agranular_combined$FAMILYL                                                     
    ## DAY50_dead_granular_agranular_combined$GATEQ2_UR                                                ***
    ## DAY50_dead_granular_agranular_combined$FAMILYB:DAY50_dead_granular_agranular_combined$GATEQ2_UR    
    ## DAY50_dead_granular_agranular_combined$FAMILYD:DAY50_dead_granular_agranular_combined$GATEQ2_UR    
    ## DAY50_dead_granular_agranular_combined$FAMILYE:DAY50_dead_granular_agranular_combined$GATEQ2_UR    
    ## DAY50_dead_granular_agranular_combined$FAMILYJ:DAY50_dead_granular_agranular_combined$GATEQ2_UR    
    ## DAY50_dead_granular_agranular_combined$FAMILYL:DAY50_dead_granular_agranular_combined$GATEQ2_UR    
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
    ## 
    ## Residual standard error: 0.08608 on 138 degrees of freedom
    ## Multiple R-squared:  0.6171, Adjusted R-squared:  0.5865 
    ## F-statistic: 20.22 on 11 and 138 DF,  p-value: < 2.2e-16

``` r
DAY50_dead_granular_agranula_aov_gate_leastsquares <- lsmeans(DAY50_dead_granular_agranular_aov_interaction, "DAY50_dead_granular_agranular_combined$GATE", adjust="tukey")
cld(DAY50_dead_granular_agranula_aov_gate_leastsquares, alpha=0.05, Letters=letters) # the means of the two groups not different
```

    ##  DAY50_dead_granular_agranular_combined$GATE    lsmean         SE  df
    ##  Q1_UR                                       0.3728448 0.02300647 138
    ##  Q2_UR                                       0.3728448 0.02300647 138
    ##  lower.CL  upper.CL .group
    ##  0.327354 0.4183356  a    
    ##  0.327354 0.4183356  a    
    ## 
    ## Results are averaged over the levels of: DAY50_dead_granular_agranular_combined$FAMILY 
    ## Confidence level used: 0.95 
    ## significance level used: alpha = 0.05

``` r
DAY50_live_granular_agranula_aov_interaction_leastsquares_family <- lsmeans(DAY50_live_granular_agranular_aov_interaction, "DAY50_live_granular_agranular_combined$FAMILY", adjust="tukey")
cld(DAY50_live_granular_agranula_aov_interaction_leastsquares_family, alpha=0.05, Letters=letters) # the means of the groups are not significantly different 
```

    ##  DAY50_live_granular_agranular_combined$FAMILY    lsmean         SE  df
    ##  A                                             0.1736419 0.01755856 138
    ##  B                                             0.1736419 0.01755856 138
    ##  D                                             0.1736419 0.01755856 138
    ##  E                                             0.1736419 0.01755856 138
    ##  J                                             0.1736419 0.01755856 138
    ##  L                                             0.1736419 0.01755856 138
    ##   lower.CL  upper.CL .group
    ##  0.1389234 0.2083605  a    
    ##  0.1389234 0.2083605  a    
    ##  0.1389234 0.2083605  a    
    ##  0.1389234 0.2083605  a    
    ##  0.1389234 0.2083605  a    
    ##  0.1389234 0.2083605  a    
    ## 
    ## Results are averaged over the levels of: DAY50_live_granular_agranular_combined$GATE 
    ## Confidence level used: 0.95 
    ## P value adjustment: tukey method for comparing a family of 6 estimates 
    ## significance level used: alpha = 0.05

### Plotting of Combined DAY 7 and DAY 50 for live and dead hemocytes

``` r
DAY50_dead_granular_agranular_combined$DAY <- "50" 
DAY50_live_granular_agranular_combined$DAY <- "50"
APOP_Live_apoptotic_combined_all$DAY <- "07" 
combined_dead_apoptotic_agranular_granular$DAY <- "07"

DAY50_dead_granular_agranular_combined_subset <- DAY50_dead_granular_agranular_combined[,c("SAMPLE_ID", "FAMILY","ASSAY","PERCENT_OF_THIS_PLOT", "GATE","DAY","GROUP", "PLOT")]
DAY50_live_granular_agranular_combined_subset <-DAY50_live_granular_agranular_combined[,c("SAMPLE_ID", "FAMILY","ASSAY","PERCENT_OF_THIS_PLOT", "GATE","DAY","GROUP","PLOT")]
APOP_Live_apoptotic_combined_all_subset <- APOP_Live_apoptotic_combined_all[,c("SAMPLE_ID", "FAMILY","ASSAY","PERCENT_OF_THIS_PLOT", "GATE","DAY","GROUP","PLOT")]
combined_dead_apoptotic_agranular_granular_subset <-combined_dead_apoptotic_agranular_granular[,c("SAMPLE_ID", "FAMILY","ASSAY","PERCENT_OF_THIS_PLOT", "GATE","DAY","GROUP","PLOT")]

all_apoptotic_DAY7_DAY50 <- rbind(DAY50_dead_granular_agranular_combined_subset,DAY50_live_granular_agranular_combined_subset, APOP_Live_apoptotic_combined_all_subset, combined_dead_apoptotic_agranular_granular_subset)


# Overall with all families included
#to change the labels in the plot below 

combined_families <- ggplot(all_apoptotic_DAY7_DAY50, aes(x=GROUP, y=PERCENT_OF_THIS_PLOT, fill=GATE)) + geom_boxplot() + ggtitle("Percent of Granular and Agranular Live and Dead Apoptotic Hemocytes \n on Day 7 and Day 50 (low quality removed)") + ylab("Percent of Hemocyte Events in each quad plot") + facet_grid(.~DAY+GROUP, scales="free") + scale_fill_manual(name="Hemocyte Type", labels=c("Live Apoptotic Granular","Dead Apoptotic Agranular", "Live Apoptotic Granular","Dead Apoptotic Granular"), values=c("Q1_LR"="#969e4a","Q1_UR"="#9250a2", "Q2_LR"="#b9515a", "Q2_UR"="#6785d7")) 

#BEST PLOT
#combined_families_bar <- 
  ggplot(all_apoptotic_DAY7_DAY50, aes(x=DAY, y=PERCENT_OF_THIS_PLOT, fill=GATE)) + 
  geom_col(position=position_dodge()) + 
  ggtitle("Percent of Granular and Agranular Live and Dead Apoptotic Hemocytes \n on Day 7 and Day 50 (low quality removed)") + ylab("Percent of Hemocyte Events in each quad plot") + 
  facet_grid(GROUP~FAMILY, scales="free") + 
  scale_fill_manual(name="Hemocyte Type", labels=c("Live Apoptotic Agranular","Dead Apoptotic Agranular", "Live Apoptotic Granular","Dead Apoptotic Granular"), 
                    values=c("Q1_LR"="#969e4a","Q1_UR"="#9250a2", "Q2_LR"="#b9515a", "Q2_UR"="#6785d7")) 
```

![](Dermo_Apoptosis_Assay_Data_analysis_files/figure-markdown_github/dead_apop_7_50_plotting-1.png)

``` r
# By GATE and DAY and GROUP
gate_names <- c("Q1_LR"="Live Apoptotic Agranular", "Q1_UR"="Dead Apoptotic Agranular", "Q2_LR"="Live Apoptotic Granular", "Q2_UR"="Dead Apoptotic Granular")
families_separated <- ggplot(all_apoptotic_DAY7_DAY50, aes(x=DAY, y=PERCENT_OF_THIS_PLOT, fill=FAMILY)) + geom_boxplot() + ggtitle("Percent of Granular and Agranular Live and Dead Apoptotic Hemocytes \n on Day 7 and Day 50 (low quality removed)") + ylab("Percent of Hemocyte Events in each quad plot") + facet_grid(.~GATE, scales="free", labeller = as_labeller((gate_names)))  + scale_fill_manual(name="Family", labels=c("A","B","D","E","J","L"), values=c("A"="#6971c9","B"="#86a542", "D"="#a24f99", "E"="#50b47b","J"="#ba4855","L"="#c07d37")) 

# Put the plots together
ggarrange(combined_families,families_separated, labels=c("A","B"), ncol=1,nrow=2)
```

![](Dermo_Apoptosis_Assay_Data_analysis_files/figure-markdown_github/dead_apop_7_50_plotting-2.png)

#### Necrotic Granular Cells

``` r
DAY50_necrotic_granular <- DAY50_APOP_PLOT4_GRANULAR_QUAD_PLOT %>% filter(GATE=="Q2_UL")

DAY50_APOP_necrotic_granular_BAD_NOT_REMOVED <- ggplot(data=DAY50_necrotic_granular, aes(x=GROUP, y=PERCENT_OF_THIS_PLOT, fill=GROUP)) + geom_boxplot() + ggtitle("Percent of Necrotic Granular Hemocytes at Day 50 \n Low Quality Not Removed") +
    xlab("Family") + ylab("Percent of Hemocyte Events") + ylim(0,100)+ facet_grid(.~FAMILY+GROUP, scales="free") 

DAY50_necrotic_granular_BAD_REMOVED <- DAY50_APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED %>% filter(GATE=="Q2_UL")
DAY50_APOP_necrotic_granular_BAD_REMOVED <- ggplot(data= DAY50_necrotic_granular_BAD_REMOVED, aes(x=GROUP, y=PERCENT_OF_THIS_PLOT, fill=GROUP)) + geom_boxplot() + ggtitle("Percent of Necrotic Granular Hemocytes at Day 50 \nLow Quality Removed") + xlab("Family") + ylab("Percent of Hemocyte Events") + ylim(0,100)+ facet_grid(.~FAMILY+GROUP, scales="free") 
DAY50_APOP_necrotic_granular_BAD_REMOVED
```

![](Dermo_Apoptosis_Assay_Data_analysis_files/figure-markdown_github/necrotic_granular_day50-1.png)

### FAMILY A

``` r
DAY50_necrotic_granular_FAMILY_A <- DAY50_necrotic_granular %>% filter(FAMILY=="A")

DAY50_necrotic_granular_FAMILY_A_aov <- aov(DAY50_necrotic_granular_FAMILY_A$Arcsine ~ DAY50_necrotic_granular_FAMILY_A$GROUP, data=DAY50_necrotic_granular_FAMILY_A)
summary(DAY50_necrotic_granular_FAMILY_A_aov)
```

    ##                                        Df  Sum Sq  Mean Sq F value Pr(>F)
    ## DAY50_necrotic_granular_FAMILY_A$GROUP  1 0.00029 0.000289   0.037  0.852
    ## Residuals                              12 0.09491 0.007909

``` r
DAY50_necrotic_granular_BAD_REMOVED_FAMILY_A <- DAY50_necrotic_granular_BAD_REMOVED %>% filter(FAMILY=="A") 
DAY50_necrotic_granular_BAD_REMOVED_FAMILY_A_aov <- aov(DAY50_necrotic_granular_BAD_REMOVED_FAMILY_A$Arcsine ~ DAY50_necrotic_granular_BAD_REMOVED_FAMILY_A$GROUP, data=DAY50_necrotic_granular_BAD_REMOVED_FAMILY_A)
summary(DAY50_necrotic_granular_BAD_REMOVED_FAMILY_A_aov)
```

    ##                                                    Df  Sum Sq  Mean Sq
    ## DAY50_necrotic_granular_BAD_REMOVED_FAMILY_A$GROUP  1 0.00029 0.000289
    ## Residuals                                          12 0.09491 0.007909
    ##                                                    F value Pr(>F)
    ## DAY50_necrotic_granular_BAD_REMOVED_FAMILY_A$GROUP   0.037  0.852
    ## Residuals

### FAMILY B

``` r
DAY50_necrotic_granular_FAMILY_B <- DAY50_necrotic_granular %>% filter(FAMILY=="B")

DAY50_necrotic_granular_FAMILY_B_aov <- aov(DAY50_necrotic_granular_FAMILY_B$Arcsine ~ DAY50_necrotic_granular_FAMILY_B$GROUP, data=DAY50_necrotic_granular_FAMILY_B)
summary(DAY50_necrotic_granular_FAMILY_B_aov)
```

    ##                                        Df   Sum Sq   Mean Sq F value
    ## DAY50_necrotic_granular_FAMILY_B$GROUP  1 0.001177 0.0011775   1.419
    ## Residuals                              12 0.009954 0.0008295        
    ##                                        Pr(>F)
    ## DAY50_necrotic_granular_FAMILY_B$GROUP  0.257
    ## Residuals

``` r
DAY50_necrotic_granular_BAD_REMOVED_FAMILY_B <- DAY50_necrotic_granular_BAD_REMOVED %>% filter(FAMILY=="B") 
DAY50_necrotic_granular_BAD_REMOVED_FAMILY_B_aov <- aov(DAY50_necrotic_granular_BAD_REMOVED_FAMILY_B$Arcsine ~ DAY50_necrotic_granular_BAD_REMOVED_FAMILY_B$GROUP, data=DAY50_necrotic_granular_BAD_REMOVED_FAMILY_B)
summary(DAY50_necrotic_granular_BAD_REMOVED_FAMILY_B_aov)
```

    ##                                                    Df   Sum Sq   Mean Sq
    ## DAY50_necrotic_granular_BAD_REMOVED_FAMILY_B$GROUP  1 0.001430 0.0014304
    ## Residuals                                          11 0.009532 0.0008666
    ##                                                    F value Pr(>F)
    ## DAY50_necrotic_granular_BAD_REMOVED_FAMILY_B$GROUP   1.651  0.225
    ## Residuals

### FAMILY D

``` r
DAY50_necrotic_granular_FAMILY_D <- DAY50_necrotic_granular %>% filter(FAMILY=="D")

DAY50_necrotic_granular_FAMILY_D_aov <- aov(DAY50_necrotic_granular_FAMILY_D$Arcsine ~ DAY50_necrotic_granular_FAMILY_D$GROUP, data=DAY50_necrotic_granular_FAMILY_D)
summary(DAY50_necrotic_granular_FAMILY_D_aov)
```

    ##                                        Df  Sum Sq   Mean Sq F value Pr(>F)
    ## DAY50_necrotic_granular_FAMILY_D$GROUP  1 0.00065 0.0006534   0.237  0.635
    ## Residuals                              12 0.03312 0.0027596

``` r
DAY50_necrotic_granular_BAD_REMOVED_FAMILY_D <- DAY50_necrotic_granular_BAD_REMOVED %>% filter(FAMILY=="D") 
DAY50_necrotic_granular_BAD_REMOVED_FAMILY_D_aov <- aov(DAY50_necrotic_granular_BAD_REMOVED_FAMILY_D$Arcsine ~ DAY50_necrotic_granular_BAD_REMOVED_FAMILY_D$GROUP, data=DAY50_necrotic_granular_BAD_REMOVED_FAMILY_D)
summary(DAY50_necrotic_granular_BAD_REMOVED_FAMILY_D_aov)
```

    ##                                                    Df   Sum Sq  Mean Sq
    ## DAY50_necrotic_granular_BAD_REMOVED_FAMILY_D$GROUP  1 0.001766 0.001766
    ## Residuals                                          10 0.031053 0.003105
    ##                                                    F value Pr(>F)
    ## DAY50_necrotic_granular_BAD_REMOVED_FAMILY_D$GROUP   0.569  0.468
    ## Residuals

### FAMILY E

``` r
DAY50_necrotic_granular_FAMILY_E <- DAY50_necrotic_granular %>% filter(FAMILY=="E")

DAY50_necrotic_granular_FAMILY_E_aov <- aov(DAY50_necrotic_granular_FAMILY_E$Arcsine ~ DAY50_necrotic_granular_FAMILY_E$GROUP, data=DAY50_necrotic_granular_FAMILY_E)
summary(DAY50_necrotic_granular_FAMILY_E_aov)
```

    ##                                        Df   Sum Sq   Mean Sq F value
    ## DAY50_necrotic_granular_FAMILY_E$GROUP  1 0.000435 0.0004351   0.762
    ## Residuals                              13 0.007417 0.0005706        
    ##                                        Pr(>F)
    ## DAY50_necrotic_granular_FAMILY_E$GROUP  0.398
    ## Residuals

``` r
DAY50_necrotic_granular_BAD_REMOVED_FAMILY_E <- DAY50_necrotic_granular_BAD_REMOVED %>% filter(FAMILY=="E") 
DAY50_necrotic_granular_BAD_REMOVED_FAMILY_E_aov <- aov(DAY50_necrotic_granular_BAD_REMOVED_FAMILY_E$Arcsine ~ DAY50_necrotic_granular_BAD_REMOVED_FAMILY_E$GROUP, data=DAY50_necrotic_granular_BAD_REMOVED_FAMILY_E)
summary(DAY50_necrotic_granular_BAD_REMOVED_FAMILY_E_aov)
```

    ##                                                    Df   Sum Sq  Mean Sq
    ## DAY50_necrotic_granular_BAD_REMOVED_FAMILY_E$GROUP  1 0.000055 5.54e-05
    ## Residuals                                          12 0.006432 5.36e-04
    ##                                                    F value Pr(>F)
    ## DAY50_necrotic_granular_BAD_REMOVED_FAMILY_E$GROUP   0.103  0.753
    ## Residuals

### FAMILY J

``` r
DAY50_necrotic_granular_FAMILY_J <- DAY50_necrotic_granular %>% filter(FAMILY=="J")

DAY50_necrotic_granular_FAMILY_J_aov <- aov(DAY50_necrotic_granular_FAMILY_J$Arcsine ~ DAY50_necrotic_granular_FAMILY_J$GROUP, data=DAY50_necrotic_granular_FAMILY_J)
summary(DAY50_necrotic_granular_FAMILY_J_aov)
```

    ##                                        Df   Sum Sq   Mean Sq F value
    ## DAY50_necrotic_granular_FAMILY_J$GROUP  1 0.000087 0.0000869   0.192
    ## Residuals                              11 0.004971 0.0004519        
    ##                                        Pr(>F)
    ## DAY50_necrotic_granular_FAMILY_J$GROUP  0.669
    ## Residuals

``` r
DAY50_necrotic_granular_BAD_REMOVED_FAMILY_J <- DAY50_necrotic_granular_BAD_REMOVED %>% filter(FAMILY=="J") 
DAY50_necrotic_granular_BAD_REMOVED_FAMILY_J_aov <- aov(DAY50_necrotic_granular_BAD_REMOVED_FAMILY_J$Arcsine ~ DAY50_necrotic_granular_BAD_REMOVED_FAMILY_J$GROUP, data=DAY50_necrotic_granular_BAD_REMOVED_FAMILY_J)
summary(DAY50_necrotic_granular_BAD_REMOVED_FAMILY_J_aov)
```

    ##                                                    Df   Sum Sq   Mean Sq
    ## DAY50_necrotic_granular_BAD_REMOVED_FAMILY_J$GROUP  1 0.000128 0.0001284
    ## Residuals                                           9 0.004751 0.0005279
    ##                                                    F value Pr(>F)
    ## DAY50_necrotic_granular_BAD_REMOVED_FAMILY_J$GROUP   0.243  0.634
    ## Residuals

### FAMILY L

``` r
DAY50_necrotic_granular_FAMILY_L <- DAY50_necrotic_granular %>% filter(FAMILY=="L")

DAY50_necrotic_granular_FAMILY_L_aov <- aov(DAY50_necrotic_granular_FAMILY_L$Arcsine ~ DAY50_necrotic_granular_FAMILY_L$GROUP, data=DAY50_necrotic_granular_FAMILY_L)
summary(DAY50_necrotic_granular_FAMILY_L_aov)
```

    ##                                        Df   Sum Sq  Mean Sq F value Pr(>F)
    ## DAY50_necrotic_granular_FAMILY_L$GROUP  1 0.001728 0.001728   1.394  0.268
    ## Residuals                               9 0.011151 0.001239

``` r
DAY50_necrotic_granular_BAD_REMOVED_FAMILY_L <- DAY50_necrotic_granular_BAD_REMOVED %>% filter(FAMILY=="L") 
DAY50_necrotic_granular_BAD_REMOVED_FAMILY_L_aov <- aov(DAY50_necrotic_granular_BAD_REMOVED_FAMILY_L$Arcsine ~ DAY50_necrotic_granular_BAD_REMOVED_FAMILY_L$GROUP, data=DAY50_necrotic_granular_BAD_REMOVED_FAMILY_L)
summary(DAY50_necrotic_granular_BAD_REMOVED_FAMILY_L_aov)
```

    ##                                                    Df   Sum Sq  Mean Sq
    ## DAY50_necrotic_granular_BAD_REMOVED_FAMILY_L$GROUP  1 0.001728 0.001728
    ## Residuals                                           9 0.011151 0.001239
    ##                                                    F value Pr(>F)
    ## DAY50_necrotic_granular_BAD_REMOVED_FAMILY_L$GROUP   1.394  0.268
    ## Residuals

### Two Way ANOVA of Necrotic Granular

``` r
DAY50_necrotic_granular_twoway_BAD_REMOVED_lm <- lm(DAY50_necrotic_granular_BAD_REMOVED$Arcsine ~ DAY50_necrotic_granular_BAD_REMOVED$GROUP + DAY50_necrotic_granular_BAD_REMOVED$FAMILY, data=DAY50_necrotic_granular_BAD_REMOVED)
Anova(DAY50_necrotic_granular_twoway_BAD_REMOVED_lm, type="II")
```

    ## Anova Table (Type II tests)
    ## 
    ## Response: DAY50_necrotic_granular_BAD_REMOVED$Arcsine
    ##                                              Sum Sq Df F value Pr(>F)  
    ## DAY50_necrotic_granular_BAD_REMOVED$GROUP  0.003388  1  1.4414 0.2341  
    ## DAY50_necrotic_granular_BAD_REMOVED$FAMILY 0.025459  5  2.1662 0.0680 .
    ## Residuals                                  0.159837 68                 
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

``` r
summary(DAY50_necrotic_granular_twoway_BAD_REMOVED_lm)
```

    ## 
    ## Call:
    ## lm(formula = DAY50_necrotic_granular_BAD_REMOVED$Arcsine ~ DAY50_necrotic_granular_BAD_REMOVED$GROUP + 
    ##     DAY50_necrotic_granular_BAD_REMOVED$FAMILY, data = DAY50_necrotic_granular_BAD_REMOVED)
    ## 
    ## Residuals:
    ##       Min        1Q    Median        3Q       Max 
    ## -0.078659 -0.022095 -0.007372  0.015857  0.271645 
    ## 
    ## Coefficients:
    ##                                                     Estimate Std. Error
    ## (Intercept)                                         0.106661   0.015556
    ## DAY50_necrotic_granular_BAD_REMOVED$GROUPtreatment  0.014468   0.012051
    ## DAY50_necrotic_granular_BAD_REMOVED$FAMILYB        -0.046360   0.018712
    ## DAY50_necrotic_granular_BAD_REMOVED$FAMILYD        -0.001228   0.019081
    ## DAY50_necrotic_granular_BAD_REMOVED$FAMILYE        -0.029208   0.018325
    ## DAY50_necrotic_granular_BAD_REMOVED$FAMILYJ        -0.043583   0.019535
    ## DAY50_necrotic_granular_BAD_REMOVED$FAMILYL        -0.026833   0.019557
    ##                                                    t value Pr(>|t|)    
    ## (Intercept)                                          6.857 2.57e-09 ***
    ## DAY50_necrotic_granular_BAD_REMOVED$GROUPtreatment   1.201   0.2341    
    ## DAY50_necrotic_granular_BAD_REMOVED$FAMILYB         -2.478   0.0157 *  
    ## DAY50_necrotic_granular_BAD_REMOVED$FAMILYD         -0.064   0.9489    
    ## DAY50_necrotic_granular_BAD_REMOVED$FAMILYE         -1.594   0.1156    
    ## DAY50_necrotic_granular_BAD_REMOVED$FAMILYJ         -2.231   0.0290 *  
    ## DAY50_necrotic_granular_BAD_REMOVED$FAMILYL         -1.372   0.1745    
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
    ## 
    ## Residual standard error: 0.04848 on 68 degrees of freedom
    ## Multiple R-squared:  0.1551, Adjusted R-squared:  0.08051 
    ## F-statistic:  2.08 on 6 and 68 DF,  p-value: 0.0669

### One Way ANOVA of Necrotic Granular Just Challenged

``` r
DAY50_necrotic_granular_BAD_REMOVED_CHALLENGE <- DAY50_necrotic_granular_BAD_REMOVED[!grepl("control", DAY50_necrotic_granular_BAD_REMOVED$GROUP),]

DAY50_necrotic_granular_BAD_REMOVED_CHALLENGE_aov <- aov(DAY50_necrotic_granular_BAD_REMOVED_CHALLENGE$Arcsine ~ DAY50_necrotic_granular_BAD_REMOVED_CHALLENGE$FAMILY, data=DAY50_necrotic_granular_BAD_REMOVED_CHALLENGE)
summary(DAY50_necrotic_granular_BAD_REMOVED_CHALLENGE_aov) # significantly different between families 
```

    ##                                                      Df  Sum Sq  Mean Sq
    ## DAY50_necrotic_granular_BAD_REMOVED_CHALLENGE$FAMILY  5 0.01869 0.003739
    ## Residuals                                            45 0.14327 0.003184
    ##                                                      F value Pr(>F)
    ## DAY50_necrotic_granular_BAD_REMOVED_CHALLENGE$FAMILY   1.174  0.337
    ## Residuals

#### Necrotic Agranular Cells

``` r
DAY50_necrotic_agranular <- DAY50_APOP_PLOT7_AGRANULAR_QUAD_PLOT %>% filter(GATE=="Q1_UL")

DAY50_necrotic_agranular_BAD_NOT_REMOVED <- ggplot(data=DAY50_necrotic_agranular, aes(x=GROUP, y=PERCENT_OF_THIS_PLOT, fill=GROUP)) + geom_boxplot() + ggtitle("Percent of Necrotic Agranular Hemocytes at Day 50 \n Low Quality Not Removed") +
    xlab("Family") + ylab("Percent of Hemocyte Events") + ylim(0,100)+ facet_grid(.~FAMILY+GROUP, scales="free") 

DAY50_necrotic_agranular_BAD_REMOVED <- DAY50_APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED %>% filter(GATE=="Q1_UL")
DAY50_APOP_necrotic_agranular_BAD_REMOVED <- ggplot(data= DAY50_necrotic_agranular_BAD_REMOVED , aes(x=GROUP, y=PERCENT_OF_THIS_PLOT, fill=GROUP)) + geom_boxplot() + ggtitle("Percent of Necrotic Agranular Hemocytes at Day 50 \nLow Quality Removed") + xlab("Family") + ylab("Percent of Hemocyte Events") + ylim(0,100)+ facet_grid(.~FAMILY+GROUP, scales="free") 
DAY50_APOP_necrotic_agranular_BAD_REMOVED
```

![](Dermo_Apoptosis_Assay_Data_analysis_files/figure-markdown_github/necrotic_agranular_day50-1.png)

### FAMILY A

``` r
DAY50_necrotic_agranular_FAMILY_A <- DAY50_necrotic_agranular %>% filter(FAMILY=="A")

DAY50_necrotic_agranular_FAMILY_A_aov <- aov(DAY50_necrotic_agranular_FAMILY_A$Arcsine ~ DAY50_necrotic_agranular_FAMILY_A$GROUP, data=DAY50_necrotic_agranular_FAMILY_A)
summary(DAY50_necrotic_agranular_FAMILY_A_aov)
```

    ##                                         Df Sum Sq Mean Sq F value Pr(>F)
    ## DAY50_necrotic_agranular_FAMILY_A$GROUP  1 0.0066 0.00658   0.161  0.695
    ## Residuals                               12 0.4901 0.04084

``` r
DAY50_necrotic_agranular_BAD_REMOVED_FAMILY_A <- DAY50_necrotic_agranular_BAD_REMOVED %>% filter(FAMILY=="A") 
DAY50_necrotic_agranular_BAD_REMOVED_FAMILY_A_aov <- aov(DAY50_necrotic_agranular_BAD_REMOVED_FAMILY_A$Arcsine ~ DAY50_necrotic_agranular_BAD_REMOVED_FAMILY_A$GROUP, data=DAY50_necrotic_agranular_BAD_REMOVED_FAMILY_A)
summary(DAY50_necrotic_agranular_BAD_REMOVED_FAMILY_A_aov)
```

    ##                                                     Df Sum Sq Mean Sq
    ## DAY50_necrotic_agranular_BAD_REMOVED_FAMILY_A$GROUP  1 0.0066 0.00658
    ## Residuals                                           12 0.4901 0.04084
    ##                                                     F value Pr(>F)
    ## DAY50_necrotic_agranular_BAD_REMOVED_FAMILY_A$GROUP   0.161  0.695
    ## Residuals

### FAMILY B

``` r
DAY50_necrotic_agranular_FAMILY_B <- DAY50_necrotic_agranular %>% filter(FAMILY=="B")

DAY50_necrotic_agranular_FAMILY_B_aov <- aov(DAY50_necrotic_agranular_FAMILY_B$Arcsine ~ DAY50_necrotic_agranular_FAMILY_B$GROUP, data=DAY50_necrotic_agranular_FAMILY_B)
summary(DAY50_necrotic_agranular_FAMILY_B_aov)
```

    ##                                         Df  Sum Sq  Mean Sq F value Pr(>F)
    ## DAY50_necrotic_agranular_FAMILY_B$GROUP  1 0.00355 0.003553   0.295  0.597
    ## Residuals                               12 0.14438 0.012032

``` r
DAY50_necrotic_agranular_BAD_REMOVED_FAMILY_B <- DAY50_necrotic_agranular_BAD_REMOVED %>% filter(FAMILY=="B") 
DAY50_necrotic_agranular_BAD_REMOVED_FAMILY_B_aov <- aov(DAY50_necrotic_agranular_BAD_REMOVED_FAMILY_B$Arcsine ~ DAY50_necrotic_agranular_BAD_REMOVED_FAMILY_B$GROUP, data=DAY50_necrotic_agranular_BAD_REMOVED_FAMILY_B)
summary(DAY50_necrotic_agranular_BAD_REMOVED_FAMILY_B_aov)
```

    ##                                                     Df  Sum Sq  Mean Sq
    ## DAY50_necrotic_agranular_BAD_REMOVED_FAMILY_B$GROUP  1 0.00426 0.004262
    ## Residuals                                           11 0.14325 0.013022
    ##                                                     F value Pr(>F)
    ## DAY50_necrotic_agranular_BAD_REMOVED_FAMILY_B$GROUP   0.327  0.579
    ## Residuals

### FAMILY D

``` r
DAY50_necrotic_agranular_FAMILY_D <- DAY50_necrotic_agranular %>% filter(FAMILY=="D")

DAY50_necrotic_agranular_FAMILY_D_aov <- aov(DAY50_necrotic_agranular_FAMILY_D$Arcsine ~ DAY50_necrotic_agranular_FAMILY_D$GROUP, data=DAY50_necrotic_agranular_FAMILY_D)
summary(DAY50_necrotic_agranular_FAMILY_D_aov)
```

    ##                                         Df Sum Sq Mean Sq F value Pr(>F)
    ## DAY50_necrotic_agranular_FAMILY_D$GROUP  1 0.0004 0.00043   0.014  0.909
    ## Residuals                               12 0.3813 0.03177

``` r
DAY50_necrotic_agranular_BAD_REMOVED_FAMILY_D <- DAY50_necrotic_agranular_BAD_REMOVED %>% filter(FAMILY=="D") 
DAY50_necrotic_agranular_BAD_REMOVED_FAMILY_D_aov <- aov(DAY50_necrotic_agranular_BAD_REMOVED_FAMILY_D$Arcsine ~ DAY50_necrotic_agranular_BAD_REMOVED_FAMILY_D$GROUP, data=DAY50_necrotic_agranular_BAD_REMOVED_FAMILY_D)
summary(DAY50_necrotic_agranular_BAD_REMOVED_FAMILY_D_aov)
```

    ##                                                     Df Sum Sq Mean Sq
    ## DAY50_necrotic_agranular_BAD_REMOVED_FAMILY_D$GROUP  1 0.0002 0.00025
    ## Residuals                                           10 0.3807 0.03807
    ##                                                     F value Pr(>F)
    ## DAY50_necrotic_agranular_BAD_REMOVED_FAMILY_D$GROUP   0.006  0.937
    ## Residuals

### FAMILY E

``` r
DAY50_necrotic_agranular_FAMILY_E <- DAY50_necrotic_agranular %>% filter(FAMILY=="E")

DAY50_necrotic_agranular_FAMILY_E_aov <- aov(DAY50_necrotic_agranular_FAMILY_E$Arcsine ~ DAY50_necrotic_agranular_FAMILY_E$GROUP, data=DAY50_necrotic_agranular_FAMILY_E)
summary(DAY50_necrotic_agranular_FAMILY_E_aov)
```

    ##                                         Df  Sum Sq  Mean Sq F value Pr(>F)
    ## DAY50_necrotic_agranular_FAMILY_E$GROUP  1 0.01584 0.015838   1.894  0.192
    ## Residuals                               13 0.10873 0.008364

``` r
DAY50_necrotic_agranular_BAD_REMOVED_FAMILY_E <- DAY50_necrotic_agranular_BAD_REMOVED %>% filter(FAMILY=="E") 
DAY50_necrotic_agranular_BAD_REMOVED_FAMILY_E_aov <- aov(DAY50_necrotic_agranular_BAD_REMOVED_FAMILY_E$Arcsine ~ DAY50_necrotic_agranular_BAD_REMOVED_FAMILY_E$GROUP, data=DAY50_necrotic_agranular_BAD_REMOVED_FAMILY_E)
summary(DAY50_necrotic_agranular_BAD_REMOVED_FAMILY_E_aov)
```

    ##                                                     Df  Sum Sq  Mean Sq
    ## DAY50_necrotic_agranular_BAD_REMOVED_FAMILY_E$GROUP  1 0.00141 0.001409
    ## Residuals                                           12 0.06507 0.005423
    ##                                                     F value Pr(>F)
    ## DAY50_necrotic_agranular_BAD_REMOVED_FAMILY_E$GROUP    0.26  0.619
    ## Residuals

### FAMILY J

``` r
DAY50_necrotic_agranular_FAMILY_J <- DAY50_necrotic_agranular %>% filter(FAMILY=="J")

DAY50_necrotic_agranular_FAMILY_J_aov <- aov(DAY50_necrotic_agranular_FAMILY_J$Arcsine ~ DAY50_necrotic_agranular_FAMILY_J$GROUP, data=DAY50_necrotic_agranular_FAMILY_J)
summary(DAY50_necrotic_agranular_FAMILY_J_aov)
```

    ##                                         Df  Sum Sq  Mean Sq F value Pr(>F)
    ## DAY50_necrotic_agranular_FAMILY_J$GROUP  1 0.00230 0.002302   0.274  0.611
    ## Residuals                               11 0.09251 0.008410

``` r
DAY50_necrotic_agranular_BAD_REMOVED_FAMILY_J <- DAY50_necrotic_agranular_BAD_REMOVED %>% filter(FAMILY=="J") 
DAY50_necrotic_agranular_BAD_REMOVED_FAMILY_J_aov <- aov(DAY50_necrotic_agranular_BAD_REMOVED_FAMILY_J$Arcsine ~ DAY50_necrotic_agranular_BAD_REMOVED_FAMILY_J$GROUP, data=DAY50_necrotic_agranular_BAD_REMOVED_FAMILY_J)
summary(DAY50_necrotic_agranular_BAD_REMOVED_FAMILY_J_aov)
```

    ##                                                     Df  Sum Sq  Mean Sq
    ## DAY50_necrotic_agranular_BAD_REMOVED_FAMILY_J$GROUP  1 0.00051 0.000506
    ## Residuals                                            9 0.07546 0.008384
    ##                                                     F value Pr(>F)
    ## DAY50_necrotic_agranular_BAD_REMOVED_FAMILY_J$GROUP    0.06  0.811
    ## Residuals

### FAMILY L

``` r
DAY50_necrotic_agranular_FAMILY_L <- DAY50_necrotic_agranular %>% filter(FAMILY=="L")

DAY50_necrotic_agranular_FAMILY_L_aov <- aov(DAY50_necrotic_agranular_FAMILY_L$Arcsine ~ DAY50_necrotic_agranular_FAMILY_L$GROUP, data=DAY50_necrotic_agranular_FAMILY_L)
summary(DAY50_necrotic_agranular_FAMILY_L_aov)
```

    ##                                         Df  Sum Sq Mean Sq F value Pr(>F)
    ## DAY50_necrotic_agranular_FAMILY_L$GROUP  1 0.01531 0.01531   2.106  0.181
    ## Residuals                                9 0.06543 0.00727

``` r
DAY50_necrotic_agranular_BAD_REMOVED_FAMILY_L <- DAY50_necrotic_agranular_BAD_REMOVED %>% filter(FAMILY=="L") 
DAY50_necrotic_agranular_BAD_REMOVED_FAMILY_L_aov <- aov(DAY50_necrotic_agranular_BAD_REMOVED_FAMILY_L$Arcsine ~ DAY50_necrotic_agranular_BAD_REMOVED_FAMILY_L$GROUP, data=DAY50_necrotic_agranular_BAD_REMOVED_FAMILY_L)
summary(DAY50_necrotic_agranular_BAD_REMOVED_FAMILY_L_aov)
```

    ##                                                     Df  Sum Sq Mean Sq
    ## DAY50_necrotic_agranular_BAD_REMOVED_FAMILY_L$GROUP  1 0.01531 0.01531
    ## Residuals                                            9 0.06543 0.00727
    ##                                                     F value Pr(>F)
    ## DAY50_necrotic_agranular_BAD_REMOVED_FAMILY_L$GROUP   2.106  0.181
    ## Residuals

### Two Way ANOVA of Necrotic Agranular

``` r
DAY50_necrotic_agranular_twoway_BAD_REMOVED_lm <- lm(DAY50_necrotic_agranular_BAD_REMOVED$Arcsine ~ DAY50_necrotic_agranular_BAD_REMOVED$GROUP + DAY50_necrotic_agranular_BAD_REMOVED$FAMILY, data=DAY50_necrotic_agranular_BAD_REMOVED)
Anova(DAY50_necrotic_agranular_twoway_BAD_REMOVED_lm , type="II")
```

    ## Anova Table (Type II tests)
    ## 
    ## Response: DAY50_necrotic_agranular_BAD_REMOVED$Arcsine
    ##                                              Sum Sq Df F value Pr(>F)
    ## DAY50_necrotic_agranular_BAD_REMOVED$GROUP  0.00087  1  0.0476 0.8279
    ## DAY50_necrotic_agranular_BAD_REMOVED$FAMILY 0.04915  5  0.5359 0.7484
    ## Residuals                                   1.24742 68

``` r
summary(DAY50_necrotic_agranular_twoway_BAD_REMOVED_lm)
```

    ## 
    ## Call:
    ## lm(formula = DAY50_necrotic_agranular_BAD_REMOVED$Arcsine ~ DAY50_necrotic_agranular_BAD_REMOVED$GROUP + 
    ##     DAY50_necrotic_agranular_BAD_REMOVED$FAMILY, data = DAY50_necrotic_agranular_BAD_REMOVED)
    ## 
    ## Residuals:
    ##      Min       1Q   Median       3Q      Max 
    ## -0.17317 -0.06532 -0.03020  0.02758  0.53569 
    ## 
    ## Coefficients:
    ##                                                       Estimate Std. Error
    ## (Intercept)                                          0.2898301  0.0434578
    ## DAY50_necrotic_agranular_BAD_REMOVED$GROUPtreatment  0.0073484  0.0336661
    ## DAY50_necrotic_agranular_BAD_REMOVED$FAMILYB        -0.0449129  0.0522733
    ## DAY50_necrotic_agranular_BAD_REMOVED$FAMILYD         0.0291088  0.0533064
    ## DAY50_necrotic_agranular_BAD_REMOVED$FAMILYE         0.0007227  0.0511920
    ## DAY50_necrotic_agranular_BAD_REMOVED$FAMILYJ        -0.0404288  0.0545726
    ## DAY50_necrotic_agranular_BAD_REMOVED$FAMILYL        -0.0243258  0.0546339
    ##                                                     t value Pr(>|t|)    
    ## (Intercept)                                           6.669 5.56e-09 ***
    ## DAY50_necrotic_agranular_BAD_REMOVED$GROUPtreatment   0.218    0.828    
    ## DAY50_necrotic_agranular_BAD_REMOVED$FAMILYB         -0.859    0.393    
    ## DAY50_necrotic_agranular_BAD_REMOVED$FAMILYD          0.546    0.587    
    ## DAY50_necrotic_agranular_BAD_REMOVED$FAMILYE          0.014    0.989    
    ## DAY50_necrotic_agranular_BAD_REMOVED$FAMILYJ         -0.741    0.461    
    ## DAY50_necrotic_agranular_BAD_REMOVED$FAMILYL         -0.445    0.658    
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
    ## 
    ## Residual standard error: 0.1354 on 68 degrees of freedom
    ## Multiple R-squared:  0.03885,    Adjusted R-squared:  -0.04596 
    ## F-statistic: 0.4581 on 6 and 68 DF,  p-value: 0.8368

### One Way ANOVA of Necrotic Agranular Just Challenged

``` r
DAY50_necrotic_agranular_BAD_REMOVED_CHALLENGE <- DAY50_necrotic_agranular_BAD_REMOVED[!grepl("control", DAY50_necrotic_agranular_BAD_REMOVED$GROUP),]

DAY50_necrotic_agranular_BAD_REMOVED_CHALLENGE_aov <- aov(DAY50_necrotic_agranular_BAD_REMOVED_CHALLENGE$Arcsine ~ DAY50_necrotic_agranular_BAD_REMOVED_CHALLENGE$FAMILY, data=DAY50_necrotic_agranular_BAD_REMOVED_CHALLENGE)
summary(DAY50_necrotic_agranular_BAD_REMOVED_CHALLENGE_aov) # significantly different between families 
```

    ##                                                       Df Sum Sq Mean Sq
    ## DAY50_necrotic_agranular_BAD_REMOVED_CHALLENGE$FAMILY  5 0.0208 0.00416
    ## Residuals                                             45 0.9930 0.02207
    ##                                                       F value Pr(>F)
    ## DAY50_necrotic_agranular_BAD_REMOVED_CHALLENGE$FAMILY   0.189  0.965
    ## Residuals

Two Way ANOVA of Necrotic cells
-------------------------------

``` r
DAY50_necrotic_granular_agranular_combined <- rbind(DAY50_necrotic_granular_BAD_REMOVED,DAY50_necrotic_agranular_BAD_REMOVED)

ggplot(DAY50_necrotic_granular_agranular_combined, aes(x=GROUP, y=PERCENT_OF_THIS_PLOT, fill=GATE)) + facet_grid(.~FAMILY+GROUP, scales="free") + geom_boxplot() + ggtitle("Percent of Granular and Agranular Necrotic Hemocytes at Day 50 (low quality removed)") + ylab("Percent of Hemocyte Events in each quad plot")  +scale_fill_manual(name="Hemocyte Type", labels=c("Necrotic Granular", "Necrotic Agranular"), values=c("Q2_UL"="#99a765","Q1_UL"="#96578a")) 
```

![](Dermo_Apoptosis_Assay_Data_analysis_files/figure-markdown_github/day50_necrotic_cells_twoway-1.png)

``` r
# Two way ANOVA
DAY50_necrotic_granular_agranular_aov <- lm(DAY50_necrotic_granular_agranular_combined$Arcsine ~DAY50_necrotic_granular_agranular_combined$FAMILY + DAY50_necrotic_granular_agranular_combined$GATE, data=DAY50_necrotic_granular_agranular_combined)
Anova(DAY50_necrotic_granular_agranular_aov , type="II") #GATE is significant
```

    ## Anova Table (Type II tests)
    ## 
    ## Response: DAY50_necrotic_granular_agranular_combined$Arcsine
    ##                                                    Sum Sq  Df  F value
    ## DAY50_necrotic_granular_agranular_combined$FAMILY 0.06863   5   1.3839
    ## DAY50_necrotic_granular_agranular_combined$GATE   1.35161   1 136.2685
    ## Residuals                                         1.41837 143         
    ##                                                   Pr(>F)    
    ## DAY50_necrotic_granular_agranular_combined$FAMILY 0.2338    
    ## DAY50_necrotic_granular_agranular_combined$GATE   <2e-16 ***
    ## Residuals                                                   
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

``` r
summary(DAY50_necrotic_granular_agranular_aov )
```

    ## 
    ## Call:
    ## lm(formula = DAY50_necrotic_granular_agranular_combined$Arcsine ~ 
    ##     DAY50_necrotic_granular_agranular_combined$FAMILY + DAY50_necrotic_granular_agranular_combined$GATE, 
    ##     data = DAY50_necrotic_granular_agranular_combined)
    ## 
    ## Residuals:
    ##      Min       1Q   Median       3Q      Max 
    ## -0.17695 -0.04321 -0.01579  0.01783  0.53751 
    ## 
    ## Coefficients:
    ##                                                      Estimate Std. Error
    ## (Intercept)                                           0.11111    0.02050
    ## DAY50_necrotic_granular_agranular_combined$FAMILYB   -0.04672    0.02712
    ## DAY50_necrotic_granular_agranular_combined$FAMILYD    0.01342    0.02770
    ## DAY50_necrotic_granular_agranular_combined$FAMILYE   -0.01424    0.02662
    ## DAY50_necrotic_granular_agranular_combined$FAMILYJ   -0.04186    0.02837
    ## DAY50_necrotic_granular_agranular_combined$FAMILYL   -0.02643    0.02837
    ## DAY50_necrotic_granular_agranular_combined$GATEQ1_UL  0.18985    0.01626
    ##                                                      t value Pr(>|t|)    
    ## (Intercept)                                            5.419 2.48e-07 ***
    ## DAY50_necrotic_granular_agranular_combined$FAMILYB    -1.722   0.0872 .  
    ## DAY50_necrotic_granular_agranular_combined$FAMILYD     0.484   0.6288    
    ## DAY50_necrotic_granular_agranular_combined$FAMILYE    -0.535   0.5934    
    ## DAY50_necrotic_granular_agranular_combined$FAMILYJ    -1.475   0.1423    
    ## DAY50_necrotic_granular_agranular_combined$FAMILYL    -0.931   0.3532    
    ## DAY50_necrotic_granular_agranular_combined$GATEQ1_UL  11.673  < 2e-16 ***
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
    ## 
    ## Residual standard error: 0.09959 on 143 degrees of freedom
    ## Multiple R-squared:  0.5003, Adjusted R-squared:  0.4794 
    ## F-statistic: 23.86 on 6 and 143 DF,  p-value: < 2.2e-16

``` r
# Two- Way ANOVA with interaction
DAY50_necrotic_granular_agranular_aov_interaction <- lm(DAY50_necrotic_granular_agranular_combined$Arcsine ~DAY50_necrotic_granular_agranular_combined$FAMILY + DAY50_necrotic_granular_agranular_combined$GATE + DAY50_necrotic_granular_agranular_combined$FAMILY:DAY50_necrotic_granular_agranular_combined$GATE, data=DAY50_necrotic_granular_agranular_combined)
Anova(DAY50_necrotic_granular_agranular_aov_interaction, type="II") #GATE is significant
```

    ## Anova Table (Type II tests)
    ## 
    ## Response: DAY50_necrotic_granular_agranular_combined$Arcsine
    ##                                                                                                    Sum Sq
    ## DAY50_necrotic_granular_agranular_combined$FAMILY                                                 0.06863
    ## DAY50_necrotic_granular_agranular_combined$GATE                                                   1.35161
    ## DAY50_necrotic_granular_agranular_combined$FAMILY:DAY50_necrotic_granular_agranular_combined$GATE 0.00686
    ## Residuals                                                                                         1.41152
    ##                                                                                                    Df
    ## DAY50_necrotic_granular_agranular_combined$FAMILY                                                   5
    ## DAY50_necrotic_granular_agranular_combined$GATE                                                     1
    ## DAY50_necrotic_granular_agranular_combined$FAMILY:DAY50_necrotic_granular_agranular_combined$GATE   5
    ## Residuals                                                                                         138
    ##                                                                                                    F value
    ## DAY50_necrotic_granular_agranular_combined$FAMILY                                                   1.3420
    ## DAY50_necrotic_granular_agranular_combined$GATE                                                   132.1429
    ## DAY50_necrotic_granular_agranular_combined$FAMILY:DAY50_necrotic_granular_agranular_combined$GATE   0.1341
    ## Residuals                                                                                                 
    ##                                                                                                   Pr(>F)
    ## DAY50_necrotic_granular_agranular_combined$FAMILY                                                 0.2502
    ## DAY50_necrotic_granular_agranular_combined$GATE                                                   <2e-16
    ## DAY50_necrotic_granular_agranular_combined$FAMILY:DAY50_necrotic_granular_agranular_combined$GATE 0.9843
    ## Residuals                                                                                               
    ##                                                                                                      
    ## DAY50_necrotic_granular_agranular_combined$FAMILY                                                    
    ## DAY50_necrotic_granular_agranular_combined$GATE                                                   ***
    ## DAY50_necrotic_granular_agranular_combined$FAMILY:DAY50_necrotic_granular_agranular_combined$GATE    
    ## Residuals                                                                                            
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

``` r
summary(DAY50_necrotic_granular_agranular_aov_interaction)
```

    ## 
    ## Call:
    ## lm(formula = DAY50_necrotic_granular_agranular_combined$Arcsine ~ 
    ##     DAY50_necrotic_granular_agranular_combined$FAMILY + DAY50_necrotic_granular_agranular_combined$GATE + 
    ##         DAY50_necrotic_granular_agranular_combined$FAMILY:DAY50_necrotic_granular_agranular_combined$GATE, 
    ##     data = DAY50_necrotic_granular_agranular_combined)
    ## 
    ## Residuals:
    ##      Min       1Q   Median       3Q      Max 
    ## -0.17107 -0.03981 -0.01789  0.01769  0.53779 
    ## 
    ## Coefficients:
    ##                                                                                                          Estimate
    ## (Intercept)                                                                                              0.116996
    ## DAY50_necrotic_granular_agranular_combined$FAMILYB                                                      -0.047791
    ## DAY50_necrotic_granular_agranular_combined$FAMILYD                                                      -0.001917
    ## DAY50_necrotic_granular_agranular_combined$FAMILYE                                                      -0.029208
    ## DAY50_necrotic_granular_agranular_combined$FAMILYJ                                                      -0.043395
    ## DAY50_necrotic_granular_agranular_combined$FAMILYL                                                      -0.027961
    ## DAY50_necrotic_granular_agranular_combined$GATEQ1_UL                                                     0.178083
    ## DAY50_necrotic_granular_agranular_combined$FAMILYB:DAY50_necrotic_granular_agranular_combined$GATEQ1_UL  0.002151
    ## DAY50_necrotic_granular_agranular_combined$FAMILYD:DAY50_necrotic_granular_agranular_combined$GATEQ1_UL  0.030675
    ## DAY50_necrotic_granular_agranular_combined$FAMILYE:DAY50_necrotic_granular_agranular_combined$GATEQ1_UL  0.029931
    ## DAY50_necrotic_granular_agranular_combined$FAMILYJ:DAY50_necrotic_granular_agranular_combined$GATEQ1_UL  0.003062
    ## DAY50_necrotic_granular_agranular_combined$FAMILYL:DAY50_necrotic_granular_agranular_combined$GATEQ1_UL  0.003062
    ##                                                                                                         Std. Error
    ## (Intercept)                                                                                               0.027030
    ## DAY50_necrotic_granular_agranular_combined$FAMILYB                                                        0.038954
    ## DAY50_necrotic_granular_agranular_combined$FAMILYD                                                        0.039786
    ## DAY50_necrotic_granular_agranular_combined$FAMILYE                                                        0.038226
    ## DAY50_necrotic_granular_agranular_combined$FAMILYJ                                                        0.040749
    ## DAY50_necrotic_granular_agranular_combined$FAMILYL                                                        0.040749
    ## DAY50_necrotic_granular_agranular_combined$GATEQ1_UL                                                      0.038226
    ## DAY50_necrotic_granular_agranular_combined$FAMILYB:DAY50_necrotic_granular_agranular_combined$GATEQ1_UL   0.055089
    ## DAY50_necrotic_granular_agranular_combined$FAMILYD:DAY50_necrotic_granular_agranular_combined$GATEQ1_UL   0.056267
    ## DAY50_necrotic_granular_agranular_combined$FAMILYE:DAY50_necrotic_granular_agranular_combined$GATEQ1_UL   0.054059
    ## DAY50_necrotic_granular_agranular_combined$FAMILYJ:DAY50_necrotic_granular_agranular_combined$GATEQ1_UL   0.057627
    ## DAY50_necrotic_granular_agranular_combined$FAMILYL:DAY50_necrotic_granular_agranular_combined$GATEQ1_UL   0.057627
    ##                                                                                                         t value
    ## (Intercept)                                                                                               4.328
    ## DAY50_necrotic_granular_agranular_combined$FAMILYB                                                       -1.227
    ## DAY50_necrotic_granular_agranular_combined$FAMILYD                                                       -0.048
    ## DAY50_necrotic_granular_agranular_combined$FAMILYE                                                       -0.764
    ## DAY50_necrotic_granular_agranular_combined$FAMILYJ                                                       -1.065
    ## DAY50_necrotic_granular_agranular_combined$FAMILYL                                                       -0.686
    ## DAY50_necrotic_granular_agranular_combined$GATEQ1_UL                                                      4.659
    ## DAY50_necrotic_granular_agranular_combined$FAMILYB:DAY50_necrotic_granular_agranular_combined$GATEQ1_UL   0.039
    ## DAY50_necrotic_granular_agranular_combined$FAMILYD:DAY50_necrotic_granular_agranular_combined$GATEQ1_UL   0.545
    ## DAY50_necrotic_granular_agranular_combined$FAMILYE:DAY50_necrotic_granular_agranular_combined$GATEQ1_UL   0.554
    ## DAY50_necrotic_granular_agranular_combined$FAMILYJ:DAY50_necrotic_granular_agranular_combined$GATEQ1_UL   0.053
    ## DAY50_necrotic_granular_agranular_combined$FAMILYL:DAY50_necrotic_granular_agranular_combined$GATEQ1_UL   0.053
    ##                                                                                                         Pr(>|t|)
    ## (Intercept)                                                                                             2.87e-05
    ## DAY50_necrotic_granular_agranular_combined$FAMILYB                                                         0.222
    ## DAY50_necrotic_granular_agranular_combined$FAMILYD                                                         0.962
    ## DAY50_necrotic_granular_agranular_combined$FAMILYE                                                         0.446
    ## DAY50_necrotic_granular_agranular_combined$FAMILYJ                                                         0.289
    ## DAY50_necrotic_granular_agranular_combined$FAMILYL                                                         0.494
    ## DAY50_necrotic_granular_agranular_combined$GATEQ1_UL                                                    7.41e-06
    ## DAY50_necrotic_granular_agranular_combined$FAMILYB:DAY50_necrotic_granular_agranular_combined$GATEQ1_UL    0.969
    ## DAY50_necrotic_granular_agranular_combined$FAMILYD:DAY50_necrotic_granular_agranular_combined$GATEQ1_UL    0.587
    ## DAY50_necrotic_granular_agranular_combined$FAMILYE:DAY50_necrotic_granular_agranular_combined$GATEQ1_UL    0.581
    ## DAY50_necrotic_granular_agranular_combined$FAMILYJ:DAY50_necrotic_granular_agranular_combined$GATEQ1_UL    0.958
    ## DAY50_necrotic_granular_agranular_combined$FAMILYL:DAY50_necrotic_granular_agranular_combined$GATEQ1_UL    0.958
    ##                                                                                                            
    ## (Intercept)                                                                                             ***
    ## DAY50_necrotic_granular_agranular_combined$FAMILYB                                                         
    ## DAY50_necrotic_granular_agranular_combined$FAMILYD                                                         
    ## DAY50_necrotic_granular_agranular_combined$FAMILYE                                                         
    ## DAY50_necrotic_granular_agranular_combined$FAMILYJ                                                         
    ## DAY50_necrotic_granular_agranular_combined$FAMILYL                                                         
    ## DAY50_necrotic_granular_agranular_combined$GATEQ1_UL                                                    ***
    ## DAY50_necrotic_granular_agranular_combined$FAMILYB:DAY50_necrotic_granular_agranular_combined$GATEQ1_UL    
    ## DAY50_necrotic_granular_agranular_combined$FAMILYD:DAY50_necrotic_granular_agranular_combined$GATEQ1_UL    
    ## DAY50_necrotic_granular_agranular_combined$FAMILYE:DAY50_necrotic_granular_agranular_combined$GATEQ1_UL    
    ## DAY50_necrotic_granular_agranular_combined$FAMILYJ:DAY50_necrotic_granular_agranular_combined$GATEQ1_UL    
    ## DAY50_necrotic_granular_agranular_combined$FAMILYL:DAY50_necrotic_granular_agranular_combined$GATEQ1_UL    
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
    ## 
    ## Residual standard error: 0.1011 on 138 degrees of freedom
    ## Multiple R-squared:  0.5027, Adjusted R-squared:  0.4631 
    ## F-statistic: 12.68 on 11 and 138 DF,  p-value: 2.4e-16

``` r
DAY50_necrotic_granular_agranular_aov_gate_leastsquares <- lsmeans(DAY50_necrotic_granular_agranular_aov_interaction, "DAY50_necrotic_granular_agranular_combined$GATE", adjust="tukey")
cld(DAY50_necrotic_granular_agranular_aov_gate_leastsquares, alpha=0.05, Letters=letters) # the means of the two groups not different
```

    ##  DAY50_necrotic_granular_agranular_combined$GATE    lsmean         SE  df
    ##  Q2_UL                                           0.1169957 0.02702957 138
    ##  Q1_UL                                           0.1169957 0.02702957 138
    ##    lower.CL  upper.CL .group
    ##  0.06355004 0.1704414  a    
    ##  0.06355004 0.1704414  a    
    ## 
    ## Results are averaged over the levels of: DAY50_necrotic_granular_agranular_combined$FAMILY 
    ## Confidence level used: 0.95 
    ## significance level used: alpha = 0.05

#### Live Non-Apoptotic Granular cells

``` r
DAY50_live_non_apoptotic_granular <- DAY50_APOP_PLOT4_GRANULAR_QUAD_PLOT %>% filter(GATE=="Q2_LL")

DAY50_live_non_apoptotic_granular_BAD_NOT_REMOVED_plot <- ggplot(data=DAY50_live_granular, aes(x=GROUP, y=PERCENT_OF_THIS_PLOT, fill=GROUP)) + geom_boxplot() + ggtitle("Percent of Live Non-Apoptotic Granular Hemocytes at Day 50 \n Low Quality Not Removed") +
    xlab("Family") + ylab("Percent of Hemocyte Events") + ylim(0,100)+ facet_grid(.~FAMILY+GROUP, scales="free") 

DAY50_live_non_apoptotic_granular_BAD_REMOVED <- DAY50_APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED %>% filter(GATE=="Q2_LL")
DAY50_live_non_apoptotic_granular_BAD_REMOVED_plot <- ggplot(data= DAY50_live_non_apoptotic_granular_BAD_REMOVED, aes(x=GROUP, y=PERCENT_OF_THIS_PLOT, fill=GROUP)) + geom_boxplot() + ggtitle("Percent of Live Non-Apoptotic Granulr Hemocytes at Day 50 \nLow Quality Removed") + xlab("Family") + ylab("Percent of Hemocyte Events") + ylim(0,100)+ facet_grid(.~FAMILY+GROUP, scales="free") 
DAY50_live_non_apoptotic_granular_BAD_REMOVED_plot
```

![](Dermo_Apoptosis_Assay_Data_analysis_files/figure-markdown_github/live_non_apoptotic_granular_day50-1.png)

### FAMILY A

``` r
DAY50_live_non_apoptotic_granular_FAMILY_A <- DAY50_live_non_apoptotic_granular %>% filter(FAMILY=="A")

DAY50_live_non_apoptotic_granular_FAMILY_A_aov <- aov(DAY50_live_non_apoptotic_granular_FAMILY_A$Arcsine ~ DAY50_live_non_apoptotic_granular_FAMILY_A$GROUP, data=DAY50_live_non_apoptotic_granular_FAMILY_A)
summary(DAY50_live_non_apoptotic_granular_FAMILY_A_aov)
```

    ##                                                  Df  Sum Sq  Mean Sq
    ## DAY50_live_non_apoptotic_granular_FAMILY_A$GROUP  1 0.00305 0.003051
    ## Residuals                                        12 0.05943 0.004952
    ##                                                  F value Pr(>F)
    ## DAY50_live_non_apoptotic_granular_FAMILY_A$GROUP   0.616  0.448
    ## Residuals

``` r
DAY50_live_non_apoptotic_granular_BAD_REMOVED_FAMILY_A <- DAY50_live_non_apoptotic_granular_BAD_REMOVED %>% filter(FAMILY=="A") 
DAY50_live_non_apoptotic_granular_BAD_REMOVED_FAMILY_A_aov <- aov(DAY50_live_non_apoptotic_granular_BAD_REMOVED_FAMILY_A$Arcsine ~ DAY50_live_non_apoptotic_granular_BAD_REMOVED_FAMILY_A$GROUP, data=DAY50_live_non_apoptotic_granular_BAD_REMOVED_FAMILY_A)
summary(DAY50_live_non_apoptotic_granular_BAD_REMOVED_FAMILY_A_aov)
```

    ##                                                              Df  Sum Sq
    ## DAY50_live_non_apoptotic_granular_BAD_REMOVED_FAMILY_A$GROUP  1 0.00305
    ## Residuals                                                    12 0.05943
    ##                                                               Mean Sq
    ## DAY50_live_non_apoptotic_granular_BAD_REMOVED_FAMILY_A$GROUP 0.003051
    ## Residuals                                                    0.004952
    ##                                                              F value
    ## DAY50_live_non_apoptotic_granular_BAD_REMOVED_FAMILY_A$GROUP   0.616
    ## Residuals                                                           
    ##                                                              Pr(>F)
    ## DAY50_live_non_apoptotic_granular_BAD_REMOVED_FAMILY_A$GROUP  0.448
    ## Residuals

### FAMILY B

``` r
DAY50_live_non_apoptotic_granular_FAMILY_B <- DAY50_live_non_apoptotic_granular %>% filter(FAMILY=="B")

DAY50_live_non_apoptotic_granular_FAMILY_B_aov <- aov(DAY50_live_non_apoptotic_granular_FAMILY_B$Arcsine ~ DAY50_live_non_apoptotic_granular_FAMILY_B$GROUP, data=DAY50_live_non_apoptotic_granular_FAMILY_B)
summary(DAY50_live_non_apoptotic_granular_FAMILY_B_aov)
```

    ##                                                  Df  Sum Sq  Mean Sq
    ## DAY50_live_non_apoptotic_granular_FAMILY_B$GROUP  1 0.00140 0.001395
    ## Residuals                                        12 0.03408 0.002840
    ##                                                  F value Pr(>F)
    ## DAY50_live_non_apoptotic_granular_FAMILY_B$GROUP   0.491  0.497
    ## Residuals

``` r
DAY50_live_non_apoptotic_granular_BAD_REMOVED_FAMILY_B <- DAY50_live_non_apoptotic_granular_BAD_REMOVED %>% filter(FAMILY=="B") 
DAY50_live_non_apoptotic_granular_BAD_REMOVED_FAMILY_B_aov <- aov(DAY50_live_non_apoptotic_granular_BAD_REMOVED_FAMILY_B$Arcsine ~ DAY50_live_non_apoptotic_granular_BAD_REMOVED_FAMILY_B$GROUP, data=DAY50_live_non_apoptotic_granular_BAD_REMOVED_FAMILY_B)
summary(DAY50_live_non_apoptotic_granular_BAD_REMOVED_FAMILY_B_aov)
```

    ##                                                              Df   Sum Sq
    ## DAY50_live_non_apoptotic_granular_BAD_REMOVED_FAMILY_B$GROUP  1 0.002637
    ## Residuals                                                    11 0.028950
    ##                                                               Mean Sq
    ## DAY50_live_non_apoptotic_granular_BAD_REMOVED_FAMILY_B$GROUP 0.002637
    ## Residuals                                                    0.002632
    ##                                                              F value
    ## DAY50_live_non_apoptotic_granular_BAD_REMOVED_FAMILY_B$GROUP   1.002
    ## Residuals                                                           
    ##                                                              Pr(>F)
    ## DAY50_live_non_apoptotic_granular_BAD_REMOVED_FAMILY_B$GROUP  0.338
    ## Residuals

### FAMILY D

``` r
DAY50_live_non_apoptotic_granular_FAMILY_D <- DAY50_live_non_apoptotic_granular %>% filter(FAMILY=="D")

DAY50_live_non_apoptotic_granular_FAMILY_D_aov <- aov(DAY50_live_non_apoptotic_granular_FAMILY_D$Arcsine ~ DAY50_live_non_apoptotic_granular_FAMILY_D$GROUP, data=DAY50_live_non_apoptotic_granular_FAMILY_D)
summary(DAY50_live_non_apoptotic_granular_FAMILY_D_aov)
```

    ##                                                  Df  Sum Sq  Mean Sq
    ## DAY50_live_non_apoptotic_granular_FAMILY_D$GROUP  1 0.00023 0.000226
    ## Residuals                                        12 0.09245 0.007704
    ##                                                  F value Pr(>F)
    ## DAY50_live_non_apoptotic_granular_FAMILY_D$GROUP   0.029  0.867
    ## Residuals

``` r
DAY50_live_non_apoptotic_granular_BAD_REMOVED_FAMILY_D <- DAY50_live_non_apoptotic_granular_BAD_REMOVED %>% filter(FAMILY=="D") 
DAY50_live_non_apoptotic_granular_BAD_REMOVED_FAMILY_D_aov <- aov(DAY50_live_non_apoptotic_granular_BAD_REMOVED_FAMILY_D$Arcsine ~ DAY50_live_non_apoptotic_granular_BAD_REMOVED_FAMILY_D$GROUP, data=DAY50_live_non_apoptotic_granular_BAD_REMOVED_FAMILY_D)
summary(DAY50_live_non_apoptotic_granular_BAD_REMOVED_FAMILY_D_aov)
```

    ##                                                              Df  Sum Sq
    ## DAY50_live_non_apoptotic_granular_BAD_REMOVED_FAMILY_D$GROUP  1 0.00205
    ## Residuals                                                    10 0.08658
    ##                                                               Mean Sq
    ## DAY50_live_non_apoptotic_granular_BAD_REMOVED_FAMILY_D$GROUP 0.002052
    ## Residuals                                                    0.008658
    ##                                                              F value
    ## DAY50_live_non_apoptotic_granular_BAD_REMOVED_FAMILY_D$GROUP   0.237
    ## Residuals                                                           
    ##                                                              Pr(>F)
    ## DAY50_live_non_apoptotic_granular_BAD_REMOVED_FAMILY_D$GROUP  0.637
    ## Residuals

### FAMILY E

``` r
DAY50_live_non_apoptotic_granular_FAMILY_E <- DAY50_live_non_apoptotic_granular %>% filter(FAMILY=="E")

DAY50_live_non_apoptotic_granular_FAMILY_E_aov <- aov(DAY50_live_non_apoptotic_granular_FAMILY_E$Arcsine ~ DAY50_live_non_apoptotic_granular_FAMILY_E$GROUP, data=DAY50_live_non_apoptotic_granular_FAMILY_E)
summary(DAY50_live_non_apoptotic_granular_FAMILY_E_aov)
```

    ##                                                  Df  Sum Sq  Mean Sq
    ## DAY50_live_non_apoptotic_granular_FAMILY_E$GROUP  1 0.00350 0.003503
    ## Residuals                                        13 0.03327 0.002559
    ##                                                  F value Pr(>F)
    ## DAY50_live_non_apoptotic_granular_FAMILY_E$GROUP   1.369  0.263
    ## Residuals

``` r
DAY50_live_non_apoptotic_granular_BAD_REMOVED_FAMILY_E <- DAY50_live_non_apoptotic_granular_BAD_REMOVED %>% filter(FAMILY=="E") 
DAY50_live_non_apoptotic_granular_BAD_REMOVED_FAMILY_E_aov <- aov(DAY50_live_non_apoptotic_granular_BAD_REMOVED_FAMILY_E$Arcsine ~ DAY50_live_non_apoptotic_granular_BAD_REMOVED_FAMILY_E$GROUP, data=DAY50_live_non_apoptotic_granular_BAD_REMOVED_FAMILY_E)
summary(DAY50_live_non_apoptotic_granular_BAD_REMOVED_FAMILY_E_aov)
```

    ##                                                              Df   Sum Sq
    ## DAY50_live_non_apoptotic_granular_BAD_REMOVED_FAMILY_E$GROUP  1 0.001521
    ## Residuals                                                    12 0.031520
    ##                                                               Mean Sq
    ## DAY50_live_non_apoptotic_granular_BAD_REMOVED_FAMILY_E$GROUP 0.001521
    ## Residuals                                                    0.002627
    ##                                                              F value
    ## DAY50_live_non_apoptotic_granular_BAD_REMOVED_FAMILY_E$GROUP   0.579
    ## Residuals                                                           
    ##                                                              Pr(>F)
    ## DAY50_live_non_apoptotic_granular_BAD_REMOVED_FAMILY_E$GROUP  0.461
    ## Residuals

### FAMILY J

``` r
DAY50_live_non_apoptotic_granular_FAMILY_J <- DAY50_live_non_apoptotic_granular %>% filter(FAMILY=="J")

DAY50_live_non_apoptotic_granular_FAMILY_J_aov <- aov(DAY50_live_non_apoptotic_granular_FAMILY_J$Arcsine ~ DAY50_live_non_apoptotic_granular_FAMILY_J$GROUP, data=DAY50_live_non_apoptotic_granular_FAMILY_J)
summary(DAY50_live_non_apoptotic_granular_FAMILY_J_aov)
```

    ##                                                  Df  Sum Sq  Mean Sq
    ## DAY50_live_non_apoptotic_granular_FAMILY_J$GROUP  1 0.01021 0.010208
    ## Residuals                                        11 0.07009 0.006371
    ##                                                  F value Pr(>F)
    ## DAY50_live_non_apoptotic_granular_FAMILY_J$GROUP   1.602  0.232
    ## Residuals

``` r
DAY50_live_non_apoptotic_granular_BAD_REMOVED_FAMILY_J <- DAY50_live_non_apoptotic_granular_BAD_REMOVED %>% filter(FAMILY=="J") 
DAY50_live_non_apoptotic_granular_BAD_REMOVED_FAMILY_J_aov <- aov(DAY50_live_non_apoptotic_granular_BAD_REMOVED_FAMILY_J$Arcsine ~ DAY50_live_non_apoptotic_granular_BAD_REMOVED_FAMILY_J$GROUP, data=DAY50_live_non_apoptotic_granular_BAD_REMOVED_FAMILY_J)
summary(DAY50_live_non_apoptotic_granular_BAD_REMOVED_FAMILY_J_aov)
```

    ##                                                              Df  Sum Sq
    ## DAY50_live_non_apoptotic_granular_BAD_REMOVED_FAMILY_J$GROUP  1 0.01282
    ## Residuals                                                     9 0.05566
    ##                                                               Mean Sq
    ## DAY50_live_non_apoptotic_granular_BAD_REMOVED_FAMILY_J$GROUP 0.012817
    ## Residuals                                                    0.006184
    ##                                                              F value
    ## DAY50_live_non_apoptotic_granular_BAD_REMOVED_FAMILY_J$GROUP   2.073
    ## Residuals                                                           
    ##                                                              Pr(>F)
    ## DAY50_live_non_apoptotic_granular_BAD_REMOVED_FAMILY_J$GROUP  0.184
    ## Residuals

### FAMILY L

``` r
DAY50_live_non_apoptotic_granular_FAMILY_L <- DAY50_live_non_apoptotic_granular %>% filter(FAMILY=="L")

DAY50_live_non_apoptotic_granular_FAMILY_L_aov <- aov(DAY50_live_non_apoptotic_granular_FAMILY_L$Arcsine ~ DAY50_live_non_apoptotic_granular_FAMILY_L$GROUP, data=DAY50_live_non_apoptotic_granular_FAMILY_L)
summary(DAY50_live_non_apoptotic_granular_FAMILY_L_aov)
```

    ##                                                  Df  Sum Sq  Mean Sq
    ## DAY50_live_non_apoptotic_granular_FAMILY_L$GROUP  1 0.00363 0.003626
    ## Residuals                                         9 0.05768 0.006409
    ##                                                  F value Pr(>F)
    ## DAY50_live_non_apoptotic_granular_FAMILY_L$GROUP   0.566  0.471
    ## Residuals

``` r
DAY50_live_non_apoptotic_granular_BAD_REMOVED_FAMILY_L <- DAY50_live_non_apoptotic_granular_BAD_REMOVED %>% filter(FAMILY=="L") 
DAY50_live_non_apoptotic_granular_BAD_REMOVED_FAMILY_L_aov <- aov(DAY50_live_non_apoptotic_granular_BAD_REMOVED_FAMILY_L$Arcsine ~ DAY50_live_non_apoptotic_granular_BAD_REMOVED_FAMILY_L$GROUP, data=DAY50_live_non_apoptotic_granular_BAD_REMOVED_FAMILY_L)
summary(DAY50_live_non_apoptotic_granular_BAD_REMOVED_FAMILY_L_aov)
```

    ##                                                              Df  Sum Sq
    ## DAY50_live_non_apoptotic_granular_BAD_REMOVED_FAMILY_L$GROUP  1 0.00363
    ## Residuals                                                     9 0.05768
    ##                                                               Mean Sq
    ## DAY50_live_non_apoptotic_granular_BAD_REMOVED_FAMILY_L$GROUP 0.003626
    ## Residuals                                                    0.006409
    ##                                                              F value
    ## DAY50_live_non_apoptotic_granular_BAD_REMOVED_FAMILY_L$GROUP   0.566
    ## Residuals                                                           
    ##                                                              Pr(>F)
    ## DAY50_live_non_apoptotic_granular_BAD_REMOVED_FAMILY_L$GROUP  0.471
    ## Residuals

### Two Way ANOVA of Live Non-Apoptotic Granular

``` r
DAY50_live_non_apoptotic_granular_twoway_BAD_REMOVED_lm <- lm(DAY50_live_non_apoptotic_granular_BAD_REMOVED$Arcsine ~ DAY50_live_non_apoptotic_granular_BAD_REMOVED$GROUP + DAY50_live_granular_BAD_REMOVED$FAMILY, data=DAY50_live_non_apoptotic_granular_BAD_REMOVED)
Anova(DAY50_live_non_apoptotic_granular_twoway_BAD_REMOVED_lm, type="II")
```

    ## Anova Table (Type II tests)
    ## 
    ## Response: DAY50_live_non_apoptotic_granular_BAD_REMOVED$Arcsine
    ##                                                      Sum Sq Df F value
    ## DAY50_live_non_apoptotic_granular_BAD_REMOVED$GROUP 0.00466  1  0.9296
    ## DAY50_live_granular_BAD_REMOVED$FAMILY              0.04709  5  1.8789
    ## Residuals                                           0.34086 68        
    ##                                                     Pr(>F)
    ## DAY50_live_non_apoptotic_granular_BAD_REMOVED$GROUP 0.3384
    ## DAY50_live_granular_BAD_REMOVED$FAMILY              0.1095
    ## Residuals

``` r
summary(DAY50_live_non_apoptotic_granular_twoway_BAD_REMOVED_lm)
```

    ## 
    ## Call:
    ## lm(formula = DAY50_live_non_apoptotic_granular_BAD_REMOVED$Arcsine ~ 
    ##     DAY50_live_non_apoptotic_granular_BAD_REMOVED$GROUP + DAY50_live_granular_BAD_REMOVED$FAMILY, 
    ##     data = DAY50_live_non_apoptotic_granular_BAD_REMOVED)
    ## 
    ## Residuals:
    ##       Min        1Q    Median        3Q       Max 
    ## -0.205168 -0.046417 -0.009212  0.043377  0.146268 
    ## 
    ## Coefficients:
    ##                                                              Estimate
    ## (Intercept)                                                   1.23410
    ## DAY50_live_non_apoptotic_granular_BAD_REMOVED$GROUPtreatment -0.01697
    ## DAY50_live_granular_BAD_REMOVED$FAMILYB                      -0.01114
    ## DAY50_live_granular_BAD_REMOVED$FAMILYD                      -0.06570
    ## DAY50_live_granular_BAD_REMOVED$FAMILYE                      -0.05088
    ## DAY50_live_granular_BAD_REMOVED$FAMILYJ                      -0.05541
    ## DAY50_live_granular_BAD_REMOVED$FAMILYL                      -0.05349
    ##                                                              Std. Error
    ## (Intercept)                                                     0.02272
    ## DAY50_live_non_apoptotic_granular_BAD_REMOVED$GROUPtreatment    0.01760
    ## DAY50_live_granular_BAD_REMOVED$FAMILYB                         0.02733
    ## DAY50_live_granular_BAD_REMOVED$FAMILYD                         0.02787
    ## DAY50_live_granular_BAD_REMOVED$FAMILYE                         0.02676
    ## DAY50_live_granular_BAD_REMOVED$FAMILYJ                         0.02853
    ## DAY50_live_granular_BAD_REMOVED$FAMILYL                         0.02856
    ##                                                              t value
    ## (Intercept)                                                   54.325
    ## DAY50_live_non_apoptotic_granular_BAD_REMOVED$GROUPtreatment  -0.964
    ## DAY50_live_granular_BAD_REMOVED$FAMILYB                       -0.408
    ## DAY50_live_granular_BAD_REMOVED$FAMILYD                       -2.358
    ## DAY50_live_granular_BAD_REMOVED$FAMILYE                       -1.901
    ## DAY50_live_granular_BAD_REMOVED$FAMILYJ                       -1.942
    ## DAY50_live_granular_BAD_REMOVED$FAMILYL                       -1.873
    ##                                                              Pr(>|t|)    
    ## (Intercept)                                                    <2e-16 ***
    ## DAY50_live_non_apoptotic_granular_BAD_REMOVED$GROUPtreatment   0.3384    
    ## DAY50_live_granular_BAD_REMOVED$FAMILYB                        0.6847    
    ## DAY50_live_granular_BAD_REMOVED$FAMILYD                        0.0213 *  
    ## DAY50_live_granular_BAD_REMOVED$FAMILYE                        0.0615 .  
    ## DAY50_live_granular_BAD_REMOVED$FAMILYJ                        0.0563 .  
    ## DAY50_live_granular_BAD_REMOVED$FAMILYL                        0.0654 .  
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
    ## 
    ## Residual standard error: 0.0708 on 68 degrees of freedom
    ## Multiple R-squared:  0.1325, Adjusted R-squared:  0.05594 
    ## F-statistic: 1.731 on 6 and 68 DF,  p-value: 0.1271

### One Way ANOVA of Live Non-Apoptotic Granular Just Challenged

``` r
DAY50_live_non_apoptotic_granular_BAD_REMOVED_CHALLENGE <- DAY50_live_non_apoptotic_granular_BAD_REMOVED[!grepl("control", DAY50_live_non_apoptotic_granular_BAD_REMOVED$GROUP),]

DAY50_live_non_apoptotic_granular_BAD_REMOVED_CHALLENGE_aov <- aov(DAY50_live_non_apoptotic_granular_BAD_REMOVED_CHALLENGE$Arcsine ~ DAY50_live_non_apoptotic_granular_BAD_REMOVED_CHALLENGE$FAMILY, data=DAY50_live_non_apoptotic_granular_BAD_REMOVED_CHALLENGE)
summary(DAY50_live_non_apoptotic_granular_BAD_REMOVED_CHALLENGE_aov) # significantly different between families 
```

    ##                                                                Df  Sum Sq
    ## DAY50_live_non_apoptotic_granular_BAD_REMOVED_CHALLENGE$FAMILY  5 0.04782
    ## Residuals                                                      45 0.21810
    ##                                                                 Mean Sq
    ## DAY50_live_non_apoptotic_granular_BAD_REMOVED_CHALLENGE$FAMILY 0.009564
    ## Residuals                                                      0.004847
    ##                                                                F value
    ## DAY50_live_non_apoptotic_granular_BAD_REMOVED_CHALLENGE$FAMILY   1.973
    ## Residuals                                                             
    ##                                                                Pr(>F)
    ## DAY50_live_non_apoptotic_granular_BAD_REMOVED_CHALLENGE$FAMILY  0.101
    ## Residuals

Live Non-Apoptotic Agranular
----------------------------

``` r
DAY50_live_non_apoptotic_agranular <- DAY50_APOP_PLOT7_AGRANULAR_QUAD_PLOT %>% filter(GATE=="Q1_LL")

DAY50_live_non_apoptotic_agranular_BAD_NOT_REMOVED_plot <- ggplot(data=DAY50_live_non_apoptotic_agranular, aes(x=GROUP, y=PERCENT_OF_THIS_PLOT, fill=GROUP)) + geom_boxplot() + ggtitle("Percent of Live Non-Apoptotic Agranular Hemocytes at Day 50 \n Low Quality Not Removed") +
    xlab("Family") + ylab("Percent of Hemocyte Events") + ylim(0,100)+ facet_grid(.~FAMILY+GROUP, scales="free") 

DAY50_live_non_apoptotic_agranular_BAD_REMOVED <- DAY50_APOP_PLOT7_AGRANULAR_QUAD_PLOT %>% filter(GATE=="Q1_LL")

DAY50_live_non_apoptotic_agranular_BAD_REMOVED_plot <- ggplot(data=DAY50_live_non_apoptotic_agranular_BAD_REMOVED, aes(x=GROUP, y=PERCENT_OF_THIS_PLOT, fill=GROUP)) + geom_boxplot() + ggtitle("Percent of Live Non-Apoptotic Agranular Hemocytes at Day 50 \nLow Quality Removed") + xlab("Family") + ylab("Percent of Hemocyte Events") + ylim(0,100)+ facet_grid(.~FAMILY+GROUP, scales="free") 
DAY50_live_non_apoptotic_agranular_BAD_REMOVED_plot
```

![](Dermo_Apoptosis_Assay_Data_analysis_files/figure-markdown_github/live_non_apoptotic_agranular_day50-1.png)

### FAMILY A

``` r
DAY50_live_non_apoptotic_agranular_FAMILY_A <- DAY50_live_non_apoptotic_agranular %>% filter(FAMILY=="A")

DAY50_live_non_apoptotic_agranular_FAMILY_A_aov <- aov(DAY50_live_non_apoptotic_agranular_FAMILY_A$Arcsine ~ DAY50_live_non_apoptotic_agranular_FAMILY_A$GROUP, data=DAY50_live_non_apoptotic_agranular_FAMILY_A)
summary(DAY50_live_non_apoptotic_agranular_FAMILY_A_aov)
```

    ##                                                   Df Sum Sq Mean Sq
    ## DAY50_live_non_apoptotic_agranular_FAMILY_A$GROUP  1 0.0272  0.0272
    ## Residuals                                         12 0.5916  0.0493
    ##                                                   F value Pr(>F)
    ## DAY50_live_non_apoptotic_agranular_FAMILY_A$GROUP   0.552  0.472
    ## Residuals

``` r
DAY50_live_non_apoptotic_agranular_BAD_REMOVED_FAMILY_A <- DAY50_live_non_apoptotic_agranular_BAD_REMOVED %>% filter(FAMILY=="A") 
DAY50_live_non_apoptotic_agranular_BAD_REMOVED_FAMILY_A_aov <- aov(DAY50_live_non_apoptotic_agranular_BAD_REMOVED_FAMILY_A$Arcsine ~ DAY50_live_non_apoptotic_agranular_BAD_REMOVED_FAMILY_A$GROUP, data=DAY50_live_non_apoptotic_agranular_BAD_REMOVED_FAMILY_A)
summary(DAY50_live_non_apoptotic_agranular_BAD_REMOVED_FAMILY_A_aov)
```

    ##                                                               Df Sum Sq
    ## DAY50_live_non_apoptotic_agranular_BAD_REMOVED_FAMILY_A$GROUP  1 0.0272
    ## Residuals                                                     12 0.5916
    ##                                                               Mean Sq
    ## DAY50_live_non_apoptotic_agranular_BAD_REMOVED_FAMILY_A$GROUP  0.0272
    ## Residuals                                                      0.0493
    ##                                                               F value
    ## DAY50_live_non_apoptotic_agranular_BAD_REMOVED_FAMILY_A$GROUP   0.552
    ## Residuals                                                            
    ##                                                               Pr(>F)
    ## DAY50_live_non_apoptotic_agranular_BAD_REMOVED_FAMILY_A$GROUP  0.472
    ## Residuals

### FAMILY B

``` r
DAY50_live_non_apoptotic_agranular_FAMILY_B <- DAY50_live_non_apoptotic_agranular %>% filter(FAMILY=="B")

DAY50_live_non_apoptotic_agranular_FAMILY_B_aov <- aov(DAY50_live_non_apoptotic_agranular_FAMILY_B$Arcsine ~ DAY50_live_non_apoptotic_agranular_FAMILY_B$GROUP, data=DAY50_live_non_apoptotic_agranular_FAMILY_B)
summary(DAY50_live_non_apoptotic_agranular_FAMILY_B_aov)
```

    ##                                                   Df  Sum Sq Mean Sq
    ## DAY50_live_non_apoptotic_agranular_FAMILY_B$GROUP  1 0.01364 0.01364
    ## Residuals                                         12 0.21061 0.01755
    ##                                                   F value Pr(>F)
    ## DAY50_live_non_apoptotic_agranular_FAMILY_B$GROUP   0.777  0.395
    ## Residuals

``` r
DAY50_live_non_apoptotic_agranular_BAD_REMOVED_FAMILY_B <- DAY50_live_non_apoptotic_agranular_BAD_REMOVED %>% filter(FAMILY=="B") 
DAY50_live_non_apoptotic_agranular_BAD_REMOVED_FAMILY_B_aov <- aov(DAY50_live_non_apoptotic_agranular_BAD_REMOVED_FAMILY_B$Arcsine ~ DAY50_live_non_apoptotic_agranular_BAD_REMOVED_FAMILY_B$GROUP, data=DAY50_live_non_apoptotic_agranular_BAD_REMOVED_FAMILY_B)
summary(DAY50_live_non_apoptotic_agranular_BAD_REMOVED_FAMILY_B_aov)
```

    ##                                                               Df  Sum Sq
    ## DAY50_live_non_apoptotic_agranular_BAD_REMOVED_FAMILY_B$GROUP  1 0.01364
    ## Residuals                                                     12 0.21061
    ##                                                               Mean Sq
    ## DAY50_live_non_apoptotic_agranular_BAD_REMOVED_FAMILY_B$GROUP 0.01364
    ## Residuals                                                     0.01755
    ##                                                               F value
    ## DAY50_live_non_apoptotic_agranular_BAD_REMOVED_FAMILY_B$GROUP   0.777
    ## Residuals                                                            
    ##                                                               Pr(>F)
    ## DAY50_live_non_apoptotic_agranular_BAD_REMOVED_FAMILY_B$GROUP  0.395
    ## Residuals

### FAMILY D

``` r
DAY50_live_non_apoptotic_agranular_FAMILY_D <- DAY50_live_non_apoptotic_agranular %>% filter(FAMILY=="D")

DAY50_live_non_apoptotic_agranular_FAMILY_D_aov <- aov(DAY50_live_non_apoptotic_agranular_FAMILY_D$Arcsine ~ DAY50_live_non_apoptotic_agranular_FAMILY_D$GROUP, data=DAY50_live_non_apoptotic_agranular_FAMILY_D)
summary(DAY50_live_non_apoptotic_agranular_FAMILY_D_aov)
```

    ##                                                   Df Sum Sq Mean Sq
    ## DAY50_live_non_apoptotic_agranular_FAMILY_D$GROUP  1 0.0089 0.00888
    ## Residuals                                         12 0.7067 0.05889
    ##                                                   F value Pr(>F)
    ## DAY50_live_non_apoptotic_agranular_FAMILY_D$GROUP   0.151  0.705
    ## Residuals

``` r
DAY50_live_non_apoptotic_agranular_BAD_REMOVED_FAMILY_D <- DAY50_live_non_apoptotic_agranular_BAD_REMOVED %>% filter(FAMILY=="D") 
DAY50_live_non_apoptotic_agranular_BAD_REMOVED_FAMILY_D_aov <- aov(DAY50_live_non_apoptotic_agranular_BAD_REMOVED_FAMILY_D$Arcsine ~ DAY50_live_non_apoptotic_agranular_BAD_REMOVED_FAMILY_D$GROUP, data=DAY50_live_non_apoptotic_agranular_BAD_REMOVED_FAMILY_D)
summary(DAY50_live_non_apoptotic_agranular_BAD_REMOVED_FAMILY_D_aov)
```

    ##                                                               Df Sum Sq
    ## DAY50_live_non_apoptotic_agranular_BAD_REMOVED_FAMILY_D$GROUP  1 0.0089
    ## Residuals                                                     12 0.7067
    ##                                                               Mean Sq
    ## DAY50_live_non_apoptotic_agranular_BAD_REMOVED_FAMILY_D$GROUP 0.00888
    ## Residuals                                                     0.05889
    ##                                                               F value
    ## DAY50_live_non_apoptotic_agranular_BAD_REMOVED_FAMILY_D$GROUP   0.151
    ## Residuals                                                            
    ##                                                               Pr(>F)
    ## DAY50_live_non_apoptotic_agranular_BAD_REMOVED_FAMILY_D$GROUP  0.705
    ## Residuals

### FAMILY E

``` r
DAY50_live_non_apoptotic_agranular_FAMILY_E <- DAY50_live_non_apoptotic_agranular %>% filter(FAMILY=="E")

DAY50_live_non_apoptotic_agranular_FAMILY_E_aov <- aov(DAY50_live_non_apoptotic_agranular_FAMILY_E$Arcsine ~ DAY50_live_non_apoptotic_agranular_FAMILY_E$GROUP, data=DAY50_live_non_apoptotic_agranular_FAMILY_E)
summary(DAY50_live_non_apoptotic_agranular_FAMILY_E_aov)
```

    ##                                                   Df Sum Sq Mean Sq
    ## DAY50_live_non_apoptotic_agranular_FAMILY_E$GROUP  1 0.0230 0.02297
    ## Residuals                                         13 0.3627 0.02790
    ##                                                   F value Pr(>F)
    ## DAY50_live_non_apoptotic_agranular_FAMILY_E$GROUP   0.824  0.381
    ## Residuals

``` r
DAY50_live_non_apoptotic_agranular_BAD_REMOVED_FAMILY_E <- DAY50_live_non_apoptotic_agranular_BAD_REMOVED %>% filter(FAMILY=="E") 
DAY50_live_non_apoptotic_agranular_BAD_REMOVED_FAMILY_E_aov <- aov(DAY50_live_non_apoptotic_agranular_BAD_REMOVED_FAMILY_E$Arcsine ~ DAY50_live_non_apoptotic_agranular_BAD_REMOVED_FAMILY_E$GROUP, data=DAY50_live_non_apoptotic_agranular_BAD_REMOVED_FAMILY_E)
summary(DAY50_live_non_apoptotic_agranular_BAD_REMOVED_FAMILY_E_aov)
```

    ##                                                               Df Sum Sq
    ## DAY50_live_non_apoptotic_agranular_BAD_REMOVED_FAMILY_E$GROUP  1 0.0230
    ## Residuals                                                     13 0.3627
    ##                                                               Mean Sq
    ## DAY50_live_non_apoptotic_agranular_BAD_REMOVED_FAMILY_E$GROUP 0.02297
    ## Residuals                                                     0.02790
    ##                                                               F value
    ## DAY50_live_non_apoptotic_agranular_BAD_REMOVED_FAMILY_E$GROUP   0.824
    ## Residuals                                                            
    ##                                                               Pr(>F)
    ## DAY50_live_non_apoptotic_agranular_BAD_REMOVED_FAMILY_E$GROUP  0.381
    ## Residuals

### FAMILY J

``` r
DAY50_live_non_apoptotic_agranular_FAMILY_J <- DAY50_live_non_apoptotic_agranular %>% filter(FAMILY=="J")

DAY50_live_non_apoptotic_agranular_FAMILY_J_aov <- aov(DAY50_live_non_apoptotic_agranular_FAMILY_J$Arcsine ~ DAY50_live_non_apoptotic_agranular_FAMILY_J$GROUP, data=DAY50_live_non_apoptotic_agranular_FAMILY_J)
summary(DAY50_live_non_apoptotic_agranular_FAMILY_J_aov)
```

    ##                                                   Df Sum Sq  Mean Sq
    ## DAY50_live_non_apoptotic_agranular_FAMILY_J$GROUP  1 0.0033 0.003318
    ## Residuals                                         11 0.3285 0.029861
    ##                                                   F value Pr(>F)
    ## DAY50_live_non_apoptotic_agranular_FAMILY_J$GROUP   0.111  0.745
    ## Residuals

``` r
DAY50_live_non_apoptotic_agranular_BAD_REMOVED_FAMILY_J <- DAY50_live_non_apoptotic_agranular_BAD_REMOVED %>% filter(FAMILY=="J") 
DAY50_live_non_apoptotic_agranular_BAD_REMOVED_FAMILY_J_aov <- aov(DAY50_live_non_apoptotic_agranular_BAD_REMOVED_FAMILY_J$Arcsine ~ DAY50_live_non_apoptotic_agranular_BAD_REMOVED_FAMILY_J$GROUP, data=DAY50_live_non_apoptotic_agranular_BAD_REMOVED_FAMILY_J)
summary(DAY50_live_non_apoptotic_agranular_BAD_REMOVED_FAMILY_J_aov)
```

    ##                                                               Df Sum Sq
    ## DAY50_live_non_apoptotic_agranular_BAD_REMOVED_FAMILY_J$GROUP  1 0.0033
    ## Residuals                                                     11 0.3285
    ##                                                                Mean Sq
    ## DAY50_live_non_apoptotic_agranular_BAD_REMOVED_FAMILY_J$GROUP 0.003318
    ## Residuals                                                     0.029861
    ##                                                               F value
    ## DAY50_live_non_apoptotic_agranular_BAD_REMOVED_FAMILY_J$GROUP   0.111
    ## Residuals                                                            
    ##                                                               Pr(>F)
    ## DAY50_live_non_apoptotic_agranular_BAD_REMOVED_FAMILY_J$GROUP  0.745
    ## Residuals

### FAMILY L

``` r
DAY50_live_non_apoptotic_agranular_FAMILY_L <- DAY50_live_non_apoptotic_agranular %>% filter(FAMILY=="L")

DAY50_live_non_apoptotic_agranular_FAMILY_L_aov <- aov(DAY50_live_non_apoptotic_agranular_FAMILY_L$Arcsine ~ DAY50_live_non_apoptotic_agranular_FAMILY_L$GROUP, data=DAY50_live_non_apoptotic_agranular_FAMILY_L)
summary(DAY50_live_non_apoptotic_agranular_FAMILY_L_aov)
```

    ##                                                   Df  Sum Sq Mean Sq
    ## DAY50_live_non_apoptotic_agranular_FAMILY_L$GROUP  1 0.01289 0.01289
    ## Residuals                                          9 0.14272 0.01586
    ##                                                   F value Pr(>F)
    ## DAY50_live_non_apoptotic_agranular_FAMILY_L$GROUP   0.813  0.391
    ## Residuals

``` r
DAY50_live_non_apoptotic_agranular_BAD_REMOVED_FAMILY_L <- DAY50_live_non_apoptotic_agranular_BAD_REMOVED %>% filter(FAMILY=="L") 
DAY50_live_non_apoptotic_agranular_BAD_REMOVED_FAMILY_L_aov <- aov(DAY50_live_non_apoptotic_agranular_BAD_REMOVED_FAMILY_L$Arcsine ~ DAY50_live_non_apoptotic_agranular_BAD_REMOVED_FAMILY_L$GROUP, data=DAY50_live_non_apoptotic_agranular_BAD_REMOVED_FAMILY_L)
summary(DAY50_live_non_apoptotic_agranular_BAD_REMOVED_FAMILY_L_aov)
```

    ##                                                               Df  Sum Sq
    ## DAY50_live_non_apoptotic_agranular_BAD_REMOVED_FAMILY_L$GROUP  1 0.01289
    ## Residuals                                                      9 0.14272
    ##                                                               Mean Sq
    ## DAY50_live_non_apoptotic_agranular_BAD_REMOVED_FAMILY_L$GROUP 0.01289
    ## Residuals                                                     0.01586
    ##                                                               F value
    ## DAY50_live_non_apoptotic_agranular_BAD_REMOVED_FAMILY_L$GROUP   0.813
    ## Residuals                                                            
    ##                                                               Pr(>F)
    ## DAY50_live_non_apoptotic_agranular_BAD_REMOVED_FAMILY_L$GROUP  0.391
    ## Residuals

### Two Way ANOVA of Live Agranular

``` r
DAY50_live_non_apoptotic_agranular_twoway_BAD_REMOVED_lm <- lm(DAY50_live_non_apoptotic_agranular_BAD_REMOVED$Arcsine ~ DAY50_live_non_apoptotic_agranular_BAD_REMOVED$GROUP + DAY50_live_non_apoptotic_agranular_BAD_REMOVED$FAMILY, data=DAY50_live_non_apoptotic_agranular_BAD_REMOVED)
Anova(DAY50_live_non_apoptotic_agranular_twoway_BAD_REMOVED_lm , type="II")
```

    ## Anova Table (Type II tests)
    ## 
    ## Response: DAY50_live_non_apoptotic_agranular_BAD_REMOVED$Arcsine
    ##                                                        Sum Sq Df F value
    ## DAY50_live_non_apoptotic_agranular_BAD_REMOVED$GROUP  0.02406  1  0.7394
    ## DAY50_live_non_apoptotic_agranular_BAD_REMOVED$FAMILY 0.08726  5  0.5364
    ## Residuals                                             2.40766 74        
    ##                                                       Pr(>F)
    ## DAY50_live_non_apoptotic_agranular_BAD_REMOVED$GROUP  0.3926
    ## DAY50_live_non_apoptotic_agranular_BAD_REMOVED$FAMILY 0.7481
    ## Residuals

``` r
summary(DAY50_live_non_apoptotic_agranular_twoway_BAD_REMOVED_lm)
```

    ## 
    ## Call:
    ## lm(formula = DAY50_live_non_apoptotic_agranular_BAD_REMOVED$Arcsine ~ 
    ##     DAY50_live_non_apoptotic_agranular_BAD_REMOVED$GROUP + DAY50_live_non_apoptotic_agranular_BAD_REMOVED$FAMILY, 
    ##     data = DAY50_live_non_apoptotic_agranular_BAD_REMOVED)
    ## 
    ## Residuals:
    ##      Min       1Q   Median       3Q      Max 
    ## -0.64013 -0.09864  0.00600  0.11555  0.30519 
    ## 
    ## Coefficients:
    ##                                                               Estimate
    ## (Intercept)                                                    0.99858
    ## DAY50_live_non_apoptotic_agranular_BAD_REMOVED$GROUPtreatment  0.03663
    ## DAY50_live_non_apoptotic_agranular_BAD_REMOVED$FAMILYB        -0.00457
    ## DAY50_live_non_apoptotic_agranular_BAD_REMOVED$FAMILYD        -0.03645
    ## DAY50_live_non_apoptotic_agranular_BAD_REMOVED$FAMILYE        -0.05148
    ## DAY50_live_non_apoptotic_agranular_BAD_REMOVED$FAMILYJ        -0.03679
    ## DAY50_live_non_apoptotic_agranular_BAD_REMOVED$FAMILYL        -0.10462
    ##                                                               Std. Error
    ## (Intercept)                                                      0.05701
    ## DAY50_live_non_apoptotic_agranular_BAD_REMOVED$GROUPtreatment    0.04259
    ## DAY50_live_non_apoptotic_agranular_BAD_REMOVED$FAMILYB           0.06824
    ## DAY50_live_non_apoptotic_agranular_BAD_REMOVED$FAMILYD           0.06824
    ## DAY50_live_non_apoptotic_agranular_BAD_REMOVED$FAMILYE           0.06706
    ## DAY50_live_non_apoptotic_agranular_BAD_REMOVED$FAMILYJ           0.06948
    ## DAY50_live_non_apoptotic_agranular_BAD_REMOVED$FAMILYL           0.07275
    ##                                                               t value
    ## (Intercept)                                                    17.517
    ## DAY50_live_non_apoptotic_agranular_BAD_REMOVED$GROUPtreatment   0.860
    ## DAY50_live_non_apoptotic_agranular_BAD_REMOVED$FAMILYB         -0.067
    ## DAY50_live_non_apoptotic_agranular_BAD_REMOVED$FAMILYD         -0.534
    ## DAY50_live_non_apoptotic_agranular_BAD_REMOVED$FAMILYE         -0.768
    ## DAY50_live_non_apoptotic_agranular_BAD_REMOVED$FAMILYJ         -0.529
    ## DAY50_live_non_apoptotic_agranular_BAD_REMOVED$FAMILYL         -1.438
    ##                                                               Pr(>|t|)    
    ## (Intercept)                                                     <2e-16 ***
    ## DAY50_live_non_apoptotic_agranular_BAD_REMOVED$GROUPtreatment    0.393    
    ## DAY50_live_non_apoptotic_agranular_BAD_REMOVED$FAMILYB           0.947    
    ## DAY50_live_non_apoptotic_agranular_BAD_REMOVED$FAMILYD           0.595    
    ## DAY50_live_non_apoptotic_agranular_BAD_REMOVED$FAMILYE           0.445    
    ## DAY50_live_non_apoptotic_agranular_BAD_REMOVED$FAMILYJ           0.598    
    ## DAY50_live_non_apoptotic_agranular_BAD_REMOVED$FAMILYL           0.155    
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
    ## 
    ## Residual standard error: 0.1804 on 74 degrees of freedom
    ## Multiple R-squared:  0.04526,    Adjusted R-squared:  -0.03215 
    ## F-statistic: 0.5846 on 6 and 74 DF,  p-value: 0.7415

### One Way ANOVA of Live Non-Apoptotic Agranular Just Challenged

``` r
DAY50_live_non_apoptotic_agranular_BAD_REMOVED_CHALLENGE <- DAY50_live_non_apoptotic_agranular_BAD_REMOVED[!grepl("control", DAY50_live_non_apoptotic_agranular_BAD_REMOVED$GROUP),]

DAY50_live_non_apoptotic_agranular_BAD_REMOVED_CHALLENGE_aov <- aov(DAY50_live_non_apoptotic_agranular_BAD_REMOVED_CHALLENGE$Arcsine ~ DAY50_live_non_apoptotic_agranular_BAD_REMOVED_CHALLENGE$FAMILY, data=DAY50_live_non_apoptotic_agranular_BAD_REMOVED_CHALLENGE)
summary(DAY50_live_non_apoptotic_agranular_BAD_REMOVED_CHALLENGE_aov) # significantly different between families 
```

    ##                                                                 Df Sum Sq
    ## DAY50_live_non_apoptotic_agranular_BAD_REMOVED_CHALLENGE$FAMILY  5 0.1304
    ## Residuals                                                       48 1.6869
    ##                                                                 Mean Sq
    ## DAY50_live_non_apoptotic_agranular_BAD_REMOVED_CHALLENGE$FAMILY 0.02607
    ## Residuals                                                       0.03514
    ##                                                                 F value
    ## DAY50_live_non_apoptotic_agranular_BAD_REMOVED_CHALLENGE$FAMILY   0.742
    ## Residuals                                                              
    ##                                                                 Pr(>F)
    ## DAY50_live_non_apoptotic_agranular_BAD_REMOVED_CHALLENGE$FAMILY  0.596
    ## Residuals

Two Way ANOVA of Live Non-Apoptotic cells
-----------------------------------------

``` r
DAY50_live_non_apoptotic_granular_agranular_combined <- rbind(DAY50_live_non_apoptotic_granular_BAD_REMOVED,DAY50_live_non_apoptotic_agranular_BAD_REMOVED)

ggplot(DAY50_live_non_apoptotic_granular_agranular_combined, aes(x=GROUP, y=PERCENT_OF_THIS_PLOT, fill=GATE)) + facet_grid(.~FAMILY+GROUP, scales="free") + geom_boxplot() + ggtitle("Percent of Granular and Agranular Live Non-apoptotic Hemocytes at Day 50 (low quality removed)") + ylab("Percent of Hemocyte Events in each quad plot")+ scale_fill_manual(name="Hemocyte Type", labels=c("Necrotic Granular", "Necrotic Agranular"), values=c("Q2_LL"="#99a765","Q1_LL"="#96578a")) 
```

![](Dermo_Apoptosis_Assay_Data_analysis_files/figure-markdown_github/day50_live_non_apoptotic_cells_twoway-1.png)

``` r
# Two way ANOVA
DAY50_live_non_apoptotic_granular_agranular_aov <- lm(DAY50_live_non_apoptotic_granular_agranular_combined$Arcsine ~DAY50_live_non_apoptotic_granular_agranular_combined$FAMILY + DAY50_live_non_apoptotic_granular_agranular_combined$GATE, data=DAY50_live_non_apoptotic_granular_agranular_combined)
Anova(DAY50_live_non_apoptotic_granular_agranular_aov , type="II") #GATE is significant
```

    ## Anova Table (Type II tests)
    ## 
    ## Response: DAY50_live_non_apoptotic_granular_agranular_combined$Arcsine
    ##                                                              Sum Sq  Df
    ## DAY50_live_non_apoptotic_granular_agranular_combined$FAMILY 0.11434   5
    ## DAY50_live_non_apoptotic_granular_agranular_combined$GATE   1.52575   1
    ## Residuals                                                   2.80037 149
    ##                                                             F value
    ## DAY50_live_non_apoptotic_granular_agranular_combined$FAMILY  1.2168
    ## DAY50_live_non_apoptotic_granular_agranular_combined$GATE   81.1812
    ## Residuals                                                          
    ##                                                                Pr(>F)    
    ## DAY50_live_non_apoptotic_granular_agranular_combined$FAMILY     0.304    
    ## DAY50_live_non_apoptotic_granular_agranular_combined$GATE   9.204e-16 ***
    ## Residuals                                                                
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

``` r
summary(DAY50_live_non_apoptotic_granular_agranular_aov)
```

    ## 
    ## Call:
    ## lm(formula = DAY50_live_non_apoptotic_granular_agranular_combined$Arcsine ~ 
    ##     DAY50_live_non_apoptotic_granular_agranular_combined$FAMILY + 
    ##         DAY50_live_non_apoptotic_granular_agranular_combined$GATE, 
    ##     data = DAY50_live_non_apoptotic_granular_agranular_combined)
    ## 
    ## Residuals:
    ##      Min       1Q   Median       3Q      Max 
    ## -0.61475 -0.05605  0.00351  0.08058  0.31976 
    ## 
    ## Coefficients:
    ##                                                                 Estimate
    ## (Intercept)                                                     1.222384
    ## DAY50_live_non_apoptotic_granular_agranular_combined$FAMILYB   -0.008269
    ## DAY50_live_non_apoptotic_granular_agranular_combined$FAMILYD   -0.050956
    ## DAY50_live_non_apoptotic_granular_agranular_combined$FAMILYE   -0.052076
    ## DAY50_live_non_apoptotic_granular_agranular_combined$FAMILYJ   -0.045824
    ## DAY50_live_non_apoptotic_granular_agranular_combined$FAMILYL   -0.079818
    ## DAY50_live_non_apoptotic_granular_agranular_combined$GATEQ1_LL -0.198041
    ##                                                                Std. Error
    ## (Intercept)                                                      0.028143
    ## DAY50_live_non_apoptotic_granular_agranular_combined$FAMILYB     0.036979
    ## DAY50_live_non_apoptotic_granular_agranular_combined$FAMILYD     0.037347
    ## DAY50_live_non_apoptotic_granular_agranular_combined$FAMILYE     0.036324
    ## DAY50_live_non_apoptotic_granular_agranular_combined$FAMILYJ     0.038147
    ## DAY50_live_non_apoptotic_granular_agranular_combined$FAMILYL     0.039058
    ## DAY50_live_non_apoptotic_granular_agranular_combined$GATEQ1_LL   0.021980
    ##                                                                t value
    ## (Intercept)                                                     43.435
    ## DAY50_live_non_apoptotic_granular_agranular_combined$FAMILYB    -0.224
    ## DAY50_live_non_apoptotic_granular_agranular_combined$FAMILYD    -1.364
    ## DAY50_live_non_apoptotic_granular_agranular_combined$FAMILYE    -1.434
    ## DAY50_live_non_apoptotic_granular_agranular_combined$FAMILYJ    -1.201
    ## DAY50_live_non_apoptotic_granular_agranular_combined$FAMILYL    -2.044
    ## DAY50_live_non_apoptotic_granular_agranular_combined$GATEQ1_LL  -9.010
    ##                                                                Pr(>|t|)
    ## (Intercept)                                                     < 2e-16
    ## DAY50_live_non_apoptotic_granular_agranular_combined$FAMILYB     0.8234
    ## DAY50_live_non_apoptotic_granular_agranular_combined$FAMILYD     0.1745
    ## DAY50_live_non_apoptotic_granular_agranular_combined$FAMILYE     0.1538
    ## DAY50_live_non_apoptotic_granular_agranular_combined$FAMILYJ     0.2316
    ## DAY50_live_non_apoptotic_granular_agranular_combined$FAMILYL     0.0428
    ## DAY50_live_non_apoptotic_granular_agranular_combined$GATEQ1_LL  9.2e-16
    ##                                                                   
    ## (Intercept)                                                    ***
    ## DAY50_live_non_apoptotic_granular_agranular_combined$FAMILYB      
    ## DAY50_live_non_apoptotic_granular_agranular_combined$FAMILYD      
    ## DAY50_live_non_apoptotic_granular_agranular_combined$FAMILYE      
    ## DAY50_live_non_apoptotic_granular_agranular_combined$FAMILYJ      
    ## DAY50_live_non_apoptotic_granular_agranular_combined$FAMILYL   *  
    ## DAY50_live_non_apoptotic_granular_agranular_combined$GATEQ1_LL ***
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
    ## 
    ## Residual standard error: 0.1371 on 149 degrees of freedom
    ## Multiple R-squared:  0.3703, Adjusted R-squared:  0.345 
    ## F-statistic:  14.6 on 6 and 149 DF,  p-value: 4.485e-13

``` r
# Two- Way ANOVA with interaction
DAY50_live_non_apoptotic_granular_agranular_aov_interaction <- lm(DAY50_live_non_apoptotic_granular_agranular_combined$Arcsine ~DAY50_live_non_apoptotic_granular_agranular_combined$FAMILY + DAY50_live_non_apoptotic_granular_agranular_combined$GATE + DAY50_live_non_apoptotic_granular_agranular_combined$FAMILY:DAY50_live_non_apoptotic_granular_agranular_combined$GATE, data=DAY50_live_non_apoptotic_granular_agranular_combined)
Anova(DAY50_live_non_apoptotic_granular_agranular_aov_interaction, type="II") #GATE is significant
```

    ## Anova Table (Type II tests)
    ## 
    ## Response: DAY50_live_non_apoptotic_granular_agranular_combined$Arcsine
    ##                                                                                                                        Sum Sq
    ## DAY50_live_non_apoptotic_granular_agranular_combined$FAMILY                                                           0.11434
    ## DAY50_live_non_apoptotic_granular_agranular_combined$GATE                                                             1.52575
    ## DAY50_live_non_apoptotic_granular_agranular_combined$FAMILY:DAY50_live_non_apoptotic_granular_agranular_combined$GATE 0.02312
    ## Residuals                                                                                                             2.77724
    ##                                                                                                                        Df
    ## DAY50_live_non_apoptotic_granular_agranular_combined$FAMILY                                                             5
    ## DAY50_live_non_apoptotic_granular_agranular_combined$GATE                                                               1
    ## DAY50_live_non_apoptotic_granular_agranular_combined$FAMILY:DAY50_live_non_apoptotic_granular_agranular_combined$GATE   5
    ## Residuals                                                                                                             144
    ##                                                                                                                       F value
    ## DAY50_live_non_apoptotic_granular_agranular_combined$FAMILY                                                            1.1858
    ## DAY50_live_non_apoptotic_granular_agranular_combined$GATE                                                             79.1102
    ## DAY50_live_non_apoptotic_granular_agranular_combined$FAMILY:DAY50_live_non_apoptotic_granular_agranular_combined$GATE  0.2398
    ## Residuals                                                                                                                    
    ##                                                                                                                          Pr(>F)
    ## DAY50_live_non_apoptotic_granular_agranular_combined$FAMILY                                                              0.3191
    ## DAY50_live_non_apoptotic_granular_agranular_combined$GATE                                                             2.242e-15
    ## DAY50_live_non_apoptotic_granular_agranular_combined$FAMILY:DAY50_live_non_apoptotic_granular_agranular_combined$GATE    0.9443
    ## Residuals                                                                                                                      
    ##                                                                                                                          
    ## DAY50_live_non_apoptotic_granular_agranular_combined$FAMILY                                                              
    ## DAY50_live_non_apoptotic_granular_agranular_combined$GATE                                                             ***
    ## DAY50_live_non_apoptotic_granular_agranular_combined$FAMILY:DAY50_live_non_apoptotic_granular_agranular_combined$GATE    
    ## Residuals                                                                                                                
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

``` r
summary(DAY50_live_non_apoptotic_granular_agranular_aov_interaction)
```

    ## 
    ## Call:
    ## lm(formula = DAY50_live_non_apoptotic_granular_agranular_combined$Arcsine ~ 
    ##     DAY50_live_non_apoptotic_granular_agranular_combined$FAMILY + 
    ##         DAY50_live_non_apoptotic_granular_agranular_combined$GATE + 
    ##         DAY50_live_non_apoptotic_granular_agranular_combined$FAMILY:DAY50_live_non_apoptotic_granular_agranular_combined$GATE, 
    ##     data = DAY50_live_non_apoptotic_granular_agranular_combined)
    ## 
    ## Residuals:
    ##      Min       1Q   Median       3Q      Max 
    ## -0.62705 -0.05762  0.00160  0.07380  0.31827 
    ## 
    ## Coefficients:
    ##                                                                                                                              Estimate
    ## (Intercept)                                                                                                                  1.221980
    ## DAY50_live_non_apoptotic_granular_agranular_combined$FAMILYB                                                                -0.009465
    ## DAY50_live_non_apoptotic_granular_agranular_combined$FAMILYD                                                                -0.064897
    ## DAY50_live_non_apoptotic_granular_agranular_combined$FAMILYE                                                                -0.050877
    ## DAY50_live_non_apoptotic_granular_agranular_combined$FAMILYJ                                                                -0.055626
    ## DAY50_live_non_apoptotic_granular_agranular_combined$FAMILYL                                                                -0.052163
    ## DAY50_live_non_apoptotic_granular_agranular_combined$GATEQ1_LL                                                              -0.197233
    ## DAY50_live_non_apoptotic_granular_agranular_combined$FAMILYB:DAY50_live_non_apoptotic_granular_agranular_combined$GATEQ1_LL  0.002278
    ## DAY50_live_non_apoptotic_granular_agranular_combined$FAMILYD:DAY50_live_non_apoptotic_granular_agranular_combined$GATEQ1_LL  0.025834
    ## DAY50_live_non_apoptotic_granular_agranular_combined$FAMILYE:DAY50_live_non_apoptotic_granular_agranular_combined$GATEQ1_LL -0.002345
    ## DAY50_live_non_apoptotic_granular_agranular_combined$FAMILYJ:DAY50_live_non_apoptotic_granular_agranular_combined$GATEQ1_LL  0.018034
    ## DAY50_live_non_apoptotic_granular_agranular_combined$FAMILYL:DAY50_live_non_apoptotic_granular_agranular_combined$GATEQ1_LL -0.055309
    ##                                                                                                                             Std. Error
    ## (Intercept)                                                                                                                   0.037116
    ## DAY50_live_non_apoptotic_granular_agranular_combined$FAMILYB                                                                  0.053490
    ## DAY50_live_non_apoptotic_granular_agranular_combined$FAMILYD                                                                  0.054633
    ## DAY50_live_non_apoptotic_granular_agranular_combined$FAMILYE                                                                  0.052490
    ## DAY50_live_non_apoptotic_granular_agranular_combined$FAMILYJ                                                                  0.055955
    ## DAY50_live_non_apoptotic_granular_agranular_combined$FAMILYL                                                                  0.055955
    ## DAY50_live_non_apoptotic_granular_agranular_combined$GATEQ1_LL                                                                0.052490
    ## DAY50_live_non_apoptotic_granular_agranular_combined$FAMILYB:DAY50_live_non_apoptotic_granular_agranular_combined$GATEQ1_LL   0.074942
    ## DAY50_live_non_apoptotic_granular_agranular_combined$FAMILYD:DAY50_live_non_apoptotic_granular_agranular_combined$GATEQ1_LL   0.075763
    ## DAY50_live_non_apoptotic_granular_agranular_combined$FAMILYE:DAY50_live_non_apoptotic_granular_agranular_combined$GATEQ1_LL   0.073611
    ## DAY50_live_non_apoptotic_granular_agranular_combined$FAMILYJ:DAY50_live_non_apoptotic_granular_agranular_combined$GATEQ1_LL   0.077409
    ## DAY50_live_non_apoptotic_granular_agranular_combined$FAMILYL:DAY50_live_non_apoptotic_granular_agranular_combined$GATEQ1_LL   0.079132
    ##                                                                                                                             t value
    ## (Intercept)                                                                                                                  32.923
    ## DAY50_live_non_apoptotic_granular_agranular_combined$FAMILYB                                                                 -0.177
    ## DAY50_live_non_apoptotic_granular_agranular_combined$FAMILYD                                                                 -1.188
    ## DAY50_live_non_apoptotic_granular_agranular_combined$FAMILYE                                                                 -0.969
    ## DAY50_live_non_apoptotic_granular_agranular_combined$FAMILYJ                                                                 -0.994
    ## DAY50_live_non_apoptotic_granular_agranular_combined$FAMILYL                                                                 -0.932
    ## DAY50_live_non_apoptotic_granular_agranular_combined$GATEQ1_LL                                                               -3.758
    ## DAY50_live_non_apoptotic_granular_agranular_combined$FAMILYB:DAY50_live_non_apoptotic_granular_agranular_combined$GATEQ1_LL   0.030
    ## DAY50_live_non_apoptotic_granular_agranular_combined$FAMILYD:DAY50_live_non_apoptotic_granular_agranular_combined$GATEQ1_LL   0.341
    ## DAY50_live_non_apoptotic_granular_agranular_combined$FAMILYE:DAY50_live_non_apoptotic_granular_agranular_combined$GATEQ1_LL  -0.032
    ## DAY50_live_non_apoptotic_granular_agranular_combined$FAMILYJ:DAY50_live_non_apoptotic_granular_agranular_combined$GATEQ1_LL   0.233
    ## DAY50_live_non_apoptotic_granular_agranular_combined$FAMILYL:DAY50_live_non_apoptotic_granular_agranular_combined$GATEQ1_LL  -0.699
    ##                                                                                                                             Pr(>|t|)
    ## (Intercept)                                                                                                                  < 2e-16
    ## DAY50_live_non_apoptotic_granular_agranular_combined$FAMILYB                                                                0.859796
    ## DAY50_live_non_apoptotic_granular_agranular_combined$FAMILYD                                                                0.236842
    ## DAY50_live_non_apoptotic_granular_agranular_combined$FAMILYE                                                                0.334032
    ## DAY50_live_non_apoptotic_granular_agranular_combined$FAMILYJ                                                                0.321829
    ## DAY50_live_non_apoptotic_granular_agranular_combined$FAMILYL                                                                0.352770
    ## DAY50_live_non_apoptotic_granular_agranular_combined$GATEQ1_LL                                                              0.000249
    ## DAY50_live_non_apoptotic_granular_agranular_combined$FAMILYB:DAY50_live_non_apoptotic_granular_agranular_combined$GATEQ1_LL 0.975788
    ## DAY50_live_non_apoptotic_granular_agranular_combined$FAMILYD:DAY50_live_non_apoptotic_granular_agranular_combined$GATEQ1_LL 0.733616
    ## DAY50_live_non_apoptotic_granular_agranular_combined$FAMILYE:DAY50_live_non_apoptotic_granular_agranular_combined$GATEQ1_LL 0.974633
    ## DAY50_live_non_apoptotic_granular_agranular_combined$FAMILYJ:DAY50_live_non_apoptotic_granular_agranular_combined$GATEQ1_LL 0.816114
    ## DAY50_live_non_apoptotic_granular_agranular_combined$FAMILYL:DAY50_live_non_apoptotic_granular_agranular_combined$GATEQ1_LL 0.485708
    ##                                                                                                                                
    ## (Intercept)                                                                                                                 ***
    ## DAY50_live_non_apoptotic_granular_agranular_combined$FAMILYB                                                                   
    ## DAY50_live_non_apoptotic_granular_agranular_combined$FAMILYD                                                                   
    ## DAY50_live_non_apoptotic_granular_agranular_combined$FAMILYE                                                                   
    ## DAY50_live_non_apoptotic_granular_agranular_combined$FAMILYJ                                                                   
    ## DAY50_live_non_apoptotic_granular_agranular_combined$FAMILYL                                                                   
    ## DAY50_live_non_apoptotic_granular_agranular_combined$GATEQ1_LL                                                              ***
    ## DAY50_live_non_apoptotic_granular_agranular_combined$FAMILYB:DAY50_live_non_apoptotic_granular_agranular_combined$GATEQ1_LL    
    ## DAY50_live_non_apoptotic_granular_agranular_combined$FAMILYD:DAY50_live_non_apoptotic_granular_agranular_combined$GATEQ1_LL    
    ## DAY50_live_non_apoptotic_granular_agranular_combined$FAMILYE:DAY50_live_non_apoptotic_granular_agranular_combined$GATEQ1_LL    
    ## DAY50_live_non_apoptotic_granular_agranular_combined$FAMILYJ:DAY50_live_non_apoptotic_granular_agranular_combined$GATEQ1_LL    
    ## DAY50_live_non_apoptotic_granular_agranular_combined$FAMILYL:DAY50_live_non_apoptotic_granular_agranular_combined$GATEQ1_LL    
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
    ## 
    ## Residual standard error: 0.1389 on 144 degrees of freedom
    ## Multiple R-squared:  0.3755, Adjusted R-squared:  0.3278 
    ## F-statistic: 7.872 on 11 and 144 DF,  p-value: 1.321e-10

``` r
DAY50_live_non_apoptotic_granular_agranular_aov_gate_leastsquares <- lsmeans(DAY50_live_non_apoptotic_granular_agranular_aov_interaction, "DAY50_live_non_apoptotic_granular_agranular_combined$GATE", adjust="tukey")
cld(DAY50_live_non_apoptotic_granular_agranular_aov_gate_leastsquares, alpha=0.05, Letters=letters) # the means of the two groups not different
```

    ##  DAY50_live_non_apoptotic_granular_agranular_combined$GATE  lsmean
    ##  Q2_LL                                                     1.22198
    ##  Q1_LL                                                     1.22198
    ##          SE  df lower.CL upper.CL .group
    ##  0.03711603 144 1.148618 1.295343  a    
    ##  0.03711603 144 1.148618 1.295343  a    
    ## 
    ## Results are averaged over the levels of: DAY50_live_non_apoptotic_granular_agranular_combined$FAMILY 
    ## Confidence level used: 0.95 
    ## significance level used: alpha = 0.05

#### Combined Plotting

``` r
DAY50_APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$DAY <- "50"
DAY50_APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED$CELL <- "granular"
DAY50_APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$DAY <- "50"
DAY50_APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED$CELL <- "agranular"
APOP_PLOT4_GRANULAR_QUAD_PLOT_GATE_ADDED_BAD_REMOVED$DAY <- "07"
APOP_PLOT4_GRANULAR_QUAD_PLOT_GATE_ADDED_BAD_REMOVED$CELL <- "granular"
APOP_PLOT7_AGRANULAR_QUAD_PLOT_GATE_ADDED_BAD_REMOVED$DAY <- "07"
APOP_PLOT7_AGRANULAR_QUAD_PLOT_GATE_ADDED_BAD_REMOVED$CELL <- "agranular"


DAY50_APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED_subset <- DAY50_APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED[,c("SAMPLE_ID", "FAMILY","ASSAY","PERCENT_OF_THIS_PLOT", "GATE","DAY","GROUP", "PLOT","CELL","Arcsine")]
DAY50_APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED_subset<- DAY50_APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED[,c("SAMPLE_ID", "FAMILY","ASSAY","PERCENT_OF_THIS_PLOT", "GATE","DAY","GROUP", "PLOT","CELL","Arcsine")]
APOP_PLOT4_GRANULAR_QUAD_PLOT_GATE_ADDED_BAD_REMOVED_subset <- APOP_PLOT4_GRANULAR_QUAD_PLOT_GATE_ADDED_BAD_REMOVED[,c("SAMPLE_ID", "FAMILY","ASSAY","PERCENT_OF_THIS_PLOT", "GATE","DAY","GROUP", "PLOT","CELL","Arcsine")]
APOP_PLOT7_AGRANULAR_QUAD_PLOT_GATE_ADDED_BAD_REMOVED_subset <- APOP_PLOT7_AGRANULAR_QUAD_PLOT_GATE_ADDED_BAD_REMOVED[,c("SAMPLE_ID", "FAMILY","ASSAY","PERCENT_OF_THIS_PLOT", "GATE","DAY","GROUP", "PLOT","CELL","Arcsine")]

all_granular_agranular_DAY7_DAY50 <- rbind(DAY50_APOP_PLOT4_GRANULAR_QUAD_PLOT_BAD_REMOVED_subset,DAY50_APOP_PLOT7_AGRANULAR_QUAD_PLOT_BAD_REMOVED_subset,APOP_PLOT4_GRANULAR_QUAD_PLOT_GATE_ADDED_BAD_REMOVED_subset,APOP_PLOT7_AGRANULAR_QUAD_PLOT_GATE_ADDED_BAD_REMOVED_subset)

all_granular_agranular_DAY7_DAY50_challenge <- all_granular_agranular_DAY7_DAY50[grepl("treatment", all_granular_agranular_DAY7_DAY50$GROUP),]

#BEST PLOT 
  control_and_challenge <- ggplot(all_granular_agranular_DAY7_DAY50, aes(x=GROUP, y=PERCENT_OF_THIS_PLOT, fill=GATE)) + 
  geom_col(position=position_fill()) + 
  ggtitle("Percent of Granular and Agranular Hemocytes \n on Day 7 and Day 50 (low quality removed)") + ylab("Percent of Hemocyte Events in each quad plot") + 
  facet_grid(DAY~CELL+FAMILY, scales="free") + scale_fill_manual(name="Hemocyte Type", labels=c("Live Non-Apoptotic Granular","Live Apoptotic Granular", "Dead Apoptotic Granular", "Necrotic Granular", "Live Non-Apoptotic Agranular", "Live Apoptotic Agranular", "Dead Apoptotic Agranular", "Necrotic Agranular"), values=c("Q2_LL"="#7d7f77","Q2_LR"="#33362f", "Q2_UL"="#d1c9b8","Q2_UR"="#accccf","Q1_LL"="#488772", "Q1_LR"="#52d79b","Q1_UL"="#a5d4c1","Q1_UR"="#62dccc")) 

#just_challenge<-
  ggplot(all_granular_agranular_DAY7_DAY50_challenge, aes(x=GROUP, y=PERCENT_OF_THIS_PLOT, fill=GATE)) + 
  geom_col(position=position_fill()) + 
  ggtitle("Percent of Granular and Agranular Hemocytes from Challenged Oysters \n on Day 7 and Day 50 (low quality removed)") + ylab("Percent of Hemocyte Events in each quad plot") + 
  facet_grid(DAY~CELL+FAMILY, scales="free") + scale_fill_manual(name="Hemocyte Type", labels=c("Live Non-Apoptotic Granular","Live Apoptotic Granular", "Dead Apoptotic Granular", "Necrotic Granular", "Live Non-Apoptotic Agranular", "Live Apoptotic Agranular", "Dead Apoptotic Agranular", "Necrotic Agranular"), values=c("Q2_LL"="#7d7f77","Q2_LR"="#33362f", "Q2_UL"="#d1c9b8","Q2_UR"="#accccf","Q1_LL"="#488772", "Q1_LR"="#52d79b","Q1_UL"="#a5d4c1","Q1_UR"="#62dccc")) 
```

![](Dermo_Apoptosis_Assay_Data_analysis_files/figure-markdown_github/granular_agranular_plotting-1.png)

#### Two-Way ANOVA of GATE and DAY

``` r
all_granular_agranular_DAY7_DAY50_lm <- lm(all_granular_agranular_DAY7_DAY50$Arcsine ~ all_granular_agranular_DAY7_DAY50$GATE + all_granular_agranular_DAY7_DAY50$DAY + all_granular_agranular_DAY7_DAY50$GATE:all_granular_agranular_DAY7_DAY50$DAY, data=all_granular_agranular_DAY7_DAY50)
Anova(all_granular_agranular_DAY7_DAY50_lm, type="II")
```

    ## Anova Table (Type II tests)
    ## 
    ## Response: all_granular_agranular_DAY7_DAY50$Arcsine
    ##                                                                               Sum Sq
    ## all_granular_agranular_DAY7_DAY50$GATE                                       154.939
    ## all_granular_agranular_DAY7_DAY50$DAY                                          0.001
    ## all_granular_agranular_DAY7_DAY50$GATE:all_granular_agranular_DAY7_DAY50$DAY   0.650
    ## Residuals                                                                     12.588
    ##                                                                                Df
    ## all_granular_agranular_DAY7_DAY50$GATE                                          7
    ## all_granular_agranular_DAY7_DAY50$DAY                                           1
    ## all_granular_agranular_DAY7_DAY50$GATE:all_granular_agranular_DAY7_DAY50$DAY    7
    ## Residuals                                                                    1040
    ##                                                                                F value
    ## all_granular_agranular_DAY7_DAY50$GATE                                       1828.6687
    ## all_granular_agranular_DAY7_DAY50$DAY                                           0.0900
    ## all_granular_agranular_DAY7_DAY50$GATE:all_granular_agranular_DAY7_DAY50$DAY    7.6738
    ## Residuals                                                                             
    ##                                                                                 Pr(>F)
    ## all_granular_agranular_DAY7_DAY50$GATE                                       < 2.2e-16
    ## all_granular_agranular_DAY7_DAY50$DAY                                           0.7643
    ## all_granular_agranular_DAY7_DAY50$GATE:all_granular_agranular_DAY7_DAY50$DAY 4.651e-09
    ## Residuals                                                                             
    ##                                                                                 
    ## all_granular_agranular_DAY7_DAY50$GATE                                       ***
    ## all_granular_agranular_DAY7_DAY50$DAY                                           
    ## all_granular_agranular_DAY7_DAY50$GATE:all_granular_agranular_DAY7_DAY50$DAY ***
    ## Residuals                                                                       
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

### Summary Statistics Day 50

``` r
# Summary Statistics for Percentages 
total_apoptosis_statistics_day50 <- summarySE(data=all_granular_agranular_DAY7_DAY50, "PERCENT_OF_THIS_PLOT", groupvars=c("GROUP", "GATE","FAMILY"))
total_apoptosis_statistics_day50 
```

    ##        GROUP  GATE FAMILY  N PERCENT_OF_THIS_PLOT         sd         se
    ## 1    control Q2_LL      A  7           88.9971429  4.1455225  1.5668602
    ## 2    control Q2_LL      B  7           85.0514286  4.0440385  1.5285029
    ## 3    control Q2_LL      D  6           86.7900000  6.8332306  2.7896547
    ## 4    control Q2_LL      E  6           83.5833333  4.8989046  1.9999694
    ## 5    control Q2_LL      J  5           88.2380000  6.1950924  2.7705296
    ## 6    control Q2_LL      L  6           88.5516667  6.2795969  2.5636347
    ## 7    control Q2_LR      A  7            7.2485714  3.0844958  1.1658298
    ## 8    control Q2_LR      B  7           11.4157143  2.7693432  1.0467134
    ## 9    control Q2_LR      D  6            9.7883333  5.2504492  2.1434869
    ## 10   control Q2_LR      E  6            9.4200000  5.4039393  2.2061490
    ## 11   control Q2_LR      J  5            9.0380000  4.1283495  1.8462540
    ## 12   control Q2_LR      L  6            8.6350000  5.1307495  2.0946197
    ## 13   control Q2_UL      A  7            1.0371429  0.7828945  0.2959063
    ## 14   control Q2_UL      B  7            0.9171429  0.9908198  0.3744947
    ## 15   control Q2_UL      D  6            0.7800000  0.6434594  0.2626912
    ## 16   control Q2_UL      E  6            3.2316667  5.7298810  2.3392141
    ## 17   control Q2_UL      J  5            0.6200000  0.4627094  0.2069299
    ## 18   control Q2_UL      L  6            0.5483333  0.2832961  0.1156551
    ## 19   control Q2_UR      A  7            2.7185714  1.1930413  0.4509272
    ## 20   control Q2_UR      B  7            2.6128571  2.4351161  0.9203874
    ## 21   control Q2_UR      D  6            2.6450000  1.6010215  0.6536143
    ## 22   control Q2_UR      E  6            3.7666667  1.5869552  0.6478717
    ## 23   control Q2_UR      J  5            2.1040000  1.7740998  0.7934015
    ## 24   control Q2_UR      L  6            2.2600000  1.8011441  0.7353140
    ## 25   control Q1_LL      A  7           67.8900000 14.7300305  5.5674282
    ## 26   control Q1_LL      B  7           64.8342857  8.2551577  3.1201563
    ## 27   control Q1_LL      D  6           66.1433333 13.6141216  5.5579419
    ## 28   control Q1_LL      E  6           59.0833333 25.1506292 10.2677014
    ## 29   control Q1_LL      J  5           69.4260000 19.5234124  8.7311354
    ## 30   control Q1_LL      L  6           69.7966667  9.2568627  3.7790984
    ## 31   control Q1_LR      A  7            4.1571429  2.9671407  1.1214738
    ## 32   control Q1_LR      B  7            8.3257143  3.9116359  1.4784594
    ## 33   control Q1_LR      D  6            6.8250000  3.6089043  1.4733290
    ## 34   control Q1_LR      E  6            5.8933333  3.9999983  1.6329925
    ## 35   control Q1_LR      J  5            8.3000000  4.7233886  2.1123636
    ## 36   control Q1_LR      L  6            8.5800000  6.1897237  2.5269441
    ## 37   control Q1_UL      A  7            9.2885714 10.3697034  3.9193795
    ## 38   control Q1_UL      B  7            9.0071429  9.4439852  3.5694909
    ## 39   control Q1_UL      D  6           10.6583333  5.9194169  2.4165918
    ## 40   control Q1_UL      E  6           19.4250000 24.5704202 10.0308321
    ## 41   control Q1_UL      J  5            6.0000000  4.7190200  2.1104099
    ## 42   control Q1_UL      L  6            7.4850000  4.2082336  1.7180042
    ## 43   control Q1_UR      A  7           18.6642857 10.4490284  3.9493615
    ## 44   control Q1_UR      B  7           17.8314286  7.9188624  2.9930486
    ## 45   control Q1_UR      D  6           16.3733333  9.6157281  3.9256046
    ## 46   control Q1_UR      E  6           15.5983333  6.8515412  2.7971300
    ## 47   control Q1_UR      J  5           16.2780000 12.1074923  5.4146352
    ## 48   control Q1_UR      L  6           14.1400000  7.0865140  2.8930572
    ## 49 treatment Q2_LL      A 18           90.1427778  4.8059103  1.1327639
    ## 50 treatment Q2_LL      B 15           86.1000000  3.7703297  0.9734949
    ## 51 treatment Q2_LL      D 14           84.8507143  6.2828955  1.6791745
    ## 52 treatment Q2_LL      E 17           87.7258824  5.0361829  1.2214538
    ## 53 treatment Q2_LL      J 17           85.5835294  5.8167731  1.4107747
    ## 54 treatment Q2_LL      L 14           88.8564286  7.8760383  2.1049598
    ## 55 treatment Q2_LR      A 18            5.7350000  2.8363341  0.6685304
    ## 56 treatment Q2_LR      B 15           10.1360000  2.8817946  0.7440762
    ## 57 treatment Q2_LR      D 14            9.4371429  3.3249510  0.8886305
    ## 58 treatment Q2_LR      E 17            8.2376471  3.4536765  0.8376396
    ## 59 treatment Q2_LR      J 17            9.6300000  4.8230942  1.1697722
    ## 60 treatment Q2_LR      L 14            8.5485714  6.7004728  1.7907767
    ## 61 treatment Q2_UL      A 18            1.6905556  3.2717462  0.7711580
    ## 62 treatment Q2_UL      B 15            0.9566667  0.6368636  0.1644375
    ## 63 treatment Q2_UL      D 14            1.5835714  1.4918940  0.3987255
    ## 64 treatment Q2_UL      E 17            0.7629412  0.4403800  0.1068078
    ## 65 treatment Q2_UL      J 17            1.1935294  0.8651224  0.2098230
    ## 66 treatment Q2_UL      L 14            0.9471429  0.6669036  0.1782375
    ## 67 treatment Q2_UR      A 18            2.4294444  1.3714461  0.3232529
    ## 68 treatment Q2_UR      B 15            2.8060000  1.8887025  0.4876609
    ## 69 treatment Q2_UR      D 14            4.1307143  2.9530362  0.7892321
    ## 70 treatment Q2_UR      E 17            3.2747059  2.1709362  0.5265294
    ## 71 treatment Q2_UR      J 17            3.5923529  3.0282865  0.7344674
    ## 72 treatment Q2_UR      L 14            1.6485714  1.3667528  0.3652800
    ## 73 treatment Q1_LL      A 18           73.5594444 17.1154160  4.0341422
    ## 74 treatment Q1_LL      B 15           69.9286667 16.5178613  4.2648934
    ## 75 treatment Q1_LL      D 14           62.8214286 21.3428781  5.7041241
    ## 76 treatment Q1_LL      E 17           68.6876471 14.2682092  3.4605490
    ## 77 treatment Q1_LL      J 17           67.6300000 10.8946139  2.6423320
    ## 78 treatment Q1_LL      L 14           70.2878571 16.3353233  4.3657988
    ## 79 treatment Q1_LR      A 18            3.3377778  1.8640486  0.4393605
    ## 80 treatment Q1_LR      B 15            6.3946667  4.4137251  1.1396189
    ## 81 treatment Q1_LR      D 14            4.2935714  2.4612805  0.6578049
    ## 82 treatment Q1_LR      E 17            5.7547059  4.2775491  1.0374580
    ## 83 treatment Q1_LR      J 17            6.6958824  4.3393405  1.0524447
    ## 84 treatment Q1_LR      L 14            8.8792857  8.4988736  2.2714195
    ## 85 treatment Q1_UL      A 18           10.8633333 13.4108477  3.1609671
    ## 86 treatment Q1_UL      B 15            7.6740000  6.3517206  1.6400072
    ## 87 treatment Q1_UL      D 14           14.7414286 16.1128820  4.3063489
    ## 88 treatment Q1_UL      E 17            9.4305882  5.2629049  1.2764419
    ## 89 treatment Q1_UL      J 17            8.6564706  5.2984997  1.2850749
    ## 90 treatment Q1_UL      L 14            9.4542857  4.8528607  1.2969816
    ## 91 treatment Q1_UR      A 18           12.2405556  6.4745706  1.5260709
    ## 92 treatment Q1_UR      B 15           16.0033333 12.0893416  3.1214546
    ## 93 treatment Q1_UR      D 14           18.1428571 11.3346273  3.0293066
    ## 94 treatment Q1_UR      E 17           16.1282353  9.5781152  2.3230342
    ## 95 treatment Q1_UR      J 17           17.0182353  6.8901236  1.6711004
    ## 96 treatment Q1_UR      L 14           11.3785714  9.2832901  2.4810636
    ##            ci
    ## 1   3.8339689
    ## 2   3.7401118
    ## 3   7.1710357
    ## 4   5.1410851
    ## 5   7.6922232
    ## 6   6.5900327
    ## 7   2.8526828
    ## 8   2.5612153
    ## 9   5.5100085
    ## 10  5.6710865
    ## 11  5.1260230
    ## 12  5.3843913
    ## 13  0.7240567
    ## 14  0.9163554
    ## 15  0.6752692
    ## 16  6.0131414
    ## 17  0.5745296
    ## 18  0.2973010
    ## 19  1.1033792
    ## 20  2.2521068
    ## 21  1.6801691
    ## 22  1.6654073
    ## 23  2.2028358
    ## 24  1.8901848
    ## 25 13.6230061
    ## 26  7.6347475
    ## 27 14.2871444
    ## 28 26.3939666
    ## 29 24.2415182
    ## 30  9.7144816
    ## 31  2.7441474
    ## 32  3.6176598
    ## 33  3.7873128
    ## 34  4.1977408
    ## 35  5.8648616
    ## 36  6.4957167
    ## 37  9.5903761
    ## 38  8.7342296
    ## 39  6.2120471
    ## 40 25.7850747
    ## 41  5.8594373
    ## 42  4.4162703
    ## 43  9.6637395
    ## 44  7.3237262
    ## 45 10.0910878
    ## 46  7.1902515
    ## 47 15.0334373
    ## 48  7.4368403
    ## 49  2.3899230
    ## 50  2.0879390
    ## 51  3.6276359
    ## 52  2.5893663
    ## 53  2.9907088
    ## 54  4.5474891
    ## 55  1.4104758
    ## 56  1.5958846
    ## 57  1.9197695
    ## 58  1.7757166
    ## 59  2.4798062
    ## 60  3.8687378
    ## 61  1.6270011
    ## 62  0.3526833
    ## 63  0.8613940
    ## 64  0.2264225
    ## 65  0.4448049
    ## 66  0.3850587
    ## 67  0.6820041
    ## 68  1.0459286
    ## 69  1.7050323
    ## 70  1.1161924
    ## 71  1.5570012
    ## 72  0.7891396
    ## 73  8.5112961
    ## 74  9.1472867
    ## 75 12.3230109
    ## 76  7.3360362
    ## 77  5.6014936
    ## 78  9.4317349
    ## 79  0.9269696
    ## 80  2.4442395
    ## 81  1.4211010
    ## 82  2.1993128
    ## 83  2.2310830
    ## 84  4.9071036
    ## 85  6.6690577
    ## 86  3.5174656
    ## 87  9.3033011
    ## 88  2.7059360
    ## 89  2.7242372
    ## 90  2.8019584
    ## 91  3.2197282
    ## 92  6.6948542
    ## 93  6.5444190
    ## 94  4.9246124
    ## 95  3.5425747
    ## 96  5.3600121

### Modeling with Dirichlet Multinomial Regression

Have to wait until I have the load data and the survival data over time
=======================================================================
