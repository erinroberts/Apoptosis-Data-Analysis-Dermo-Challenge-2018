Dermo Viability Assay Data Analysis
================
Erin Roberts
7/27/2018

Load Packages
-------------

R version being used is 3.4.1

    ## Loading required package: Matrix

    ## Loading 'metafor' package (version 2.0-0). For an overview 
    ## and introduction to the package please type: help(metafor).

    ## Warning: package 'dplyr' was built under R version 3.4.2

    ## 
    ## Attaching package: 'dplyr'

    ## The following objects are masked from 'package:stats':
    ## 
    ##     filter, lag

    ## The following objects are masked from 'package:base':
    ## 
    ##     intersect, setdiff, setequal, union

    ## Warning: package 'car' was built under R version 3.4.4

    ## Loading required package: carData

    ## Warning: package 'carData' was built under R version 3.4.4

    ## 
    ## Attaching package: 'car'

    ## The following object is masked from 'package:dplyr':
    ## 
    ##     recode

    ## Warning: package 'lsmeans' was built under R version 3.4.4

    ## The 'lsmeans' package is being deprecated.
    ## Users are encouraged to switch to 'emmeans'.
    ## See help('transition') for more information, including how
    ## to convert 'lsmeans' objects and scripts to work with 'emmeans'.

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

    ## Warning: package 'knitr' was built under R version 3.4.3

VIABILITY ASSAY ANALYSIS
========================

Key for GATE Names used in Analysis
-----------------------------------

### Load in Data for GATE\_KEY

``` r
Viability_assay_GATE_KEY <- read.csv("../ANALYSIS_CSVs/VIABILITY_ASSAY/Viability_assay_GATE_KEY.csv",header=TRUE, stringsAsFactors = FALSE)
Viability_assay_GATE_KEY <- as.data.frame(Viability_assay_GATE_KEY)
Viability_assay_GATE_KEY
```

    ##   PLOT.NUMBER        AXES                          GATES.CREATED.or.USED
    ## 1      PLOT 2       FL1-H                                    CREATED: M4
    ## 2      PLOT 3 FSC-H/SSC-H                          CREATED: P1 USED: M4 
    ## 3       PLOT4 FSC-H/SSC-H       CREATED: E1,E3; USED: P1 (IN M4 IN ALL))
    ## 4      PLOT 5 FSC-H/SSC-H                                 USED: P1, V1-R
    ## 5      PLOT 9       FL3-A     USED: E1 in (P1 in (M4in all)) EXCEPT V1-R
    ## 6     PLOT 10       FL3-A USED: E3 in (p1 in ( M4 in all)), EXCEPT V1-R 
    ## 7     PLOT 12       FL3-A           CREATED: V1-R, V1-L; USED: P1 in all
    ##                                                                                    PLOT.DESCRIPTION
    ## 1                                                           M4 gate surrounds hemocytes on the plot
    ## 2                                                                        P1 surrounds all hemocytes
    ## 3                         E1 surrounds all granular hemocytes, E3 surrounds all agranular hemocytes
    ## 4                                            Shows hemocytes in P1 with the dead hemocytes removed 
    ## 5                                                     Shows LIVE granular hemocytes (dead removed) 
    ## 6                                                     Shows LIVE agranular hemocytes (dead removed)
    ## 7 Shows all hemocytes that fluoresce with PI, but only those to the right of vertical gate are dead

``` r
kable(Viability_assay_GATE_KEY, caption = "Table of Gate Key")
```

| PLOT.NUMBER | AXES        | GATES.CREATED.or.USED                         | PLOT.DESCRIPTION                                                                                  |
|:------------|:------------|:----------------------------------------------|:--------------------------------------------------------------------------------------------------|
| PLOT 2      | FL1-H       | CREATED: M4                                   | M4 gate surrounds hemocytes on the plot                                                           |
| PLOT 3      | FSC-H/SSC-H | CREATED: P1 USED: M4                          | P1 surrounds all hemocytes                                                                        |
| PLOT4       | FSC-H/SSC-H | CREATED: E1,E3; USED: P1 (IN M4 IN ALL))      | E1 surrounds all granular hemocytes, E3 surrounds all agranular hemocytes                         |
| PLOT 5      | FSC-H/SSC-H | USED: P1, V1-R                                | Shows hemocytes in P1 with the dead hemocytes removed                                             |
| PLOT 9      | FL3-A       | USED: E1 in (P1 in (M4in all)) EXCEPT V1-R    | Shows LIVE granular hemocytes (dead removed)                                                      |
| PLOT 10     | FL3-A       | USED: E3 in (p1 in ( M4 in all)), EXCEPT V1-R | Shows LIVE agranular hemocytes (dead removed)                                                     |
| PLOT 12     | FL3-A       | CREATED: V1-R, V1-L; USED: P1 in all          | Shows all hemocytes that fluoresce with PI, but only those to the right of vertical gate are dead |

Load in data for each plot
--------------------------

``` r
#Load in the Data for each plot on a separate spreadsheet

VI_PLOT2_hemocytes <- read.csv(file="../ANALYSIS_CSVs/VIABILITY_ASSAY/DAY7/PLOT2.csv", header=TRUE)
VI_PLOT3_P1_GATE <- read.csv(file="../ANALYSIS_CSVs/VIABILITY_ASSAY/DAY7/PLOT3.csv", header=TRUE)
VI_PLOT4_E1_E3_GATE <- read.csv(file="../ANALYSIS_CSVs/VIABILITY_ASSAY/DAY7/PLOT4.csv", header=TRUE)
VI_PLOT5_P1_MINUS_V1R <- read.csv(file="../ANALYSIS_CSVs/VIABILITY_ASSAY/DAY7/PLOT5.csv", header=TRUE)
VI_PLOT9_E1_MINUS_V1R <- read.csv(file="../ANALYSIS_CSVs/VIABILITY_ASSAY/DAY7/PLOT9.csv", header=TRUE)
VI_PLOT10_E3_MINUS_V1R <- read.csv(file="../ANALYSIS_CSVs/VIABILITY_ASSAY/DAY7/PLOT10.csv", header=TRUE)
VI_PLOT12_P1_PerCP <- read.csv(file="../ANALYSIS_CSVs/VIABILITY_ASSAY/DAY7/PLOT12.csv", header=TRUE)
VI_PLOT4_restructured <- read.csv(file="../ANALYSIS_CSVs/VIABILITY_ASSAY/DAY7/PLOT4_RESTRUCTURED.csv", header=TRUE)

# Remove rows with na's with the remove.na function from rgr
VI_PLOT2_hemocytes <- na.omit(VI_PLOT2_hemocytes)
VI_PLOT3_P1_GATE <- na.omit(VI_PLOT3_P1_GATE)
VI_PLOT4_E1_E3_GATE <- na.omit(VI_PLOT4_E1_E3_GATE)
VI_PLOT5_P1_MINUS_V1R <- na.omit(VI_PLOT5_P1_MINUS_V1R)
VI_PLOT9_E1_MINUS_V1R <- na.omit(VI_PLOT9_E1_MINUS_V1R)
VI_PLOT10_E3_MINUS_V1R <- na.omit(VI_PLOT10_E3_MINUS_V1R)
VI_PLOT12_P1_PerCP <- na.omit(VI_PLOT12_P1_PerCP)
VI_PLOT4_restructured <- na.omit(VI_PLOT4_restructured)

## Remove percent symbol from columns 
VI_PLOT2_hemocytes$M4_PERCENT_OF_THIS_PLOT <- as.numeric(gsub("\\%", "", VI_PLOT2_hemocytes$M4_PERCENT_OF_THIS_PLOT))
VI_PLOT3_P1_GATE$P1_PERCENT_OF_THIS_PLOT <- as.numeric(gsub("\\%", "", VI_PLOT3_P1_GATE$P1_PERCENT_OF_THIS_PLOT))
VI_PLOT4_E1_E3_GATE$E1_PERCENT_OF_THIS_PLOT <- as.numeric(gsub("\\%", "", VI_PLOT4_E1_E3_GATE$E1_PERCENT_OF_THIS_PLOT))
VI_PLOT4_E1_E3_GATE$E3_PERCENT_OF_THIS_PLOT <- as.numeric(gsub("\\%", "", VI_PLOT4_E1_E3_GATE$E3_PERCENT_OF_THIS_PLOT))
VI_PLOT12_P1_PerCP$V1_L_PERCENT_OF_THIS_PLOT <- as.numeric(gsub("\\%", "", VI_PLOT12_P1_PerCP$V1_L_PERCENT_OF_THIS_PLOT))
VI_PLOT12_P1_PerCP$V1_R_PERCENT_OF_THIS_PLOT <- as.numeric(gsub("\\%", "", VI_PLOT12_P1_PerCP$V1_R_PERCENT_OF_THIS_PLOT))
VI_PLOT4_restructured$PERCENT_OF_THIS_PLOT <- as.numeric(gsub("\\%", "", VI_PLOT4_restructured$PERCENT_OF_THIS_PLOT))

# Load in Data for the samples to remove (these were samples with lots of bacterial contamination and/or few hemocytes)
Viability_Samples_Remove <- read.csv(file="../ANALYSIS_CSVs/VIABILITY_ASSAY/DAY7/VIABILITY_SAMPLES_REMOVE.csv", header=TRUE)

# Data Frame with bad samples removed
VI_PLOT2_hemocytes_BAD_REMOVED <- VI_PLOT2_hemocytes[!VI_PLOT2_hemocytes$SAMPLE_ID %in% Viability_Samples_Remove$SAMPLE_ID, , drop=FALSE]
VI_PLOT3_P1_GATE_BAD_REMOVED <- VI_PLOT3_P1_GATE[!VI_PLOT3_P1_GATE$SAMPLE_ID %in% Viability_Samples_Remove$SAMPLE_ID, , drop=FALSE]
VI_PLOT4_E1_E3_GATE_BAD_REMOVED <- VI_PLOT4_E1_E3_GATE[!VI_PLOT4_E1_E3_GATE$SAMPLE_ID %in% Viability_Samples_Remove$SAMPLE_ID, , drop=FALSE]
VI_PLOT5_P1_MINUS_V1R_BAD_REMOVED <- VI_PLOT5_P1_MINUS_V1R[!VI_PLOT5_P1_MINUS_V1R$SAMPLE_ID %in% Viability_Samples_Remove$SAMPLE_ID, , drop=FALSE]
VI_PLOT9_E1_MINUS_V1R_BAD_REMOVED <- VI_PLOT9_E1_MINUS_V1R[!VI_PLOT9_E1_MINUS_V1R$SAMPLE_ID %in% Viability_Samples_Remove$SAMPLE_ID, , drop=FALSE]
VI_PLOT10_E3_MINUS_V1R_BAD_REMOVED <- VI_PLOT10_E3_MINUS_V1R[!VI_PLOT10_E3_MINUS_V1R$SAMPLE_ID %in% Viability_Samples_Remove$SAMPLE_ID, , drop=FALSE]
VI_PLOT12_P1_PerCP_BAD_REMOVED <- VI_PLOT12_P1_PerCP[!VI_PLOT12_P1_PerCP$SAMPLE_ID %in% Viability_Samples_Remove$SAMPLE_ID, , drop=FALSE]
VI_PLOT4_restructured_BAD_REMOVED <- VI_PLOT4_restructured[!VI_PLOT4_restructured$SAMPLE_ID %in% Viability_Samples_Remove$SAMPLE_ID, , drop=FALSE]
```

Arc sine Percentage data
========================

``` r
# Calculate Percent Live Granulocytes 
  # Take cells here and make a percentage out of GRANULAR hemocyte count from VI_PLOT3_P1_GATE P1_COUNT
  # These commands only work correctly if the csv has all the commas removed from the numbers for the thousands separator
VI_PLOT9_E1_MINUS_V1R$COUNT_THIS_PLOT<- as.numeric(VI_PLOT9_E1_MINUS_V1R$COUNT_THIS_PLOT)

VI_PLOT3_P1_GATE$P1_COUNT <- as.numeric(VI_PLOT3_P1_GATE$P1_COUNT)
VI_PLOT4_E1_E3_GATE$E1_COUNT <- as.numeric(VI_PLOT4_E1_E3_GATE$E1_COUNT) 
VI_PLOT9_E1_MINUS_V1R$PERCENT_LIVE <- (VI_PLOT9_E1_MINUS_V1R$COUNT_THIS_PLOT / VI_PLOT4_E1_E3_GATE$E1_COUNT)*100

VI_PLOT9_E1_MINUS_V1R_BAD_REMOVED$COUNT_THIS_PLOT <- as.numeric(VI_PLOT9_E1_MINUS_V1R_BAD_REMOVED$COUNT_THIS_PLOT)
VI_PLOT3_P1_GATE_BAD_REMOVED$P1_COUNT <- as.numeric(VI_PLOT3_P1_GATE_BAD_REMOVED$P1_COUNT)
VI_PLOT4_E1_E3_GATE_BAD_REMOVED$E1_COUNT <- as.numeric(VI_PLOT4_E1_E3_GATE_BAD_REMOVED$E1_COUNT)
VI_PLOT9_E1_MINUS_V1R_BAD_REMOVED$PERCENT_LIVE <- (VI_PLOT9_E1_MINUS_V1R_BAD_REMOVED$COUNT_THIS_PLOT / VI_PLOT4_E1_E3_GATE_BAD_REMOVED$E1_COUNT)*100 

# Calculate Percent Live Agranulocytes 
VI_PLOT10_E3_MINUS_V1R$COUNT_THIS_PLOT <- as.numeric(VI_PLOT10_E3_MINUS_V1R$COUNT_THIS_PLOT)
VI_PLOT4_E1_E3_GATE$E3_COUNT <- as.numeric(VI_PLOT4_E1_E3_GATE$E3_COUNT)
VI_PLOT10_E3_MINUS_V1R$PERCENT_LIVE <- (VI_PLOT10_E3_MINUS_V1R$COUNT_THIS_PLOT / VI_PLOT4_E1_E3_GATE$E3_COUNT)*100

VI_PLOT10_E3_MINUS_V1R_BAD_REMOVED$COUNT_THIS_PLOT <- as.numeric(VI_PLOT10_E3_MINUS_V1R_BAD_REMOVED$COUNT_THIS_PLOT)
VI_PLOT4_E1_E3_GATE_BAD_REMOVED$E3_COUNT <- as.numeric(VI_PLOT4_E1_E3_GATE_BAD_REMOVED$E3_COUNT)
VI_PLOT10_E3_MINUS_V1R_BAD_REMOVED$PERCENT_LIVE <- (VI_PLOT10_E3_MINUS_V1R_BAD_REMOVED$COUNT_THIS_PLOT / VI_PLOT4_E1_E3_GATE_BAD_REMOVED$E3_COUNT)*100 

# Use transf.arcsine to arcsine transform the percentages
VI_PLOT2_hemocytes$Arcsine <- transf.arcsin(VI_PLOT2_hemocytes$M4_PERCENT_OF_THIS_PLOT*.01)
VI_PLOT4_E1_E3_GATE$E1_Arcsine <- transf.arcsin(VI_PLOT4_E1_E3_GATE$E1_PERCENT_OF_THIS_PLOT*0.01)
VI_PLOT4_E1_E3_GATE$E3_Arcsine <- transf.arcsin(VI_PLOT4_E1_E3_GATE$E3_PERCENT_OF_THIS_PLOT*0.01)
VI_PLOT4_restructured$Arcsine <- transf.arcsin(VI_PLOT4_restructured$PERCENT_OF_THIS_PLOT*0.01)
VI_PLOT9_E1_MINUS_V1R$Arcsine <- transf.arcsin(VI_PLOT9_E1_MINUS_V1R$PERCENT_LIVE*0.01)
VI_PLOT10_E3_MINUS_V1R$Arcsine <- transf.arcsin(VI_PLOT10_E3_MINUS_V1R$PERCENT_LIVE*0.01)
VI_PLOT12_P1_PerCP$V1_L_Arcsine <- transf.arcsin(VI_PLOT12_P1_PerCP$V1_L_PERCENT_OF_THIS_PLOT*0.01)
VI_PLOT12_P1_PerCP$V1_R_Arcsine <- transf.arcsin(VI_PLOT12_P1_PerCP$V1_R_PERCENT_OF_THIS_PLOT*0.01)

# Use transf.arcsine to arcsine transform the percentages for the "BAD REMOVED" samples
VI_PLOT2_hemocytes_BAD_REMOVED$Arcsine <- transf.arcsin(VI_PLOT2_hemocytes_BAD_REMOVED$M4_PERCENT_OF_THIS_PLOT*.01)
VI_PLOT4_E1_E3_GATE_BAD_REMOVED$E1_Arcsine <- transf.arcsin(VI_PLOT4_E1_E3_GATE_BAD_REMOVED$E1_PERCENT_OF_THIS_PLOT*0.01)
VI_PLOT4_E1_E3_GATE_BAD_REMOVED$E3_Arcsine <- transf.arcsin(VI_PLOT4_E1_E3_GATE_BAD_REMOVED$E3_PERCENT_OF_THIS_PLOT*0.01)
VI_PLOT9_E1_MINUS_V1R_BAD_REMOVED$Arcsine <- transf.arcsin(VI_PLOT9_E1_MINUS_V1R_BAD_REMOVED$PERCENT_LIVE*0.01)
VI_PLOT10_E3_MINUS_V1R_BAD_REMOVED$Arcsine <- transf.arcsin(VI_PLOT10_E3_MINUS_V1R_BAD_REMOVED$PERCENT_LIVE*0.01)
VI_PLOT12_P1_PerCP_BAD_REMOVED$V1_L_Arcsine <- transf.arcsin(VI_PLOT12_P1_PerCP_BAD_REMOVED$V1_L_PERCENT_OF_THIS_PLOT*0.01)
VI_PLOT12_P1_PerCP_BAD_REMOVED$V1_R_Arcsine <- transf.arcsin(VI_PLOT12_P1_PerCP_BAD_REMOVED$V1_R_PERCENT_OF_THIS_PLOT*0.01)
VI_PLOT4_restructured_BAD_REMOVED$Arcsine <- transf.arcsin(VI_PLOT4_restructured_BAD_REMOVED$PERCENT_OF_THIS_PLOT*0.01)
```

Basic plots showing the data by Family and then across families
---------------------------------------------------------------

Percent Total Hemocytes out of all events
-----------------------------------------

``` r
VI_Percent_total_hemocytes_BAD_NOT_REMOVED <- ggplot(data= VI_PLOT2_hemocytes, aes(x=FAMILY, y=M4_PERCENT_OF_THIS_PLOT, color=GROUP, by=GROUP)) + geom_boxplot() + ggtitle("Percent of Hemocyte Events in Total Sample Events \n Low Quality Not Removed") +
    xlab("Family") + ylab("Percent of Hemocyte Events") + ylim(0,100)
VI_Percent_total_hemocytes_BAD_NOT_REMOVED
```

![](Dermo_Viability_Assay_Data_analysis_files/figure-markdown_github/percent_total_hemocytes-1.png)

``` r
VI_Percent_total_hemocytes_BAD_REMOVED <- ggplot(data= VI_PLOT2_hemocytes_BAD_REMOVED, aes(x=FAMILY, y=M4_PERCENT_OF_THIS_PLOT, color=GROUP, by=GROUP)) + geom_boxplot() + ggtitle("Percent of Hemocyte Events in Total Sample Events \nLow Quality Removed") +
  xlab("Family") + ylab("Percent of Hemocyte Events") + ylim(0,100)
VI_Percent_total_hemocytes_BAD_REMOVED
```

![](Dermo_Viability_Assay_Data_analysis_files/figure-markdown_github/percent_total_hemocytes-2.png)

Percent Granular Hemocytes out of all hemocytes
-----------------------------------------------

``` r
VI_Percent_Granular_Hemocytes_BAD_NOT_REMOVED <- ggplot(data=VI_PLOT4_E1_E3_GATE, aes(y=E1_PERCENT_OF_THIS_PLOT, x=FAMILY, by=GROUP, color=GROUP)) + geom_boxplot() + ggtitle("Percent of Granular Hemocyte \n Events Low Quality Not Removed") +xlab("Family") + ylab("Percent of Live and Dead Granular Hemocytes") + ylim(0,100)
VI_Percent_Granular_Hemocytes_BAD_NOT_REMOVED
```

![](Dermo_Viability_Assay_Data_analysis_files/figure-markdown_github/percent_granular_hemocytes-1.png)

``` r
VI_Percent_Granular_Hemocytes_BAD_REMOVED <- ggplot(data=VI_PLOT4_E1_E3_GATE_BAD_REMOVED, aes(y=E1_PERCENT_OF_THIS_PLOT, x=FAMILY, by=GROUP, color=GROUP)) + geom_boxplot() + ggtitle("Percent of Granular Hemocyte \n Events Low Quality Removed") +
  xlab("Family") + ylab("Percent of Live and Dead Granular Hemocytes") + ylim(0,100)
VI_Percent_Granular_Hemocytes_BAD_REMOVED
```

![](Dermo_Viability_Assay_Data_analysis_files/figure-markdown_github/percent_granular_hemocytes-2.png)

Percent of granular hemocytes (E1)
----------------------------------

### FAMILY A

``` r
VI_PLOT4_FAMILY_A <- VI_PLOT4_E1_E3_GATE %>% filter(FAMILY=="A")
```

    ## Warning: package 'bindrcpp' was built under R version 3.4.4

``` r
VI_PLOT4_E1_AOV_FAMILY_A <- aov(VI_PLOT4_FAMILY_A$E1_Arcsine ~ VI_PLOT4_FAMILY_A$GROUP, data=VI_PLOT4_FAMILY_A)
summary(VI_PLOT4_E1_AOV_FAMILY_A)
```

    ##                         Df  Sum Sq Mean Sq F value Pr(>F)  
    ## VI_PLOT4_FAMILY_A$GROUP  1 0.04543 0.04543   3.946 0.0782 .
    ## Residuals                9 0.10362 0.01151                 
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

``` r
VI_PLOT4_FAMILY_A_BAD_REMOVED <- VI_PLOT4_E1_E3_GATE_BAD_REMOVED %>% filter(FAMILY =="A")
VI_PLOT4_E1_AOV_FAMILY_A_BAD_REMOVED <- aov(VI_PLOT4_FAMILY_A_BAD_REMOVED$E1_Arcsine ~ VI_PLOT4_FAMILY_A_BAD_REMOVED$GROUP, data=VI_PLOT4_FAMILY_A_BAD_REMOVED)
summary(VI_PLOT4_E1_AOV_FAMILY_A_BAD_REMOVED)
```

    ##                                     Df  Sum Sq Mean Sq F value Pr(>F)
    ## VI_PLOT4_FAMILY_A_BAD_REMOVED$GROUP  1 0.03511 0.03511   3.086  0.117
    ## Residuals                            8 0.09101 0.01138

### FAMILY B

``` r
V1_PLOT4_FAMILY_B <- VI_PLOT4_E1_E3_GATE %>% filter(FAMILY=="B")
VI_PLOT4_E1_AOV_FAMILY_B <- aov(V1_PLOT4_FAMILY_B$E1_Arcsine ~ V1_PLOT4_FAMILY_B$GROUP, data=V1_PLOT4_FAMILY_B)
summary(VI_PLOT4_E1_AOV_FAMILY_B)
```

    ##                         Df  Sum Sq Mean Sq F value Pr(>F)
    ## V1_PLOT4_FAMILY_B$GROUP  1 0.06237 0.06237   1.749  0.234
    ## Residuals                6 0.21400 0.03567

``` r
V1_PLOT4_FAMILY_B_BAD_REMOVED <- VI_PLOT4_E1_E3_GATE_BAD_REMOVED %>% filter(FAMILY=="B")
VI_PLOT4_E1_AOV_FAMILY_B_BAD_REMOVED <- aov(V1_PLOT4_FAMILY_B_BAD_REMOVED$E1_Arcsine ~ V1_PLOT4_FAMILY_B_BAD_REMOVED$GROUP, data=V1_PLOT4_FAMILY_B_BAD_REMOVED)
summary(VI_PLOT4_E1_AOV_FAMILY_B_BAD_REMOVED)
```

    ##                                     Df  Sum Sq Mean Sq F value Pr(>F)
    ## V1_PLOT4_FAMILY_B_BAD_REMOVED$GROUP  1 0.05167 0.05167   1.327  0.301
    ## Residuals                            5 0.19465 0.03893

### FAMILY D

``` r
VI_PLOT4_FAMILY_D <- VI_PLOT4_E1_E3_GATE %>% filter(FAMILY=="D")
VI_PLOT4_E1_AOV_FAMILY_D <- aov(VI_PLOT4_FAMILY_D$E1_Arcsine ~ VI_PLOT4_FAMILY_D$GROUP, data=VI_PLOT4_FAMILY_D)
summary(VI_PLOT4_E1_AOV_FAMILY_D)
```

    ##                         Df  Sum Sq  Mean Sq F value Pr(>F)
    ## VI_PLOT4_FAMILY_D$GROUP  1 0.00065 0.000648   0.065  0.806
    ## Residuals                8 0.08028 0.010035

``` r
VI_PLOT4_FAMILY_D_BAD_REMOVED <- VI_PLOT4_E1_E3_GATE_BAD_REMOVED %>% filter(FAMILY=="D")
VI_PLOT4_E1_AOV_FAMILY_D_BAD_REMOVED <- aov(VI_PLOT4_FAMILY_D_BAD_REMOVED$E1_Arcsine ~ VI_PLOT4_FAMILY_D_BAD_REMOVED$GROUP, data=VI_PLOT4_FAMILY_D_BAD_REMOVED)
summary(VI_PLOT4_E1_AOV_FAMILY_D_BAD_REMOVED)
```

    ##                                     Df  Sum Sq  Mean Sq F value Pr(>F)
    ## VI_PLOT4_FAMILY_D_BAD_REMOVED$GROUP  1 0.00219 0.002189   0.242  0.638
    ## Residuals                            7 0.06334 0.009049

### FAMILY E

``` r
VI_PLOT4_FAMILY_E <- VI_PLOT4_E1_E3_GATE %>% filter(FAMILY=="E")
VI_PLOT4_E1_AOV_FAMILY_E <- aov(VI_PLOT4_FAMILY_E$E1_Arcsine ~ VI_PLOT4_FAMILY_E$GROUP, data=VI_PLOT4_FAMILY_E)
summary(VI_PLOT4_E1_AOV_FAMILY_E)
```

    ##                         Df  Sum Sq Mean Sq F value Pr(>F)
    ## VI_PLOT4_FAMILY_E$GROUP  1 0.00501 0.00501    0.21   0.66
    ## Residuals                7 0.16668 0.02381

``` r
VI_PLOT4_FAMILY_E_BAD_REMOVED <- VI_PLOT4_E1_E3_GATE_BAD_REMOVED %>% filter(FAMILY=="E")
VI_PLOT4_E1_AOV_FAMILY_E_BAD_REMOVED <- aov(VI_PLOT4_FAMILY_E_BAD_REMOVED$E1_Arcsine ~ VI_PLOT4_FAMILY_E_BAD_REMOVED$GROUP, data=VI_PLOT4_FAMILY_E_BAD_REMOVED)
summary(VI_PLOT4_E1_AOV_FAMILY_E_BAD_REMOVED)
```

    ##                                     Df  Sum Sq  Mean Sq F value Pr(>F)
    ## VI_PLOT4_FAMILY_E_BAD_REMOVED$GROUP  1 0.00094 0.000944   0.091  0.775
    ## Residuals                            5 0.05177 0.010354

### FAMILY J

``` r
VI_PLOT4_FAMILY_J <- VI_PLOT4_E1_E3_GATE %>% filter(FAMILY=="J")
VI_PLOT4_E1_AOV_FAMILY_J <- aov(VI_PLOT4_FAMILY_J$E1_Arcsine ~ VI_PLOT4_FAMILY_J$GROUP, data=VI_PLOT4_FAMILY_J)
summary(VI_PLOT4_E1_AOV_FAMILY_J)
```

    ##                         Df  Sum Sq Mean Sq F value Pr(>F)
    ## VI_PLOT4_FAMILY_J$GROUP  1 0.01965 0.01965   0.963  0.348
    ## Residuals               11 0.22459 0.02042

``` r
VI_PLOT4_FAMILY_J_BAD_REMOVED <- VI_PLOT4_E1_E3_GATE_BAD_REMOVED %>% filter(FAMILY=="J")
VI_PLOT4_E1_AOV_FAMILY_J_BAD_REMOVED <- aov(VI_PLOT4_FAMILY_J_BAD_REMOVED$E1_Arcsine ~ VI_PLOT4_FAMILY_J_BAD_REMOVED$GROUP, data=VI_PLOT4_FAMILY_J_BAD_REMOVED)
summary(VI_PLOT4_E1_AOV_FAMILY_J_BAD_REMOVED)
```

    ##                                     Df Sum Sq Mean Sq F value Pr(>F)
    ## VI_PLOT4_FAMILY_J_BAD_REMOVED$GROUP  1 0.0402 0.04020    3.03  0.116
    ## Residuals                            9 0.1194 0.01327

### FAMILY L

``` r
VI_PLOT4_FAMILY_L <- VI_PLOT4_E1_E3_GATE %>% filter(FAMILY=="L")
VI_PLOT4_E1_AOV_FAMILY_L <- aov(VI_PLOT4_FAMILY_L$E1_Arcsine ~ VI_PLOT4_FAMILY_L$GROUP, data=VI_PLOT4_FAMILY_L)
summary(VI_PLOT4_E1_AOV_FAMILY_L)
```

    ##                         Df  Sum Sq Mean Sq F value Pr(>F)
    ## VI_PLOT4_FAMILY_L$GROUP  1 0.01144 0.01144   0.531  0.481
    ## Residuals               11 0.23701 0.02155

``` r
VI_PLOT4_FAMILY_L_BAD_REMOVED <- VI_PLOT4_E1_E3_GATE_BAD_REMOVED %>% filter(FAMILY=="L")
VI_PLOT4_E1_AOV_FAMILY_L_BAD_REMOVED <- aov(VI_PLOT4_FAMILY_L_BAD_REMOVED$E1_Arcsine ~ VI_PLOT4_FAMILY_L_BAD_REMOVED$GROUP, data=VI_PLOT4_FAMILY_L_BAD_REMOVED)
summary(VI_PLOT4_E1_AOV_FAMILY_L_BAD_REMOVED)
```

    ##                                     Df Sum Sq  Mean Sq F value Pr(>F)
    ## VI_PLOT4_FAMILY_L_BAD_REMOVED$GROUP  1 0.0000 0.000001       0  0.995
    ## Residuals                            7 0.1461 0.020873

### Two Way ANOVA of Granular Hemocytes

``` r
VI_PLOT4_Granular_hemocytes_AOV <- lm(VI_PLOT4_E1_E3_GATE$E1_Arcsine ~ VI_PLOT4_E1_E3_GATE$GROUP + VI_PLOT4_E1_E3_GATE$FAMILY, data=VI_PLOT4_E1_E3_GATE)
Anova(VI_PLOT4_Granular_hemocytes_AOV, type="II")
```

    ## Anova Table (Type II tests)
    ## 
    ## Response: VI_PLOT4_E1_E3_GATE$E1_Arcsine
    ##                             Sum Sq Df F value Pr(>F)
    ## VI_PLOT4_E1_E3_GATE$GROUP  0.00728  1  0.3565 0.5528
    ## VI_PLOT4_E1_E3_GATE$FAMILY 0.00830  5  0.0814 0.9949
    ## Residuals                  1.16347 57

``` r
summary(VI_PLOT4_Granular_hemocytes_AOV)
```

    ## 
    ## Call:
    ## lm(formula = VI_PLOT4_E1_E3_GATE$E1_Arcsine ~ VI_PLOT4_E1_E3_GATE$GROUP + 
    ##     VI_PLOT4_E1_E3_GATE$FAMILY, data = VI_PLOT4_E1_E3_GATE)
    ## 
    ## Residuals:
    ##      Min       1Q   Median       3Q      Max 
    ## -0.32182 -0.08730 -0.00057  0.08606  0.30176 
    ## 
    ## Coefficients:
    ##                                    Estimate Std. Error t value Pr(>|t|)
    ## (Intercept)                         0.45466    0.05402   8.417  1.4e-11
    ## VI_PLOT4_E1_E3_GATE$GROUPtreatment -0.02676    0.04482  -0.597    0.553
    ## VI_PLOT4_E1_E3_GATE$FAMILYB         0.03787    0.06672   0.568    0.573
    ## VI_PLOT4_E1_E3_GATE$FAMILYD         0.02975    0.06251   0.476    0.636
    ## VI_PLOT4_E1_E3_GATE$FAMILYE         0.01752    0.06462   0.271    0.787
    ## VI_PLOT4_E1_E3_GATE$FAMILYJ         0.02433    0.05856   0.415    0.679
    ## VI_PLOT4_E1_E3_GATE$FAMILYL         0.01650    0.05856   0.282    0.779
    ##                                       
    ## (Intercept)                        ***
    ## VI_PLOT4_E1_E3_GATE$GROUPtreatment    
    ## VI_PLOT4_E1_E3_GATE$FAMILYB           
    ## VI_PLOT4_E1_E3_GATE$FAMILYD           
    ## VI_PLOT4_E1_E3_GATE$FAMILYE           
    ## VI_PLOT4_E1_E3_GATE$FAMILYJ           
    ## VI_PLOT4_E1_E3_GATE$FAMILYL           
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
    ## 
    ## Residual standard error: 0.1429 on 57 degrees of freedom
    ## Multiple R-squared:  0.01229,    Adjusted R-squared:  -0.09168 
    ## F-statistic: 0.1182 on 6 and 57 DF,  p-value: 0.9938

``` r
VI_PLOT4_Granular_hemocytes_AOV_BAD_REMOVED <- lm(VI_PLOT4_E1_E3_GATE_BAD_REMOVED$E1_Arcsine ~ VI_PLOT4_E1_E3_GATE_BAD_REMOVED$GROUP + VI_PLOT4_E1_E3_GATE_BAD_REMOVED$FAMILY, data=VI_PLOT4_E1_E3_GATE_BAD_REMOVED)
Anova(VI_PLOT4_Granular_hemocytes_AOV_BAD_REMOVED, type="II")
```

    ## Anova Table (Type II tests)
    ## 
    ## Response: VI_PLOT4_E1_E3_GATE_BAD_REMOVED$E1_Arcsine
    ##                                         Sum Sq Df F value Pr(>F)
    ## VI_PLOT4_E1_E3_GATE_BAD_REMOVED$GROUP  0.01131  1  0.6625 0.4199
    ## VI_PLOT4_E1_E3_GATE_BAD_REMOVED$FAMILY 0.02086  5  0.2444 0.9405
    ## Residuals                              0.78509 46

``` r
summary(VI_PLOT4_Granular_hemocytes_AOV_BAD_REMOVED)
```

    ## 
    ## Call:
    ## lm(formula = VI_PLOT4_E1_E3_GATE_BAD_REMOVED$E1_Arcsine ~ VI_PLOT4_E1_E3_GATE_BAD_REMOVED$GROUP + 
    ##     VI_PLOT4_E1_E3_GATE_BAD_REMOVED$FAMILY, data = VI_PLOT4_E1_E3_GATE_BAD_REMOVED)
    ## 
    ## Residuals:
    ##      Min       1Q   Median       3Q      Max 
    ## -0.29619 -0.07760 -0.00919  0.08418  0.26484 
    ## 
    ## Coefficients:
    ##                                                 Estimate Std. Error
    ## (Intercept)                                     0.475080   0.051802
    ## VI_PLOT4_E1_E3_GATE_BAD_REMOVED$GROUPtreatment -0.036342   0.044648
    ## VI_PLOT4_E1_E3_GATE_BAD_REMOVED$FAMILYB         0.048348   0.064762
    ## VI_PLOT4_E1_E3_GATE_BAD_REMOVED$FAMILYD         0.003106   0.060126
    ## VI_PLOT4_E1_E3_GATE_BAD_REMOVED$FAMILYE         0.042754   0.064762
    ## VI_PLOT4_E1_E3_GATE_BAD_REMOVED$FAMILYJ         0.039081   0.057325
    ## VI_PLOT4_E1_E3_GATE_BAD_REMOVED$FAMILYL         0.042575   0.060126
    ##                                                t value Pr(>|t|)    
    ## (Intercept)                                      9.171 5.92e-12 ***
    ## VI_PLOT4_E1_E3_GATE_BAD_REMOVED$GROUPtreatment  -0.814    0.420    
    ## VI_PLOT4_E1_E3_GATE_BAD_REMOVED$FAMILYB          0.747    0.459    
    ## VI_PLOT4_E1_E3_GATE_BAD_REMOVED$FAMILYD          0.052    0.959    
    ## VI_PLOT4_E1_E3_GATE_BAD_REMOVED$FAMILYE          0.660    0.512    
    ## VI_PLOT4_E1_E3_GATE_BAD_REMOVED$FAMILYJ          0.682    0.499    
    ## VI_PLOT4_E1_E3_GATE_BAD_REMOVED$FAMILYL          0.708    0.482    
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
    ## 
    ## Residual standard error: 0.1306 on 46 degrees of freedom
    ## Multiple R-squared:  0.03592,    Adjusted R-squared:  -0.08983 
    ## F-statistic: 0.2856 on 6 and 46 DF,  p-value: 0.9408

``` r
#NO significance, no interaction term added
```

### One Way ANOVA of Differences between Families

``` r
VI_PLOT4_E1_E3_GATE_BAD_REMOVED_CHALLENGE <- VI_PLOT4_E1_E3_GATE_BAD_REMOVED[!grepl("control", VI_PLOT4_E1_E3_GATE_BAD_REMOVED$GROUP),]
VI_PLOT4_Granular_hemocytes_oneway_lm <- aov(VI_PLOT4_E1_E3_GATE_BAD_REMOVED_CHALLENGE$E1_Arcsine ~ VI_PLOT4_E1_E3_GATE_BAD_REMOVED_CHALLENGE$FAMILY, data=VI_PLOT4_E1_E3_GATE_BAD_REMOVED_CHALLENGE)
summary(VI_PLOT4_Granular_hemocytes_oneway_lm)
```

    ##                                                  Df Sum Sq Mean Sq F value
    ## VI_PLOT4_E1_E3_GATE_BAD_REMOVED_CHALLENGE$FAMILY  5 0.0510 0.01021   0.567
    ## Residuals                                        36 0.6476 0.01799        
    ##                                                  Pr(>F)
    ## VI_PLOT4_E1_E3_GATE_BAD_REMOVED_CHALLENGE$FAMILY  0.724
    ## Residuals

Percent of Agranular hemocytes (E3)
===================================

Percent Agranular Hemocytes out of all hemocytes
------------------------------------------------

``` r
VI_Percent_Agranular_Hemocytes_BAD_NOT_REMOVED <-  ggplot(data=VI_PLOT4_E1_E3_GATE, aes(y=E3_PERCENT_OF_THIS_PLOT, x=FAMILY, by=GROUP, color=GROUP)) + geom_boxplot() + ggtitle("Percent of Agranular Hemocyte Events \n Low Quality Not Removed") +
  xlab("Family") + ylab("Percent of Live and Dead Agranular Hemocytes") + ylim(0,100)
VI_Percent_Agranular_Hemocytes_BAD_NOT_REMOVED
```

![](Dermo_Viability_Assay_Data_analysis_files/figure-markdown_github/percent_agranular_hemocytes-1.png)

``` r
VI_Percent_Agranular_Hemocytes_BAD_REMOVED <-  ggplot(data=VI_PLOT4_E1_E3_GATE_BAD_REMOVED, aes(y=E3_PERCENT_OF_THIS_PLOT, x=FAMILY, by=GROUP, color=GROUP)) + geom_boxplot() + ggtitle("Percent of Agranular Hemocyte Events") +
  xlab("Family") + ylab("Percent of Live and Dead \n Agranular Hemocytes Low Quality Removed") + ylim(0,100)
VI_Percent_Agranular_Hemocytes_BAD_REMOVED
```

![](Dermo_Viability_Assay_Data_analysis_files/figure-markdown_github/percent_agranular_hemocytes-2.png)

### FAMILY A

``` r
VI_PLOT4_FAMILY_A_E3 <- VI_PLOT4_E1_E3_GATE %>% filter(FAMILY=="A")
VI_PLOT4_E3_AOV_FAMILY_A <- aov(VI_PLOT4_FAMILY_A_E3$E3_Arcsine ~ VI_PLOT4_FAMILY_A_E3$GROUP, data=VI_PLOT4_FAMILY_A_E3)
summary(VI_PLOT4_E3_AOV_FAMILY_A)
```

    ##                            Df  Sum Sq Mean Sq F value Pr(>F)  
    ## VI_PLOT4_FAMILY_A_E3$GROUP  1 0.04417 0.04417   3.933 0.0787 .
    ## Residuals                   9 0.10108 0.01123                 
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

``` r
VI_PLOT4_FAMILY_A_E3_BAD_REMOVED <- VI_PLOT4_E1_E3_GATE_BAD_REMOVED %>% filter(FAMILY =="A")
VI_PLOT4_E3_AOV_FAMILY_A_BAD_REMOVED <- aov(VI_PLOT4_FAMILY_A_E3_BAD_REMOVED$E3_Arcsine ~ VI_PLOT4_FAMILY_A_E3_BAD_REMOVED$GROUP, data=VI_PLOT4_FAMILY_A_E3_BAD_REMOVED)
summary(VI_PLOT4_E3_AOV_FAMILY_A_BAD_REMOVED)
```

    ##                                        Df  Sum Sq Mean Sq F value Pr(>F)
    ## VI_PLOT4_FAMILY_A_E3_BAD_REMOVED$GROUP  1 0.03490 0.03490   3.066  0.118
    ## Residuals                               8 0.09107 0.01138

### FAMILY B

    ##                            Df  Sum Sq Mean Sq F value Pr(>F)
    ## VI_PLOT4_FAMILY_B_E3$GROUP  1 0.06147 0.06147   1.612  0.251
    ## Residuals                   6 0.22874 0.03812

    ##                                        Df  Sum Sq Mean Sq F value Pr(>F)
    ## VI_PLOT4_FAMILY_B_E3_BAD_REMOVED$GROUP  1 0.05289 0.05289   1.218   0.32
    ## Residuals                               5 0.21711 0.04342

### FAMILY D

    ##                            Df  Sum Sq  Mean Sq F value Pr(>F)
    ## VI_PLOT4_FAMILY_D_E3$GROUP  1 0.00227 0.002266   0.226  0.647
    ## Residuals                   8 0.08023 0.010029

    ##                                        Df  Sum Sq  Mean Sq F value Pr(>F)
    ## VI_PLOT4_FAMILY_D_E3_BAD_REMOVED$GROUP  1 0.00440 0.004403   0.462  0.518
    ## Residuals                               7 0.06665 0.009522

### FAMILY E

    ##                            Df  Sum Sq  Mean Sq F value Pr(>F)
    ## VI_PLOT4_FAMILY_E_E3$GROUP  1 0.00322 0.003224   0.131  0.728
    ## Residuals                   7 0.17229 0.024613

    ##                                        Df  Sum Sq  Mean Sq F value Pr(>F)
    ## VI_PLOT4_FAMILY_E_E3_BAD_REMOVED$GROUP  1 0.00036 0.000357   0.031  0.866
    ## Residuals                               5 0.05676 0.011351

### FAMILY J

    ##                            Df  Sum Sq Mean Sq F value Pr(>F)
    ## VI_PLOT4_FAMILY_J_E3$GROUP  1 0.02636 0.02636   1.386  0.264
    ## Residuals                  11 0.20930 0.01903

    ##                                        Df  Sum Sq Mean Sq F value Pr(>F)
    ## VI_PLOT4_FAMILY_J_E3_BAD_REMOVED$GROUP  1 0.04222 0.04222   3.089  0.113
    ## Residuals                               9 0.12299 0.01367

### FAMILY L

    ##                            Df  Sum Sq  Mean Sq F value Pr(>F)
    ## VI_PLOT4_FAMILY_L_E3$GROUP  1 0.00328 0.003279   0.162  0.695
    ## Residuals                  11 0.22317 0.020288

    ##                                        Df Sum Sq  Mean Sq F value Pr(>F)
    ## VI_PLOT4_FAMILY_L_E3_BAD_REMOVED$GROUP  1 0.0001 0.000098   0.005  0.947
    ## Residuals                               7 0.1469 0.020992

### Two Way ANOVA of Agranular Hemocytes

    ## Anova Table (Type II tests)
    ## 
    ## Response: VI_PLOT4_E1_E3_GATE$E3_Arcsine
    ##                             Sum Sq Df F value Pr(>F)
    ## VI_PLOT4_E1_E3_GATE$GROUP  0.01023  1  0.5092 0.4784
    ## VI_PLOT4_E1_E3_GATE$FAMILY 0.00512  5  0.0510 0.9983
    ## Residuals                  1.14534 57

    ## 
    ## Call:
    ## lm(formula = VI_PLOT4_E1_E3_GATE$E3_Arcsine ~ VI_PLOT4_E1_E3_GATE$GROUP + 
    ##     VI_PLOT4_E1_E3_GATE$FAMILY, data = VI_PLOT4_E1_E3_GATE)
    ## 
    ## Residuals:
    ##      Min       1Q   Median       3Q      Max 
    ## -0.29269 -0.09081  0.00860  0.08944  0.31944 
    ## 
    ## Coefficients:
    ##                                    Estimate Std. Error t value Pr(>|t|)
    ## (Intercept)                         1.06173    0.05360  19.809   <2e-16
    ## VI_PLOT4_E1_E3_GATE$GROUPtreatment  0.03173    0.04447   0.714    0.478
    ## VI_PLOT4_E1_E3_GATE$FAMILYB        -0.02923    0.06619  -0.442    0.660
    ## VI_PLOT4_E1_E3_GATE$FAMILYD        -0.02306    0.06202  -0.372    0.711
    ## VI_PLOT4_E1_E3_GATE$FAMILYE        -0.01706    0.06412  -0.266    0.791
    ## VI_PLOT4_E1_E3_GATE$FAMILYJ        -0.02082    0.05810  -0.358    0.721
    ## VI_PLOT4_E1_E3_GATE$FAMILYL        -0.01257    0.05810  -0.216    0.829
    ##                                       
    ## (Intercept)                        ***
    ## VI_PLOT4_E1_E3_GATE$GROUPtreatment    
    ## VI_PLOT4_E1_E3_GATE$FAMILYB           
    ## VI_PLOT4_E1_E3_GATE$FAMILYD           
    ## VI_PLOT4_E1_E3_GATE$FAMILYE           
    ## VI_PLOT4_E1_E3_GATE$FAMILYJ           
    ## VI_PLOT4_E1_E3_GATE$FAMILYL           
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
    ## 
    ## Residual standard error: 0.1418 on 57 degrees of freedom
    ## Multiple R-squared:  0.0123, Adjusted R-squared:  -0.09167 
    ## F-statistic: 0.1183 on 6 and 57 DF,  p-value: 0.9938

    ## Anova Table (Type II tests)
    ## 
    ## Response: VI_PLOT4_E1_E3_GATE_BAD_REMOVED$E3_Arcsine
    ##                                         Sum Sq Df F value Pr(>F)
    ## VI_PLOT4_E1_E3_GATE_BAD_REMOVED$GROUP  0.01298  1  0.7253 0.3988
    ## VI_PLOT4_E1_E3_GATE_BAD_REMOVED$FAMILY 0.01736  5  0.1940 0.9633
    ## Residuals                              0.82340 46

    ## 
    ## Call:
    ## lm(formula = VI_PLOT4_E1_E3_GATE_BAD_REMOVED$E3_Arcsine ~ VI_PLOT4_E1_E3_GATE_BAD_REMOVED$GROUP + 
    ##     VI_PLOT4_E1_E3_GATE_BAD_REMOVED$FAMILY, data = VI_PLOT4_E1_E3_GATE_BAD_REMOVED)
    ## 
    ## Residuals:
    ##      Min       1Q   Median       3Q      Max 
    ## -0.25835 -0.07881  0.01578  0.07716  0.31558 
    ## 
    ## Coefficients:
    ##                                                  Estimate Std. Error
    ## (Intercept)                                     1.0443089  0.0530513
    ## VI_PLOT4_E1_E3_GATE_BAD_REMOVED$GROUPtreatment  0.0389405  0.0457241
    ## VI_PLOT4_E1_E3_GATE_BAD_REMOVED$FAMILYB        -0.0364204  0.0663232
    ## VI_PLOT4_E1_E3_GATE_BAD_REMOVED$FAMILYD         0.0007298  0.0615755
    ## VI_PLOT4_E1_E3_GATE_BAD_REMOVED$FAMILYE        -0.0408459  0.0663232
    ## VI_PLOT4_E1_E3_GATE_BAD_REMOVED$FAMILYJ        -0.0366811  0.0587067
    ## VI_PLOT4_E1_E3_GATE_BAD_REMOVED$FAMILYL        -0.0366984  0.0615755
    ##                                                t value Pr(>|t|)    
    ## (Intercept)                                     19.685   <2e-16 ***
    ## VI_PLOT4_E1_E3_GATE_BAD_REMOVED$GROUPtreatment   0.852    0.399    
    ## VI_PLOT4_E1_E3_GATE_BAD_REMOVED$FAMILYB         -0.549    0.586    
    ## VI_PLOT4_E1_E3_GATE_BAD_REMOVED$FAMILYD          0.012    0.991    
    ## VI_PLOT4_E1_E3_GATE_BAD_REMOVED$FAMILYE         -0.616    0.541    
    ## VI_PLOT4_E1_E3_GATE_BAD_REMOVED$FAMILYJ         -0.625    0.535    
    ## VI_PLOT4_E1_E3_GATE_BAD_REMOVED$FAMILYL         -0.596    0.554    
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
    ## 
    ## Residual standard error: 0.1338 on 46 degrees of freedom
    ## Multiple R-squared:  0.03244,    Adjusted R-squared:  -0.09377 
    ## F-statistic: 0.257 on 6 and 46 DF,  p-value: 0.9539

### One Way ANOVA of Differences between Families

``` r
VI_PLOT4_E1_E3_GATE_BAD_REMOVED_CHALLENGE <- VI_PLOT4_E1_E3_GATE_BAD_REMOVED[!grepl("control", VI_PLOT4_E1_E3_GATE_BAD_REMOVED$GROUP),]
VI_PLOT4_Agranular_hemocytes_oneway_aov <- aov(VI_PLOT4_E1_E3_GATE_BAD_REMOVED_CHALLENGE$E3_Arcsine ~ VI_PLOT4_E1_E3_GATE_BAD_REMOVED_CHALLENGE$FAMILY, data=VI_PLOT4_E1_E3_GATE_BAD_REMOVED_CHALLENGE)
summary(VI_PLOT4_Agranular_hemocytes_oneway_aov)
```

    ##                                                  Df Sum Sq Mean Sq F value
    ## VI_PLOT4_E1_E3_GATE_BAD_REMOVED_CHALLENGE$FAMILY  5 0.0520 0.01040   0.546
    ## Residuals                                        36 0.6852 0.01903        
    ##                                                  Pr(>F)
    ## VI_PLOT4_E1_E3_GATE_BAD_REMOVED_CHALLENGE$FAMILY   0.74
    ## Residuals

Two Way ANOVA of Granular vs. Agranular
---------------------------------------

``` r
# Plotting
ggplot(VI_PLOT4_restructured_BAD_REMOVED, aes(x=GROUP, y=PERCENT_OF_THIS_PLOT, fill=E1_E3)) + geom_boxplot() + ggtitle("Percent of Granular and Agranular Hemocytes (low quality removed)") +
  ylab("Percent of Hemocyte Events in each quad plot") + scale_fill_manual(name="Hemocyte Type", labels=c("Granular Hemocytes", "Agranular Hemocytes"), values=c("E1"="#99a765","E3"="#96578a")) + facet_grid(.~FAMILY+GROUP, scales="free") 
```

![](Dermo_Viability_Assay_Data_analysis_files/figure-markdown_github/granular_agranular_percentage-1.png)

``` r
VI_PLOT4_agranular_granular_lm <- lm(VI_PLOT4_restructured_BAD_REMOVED$Arcsine ~ VI_PLOT4_restructured_BAD_REMOVED$E1_E3 + VI_PLOT4_restructured_BAD_REMOVED$FAMILY, data=VI_PLOT4_restructured_BAD_REMOVED)
Anova(VI_PLOT4_agranular_granular_lm, type="II")
```

    ## Anova Table (Type II tests)
    ## 
    ## Response: VI_PLOT4_restructured_BAD_REMOVED$Arcsine
    ##                                          Sum Sq Df  F value Pr(>F)    
    ## VI_PLOT4_restructured_BAD_REMOVED$E1_E3  8.8244  1 524.7023 <2e-16 ***
    ## VI_PLOT4_restructured_BAD_REMOVED$FAMILY 0.0004  5   0.0043      1    
    ## Residuals                                1.6650 99                    
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

``` r
summary(VI_PLOT4_agranular_granular_lm)
```

    ## 
    ## Call:
    ## lm(formula = VI_PLOT4_restructured_BAD_REMOVED$Arcsine ~ VI_PLOT4_restructured_BAD_REMOVED$E1_E3 + 
    ##     VI_PLOT4_restructured_BAD_REMOVED$FAMILY, data = VI_PLOT4_restructured_BAD_REMOVED)
    ## 
    ## Residuals:
    ##       Min        1Q    Median        3Q       Max 
    ## -0.287348 -0.082669 -0.001244  0.090528  0.307108 
    ## 
    ## Coefficients:
    ##                                           Estimate Std. Error t value
    ## (Intercept)                               0.472074   0.031616  14.932
    ## VI_PLOT4_restructured_BAD_REMOVED$E1_E3E3 0.577060   0.025192  22.906
    ## VI_PLOT4_restructured_BAD_REMOVED$FAMILYB 0.006168   0.045191   0.136
    ## VI_PLOT4_restructured_BAD_REMOVED$FAMILYD 0.002019   0.042134   0.048
    ## VI_PLOT4_restructured_BAD_REMOVED$FAMILYE 0.001158   0.045191   0.026
    ## VI_PLOT4_restructured_BAD_REMOVED$FAMILYJ 0.001353   0.040067   0.034
    ## VI_PLOT4_restructured_BAD_REMOVED$FAMILYL 0.003040   0.042134   0.072
    ##                                           Pr(>|t|)    
    ## (Intercept)                                 <2e-16 ***
    ## VI_PLOT4_restructured_BAD_REMOVED$E1_E3E3   <2e-16 ***
    ## VI_PLOT4_restructured_BAD_REMOVED$FAMILYB    0.892    
    ## VI_PLOT4_restructured_BAD_REMOVED$FAMILYD    0.962    
    ## VI_PLOT4_restructured_BAD_REMOVED$FAMILYE    0.980    
    ## VI_PLOT4_restructured_BAD_REMOVED$FAMILYJ    0.973    
    ## VI_PLOT4_restructured_BAD_REMOVED$FAMILYL    0.943    
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
    ## 
    ## Residual standard error: 0.1297 on 99 degrees of freedom
    ## Multiple R-squared:  0.8413, Adjusted R-squared:  0.8317 
    ## F-statistic: 87.45 on 6 and 99 DF,  p-value: < 2.2e-16

``` r
VI_PLOT4_agranular_granular_lm_interaction <- lm(VI_PLOT4_restructured_BAD_REMOVED$Arcsine ~ VI_PLOT4_restructured_BAD_REMOVED$E1_E3 + VI_PLOT4_restructured_BAD_REMOVED$FAMILY + VI_PLOT4_restructured_BAD_REMOVED$FAMILY:VI_PLOT4_restructured_BAD_REMOVED$E1_E3, data=VI_PLOT4_restructured_BAD_REMOVED)
Anova(VI_PLOT4_agranular_granular_lm_interaction, type="II")
```

    ## Anova Table (Type II tests)
    ## 
    ## Response: VI_PLOT4_restructured_BAD_REMOVED$Arcsine
    ##                                                                                  Sum Sq
    ## VI_PLOT4_restructured_BAD_REMOVED$E1_E3                                          8.8244
    ## VI_PLOT4_restructured_BAD_REMOVED$FAMILY                                         0.0004
    ## VI_PLOT4_restructured_BAD_REMOVED$E1_E3:VI_PLOT4_restructured_BAD_REMOVED$FAMILY 0.0322
    ## Residuals                                                                        1.6328
    ##                                                                                  Df
    ## VI_PLOT4_restructured_BAD_REMOVED$E1_E3                                           1
    ## VI_PLOT4_restructured_BAD_REMOVED$FAMILY                                          5
    ## VI_PLOT4_restructured_BAD_REMOVED$E1_E3:VI_PLOT4_restructured_BAD_REMOVED$FAMILY  5
    ## Residuals                                                                        94
    ##                                                                                   F value
    ## VI_PLOT4_restructured_BAD_REMOVED$E1_E3                                          508.0285
    ## VI_PLOT4_restructured_BAD_REMOVED$FAMILY                                           0.0042
    ## VI_PLOT4_restructured_BAD_REMOVED$E1_E3:VI_PLOT4_restructured_BAD_REMOVED$FAMILY   0.3708
    ## Residuals                                                                                
    ##                                                                                  Pr(>F)
    ## VI_PLOT4_restructured_BAD_REMOVED$E1_E3                                          <2e-16
    ## VI_PLOT4_restructured_BAD_REMOVED$FAMILY                                         1.0000
    ## VI_PLOT4_restructured_BAD_REMOVED$E1_E3:VI_PLOT4_restructured_BAD_REMOVED$FAMILY 0.8675
    ## Residuals                                                                              
    ##                                                                                     
    ## VI_PLOT4_restructured_BAD_REMOVED$E1_E3                                          ***
    ## VI_PLOT4_restructured_BAD_REMOVED$FAMILY                                            
    ## VI_PLOT4_restructured_BAD_REMOVED$E1_E3:VI_PLOT4_restructured_BAD_REMOVED$FAMILY    
    ## Residuals                                                                           
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

``` r
summary(VI_PLOT4_agranular_granular_lm_interaction)
```

    ## 
    ## Call:
    ## lm(formula = VI_PLOT4_restructured_BAD_REMOVED$Arcsine ~ VI_PLOT4_restructured_BAD_REMOVED$E1_E3 + 
    ##     VI_PLOT4_restructured_BAD_REMOVED$FAMILY + VI_PLOT4_restructured_BAD_REMOVED$FAMILY:VI_PLOT4_restructured_BAD_REMOVED$E1_E3, 
    ##     data = VI_PLOT4_restructured_BAD_REMOVED)
    ## 
    ## Residuals:
    ##      Min       1Q   Median       3Q      Max 
    ## -0.30138 -0.08600 -0.00233  0.08891  0.32114 
    ## 
    ## Coefficients:
    ##                                                                                       Estimate
    ## (Intercept)                                                                          0.4496409
    ## VI_PLOT4_restructured_BAD_REMOVED$E1_E3E3                                            0.6219263
    ## VI_PLOT4_restructured_BAD_REMOVED$FAMILYB                                            0.0426371
    ## VI_PLOT4_restructured_BAD_REMOVED$FAMILYD                                            0.0002792
    ## VI_PLOT4_restructured_BAD_REMOVED$FAMILYE                                            0.0370429
    ## VI_PLOT4_restructured_BAD_REMOVED$FAMILYJ                                            0.0347859
    ## VI_PLOT4_restructured_BAD_REMOVED$FAMILYL                                            0.0397488
    ## VI_PLOT4_restructured_BAD_REMOVED$E1_E3E3:VI_PLOT4_restructured_BAD_REMOVED$FAMILYB -0.0729382
    ## VI_PLOT4_restructured_BAD_REMOVED$E1_E3E3:VI_PLOT4_restructured_BAD_REMOVED$FAMILYD  0.0034793
    ## VI_PLOT4_restructured_BAD_REMOVED$E1_E3E3:VI_PLOT4_restructured_BAD_REMOVED$FAMILYE -0.0717697
    ## VI_PLOT4_restructured_BAD_REMOVED$E1_E3E3:VI_PLOT4_restructured_BAD_REMOVED$FAMILYJ -0.0668650
    ## VI_PLOT4_restructured_BAD_REMOVED$E1_E3E3:VI_PLOT4_restructured_BAD_REMOVED$FAMILYL -0.0734185
    ##                                                                                     Std. Error
    ## (Intercept)                                                                          0.0416773
    ## VI_PLOT4_restructured_BAD_REMOVED$E1_E3E3                                            0.0589406
    ## VI_PLOT4_restructured_BAD_REMOVED$FAMILYB                                            0.0649494
    ## VI_PLOT4_restructured_BAD_REMOVED$FAMILYD                                            0.0605557
    ## VI_PLOT4_restructured_BAD_REMOVED$FAMILYE                                            0.0649494
    ## VI_PLOT4_restructured_BAD_REMOVED$FAMILYJ                                            0.0575855
    ## VI_PLOT4_restructured_BAD_REMOVED$FAMILYL                                            0.0605557
    ## VI_PLOT4_restructured_BAD_REMOVED$E1_E3E3:VI_PLOT4_restructured_BAD_REMOVED$FAMILYB  0.0918523
    ## VI_PLOT4_restructured_BAD_REMOVED$E1_E3E3:VI_PLOT4_restructured_BAD_REMOVED$FAMILYD  0.0856387
    ## VI_PLOT4_restructured_BAD_REMOVED$E1_E3E3:VI_PLOT4_restructured_BAD_REMOVED$FAMILYE  0.0918523
    ## VI_PLOT4_restructured_BAD_REMOVED$E1_E3E3:VI_PLOT4_restructured_BAD_REMOVED$FAMILYJ  0.0814382
    ## VI_PLOT4_restructured_BAD_REMOVED$E1_E3E3:VI_PLOT4_restructured_BAD_REMOVED$FAMILYL  0.0856387
    ##                                                                                     t value
    ## (Intercept)                                                                          10.789
    ## VI_PLOT4_restructured_BAD_REMOVED$E1_E3E3                                            10.552
    ## VI_PLOT4_restructured_BAD_REMOVED$FAMILYB                                             0.656
    ## VI_PLOT4_restructured_BAD_REMOVED$FAMILYD                                             0.005
    ## VI_PLOT4_restructured_BAD_REMOVED$FAMILYE                                             0.570
    ## VI_PLOT4_restructured_BAD_REMOVED$FAMILYJ                                             0.604
    ## VI_PLOT4_restructured_BAD_REMOVED$FAMILYL                                             0.656
    ## VI_PLOT4_restructured_BAD_REMOVED$E1_E3E3:VI_PLOT4_restructured_BAD_REMOVED$FAMILYB  -0.794
    ## VI_PLOT4_restructured_BAD_REMOVED$E1_E3E3:VI_PLOT4_restructured_BAD_REMOVED$FAMILYD   0.041
    ## VI_PLOT4_restructured_BAD_REMOVED$E1_E3E3:VI_PLOT4_restructured_BAD_REMOVED$FAMILYE  -0.781
    ## VI_PLOT4_restructured_BAD_REMOVED$E1_E3E3:VI_PLOT4_restructured_BAD_REMOVED$FAMILYJ  -0.821
    ## VI_PLOT4_restructured_BAD_REMOVED$E1_E3E3:VI_PLOT4_restructured_BAD_REMOVED$FAMILYL  -0.857
    ##                                                                                     Pr(>|t|)
    ## (Intercept)                                                                           <2e-16
    ## VI_PLOT4_restructured_BAD_REMOVED$E1_E3E3                                             <2e-16
    ## VI_PLOT4_restructured_BAD_REMOVED$FAMILYB                                              0.513
    ## VI_PLOT4_restructured_BAD_REMOVED$FAMILYD                                              0.996
    ## VI_PLOT4_restructured_BAD_REMOVED$FAMILYE                                              0.570
    ## VI_PLOT4_restructured_BAD_REMOVED$FAMILYJ                                              0.547
    ## VI_PLOT4_restructured_BAD_REMOVED$FAMILYL                                              0.513
    ## VI_PLOT4_restructured_BAD_REMOVED$E1_E3E3:VI_PLOT4_restructured_BAD_REMOVED$FAMILYB    0.429
    ## VI_PLOT4_restructured_BAD_REMOVED$E1_E3E3:VI_PLOT4_restructured_BAD_REMOVED$FAMILYD    0.968
    ## VI_PLOT4_restructured_BAD_REMOVED$E1_E3E3:VI_PLOT4_restructured_BAD_REMOVED$FAMILYE    0.437
    ## VI_PLOT4_restructured_BAD_REMOVED$E1_E3E3:VI_PLOT4_restructured_BAD_REMOVED$FAMILYJ    0.414
    ## VI_PLOT4_restructured_BAD_REMOVED$E1_E3E3:VI_PLOT4_restructured_BAD_REMOVED$FAMILYL    0.393
    ##                                                                                        
    ## (Intercept)                                                                         ***
    ## VI_PLOT4_restructured_BAD_REMOVED$E1_E3E3                                           ***
    ## VI_PLOT4_restructured_BAD_REMOVED$FAMILYB                                              
    ## VI_PLOT4_restructured_BAD_REMOVED$FAMILYD                                              
    ## VI_PLOT4_restructured_BAD_REMOVED$FAMILYE                                              
    ## VI_PLOT4_restructured_BAD_REMOVED$FAMILYJ                                              
    ## VI_PLOT4_restructured_BAD_REMOVED$FAMILYL                                              
    ## VI_PLOT4_restructured_BAD_REMOVED$E1_E3E3:VI_PLOT4_restructured_BAD_REMOVED$FAMILYB    
    ## VI_PLOT4_restructured_BAD_REMOVED$E1_E3E3:VI_PLOT4_restructured_BAD_REMOVED$FAMILYD    
    ## VI_PLOT4_restructured_BAD_REMOVED$E1_E3E3:VI_PLOT4_restructured_BAD_REMOVED$FAMILYE    
    ## VI_PLOT4_restructured_BAD_REMOVED$E1_E3E3:VI_PLOT4_restructured_BAD_REMOVED$FAMILYJ    
    ## VI_PLOT4_restructured_BAD_REMOVED$E1_E3E3:VI_PLOT4_restructured_BAD_REMOVED$FAMILYL    
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
    ## 
    ## Residual standard error: 0.1318 on 94 degrees of freedom
    ## Multiple R-squared:  0.8443, Adjusted R-squared:  0.8261 
    ## F-statistic: 46.35 on 11 and 94 DF,  p-value: < 2.2e-16

``` r
VI_PLOT4_agranular_granular_lm_interaction_leastsquares <- lsmeans(VI_PLOT4_agranular_granular_lm_interaction, "VI_PLOT4_restructured_BAD_REMOVED$E1_E3", adjust="tukey")
cld(VI_PLOT4_agranular_granular_lm_interaction_leastsquares, alpha=0.05, Letters=letters)
```

    ##  VI_PLOT4_restructured_BAD_REMOVED$E1_E3    lsmean         SE df  lower.CL
    ##  E1                                      0.4567471 0.03570963 94 0.3858448
    ##  E3                                      0.4567471 0.03570963 94 0.3858448
    ##   upper.CL .group
    ##  0.5276494  a    
    ##  0.5276494  a    
    ## 
    ## Results are averaged over the levels of: VI_PLOT4_restructured_BAD_REMOVED$FAMILY 
    ## Confidence level used: 0.95 
    ## significance level used: alpha = 0.05

Percent of Live Granular Hemocytes
==================================

Percent Live Granular Hemocytes out of all Granular hemocytes
-------------------------------------------------------------

![](Dermo_Viability_Assay_Data_analysis_files/figure-markdown_github/percent-1.png)![](Dermo_Viability_Assay_Data_analysis_files/figure-markdown_github/percent-2.png)

### FAMILY A

    ##                                      Df  Sum Sq  Mean Sq F value Pr(>F)  
    ## VI_PLOT9_E1_MINUS_V1R_FAMILY_A$GROUP  1 0.03028 0.030283   4.258 0.0691 .
    ## Residuals                             9 0.06401 0.007112                 
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

    ##                                                  Df  Sum Sq Mean Sq
    ## VI_PLOT9_E1_MINUS_V1R_FAMILY_A_BAD_REMOVED$GROUP  1 0.03206 0.03206
    ## Residuals                                         8 0.06215 0.00777
    ##                                                  F value Pr(>F)  
    ## VI_PLOT9_E1_MINUS_V1R_FAMILY_A_BAD_REMOVED$GROUP   4.127 0.0767 .
    ## Residuals                                                        
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

### FAMILY B

    ##                                      Df Sum Sq Mean Sq F value Pr(>F)
    ## VI_PLOT9_E1_MINUS_V1R_FAMILY_B$GROUP  1 0.0308 0.03080   0.865  0.388
    ## Residuals                             6 0.2136 0.03561

    ##                                                  Df  Sum Sq Mean Sq
    ## VI_PLOT9_E1_MINUS_V1R_FAMILY_B_BAD_REMOVED$GROUP  1 0.01939 0.01939
    ## Residuals                                         5 0.15552 0.03110
    ##                                                  F value Pr(>F)
    ## VI_PLOT9_E1_MINUS_V1R_FAMILY_B_BAD_REMOVED$GROUP   0.624  0.466
    ## Residuals

### FAMILY D

    ##                                      Df Sum Sq Mean Sq F value Pr(>F)
    ## VI_PLOT9_E1_MINUS_V1R_FAMILY_D$GROUP  1 0.1162  0.1162   2.184  0.178
    ## Residuals                             8 0.4256  0.0532

    ##                                                  Df  Sum Sq Mean Sq
    ## VI_PLOT9_E1_MINUS_V1R_FAMILY_D_BAD_REMOVED$GROUP  1 0.06123 0.06123
    ## Residuals                                         7 0.14261 0.02037
    ##                                                  F value Pr(>F)
    ## VI_PLOT9_E1_MINUS_V1R_FAMILY_D_BAD_REMOVED$GROUP   3.006  0.127
    ## Residuals

### FAMILY E

    ##                                      Df  Sum Sq Mean Sq F value Pr(>F)
    ## VI_PLOT9_E1_MINUS_V1R_FAMILY_E$GROUP  1 0.04593 0.04593   1.793  0.222
    ## Residuals                             7 0.17931 0.02562

    ##                                                  Df  Sum Sq Mean Sq
    ## VI_PLOT9_E1_MINUS_V1R_FAMILY_E_BAD_REMOVED$GROUP  1 0.02942 0.02942
    ## Residuals                                         5 0.10444 0.02089
    ##                                                  F value Pr(>F)
    ## VI_PLOT9_E1_MINUS_V1R_FAMILY_E_BAD_REMOVED$GROUP   1.408  0.289
    ## Residuals

### FAMILY J

    ##                                      Df Sum Sq Mean Sq F value Pr(>F)
    ## VI_PLOT9_E1_MINUS_V1R_FAMILY_J$GROUP  1 0.0376 0.03755    0.63  0.444
    ## Residuals                            11 0.6561 0.05965

    ##                                                  Df Sum Sq Mean Sq F value
    ## VI_PLOT9_E1_MINUS_V1R_FAMILY_J_BAD_REMOVED$GROUP  1 0.0312 0.03120   0.713
    ## Residuals                                         9 0.3940 0.04377        
    ##                                                  Pr(>F)
    ## VI_PLOT9_E1_MINUS_V1R_FAMILY_J_BAD_REMOVED$GROUP   0.42
    ## Residuals

### FAMILY L

    ##                                      Df  Sum Sq Mean Sq F value Pr(>F)
    ## VI_PLOT9_E1_MINUS_V1R_FAMILY_L$GROUP  1 0.03757 0.03757   1.397  0.262
    ## Residuals                            11 0.29584 0.02689

    ##                                                  Df  Sum Sq  Mean Sq
    ## VI_PLOT9_E1_MINUS_V1R_FAMILY_L_BAD_REMOVED$GROUP  1 0.00289 0.002893
    ## Residuals                                         7 0.14757 0.021081
    ##                                                  F value Pr(>F)
    ## VI_PLOT9_E1_MINUS_V1R_FAMILY_L_BAD_REMOVED$GROUP   0.137  0.722
    ## Residuals

### Two Way ANOVA of LIVE Granular Hemocytes

    ## Anova Table (Type II tests)
    ## 
    ## Response: VI_PLOT9_E1_MINUS_V1R$Arcsine
    ##                               Sum Sq Df F value    Pr(>F)    
    ## VI_PLOT9_E1_MINUS_V1R$GROUP  0.15112  1  4.3466   0.04157 *  
    ## VI_PLOT9_E1_MINUS_V1R$FAMILY 1.27741  5  7.3483 2.252e-05 ***
    ## Residuals                    1.98176 57                      
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

    ## 
    ## Call:
    ## lm(formula = VI_PLOT9_E1_MINUS_V1R$Arcsine ~ VI_PLOT9_E1_MINUS_V1R$GROUP + 
    ##     VI_PLOT9_E1_MINUS_V1R$FAMILY, data = VI_PLOT9_E1_MINUS_V1R)
    ## 
    ## Residuals:
    ##     Min      1Q  Median      3Q     Max 
    ## -0.5271 -0.1159  0.0164  0.1124  0.4744 
    ## 
    ## Coefficients:
    ##                                      Estimate Std. Error t value Pr(>|t|)
    ## (Intercept)                           1.35850    0.07050  19.269  < 2e-16
    ## VI_PLOT9_E1_MINUS_V1R$GROUPtreatment -0.12195    0.05849  -2.085  0.04157
    ## VI_PLOT9_E1_MINUS_V1R$FAMILYB        -0.28643    0.08707  -3.290  0.00172
    ## VI_PLOT9_E1_MINUS_V1R$FAMILYD        -0.35778    0.08158  -4.386 5.04e-05
    ## VI_PLOT9_E1_MINUS_V1R$FAMILYE         0.04195    0.08434   0.497  0.62082
    ## VI_PLOT9_E1_MINUS_V1R$FAMILYJ        -0.14014    0.07643  -1.834  0.07194
    ## VI_PLOT9_E1_MINUS_V1R$FAMILYL        -0.03603    0.07643  -0.471  0.63915
    ##                                         
    ## (Intercept)                          ***
    ## VI_PLOT9_E1_MINUS_V1R$GROUPtreatment *  
    ## VI_PLOT9_E1_MINUS_V1R$FAMILYB        ** 
    ## VI_PLOT9_E1_MINUS_V1R$FAMILYD        ***
    ## VI_PLOT9_E1_MINUS_V1R$FAMILYE           
    ## VI_PLOT9_E1_MINUS_V1R$FAMILYJ        .  
    ## VI_PLOT9_E1_MINUS_V1R$FAMILYL           
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
    ## 
    ## Residual standard error: 0.1865 on 57 degrees of freedom
    ## Multiple R-squared:  0.4233, Adjusted R-squared:  0.3626 
    ## F-statistic: 6.974 on 6 and 57 DF,  p-value: 1.358e-05

    ## Anova Table (Type II tests)
    ## 
    ## Response: VI_PLOT9_E1_MINUS_V1R_BAD_REMOVED$Arcsine
    ##                                           Sum Sq Df F value    Pr(>F)    
    ## VI_PLOT9_E1_MINUS_V1R_BAD_REMOVED$GROUP  0.05676  1  2.3194 0.1346187    
    ## VI_PLOT9_E1_MINUS_V1R_BAD_REMOVED$FAMILY 0.78019  5  6.3762 0.0001414 ***
    ## Residuals                                1.12571 46                      
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

    ## 
    ## Call:
    ## lm(formula = VI_PLOT9_E1_MINUS_V1R_BAD_REMOVED$Arcsine ~ VI_PLOT9_E1_MINUS_V1R_BAD_REMOVED$GROUP + 
    ##     VI_PLOT9_E1_MINUS_V1R_BAD_REMOVED$FAMILY, data = VI_PLOT9_E1_MINUS_V1R_BAD_REMOVED)
    ## 
    ## Residuals:
    ##      Min       1Q   Median       3Q      Max 
    ## -0.39933 -0.09517  0.01368  0.11065  0.28389 
    ## 
    ## Coefficients:
    ##                                                   Estimate Std. Error
    ## (Intercept)                                       1.325985   0.062030
    ## VI_PLOT9_E1_MINUS_V1R_BAD_REMOVED$GROUPtreatment -0.081421   0.053463
    ## VI_PLOT9_E1_MINUS_V1R_BAD_REMOVED$FAMILYB        -0.255599   0.077548
    ## VI_PLOT9_E1_MINUS_V1R_BAD_REMOVED$FAMILYD        -0.298228   0.071997
    ## VI_PLOT9_E1_MINUS_V1R_BAD_REMOVED$FAMILYE        -0.007404   0.077548
    ## VI_PLOT9_E1_MINUS_V1R_BAD_REMOVED$FAMILYJ        -0.192005   0.068643
    ## VI_PLOT9_E1_MINUS_V1R_BAD_REMOVED$FAMILYL        -0.024307   0.071997
    ##                                                  t value Pr(>|t|)    
    ## (Intercept)                                       21.376  < 2e-16 ***
    ## VI_PLOT9_E1_MINUS_V1R_BAD_REMOVED$GROUPtreatment  -1.523 0.134619    
    ## VI_PLOT9_E1_MINUS_V1R_BAD_REMOVED$FAMILYB         -3.296 0.001894 ** 
    ## VI_PLOT9_E1_MINUS_V1R_BAD_REMOVED$FAMILYD         -4.142 0.000146 ***
    ## VI_PLOT9_E1_MINUS_V1R_BAD_REMOVED$FAMILYE         -0.095 0.924353    
    ## VI_PLOT9_E1_MINUS_V1R_BAD_REMOVED$FAMILYJ         -2.797 0.007502 ** 
    ## VI_PLOT9_E1_MINUS_V1R_BAD_REMOVED$FAMILYL         -0.338 0.737196    
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
    ## 
    ## Residual standard error: 0.1564 on 46 degrees of freedom
    ## Multiple R-squared:  0.4334, Adjusted R-squared:  0.3596 
    ## F-statistic: 5.866 on 6 and 46 DF,  p-value: 0.0001326

    ## Anova Table (Type II tests)
    ## 
    ## Response: VI_PLOT9_E1_MINUS_V1R_BAD_REMOVED$Arcsine
    ##                                                                                   Sum Sq
    ## VI_PLOT9_E1_MINUS_V1R_BAD_REMOVED$FAMILY                                         0.78019
    ## VI_PLOT9_E1_MINUS_V1R_BAD_REMOVED$GROUP                                          0.05676
    ## VI_PLOT9_E1_MINUS_V1R_BAD_REMOVED$FAMILY:VI_PLOT9_E1_MINUS_V1R_BAD_REMOVED$GROUP 0.11944
    ## Residuals                                                                        1.00627
    ##                                                                                  Df
    ## VI_PLOT9_E1_MINUS_V1R_BAD_REMOVED$FAMILY                                          5
    ## VI_PLOT9_E1_MINUS_V1R_BAD_REMOVED$GROUP                                           1
    ## VI_PLOT9_E1_MINUS_V1R_BAD_REMOVED$FAMILY:VI_PLOT9_E1_MINUS_V1R_BAD_REMOVED$GROUP  5
    ## Residuals                                                                        41
    ##                                                                                  F value
    ## VI_PLOT9_E1_MINUS_V1R_BAD_REMOVED$FAMILY                                          6.3577
    ## VI_PLOT9_E1_MINUS_V1R_BAD_REMOVED$GROUP                                           2.3126
    ## VI_PLOT9_E1_MINUS_V1R_BAD_REMOVED$FAMILY:VI_PLOT9_E1_MINUS_V1R_BAD_REMOVED$GROUP  0.9733
    ## Residuals                                                                               
    ##                                                                                     Pr(>F)
    ## VI_PLOT9_E1_MINUS_V1R_BAD_REMOVED$FAMILY                                         0.0001866
    ## VI_PLOT9_E1_MINUS_V1R_BAD_REMOVED$GROUP                                          0.1360030
    ## VI_PLOT9_E1_MINUS_V1R_BAD_REMOVED$FAMILY:VI_PLOT9_E1_MINUS_V1R_BAD_REMOVED$GROUP 0.4454855
    ## Residuals                                                                                 
    ##                                                                                     
    ## VI_PLOT9_E1_MINUS_V1R_BAD_REMOVED$FAMILY                                         ***
    ## VI_PLOT9_E1_MINUS_V1R_BAD_REMOVED$GROUP                                             
    ## VI_PLOT9_E1_MINUS_V1R_BAD_REMOVED$FAMILY:VI_PLOT9_E1_MINUS_V1R_BAD_REMOVED$GROUP    
    ## Residuals                                                                           
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

    ## 
    ## Call:
    ## lm(formula = VI_PLOT9_E1_MINUS_V1R_BAD_REMOVED$Arcsine ~ VI_PLOT9_E1_MINUS_V1R_BAD_REMOVED$FAMILY + 
    ##     VI_PLOT9_E1_MINUS_V1R_BAD_REMOVED$GROUP + VI_PLOT9_E1_MINUS_V1R_BAD_REMOVED$FAMILY:VI_PLOT9_E1_MINUS_V1R_BAD_REMOVED$GROUP)
    ## 
    ## Residuals:
    ##      Min       1Q   Median       3Q      Max 
    ## -0.38903 -0.06844  0.00000  0.08446  0.29419 
    ## 
    ## Coefficients:
    ##                                                                                            Estimate
    ## (Intercept)                                                                                 1.35549
    ## VI_PLOT9_E1_MINUS_V1R_BAD_REMOVED$FAMILYB                                                  -0.22596
    ## VI_PLOT9_E1_MINUS_V1R_BAD_REMOVED$FAMILYD                                                  -0.23674
    ## VI_PLOT9_E1_MINUS_V1R_BAD_REMOVED$FAMILYE                                                  -0.26549
    ## VI_PLOT9_E1_MINUS_V1R_BAD_REMOVED$FAMILYJ                                                  -0.17516
    ## VI_PLOT9_E1_MINUS_V1R_BAD_REMOVED$FAMILYL                                                  -0.15067
    ## VI_PLOT9_E1_MINUS_V1R_BAD_REMOVED$GROUPtreatment                                           -0.12357
    ## VI_PLOT9_E1_MINUS_V1R_BAD_REMOVED$FAMILYB:VI_PLOT9_E1_MINUS_V1R_BAD_REMOVED$GROUPtreatment -0.02685
    ## VI_PLOT9_E1_MINUS_V1R_BAD_REMOVED$FAMILYD:VI_PLOT9_E1_MINUS_V1R_BAD_REMOVED$GROUPtreatment -0.07484
    ## VI_PLOT9_E1_MINUS_V1R_BAD_REMOVED$FAMILYE:VI_PLOT9_E1_MINUS_V1R_BAD_REMOVED$GROUPtreatment  0.30883
    ## VI_PLOT9_E1_MINUS_V1R_BAD_REMOVED$FAMILYJ:VI_PLOT9_E1_MINUS_V1R_BAD_REMOVED$GROUPtreatment -0.01451
    ## VI_PLOT9_E1_MINUS_V1R_BAD_REMOVED$FAMILYL:VI_PLOT9_E1_MINUS_V1R_BAD_REMOVED$GROUPtreatment  0.16669
    ##                                                                                            Std. Error
    ## (Intercept)                                                                                   0.09045
    ## VI_PLOT9_E1_MINUS_V1R_BAD_REMOVED$FAMILYB                                                     0.18090
    ## VI_PLOT9_E1_MINUS_V1R_BAD_REMOVED$FAMILYD                                                     0.14301
    ## VI_PLOT9_E1_MINUS_V1R_BAD_REMOVED$FAMILYE                                                     0.18090
    ## VI_PLOT9_E1_MINUS_V1R_BAD_REMOVED$FAMILYJ                                                     0.14301
    ## VI_PLOT9_E1_MINUS_V1R_BAD_REMOVED$FAMILYL                                                     0.14301
    ## VI_PLOT9_E1_MINUS_V1R_BAD_REMOVED$GROUPtreatment                                              0.10811
    ## VI_PLOT9_E1_MINUS_V1R_BAD_REMOVED$FAMILYB:VI_PLOT9_E1_MINUS_V1R_BAD_REMOVED$GROUPtreatment    0.20080
    ## VI_PLOT9_E1_MINUS_V1R_BAD_REMOVED$FAMILYD:VI_PLOT9_E1_MINUS_V1R_BAD_REMOVED$GROUPtreatment    0.16573
    ## VI_PLOT9_E1_MINUS_V1R_BAD_REMOVED$FAMILYE:VI_PLOT9_E1_MINUS_V1R_BAD_REMOVED$GROUPtreatment    0.20080
    ## VI_PLOT9_E1_MINUS_V1R_BAD_REMOVED$FAMILYJ:VI_PLOT9_E1_MINUS_V1R_BAD_REMOVED$GROUPtreatment    0.16336
    ## VI_PLOT9_E1_MINUS_V1R_BAD_REMOVED$FAMILYL:VI_PLOT9_E1_MINUS_V1R_BAD_REMOVED$GROUPtreatment    0.16573
    ##                                                                                            t value
    ## (Intercept)                                                                                 14.986
    ## VI_PLOT9_E1_MINUS_V1R_BAD_REMOVED$FAMILYB                                                   -1.249
    ## VI_PLOT9_E1_MINUS_V1R_BAD_REMOVED$FAMILYD                                                   -1.655
    ## VI_PLOT9_E1_MINUS_V1R_BAD_REMOVED$FAMILYE                                                   -1.468
    ## VI_PLOT9_E1_MINUS_V1R_BAD_REMOVED$FAMILYJ                                                   -1.225
    ## VI_PLOT9_E1_MINUS_V1R_BAD_REMOVED$FAMILYL                                                   -1.054
    ## VI_PLOT9_E1_MINUS_V1R_BAD_REMOVED$GROUPtreatment                                            -1.143
    ## VI_PLOT9_E1_MINUS_V1R_BAD_REMOVED$FAMILYB:VI_PLOT9_E1_MINUS_V1R_BAD_REMOVED$GROUPtreatment  -0.134
    ## VI_PLOT9_E1_MINUS_V1R_BAD_REMOVED$FAMILYD:VI_PLOT9_E1_MINUS_V1R_BAD_REMOVED$GROUPtreatment  -0.452
    ## VI_PLOT9_E1_MINUS_V1R_BAD_REMOVED$FAMILYE:VI_PLOT9_E1_MINUS_V1R_BAD_REMOVED$GROUPtreatment   1.538
    ## VI_PLOT9_E1_MINUS_V1R_BAD_REMOVED$FAMILYJ:VI_PLOT9_E1_MINUS_V1R_BAD_REMOVED$GROUPtreatment  -0.089
    ## VI_PLOT9_E1_MINUS_V1R_BAD_REMOVED$FAMILYL:VI_PLOT9_E1_MINUS_V1R_BAD_REMOVED$GROUPtreatment   1.006
    ##                                                                                            Pr(>|t|)
    ## (Intercept)                                                                                  <2e-16
    ## VI_PLOT9_E1_MINUS_V1R_BAD_REMOVED$FAMILYB                                                     0.219
    ## VI_PLOT9_E1_MINUS_V1R_BAD_REMOVED$FAMILYD                                                     0.105
    ## VI_PLOT9_E1_MINUS_V1R_BAD_REMOVED$FAMILYE                                                     0.150
    ## VI_PLOT9_E1_MINUS_V1R_BAD_REMOVED$FAMILYJ                                                     0.228
    ## VI_PLOT9_E1_MINUS_V1R_BAD_REMOVED$FAMILYL                                                     0.298
    ## VI_PLOT9_E1_MINUS_V1R_BAD_REMOVED$GROUPtreatment                                              0.260
    ## VI_PLOT9_E1_MINUS_V1R_BAD_REMOVED$FAMILYB:VI_PLOT9_E1_MINUS_V1R_BAD_REMOVED$GROUPtreatment    0.894
    ## VI_PLOT9_E1_MINUS_V1R_BAD_REMOVED$FAMILYD:VI_PLOT9_E1_MINUS_V1R_BAD_REMOVED$GROUPtreatment    0.654
    ## VI_PLOT9_E1_MINUS_V1R_BAD_REMOVED$FAMILYE:VI_PLOT9_E1_MINUS_V1R_BAD_REMOVED$GROUPtreatment    0.132
    ## VI_PLOT9_E1_MINUS_V1R_BAD_REMOVED$FAMILYJ:VI_PLOT9_E1_MINUS_V1R_BAD_REMOVED$GROUPtreatment    0.930
    ## VI_PLOT9_E1_MINUS_V1R_BAD_REMOVED$FAMILYL:VI_PLOT9_E1_MINUS_V1R_BAD_REMOVED$GROUPtreatment    0.320
    ##                                                                                               
    ## (Intercept)                                                                                ***
    ## VI_PLOT9_E1_MINUS_V1R_BAD_REMOVED$FAMILYB                                                     
    ## VI_PLOT9_E1_MINUS_V1R_BAD_REMOVED$FAMILYD                                                     
    ## VI_PLOT9_E1_MINUS_V1R_BAD_REMOVED$FAMILYE                                                     
    ## VI_PLOT9_E1_MINUS_V1R_BAD_REMOVED$FAMILYJ                                                     
    ## VI_PLOT9_E1_MINUS_V1R_BAD_REMOVED$FAMILYL                                                     
    ## VI_PLOT9_E1_MINUS_V1R_BAD_REMOVED$GROUPtreatment                                              
    ## VI_PLOT9_E1_MINUS_V1R_BAD_REMOVED$FAMILYB:VI_PLOT9_E1_MINUS_V1R_BAD_REMOVED$GROUPtreatment    
    ## VI_PLOT9_E1_MINUS_V1R_BAD_REMOVED$FAMILYD:VI_PLOT9_E1_MINUS_V1R_BAD_REMOVED$GROUPtreatment    
    ## VI_PLOT9_E1_MINUS_V1R_BAD_REMOVED$FAMILYE:VI_PLOT9_E1_MINUS_V1R_BAD_REMOVED$GROUPtreatment    
    ## VI_PLOT9_E1_MINUS_V1R_BAD_REMOVED$FAMILYJ:VI_PLOT9_E1_MINUS_V1R_BAD_REMOVED$GROUPtreatment    
    ## VI_PLOT9_E1_MINUS_V1R_BAD_REMOVED$FAMILYL:VI_PLOT9_E1_MINUS_V1R_BAD_REMOVED$GROUPtreatment    
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
    ## 
    ## Residual standard error: 0.1567 on 41 degrees of freedom
    ## Multiple R-squared:  0.4936, Adjusted R-squared:  0.3577 
    ## F-statistic: 3.632 on 11 and 41 DF,  p-value: 0.001224

    ##  VI_PLOT9_E1_MINUS_V1R_BAD_REMOVED$FAMILY   lsmean         SE df lower.CL
    ##  J                                        1.105514 0.04357950 41 1.017504
    ##  L                                        1.105514 0.04357950 41 1.017504
    ##  A                                        1.231920 0.05921289 41 1.112338
    ##  B                                        1.293703 0.05405372 41 1.184540
    ##  D                                        1.293703 0.05405372 41 1.184540
    ##  E                                        1.293703 0.05405372 41 1.184540
    ##  upper.CL .group
    ##  1.193525  a    
    ##  1.193525  a    
    ##  1.351503  ab   
    ##  1.402867   b   
    ##  1.402867   b   
    ##  1.402867   b   
    ## 
    ## Results are averaged over the levels of: VI_PLOT9_E1_MINUS_V1R_BAD_REMOVED$GROUP 
    ## Confidence level used: 0.95 
    ## P value adjustment: tukey method for comparing a family of 6 estimates 
    ## significance level used: alpha = 0.05

### One Way ANOVA of Differences between Families

Percent of Live Agranular Hemocytes (E3)
========================================

Percent Live Agranular Hemocytes
================================

![](Dermo_Viability_Assay_Data_analysis_files/figure-markdown_github/percent_live_agranular_hemocytes-1.png)![](Dermo_Viability_Assay_Data_analysis_files/figure-markdown_github/percent_live_agranular_hemocytes-2.png)

### FAMILY A

    ##                                       Df   Sum Sq   Mean Sq F value Pr(>F)
    ## VI_PLOT10_E3_MINUS_V1R_FAMILY_A$GROUP  1 0.000351 0.0003509    0.74  0.412
    ## Residuals                              9 0.004265 0.0004739

    ##                                                   Df   Sum Sq   Mean Sq
    ## VI_PLOT10_E3_MINUS_V1R_FAMILY_A_BAD_REMOVED$GROUP  1 7.35e-05 7.346e-05
    ## Residuals                                          8 1.70e-03 2.126e-04
    ##                                                   F value Pr(>F)
    ## VI_PLOT10_E3_MINUS_V1R_FAMILY_A_BAD_REMOVED$GROUP   0.346  0.573
    ## Residuals

### FAMILY B

    ##                                       Df  Sum Sq  Mean Sq F value Pr(>F)
    ## VI_PLOT10_E3_MINUS_V1R_FAMILY_B$GROUP  1 0.00143 0.001428   0.239  0.642
    ## Residuals                              6 0.03581 0.005968

    ##                                                   Df   Sum Sq   Mean Sq
    ## VI_PLOT10_E3_MINUS_V1R_FAMILY_B_BAD_REMOVED$GROUP  1 0.000170 0.0001704
    ## Residuals                                          5 0.006754 0.0013509
    ##                                                   F value Pr(>F)
    ## VI_PLOT10_E3_MINUS_V1R_FAMILY_B_BAD_REMOVED$GROUP   0.126  0.737
    ## Residuals

### FAMILY D

    ##                                       Df   Sum Sq  Mean Sq F value Pr(>F)
    ## VI_PLOT10_E3_MINUS_V1R_FAMILY_D$GROUP  1 0.004803 0.004803    1.84  0.212
    ## Residuals                              8 0.020881 0.002610

    ##                                                   Df   Sum Sq  Mean Sq
    ## VI_PLOT10_E3_MINUS_V1R_FAMILY_D_BAD_REMOVED$GROUP  1 0.003617 0.003617
    ## Residuals                                          7 0.018465 0.002638
    ##                                                   F value Pr(>F)
    ## VI_PLOT10_E3_MINUS_V1R_FAMILY_D_BAD_REMOVED$GROUP   1.371   0.28
    ## Residuals

### FAMILY E

    ##                                       Df   Sum Sq   Mean Sq F value Pr(>F)
    ## VI_PLOT10_E3_MINUS_V1R_FAMILY_E$GROUP  1 0.000048 0.0000482   0.053  0.825
    ## Residuals                              7 0.006409 0.0009155

    ##                                                   Df    Sum Sq   Mean Sq
    ## VI_PLOT10_E3_MINUS_V1R_FAMILY_E_BAD_REMOVED$GROUP  1 0.0001601 0.0001601
    ## Residuals                                          5 0.0028325 0.0005665
    ##                                                   F value Pr(>F)
    ## VI_PLOT10_E3_MINUS_V1R_FAMILY_E_BAD_REMOVED$GROUP   0.283  0.618
    ## Residuals

### FAMILY J

    ##                                       Df  Sum Sq  Mean Sq F value Pr(>F)
    ## VI_PLOT10_E3_MINUS_V1R_FAMILY_J$GROUP  1 0.00265 0.002654   0.575  0.464
    ## Residuals                             11 0.05077 0.004615

    ##                                                   Df  Sum Sq  Mean Sq
    ## VI_PLOT10_E3_MINUS_V1R_FAMILY_J_BAD_REMOVED$GROUP  1 0.00308 0.003081
    ## Residuals                                          9 0.03943 0.004381
    ##                                                   F value Pr(>F)
    ## VI_PLOT10_E3_MINUS_V1R_FAMILY_J_BAD_REMOVED$GROUP   0.703  0.423
    ## Residuals

### FAMILY L

    ##                                       Df   Sum Sq  Mean Sq F value Pr(>F)
    ## VI_PLOT10_E3_MINUS_V1R_FAMILY_L$GROUP  1 0.004378 0.004378   5.642 0.0368
    ## Residuals                             11 0.008535 0.000776               
    ##                                        
    ## VI_PLOT10_E3_MINUS_V1R_FAMILY_L$GROUP *
    ## Residuals                              
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

    ##                                                   Df   Sum Sq  Mean Sq
    ## VI_PLOT10_E3_MINUS_V1R_FAMILY_L_BAD_REMOVED$GROUP  1 0.001205 0.001205
    ## Residuals                                          7 0.007306 0.001044
    ##                                                   F value Pr(>F)
    ## VI_PLOT10_E3_MINUS_V1R_FAMILY_L_BAD_REMOVED$GROUP   1.155  0.318
    ## Residuals

### Two Way ANOVA of LIVE AGranular Hemocytes

    ## Anova Table (Type II tests)
    ## 
    ## Response: VI_PLOT10_E3_MINUS_V1R$Arcsine
    ##                                 Sum Sq Df F value  Pr(>F)   
    ## VI_PLOT10_E3_MINUS_V1R$GROUP  0.007753  1  3.3333 0.07313 . 
    ## VI_PLOT10_E3_MINUS_V1R$FAMILY 0.050112  5  4.3090 0.00215 **
    ## Residuals                     0.132579 57                   
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

    ## 
    ## Call:
    ## lm(formula = VI_PLOT10_E3_MINUS_V1R$Arcsine ~ VI_PLOT10_E3_MINUS_V1R$GROUP + 
    ##     VI_PLOT10_E3_MINUS_V1R$FAMILY, data = VI_PLOT10_E3_MINUS_V1R)
    ## 
    ## Residuals:
    ##       Min        1Q    Median        3Q       Max 
    ## -0.159409 -0.017780 -0.000766  0.022808  0.099475 
    ## 
    ## Coefficients:
    ##                                         Estimate Std. Error t value
    ## (Intercept)                            1.5400589  0.0182353  84.455
    ## VI_PLOT10_E3_MINUS_V1R$GROUPtreatment -0.0276226  0.0151297  -1.826
    ## VI_PLOT10_E3_MINUS_V1R$FAMILYB        -0.0683344  0.0225209  -3.034
    ## VI_PLOT10_E3_MINUS_V1R$FAMILYD        -0.0651967  0.0211011  -3.090
    ## VI_PLOT10_E3_MINUS_V1R$FAMILYE         0.0009876  0.0218144   0.045
    ## VI_PLOT10_E3_MINUS_V1R$FAMILYJ        -0.0411152  0.0197680  -2.080
    ## VI_PLOT10_E3_MINUS_V1R$FAMILYL        -0.0085195  0.0197680  -0.431
    ##                                       Pr(>|t|)    
    ## (Intercept)                            < 2e-16 ***
    ## VI_PLOT10_E3_MINUS_V1R$GROUPtreatment  0.07313 .  
    ## VI_PLOT10_E3_MINUS_V1R$FAMILYB         0.00363 ** 
    ## VI_PLOT10_E3_MINUS_V1R$FAMILYD         0.00310 ** 
    ## VI_PLOT10_E3_MINUS_V1R$FAMILYE         0.96405    
    ## VI_PLOT10_E3_MINUS_V1R$FAMILYJ         0.04204 *  
    ## VI_PLOT10_E3_MINUS_V1R$FAMILYL         0.66811    
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
    ## 
    ## Residual standard error: 0.04823 on 57 degrees of freedom
    ## Multiple R-squared:  0.3099, Adjusted R-squared:  0.2372 
    ## F-statistic: 4.265 on 6 and 57 DF,  p-value: 0.00129

    ## Anova Table (Type II tests)
    ## 
    ## Response: VI_PLOT10_E3_MINUS_V1R_BAD_REMOVED$Arcsine
    ##                                             Sum Sq Df F value  Pr(>F)  
    ## VI_PLOT10_E3_MINUS_V1R_BAD_REMOVED$GROUP  0.004705  1  2.7019 0.10704  
    ## VI_PLOT10_E3_MINUS_V1R_BAD_REMOVED$FAMILY 0.028280  5  3.2483 0.01355 *
    ## Residuals                                 0.080095 46                  
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

    ## 
    ## Call:
    ## lm(formula = VI_PLOT10_E3_MINUS_V1R_BAD_REMOVED$Arcsine ~ VI_PLOT10_E3_MINUS_V1R_BAD_REMOVED$GROUP + 
    ##     VI_PLOT10_E3_MINUS_V1R_BAD_REMOVED$FAMILY, data = VI_PLOT10_E3_MINUS_V1R_BAD_REMOVED)
    ## 
    ## Residuals:
    ##       Min        1Q    Median        3Q       Max 
    ## -0.090910 -0.018184  0.003063  0.022075  0.108514 
    ## 
    ## Coefficients:
    ##                                                     Estimate Std. Error
    ## (Intercept)                                        1.5312960  0.0165460
    ## VI_PLOT10_E3_MINUS_V1R_BAD_REMOVED$GROUPtreatment -0.0234412  0.0142607
    ## VI_PLOT10_E3_MINUS_V1R_BAD_REMOVED$FAMILYB        -0.0403828  0.0206853
    ## VI_PLOT10_E3_MINUS_V1R_BAD_REMOVED$FAMILYD        -0.0539734  0.0192046
    ## VI_PLOT10_E3_MINUS_V1R_BAD_REMOVED$FAMILYE         0.0001202  0.0206853
    ## VI_PLOT10_E3_MINUS_V1R_BAD_REMOVED$FAMILYJ        -0.0455720  0.0183098
    ## VI_PLOT10_E3_MINUS_V1R_BAD_REMOVED$FAMILYL        -0.0044153  0.0192046
    ##                                                   t value Pr(>|t|)    
    ## (Intercept)                                        92.548  < 2e-16 ***
    ## VI_PLOT10_E3_MINUS_V1R_BAD_REMOVED$GROUPtreatment  -1.644  0.10704    
    ## VI_PLOT10_E3_MINUS_V1R_BAD_REMOVED$FAMILYB         -1.952  0.05701 .  
    ## VI_PLOT10_E3_MINUS_V1R_BAD_REMOVED$FAMILYD         -2.810  0.00724 ** 
    ## VI_PLOT10_E3_MINUS_V1R_BAD_REMOVED$FAMILYE          0.006  0.99539    
    ## VI_PLOT10_E3_MINUS_V1R_BAD_REMOVED$FAMILYJ         -2.489  0.01649 *  
    ## VI_PLOT10_E3_MINUS_V1R_BAD_REMOVED$FAMILYL         -0.230  0.81918    
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
    ## 
    ## Residual standard error: 0.04173 on 46 degrees of freedom
    ## Multiple R-squared:  0.2994, Adjusted R-squared:  0.208 
    ## F-statistic: 3.277 on 6 and 46 DF,  p-value: 0.009104

    ## Anova Table (Type II tests)
    ## 
    ## Response: VI_PLOT10_E3_MINUS_V1R_BAD_REMOVED$Arcsine
    ##                                                                                      Sum Sq
    ## VI_PLOT10_E3_MINUS_V1R_BAD_REMOVED$GROUP                                           0.004705
    ## VI_PLOT10_E3_MINUS_V1R_BAD_REMOVED$FAMILY                                          0.028280
    ## VI_PLOT10_E3_MINUS_V1R_BAD_REMOVED$GROUP:VI_PLOT10_E3_MINUS_V1R_BAD_REMOVED$FAMILY 0.003603
    ## Residuals                                                                          0.076492
    ##                                                                                    Df
    ## VI_PLOT10_E3_MINUS_V1R_BAD_REMOVED$GROUP                                            1
    ## VI_PLOT10_E3_MINUS_V1R_BAD_REMOVED$FAMILY                                           5
    ## VI_PLOT10_E3_MINUS_V1R_BAD_REMOVED$GROUP:VI_PLOT10_E3_MINUS_V1R_BAD_REMOVED$FAMILY  5
    ## Residuals                                                                          41
    ##                                                                                    F value
    ## VI_PLOT10_E3_MINUS_V1R_BAD_REMOVED$GROUP                                            2.5217
    ## VI_PLOT10_E3_MINUS_V1R_BAD_REMOVED$FAMILY                                           3.0316
    ## VI_PLOT10_E3_MINUS_V1R_BAD_REMOVED$GROUP:VI_PLOT10_E3_MINUS_V1R_BAD_REMOVED$FAMILY  0.3863
    ## Residuals                                                                                 
    ##                                                                                    Pr(>F)
    ## VI_PLOT10_E3_MINUS_V1R_BAD_REMOVED$GROUP                                           0.1200
    ## VI_PLOT10_E3_MINUS_V1R_BAD_REMOVED$FAMILY                                          0.0203
    ## VI_PLOT10_E3_MINUS_V1R_BAD_REMOVED$GROUP:VI_PLOT10_E3_MINUS_V1R_BAD_REMOVED$FAMILY 0.8553
    ## Residuals                                                                                
    ##                                                                                     
    ## VI_PLOT10_E3_MINUS_V1R_BAD_REMOVED$GROUP                                            
    ## VI_PLOT10_E3_MINUS_V1R_BAD_REMOVED$FAMILY                                          *
    ## VI_PLOT10_E3_MINUS_V1R_BAD_REMOVED$GROUP:VI_PLOT10_E3_MINUS_V1R_BAD_REMOVED$FAMILY  
    ## Residuals                                                                           
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

    ## 
    ## Call:
    ## lm(formula = VI_PLOT10_E3_MINUS_V1R_BAD_REMOVED$Arcsine ~ VI_PLOT10_E3_MINUS_V1R_BAD_REMOVED$GROUP + 
    ##     VI_PLOT10_E3_MINUS_V1R_BAD_REMOVED$FAMILY + VI_PLOT10_E3_MINUS_V1R_BAD_REMOVED$FAMILY:VI_PLOT10_E3_MINUS_V1R_BAD_REMOVED$GROUP, 
    ##     data = VI_PLOT10_E3_MINUS_V1R_BAD_REMOVED)
    ## 
    ## Residuals:
    ##       Min        1Q    Median        3Q       Max 
    ## -0.087282 -0.018324  0.000834  0.020095  0.112141 
    ## 
    ## Coefficients:
    ##                                                                                               Estimate
    ## (Intercept)                                                                                   1.510747
    ## VI_PLOT10_E3_MINUS_V1R_BAD_REMOVED$GROUPtreatment                                             0.005914
    ## VI_PLOT10_E3_MINUS_V1R_BAD_REMOVED$FAMILYB                                                   -0.027842
    ## VI_PLOT10_E3_MINUS_V1R_BAD_REMOVED$FAMILYD                                                   -0.014149
    ## VI_PLOT10_E3_MINUS_V1R_BAD_REMOVED$FAMILYE                                                    0.012293
    ## VI_PLOT10_E3_MINUS_V1R_BAD_REMOVED$FAMILYJ                                                   -0.008698
    ## VI_PLOT10_E3_MINUS_V1R_BAD_REMOVED$FAMILYL                                                    0.019549
    ## VI_PLOT10_E3_MINUS_V1R_BAD_REMOVED$GROUPtreatment:VI_PLOT10_E3_MINUS_V1R_BAD_REMOVED$FAMILYB -0.020013
    ## VI_PLOT10_E3_MINUS_V1R_BAD_REMOVED$GROUPtreatment:VI_PLOT10_E3_MINUS_V1R_BAD_REMOVED$FAMILYD -0.054138
    ## VI_PLOT10_E3_MINUS_V1R_BAD_REMOVED$GROUPtreatment:VI_PLOT10_E3_MINUS_V1R_BAD_REMOVED$FAMILYE -0.019583
    ## VI_PLOT10_E3_MINUS_V1R_BAD_REMOVED$GROUPtreatment:VI_PLOT10_E3_MINUS_V1R_BAD_REMOVED$FAMILYJ -0.049309
    ## VI_PLOT10_E3_MINUS_V1R_BAD_REMOVED$GROUPtreatment:VI_PLOT10_E3_MINUS_V1R_BAD_REMOVED$FAMILYL -0.033747
    ##                                                                                              Std. Error
    ## (Intercept)                                                                                    0.024938
    ## VI_PLOT10_E3_MINUS_V1R_BAD_REMOVED$GROUPtreatment                                              0.029806
    ## VI_PLOT10_E3_MINUS_V1R_BAD_REMOVED$FAMILYB                                                     0.049875
    ## VI_PLOT10_E3_MINUS_V1R_BAD_REMOVED$FAMILYD                                                     0.039430
    ## VI_PLOT10_E3_MINUS_V1R_BAD_REMOVED$FAMILYE                                                     0.049875
    ## VI_PLOT10_E3_MINUS_V1R_BAD_REMOVED$FAMILYJ                                                     0.039430
    ## VI_PLOT10_E3_MINUS_V1R_BAD_REMOVED$FAMILYL                                                     0.039430
    ## VI_PLOT10_E3_MINUS_V1R_BAD_REMOVED$GROUPtreatment:VI_PLOT10_E3_MINUS_V1R_BAD_REMOVED$FAMILYB   0.055362
    ## VI_PLOT10_E3_MINUS_V1R_BAD_REMOVED$GROUPtreatment:VI_PLOT10_E3_MINUS_V1R_BAD_REMOVED$FAMILYD   0.045692
    ## VI_PLOT10_E3_MINUS_V1R_BAD_REMOVED$GROUPtreatment:VI_PLOT10_E3_MINUS_V1R_BAD_REMOVED$FAMILYE   0.055362
    ## VI_PLOT10_E3_MINUS_V1R_BAD_REMOVED$GROUPtreatment:VI_PLOT10_E3_MINUS_V1R_BAD_REMOVED$FAMILYJ   0.045039
    ## VI_PLOT10_E3_MINUS_V1R_BAD_REMOVED$GROUPtreatment:VI_PLOT10_E3_MINUS_V1R_BAD_REMOVED$FAMILYL   0.045692
    ##                                                                                              t value
    ## (Intercept)                                                                                   60.581
    ## VI_PLOT10_E3_MINUS_V1R_BAD_REMOVED$GROUPtreatment                                              0.198
    ## VI_PLOT10_E3_MINUS_V1R_BAD_REMOVED$FAMILYB                                                    -0.558
    ## VI_PLOT10_E3_MINUS_V1R_BAD_REMOVED$FAMILYD                                                    -0.359
    ## VI_PLOT10_E3_MINUS_V1R_BAD_REMOVED$FAMILYE                                                     0.246
    ## VI_PLOT10_E3_MINUS_V1R_BAD_REMOVED$FAMILYJ                                                    -0.221
    ## VI_PLOT10_E3_MINUS_V1R_BAD_REMOVED$FAMILYL                                                     0.496
    ## VI_PLOT10_E3_MINUS_V1R_BAD_REMOVED$GROUPtreatment:VI_PLOT10_E3_MINUS_V1R_BAD_REMOVED$FAMILYB  -0.361
    ## VI_PLOT10_E3_MINUS_V1R_BAD_REMOVED$GROUPtreatment:VI_PLOT10_E3_MINUS_V1R_BAD_REMOVED$FAMILYD  -1.185
    ## VI_PLOT10_E3_MINUS_V1R_BAD_REMOVED$GROUPtreatment:VI_PLOT10_E3_MINUS_V1R_BAD_REMOVED$FAMILYE  -0.354
    ## VI_PLOT10_E3_MINUS_V1R_BAD_REMOVED$GROUPtreatment:VI_PLOT10_E3_MINUS_V1R_BAD_REMOVED$FAMILYJ  -1.095
    ## VI_PLOT10_E3_MINUS_V1R_BAD_REMOVED$GROUPtreatment:VI_PLOT10_E3_MINUS_V1R_BAD_REMOVED$FAMILYL  -0.739
    ##                                                                                              Pr(>|t|)
    ## (Intercept)                                                                                    <2e-16
    ## VI_PLOT10_E3_MINUS_V1R_BAD_REMOVED$GROUPtreatment                                               0.844
    ## VI_PLOT10_E3_MINUS_V1R_BAD_REMOVED$FAMILYB                                                      0.580
    ## VI_PLOT10_E3_MINUS_V1R_BAD_REMOVED$FAMILYD                                                      0.722
    ## VI_PLOT10_E3_MINUS_V1R_BAD_REMOVED$FAMILYE                                                      0.807
    ## VI_PLOT10_E3_MINUS_V1R_BAD_REMOVED$FAMILYJ                                                      0.827
    ## VI_PLOT10_E3_MINUS_V1R_BAD_REMOVED$FAMILYL                                                      0.623
    ## VI_PLOT10_E3_MINUS_V1R_BAD_REMOVED$GROUPtreatment:VI_PLOT10_E3_MINUS_V1R_BAD_REMOVED$FAMILYB    0.720
    ## VI_PLOT10_E3_MINUS_V1R_BAD_REMOVED$GROUPtreatment:VI_PLOT10_E3_MINUS_V1R_BAD_REMOVED$FAMILYD    0.243
    ## VI_PLOT10_E3_MINUS_V1R_BAD_REMOVED$GROUPtreatment:VI_PLOT10_E3_MINUS_V1R_BAD_REMOVED$FAMILYE    0.725
    ## VI_PLOT10_E3_MINUS_V1R_BAD_REMOVED$GROUPtreatment:VI_PLOT10_E3_MINUS_V1R_BAD_REMOVED$FAMILYJ    0.280
    ## VI_PLOT10_E3_MINUS_V1R_BAD_REMOVED$GROUPtreatment:VI_PLOT10_E3_MINUS_V1R_BAD_REMOVED$FAMILYL    0.464
    ##                                                                                                 
    ## (Intercept)                                                                                  ***
    ## VI_PLOT10_E3_MINUS_V1R_BAD_REMOVED$GROUPtreatment                                               
    ## VI_PLOT10_E3_MINUS_V1R_BAD_REMOVED$FAMILYB                                                      
    ## VI_PLOT10_E3_MINUS_V1R_BAD_REMOVED$FAMILYD                                                      
    ## VI_PLOT10_E3_MINUS_V1R_BAD_REMOVED$FAMILYE                                                      
    ## VI_PLOT10_E3_MINUS_V1R_BAD_REMOVED$FAMILYJ                                                      
    ## VI_PLOT10_E3_MINUS_V1R_BAD_REMOVED$FAMILYL                                                      
    ## VI_PLOT10_E3_MINUS_V1R_BAD_REMOVED$GROUPtreatment:VI_PLOT10_E3_MINUS_V1R_BAD_REMOVED$FAMILYB    
    ## VI_PLOT10_E3_MINUS_V1R_BAD_REMOVED$GROUPtreatment:VI_PLOT10_E3_MINUS_V1R_BAD_REMOVED$FAMILYD    
    ## VI_PLOT10_E3_MINUS_V1R_BAD_REMOVED$GROUPtreatment:VI_PLOT10_E3_MINUS_V1R_BAD_REMOVED$FAMILYE    
    ## VI_PLOT10_E3_MINUS_V1R_BAD_REMOVED$GROUPtreatment:VI_PLOT10_E3_MINUS_V1R_BAD_REMOVED$FAMILYJ    
    ## VI_PLOT10_E3_MINUS_V1R_BAD_REMOVED$GROUPtreatment:VI_PLOT10_E3_MINUS_V1R_BAD_REMOVED$FAMILYL    
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
    ## 
    ## Residual standard error: 0.04319 on 41 degrees of freedom
    ## Multiple R-squared:  0.3309, Adjusted R-squared:  0.1514 
    ## F-statistic: 1.844 on 11 and 41 DF,  p-value: 0.07747

    ##  VI_PLOT10_E3_MINUS_V1R_BAD_REMOVED$FAMILY   lsmean         SE df lower.CL
    ##  L                                         1.468807 0.01763355 41 1.433195
    ##  J                                         1.510747 0.02493761 41 1.460384
    ##  E                                         1.513704 0.01490307 41 1.483607
    ##  A                                         1.516661 0.01632550 41 1.483691
    ##  B                                         1.516661 0.01632550 41 1.483691
    ##  D                                         1.516661 0.01632550 41 1.483691
    ##  upper.CL .group
    ##  1.504418  a    
    ##  1.561110  a    
    ##  1.543802  a    
    ##  1.549631  a    
    ##  1.549631  a    
    ##  1.549631  a    
    ## 
    ## Results are averaged over the levels of: VI_PLOT10_E3_MINUS_V1R_BAD_REMOVED$GROUP 
    ## Confidence level used: 0.95 
    ## P value adjustment: tukey method for comparing a family of 6 estimates 
    ## significance level used: alpha = 0.05

### One Way ANOVA of Differences between Families

Analyzing difference between Live Agranular and Granular
--------------------------------------------------------

``` r
## Statistical difference between Live agranular cells and granular cells 
VI_PLOT9_PLOT10_BAD_REMOVED_combined <-rbind(VI_PLOT9_E1_MINUS_V1R_BAD_REMOVED, VI_PLOT10_E3_MINUS_V1R_BAD_REMOVED)

VI_PLOT9_PLOT10_granular_vs_agranular_twoway_aov <- lm(VI_PLOT9_PLOT10_BAD_REMOVED_combined$Arcsine ~ VI_PLOT9_PLOT10_BAD_REMOVED_combined$PERCENT_LIVE +VI_PLOT9_PLOT10_BAD_REMOVED_combined$FAMILY, data=VI_PLOT9_PLOT10_BAD_REMOVED_combined)
Anova(VI_PLOT9_PLOT10_granular_vs_agranular_twoway_aov)
```

    ## Anova Table (Type II tests)
    ## 
    ## Response: VI_PLOT9_PLOT10_BAD_REMOVED_combined$Arcsine
    ##                                                   Sum Sq Df   F value
    ## VI_PLOT9_PLOT10_BAD_REMOVED_combined$PERCENT_LIVE 4.6031  1 1583.0916
    ## VI_PLOT9_PLOT10_BAD_REMOVED_combined$FAMILY       0.0010  5    0.0676
    ## Residuals                                         0.2879 99          
    ##                                                   Pr(>F)    
    ## VI_PLOT9_PLOT10_BAD_REMOVED_combined$PERCENT_LIVE <2e-16 ***
    ## VI_PLOT9_PLOT10_BAD_REMOVED_combined$FAMILY       0.9968    
    ## Residuals                                                   
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

``` r
summary(VI_PLOT9_PLOT10_granular_vs_agranular_twoway_aov)
```

    ## 
    ## Call:
    ## lm(formula = VI_PLOT9_PLOT10_BAD_REMOVED_combined$Arcsine ~ VI_PLOT9_PLOT10_BAD_REMOVED_combined$PERCENT_LIVE + 
    ##     VI_PLOT9_PLOT10_BAD_REMOVED_combined$FAMILY, data = VI_PLOT9_PLOT10_BAD_REMOVED_combined)
    ## 
    ## Residuals:
    ##       Min        1Q    Median        3Q       Max 
    ## -0.075911 -0.050543 -0.004481  0.045469  0.145222 
    ## 
    ## Coefficients:
    ##                                                     Estimate Std. Error
    ## (Intercept)                                       -0.0567239  0.0383540
    ## VI_PLOT9_PLOT10_BAD_REMOVED_combined$PERCENT_LIVE  0.0152433  0.0003831
    ## VI_PLOT9_PLOT10_BAD_REMOVED_combined$FAMILYB       0.0058676  0.0192269
    ## VI_PLOT9_PLOT10_BAD_REMOVED_combined$FAMILYD       0.0083759  0.0181488
    ## VI_PLOT9_PLOT10_BAD_REMOVED_combined$FAMILYE       0.0032457  0.0187942
    ## VI_PLOT9_PLOT10_BAD_REMOVED_combined$FAMILYJ       0.0016954  0.0169614
    ## VI_PLOT9_PLOT10_BAD_REMOVED_combined$FAMILYL      -0.0004558  0.0175250
    ##                                                   t value Pr(>|t|)    
    ## (Intercept)                                        -1.479    0.142    
    ## VI_PLOT9_PLOT10_BAD_REMOVED_combined$PERCENT_LIVE  39.788   <2e-16 ***
    ## VI_PLOT9_PLOT10_BAD_REMOVED_combined$FAMILYB        0.305    0.761    
    ## VI_PLOT9_PLOT10_BAD_REMOVED_combined$FAMILYD        0.462    0.645    
    ## VI_PLOT9_PLOT10_BAD_REMOVED_combined$FAMILYE        0.173    0.863    
    ## VI_PLOT9_PLOT10_BAD_REMOVED_combined$FAMILYJ        0.100    0.921    
    ## VI_PLOT9_PLOT10_BAD_REMOVED_combined$FAMILYL       -0.026    0.979    
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
    ## 
    ## Residual standard error: 0.05392 on 99 degrees of freedom
    ## Multiple R-squared:  0.9473, Adjusted R-squared:  0.9441 
    ## F-statistic: 296.4 on 6 and 99 DF,  p-value: < 2.2e-16

``` r
# Plus an interaction term
VI_PLOT9_PLOT10_granular_vs_agranular_twoway_interaction_aov <- lm(VI_PLOT9_PLOT10_BAD_REMOVED_combined$Arcsine ~ VI_PLOT9_PLOT10_BAD_REMOVED_combined$PERCENT_LIVE + VI_PLOT9_PLOT10_BAD_REMOVED_combined$FAMILY + VI_PLOT9_PLOT10_BAD_REMOVED_combined$PERCENT_LIVE:VI_PLOT9_PLOT10_BAD_REMOVED_combined$FAMILY, data=VI_PLOT9_PLOT10_BAD_REMOVED_combined)
Anova(VI_PLOT9_PLOT10_granular_vs_agranular_twoway_interaction_aov, type="II")
```

    ## Anova Table (Type II tests)
    ## 
    ## Response: VI_PLOT9_PLOT10_BAD_REMOVED_combined$Arcsine
    ##                                                                                               Sum Sq
    ## VI_PLOT9_PLOT10_BAD_REMOVED_combined$PERCENT_LIVE                                             4.6031
    ## VI_PLOT9_PLOT10_BAD_REMOVED_combined$FAMILY                                                   0.0010
    ## VI_PLOT9_PLOT10_BAD_REMOVED_combined$PERCENT_LIVE:VI_PLOT9_PLOT10_BAD_REMOVED_combined$FAMILY 0.0782
    ## Residuals                                                                                     0.2096
    ##                                                                                               Df
    ## VI_PLOT9_PLOT10_BAD_REMOVED_combined$PERCENT_LIVE                                              1
    ## VI_PLOT9_PLOT10_BAD_REMOVED_combined$FAMILY                                                    5
    ## VI_PLOT9_PLOT10_BAD_REMOVED_combined$PERCENT_LIVE:VI_PLOT9_PLOT10_BAD_REMOVED_combined$FAMILY  5
    ## Residuals                                                                                     94
    ##                                                                                                 F value
    ## VI_PLOT9_PLOT10_BAD_REMOVED_combined$PERCENT_LIVE                                             2064.0698
    ## VI_PLOT9_PLOT10_BAD_REMOVED_combined$FAMILY                                                      0.0882
    ## VI_PLOT9_PLOT10_BAD_REMOVED_combined$PERCENT_LIVE:VI_PLOT9_PLOT10_BAD_REMOVED_combined$FAMILY    7.0157
    ## Residuals                                                                                              
    ##                                                                                                  Pr(>F)
    ## VI_PLOT9_PLOT10_BAD_REMOVED_combined$PERCENT_LIVE                                             < 2.2e-16
    ## VI_PLOT9_PLOT10_BAD_REMOVED_combined$FAMILY                                                      0.9939
    ## VI_PLOT9_PLOT10_BAD_REMOVED_combined$PERCENT_LIVE:VI_PLOT9_PLOT10_BAD_REMOVED_combined$FAMILY 1.305e-05
    ## Residuals                                                                                              
    ##                                                                                                  
    ## VI_PLOT9_PLOT10_BAD_REMOVED_combined$PERCENT_LIVE                                             ***
    ## VI_PLOT9_PLOT10_BAD_REMOVED_combined$FAMILY                                                      
    ## VI_PLOT9_PLOT10_BAD_REMOVED_combined$PERCENT_LIVE:VI_PLOT9_PLOT10_BAD_REMOVED_combined$FAMILY ***
    ## Residuals                                                                                        
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

``` r
summary(VI_PLOT9_PLOT10_granular_vs_agranular_twoway_interaction_aov)
```

    ## 
    ## Call:
    ## lm(formula = VI_PLOT9_PLOT10_BAD_REMOVED_combined$Arcsine ~ VI_PLOT9_PLOT10_BAD_REMOVED_combined$PERCENT_LIVE + 
    ##     VI_PLOT9_PLOT10_BAD_REMOVED_combined$FAMILY + VI_PLOT9_PLOT10_BAD_REMOVED_combined$PERCENT_LIVE:VI_PLOT9_PLOT10_BAD_REMOVED_combined$FAMILY, 
    ##     data = VI_PLOT9_PLOT10_BAD_REMOVED_combined)
    ## 
    ## Residuals:
    ##       Min        1Q    Median        3Q       Max 
    ## -0.071968 -0.044492  0.005294  0.034303  0.111435 
    ## 
    ## Coefficients:
    ##                                                                                                 Estimate
    ## (Intercept)                                                                                    -0.741555
    ## VI_PLOT9_PLOT10_BAD_REMOVED_combined$PERCENT_LIVE                                               0.022449
    ## VI_PLOT9_PLOT10_BAD_REMOVED_combined$FAMILYB                                                    0.750428
    ## VI_PLOT9_PLOT10_BAD_REMOVED_combined$FAMILYD                                                    0.767217
    ## VI_PLOT9_PLOT10_BAD_REMOVED_combined$FAMILYE                                                    0.263040
    ## VI_PLOT9_PLOT10_BAD_REMOVED_combined$FAMILYJ                                                    0.751470
    ## VI_PLOT9_PLOT10_BAD_REMOVED_combined$FAMILYL                                                    0.439569
    ## VI_PLOT9_PLOT10_BAD_REMOVED_combined$PERCENT_LIVE:VI_PLOT9_PLOT10_BAD_REMOVED_combined$FAMILYB -0.007914
    ## VI_PLOT9_PLOT10_BAD_REMOVED_combined$PERCENT_LIVE:VI_PLOT9_PLOT10_BAD_REMOVED_combined$FAMILYD -0.008101
    ## VI_PLOT9_PLOT10_BAD_REMOVED_combined$PERCENT_LIVE:VI_PLOT9_PLOT10_BAD_REMOVED_combined$FAMILYE -0.002686
    ## VI_PLOT9_PLOT10_BAD_REMOVED_combined$PERCENT_LIVE:VI_PLOT9_PLOT10_BAD_REMOVED_combined$FAMILYJ -0.007955
    ## VI_PLOT9_PLOT10_BAD_REMOVED_combined$PERCENT_LIVE:VI_PLOT9_PLOT10_BAD_REMOVED_combined$FAMILYL -0.004598
    ##                                                                                                Std. Error
    ## (Intercept)                                                                                      0.163881
    ## VI_PLOT9_PLOT10_BAD_REMOVED_combined$PERCENT_LIVE                                                0.001721
    ## VI_PLOT9_PLOT10_BAD_REMOVED_combined$FAMILYB                                                     0.175046
    ## VI_PLOT9_PLOT10_BAD_REMOVED_combined$FAMILYD                                                     0.171507
    ## VI_PLOT9_PLOT10_BAD_REMOVED_combined$FAMILYE                                                     0.219537
    ## VI_PLOT9_PLOT10_BAD_REMOVED_combined$FAMILYJ                                                     0.172374
    ## VI_PLOT9_PLOT10_BAD_REMOVED_combined$FAMILYL                                                     0.202706
    ## VI_PLOT9_PLOT10_BAD_REMOVED_combined$PERCENT_LIVE:VI_PLOT9_PLOT10_BAD_REMOVED_combined$FAMILYB   0.001863
    ## VI_PLOT9_PLOT10_BAD_REMOVED_combined$PERCENT_LIVE:VI_PLOT9_PLOT10_BAD_REMOVED_combined$FAMILYD   0.001821
    ## VI_PLOT9_PLOT10_BAD_REMOVED_combined$PERCENT_LIVE:VI_PLOT9_PLOT10_BAD_REMOVED_combined$FAMILYE   0.002314
    ## VI_PLOT9_PLOT10_BAD_REMOVED_combined$PERCENT_LIVE:VI_PLOT9_PLOT10_BAD_REMOVED_combined$FAMILYJ   0.001824
    ## VI_PLOT9_PLOT10_BAD_REMOVED_combined$PERCENT_LIVE:VI_PLOT9_PLOT10_BAD_REMOVED_combined$FAMILYL   0.002136
    ##                                                                                                t value
    ## (Intercept)                                                                                     -4.525
    ## VI_PLOT9_PLOT10_BAD_REMOVED_combined$PERCENT_LIVE                                               13.046
    ## VI_PLOT9_PLOT10_BAD_REMOVED_combined$FAMILYB                                                     4.287
    ## VI_PLOT9_PLOT10_BAD_REMOVED_combined$FAMILYD                                                     4.473
    ## VI_PLOT9_PLOT10_BAD_REMOVED_combined$FAMILYE                                                     1.198
    ## VI_PLOT9_PLOT10_BAD_REMOVED_combined$FAMILYJ                                                     4.360
    ## VI_PLOT9_PLOT10_BAD_REMOVED_combined$FAMILYL                                                     2.169
    ## VI_PLOT9_PLOT10_BAD_REMOVED_combined$PERCENT_LIVE:VI_PLOT9_PLOT10_BAD_REMOVED_combined$FAMILYB  -4.248
    ## VI_PLOT9_PLOT10_BAD_REMOVED_combined$PERCENT_LIVE:VI_PLOT9_PLOT10_BAD_REMOVED_combined$FAMILYD  -4.448
    ## VI_PLOT9_PLOT10_BAD_REMOVED_combined$PERCENT_LIVE:VI_PLOT9_PLOT10_BAD_REMOVED_combined$FAMILYE  -1.161
    ## VI_PLOT9_PLOT10_BAD_REMOVED_combined$PERCENT_LIVE:VI_PLOT9_PLOT10_BAD_REMOVED_combined$FAMILYJ  -4.361
    ## VI_PLOT9_PLOT10_BAD_REMOVED_combined$PERCENT_LIVE:VI_PLOT9_PLOT10_BAD_REMOVED_combined$FAMILYL  -2.152
    ##                                                                                                Pr(>|t|)
    ## (Intercept)                                                                                    1.76e-05
    ## VI_PLOT9_PLOT10_BAD_REMOVED_combined$PERCENT_LIVE                                               < 2e-16
    ## VI_PLOT9_PLOT10_BAD_REMOVED_combined$FAMILYB                                                   4.38e-05
    ## VI_PLOT9_PLOT10_BAD_REMOVED_combined$FAMILYD                                                   2.15e-05
    ## VI_PLOT9_PLOT10_BAD_REMOVED_combined$FAMILYE                                                     0.2339
    ## VI_PLOT9_PLOT10_BAD_REMOVED_combined$FAMILYJ                                                   3.33e-05
    ## VI_PLOT9_PLOT10_BAD_REMOVED_combined$FAMILYL                                                     0.0326
    ## VI_PLOT9_PLOT10_BAD_REMOVED_combined$PERCENT_LIVE:VI_PLOT9_PLOT10_BAD_REMOVED_combined$FAMILYB 5.07e-05
    ## VI_PLOT9_PLOT10_BAD_REMOVED_combined$PERCENT_LIVE:VI_PLOT9_PLOT10_BAD_REMOVED_combined$FAMILYD 2.38e-05
    ## VI_PLOT9_PLOT10_BAD_REMOVED_combined$PERCENT_LIVE:VI_PLOT9_PLOT10_BAD_REMOVED_combined$FAMILYE   0.2487
    ## VI_PLOT9_PLOT10_BAD_REMOVED_combined$PERCENT_LIVE:VI_PLOT9_PLOT10_BAD_REMOVED_combined$FAMILYJ 3.31e-05
    ## VI_PLOT9_PLOT10_BAD_REMOVED_combined$PERCENT_LIVE:VI_PLOT9_PLOT10_BAD_REMOVED_combined$FAMILYL   0.0339
    ##                                                                                                   
    ## (Intercept)                                                                                    ***
    ## VI_PLOT9_PLOT10_BAD_REMOVED_combined$PERCENT_LIVE                                              ***
    ## VI_PLOT9_PLOT10_BAD_REMOVED_combined$FAMILYB                                                   ***
    ## VI_PLOT9_PLOT10_BAD_REMOVED_combined$FAMILYD                                                   ***
    ## VI_PLOT9_PLOT10_BAD_REMOVED_combined$FAMILYE                                                      
    ## VI_PLOT9_PLOT10_BAD_REMOVED_combined$FAMILYJ                                                   ***
    ## VI_PLOT9_PLOT10_BAD_REMOVED_combined$FAMILYL                                                   *  
    ## VI_PLOT9_PLOT10_BAD_REMOVED_combined$PERCENT_LIVE:VI_PLOT9_PLOT10_BAD_REMOVED_combined$FAMILYB ***
    ## VI_PLOT9_PLOT10_BAD_REMOVED_combined$PERCENT_LIVE:VI_PLOT9_PLOT10_BAD_REMOVED_combined$FAMILYD ***
    ## VI_PLOT9_PLOT10_BAD_REMOVED_combined$PERCENT_LIVE:VI_PLOT9_PLOT10_BAD_REMOVED_combined$FAMILYE    
    ## VI_PLOT9_PLOT10_BAD_REMOVED_combined$PERCENT_LIVE:VI_PLOT9_PLOT10_BAD_REMOVED_combined$FAMILYJ ***
    ## VI_PLOT9_PLOT10_BAD_REMOVED_combined$PERCENT_LIVE:VI_PLOT9_PLOT10_BAD_REMOVED_combined$FAMILYL *  
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
    ## 
    ## Residual standard error: 0.04722 on 94 degrees of freedom
    ## Multiple R-squared:  0.9616, Adjusted R-squared:  0.9571 
    ## F-statistic:   214 on 11 and 94 DF,  p-value: < 2.2e-16

``` r
VI_PLOT9_PLOT10_granular_vs_agranular_twoway_interaction_aov_leastsquare_interaction <- lsmeans(VI_PLOT9_PLOT10_granular_vs_agranular_twoway_interaction_aov, pairwise ~ VI_PLOT9_PLOT10_BAD_REMOVED_combined$PERCENT_LIVE:VI_PLOT9_PLOT10_BAD_REMOVED_combined$FAMILY, adjust="tukey")
cld(VI_PLOT9_PLOT10_granular_vs_agranular_twoway_interaction_aov_leastsquare_interaction, alpha=0.05, Letters=letters)
```

    ##  VI_PLOT9_PLOT10_BAD_REMOVED_combined$PERCENT_LIVE
    ##                                           89.47479
    ##                                           89.47479
    ##                                           89.47479
    ##                                           89.47479
    ##                                           89.47479
    ##                                           89.47479
    ##  VI_PLOT9_PLOT10_BAD_REMOVED_combined$FAMILY   lsmean         SE df
    ##  J                                           1.068968 0.02691487 94
    ##  B                                           1.160929 0.02061720 94
    ##  A                                           1.206876 0.01768448 94
    ##  D                                           1.355899 0.01091503 94
    ##  L                                           1.361177 0.01081971 94
    ##  E                                           1.410318 0.01065322 94
    ##  lower.CL upper.CL .group 
    ##  1.015528 1.122408  a     
    ##  1.119993 1.201865   b    
    ##  1.171763 1.241989    c   
    ##  1.334227 1.377571     d  
    ##  1.339695 1.382660      e 
    ##  1.389166 1.431470       f
    ## 
    ## Confidence level used: 0.95 
    ## P value adjustment: tukey method for comparing a family of 6 estimates 
    ## significance level used: alpha = 0.05

``` r
#Plotting
ggplot(VI_PLOT9_PLOT10_BAD_REMOVED_combined, aes(x=GROUP, y=PERCENT_LIVE, fill=PLOT)) + geom_boxplot() + ggtitle("Percent of Live Granular and Agranular Hemocytes (low quality removed)") + ylab("Percent of Hemocyte Events in each quad plot") + scale_fill_manual(name="Hemocyte Type", labels=c("Live Granular Hemocytes", "Live Agranular Hemocytes"), values=c("E1"="#99a765","E3"="#96578a")) + facet_grid(.~FAMILY+GROUP, scales="free") 
```

![](Dermo_Viability_Assay_Data_analysis_files/figure-markdown_github/difference_between_cells-1.png)

#### Calculate Summary Statistics

``` r
# Summary Statistics for Percentages 
total_viabaility_statistics <- summarySE(data=VI_PLOT4_restructured_BAD_REMOVED, "PERCENT_OF_THIS_PLOT", groupvars=c("GROUP", "E1_E3","FAMILY"))
```

    ## Warning in qt(conf.interval/2 + 0.5, datac$N - 1): NaNs produced

``` r
viability_statistics_live <- summarySE(data=VI_PLOT9_PLOT10_BAD_REMOVED_combined, "PERCENT_LIVE", groupvars=c("GROUP", "PERCENT_LIVE","FAMILY"), conf.interval= 0.95)
```

    ## Warning: The plyr::rename operation has created duplicates for the
    ## following name(s): (`PERCENT_LIVE`)

    ## Warning: NaNs produced

``` r
# Summary Statistics for size
mean_size <- read.csv(file="../ANALYSIS_CSVs/VIABILITY_ASSAY/DAY7/VIABILITY_ASSAY_MEAN_VALUES_CORRECTED_EDITED.csv", header=TRUE)
class(mean_size$MEAN)
```

    ## [1] "numeric"

``` r
mean_size_BAD_REMOVED <- mean_size[!mean_size$SAMPLE_ID %in% Viability_Samples_Remove$SAMPLE_ID, , drop=FALSE]
mean_size_statistics <- summarySE(data=mean_size_BAD_REMOVED, "MEAN", groupvars=c("GROUP","GATE","PLOT","FAMILY"), conf.interval = 0.95)
```

    ## Warning in qt(conf.interval/2 + 0.5, datac$N - 1): NaNs produced

#### DAY 50 DATA ANALYSIS

VIABILITY ASSAY ANALYSIS
========================

Load in data for each plot
--------------------------

``` r
#Load in the Data for each plot on a separate spreadsheet

VI_DAY50_PLOT2_hemocytes <- read.csv(file="../ANALYSIS_CSVs/VIABILITY_ASSAY/DAY50/PLOT2.csv", header=TRUE)
VI_DAY50_PLOT3_P1_GATE <- read.csv(file="../ANALYSIS_CSVs/VIABILITY_ASSAY/DAY50/PLOT3.csv", header=TRUE)
VI_DAY50_PLOT4_E1_E3_GATE <- read.csv(file="../ANALYSIS_CSVs/VIABILITY_ASSAY/DAY50/PLOT4.csv", header=TRUE)
VI_DAY50_PLOT5_P1_MINUS_V1R <- read.csv(file="../ANALYSIS_CSVs/VIABILITY_ASSAY/DAY50/PLOT5.csv", header=TRUE)
VI_DAY50_PLOT9_E1_MINUS_V1R <- read.csv(file="../ANALYSIS_CSVs/VIABILITY_ASSAY/DAY50/PLOT9.csv", header=TRUE)
VI_DAY50_PLOT10_E3_MINUS_V1R <- read.csv(file="../ANALYSIS_CSVs/VIABILITY_ASSAY/DAY50/PLOT10.csv", header=TRUE)
VI_DAY50_PLOT12_P1_PerCP <- read.csv(file="../ANALYSIS_CSVs/VIABILITY_ASSAY/DAY50/PLOT12.csv", header=TRUE)

# Remove rows with na's with the remove.na function from rgr
VI_DAY50_PLOT2_hemocytes <- na.omit(VI_DAY50_PLOT2_hemocytes)
VI_DAY50_PLOT3_P1_GATE <- na.omit(VI_DAY50_PLOT3_P1_GATE)
VI_DAY50_PLOT4_E1_E3_GATE <- na.omit(VI_DAY50_PLOT4_E1_E3_GATE)
VI_DAY50_PLOT5_P1_MINUS_V1R <- na.omit(VI_DAY50_PLOT5_P1_MINUS_V1R)
VI_DAY50_PLOT9_E1_MINUS_V1R <- na.omit(VI_DAY50_PLOT9_E1_MINUS_V1R)
VI_DAY50_PLOT10_E3_MINUS_V1R <- na.omit(VI_DAY50_PLOT10_E3_MINUS_V1R)
VI_DAY50_PLOT12_P1_PerCP <- na.omit(VI_DAY50_PLOT12_P1_PerCP)

## Remove percent symbol from columns 
VI_DAY50_PLOT2_hemocytes$M4_PERCENT_OF_THIS_PLOT <- as.numeric(gsub("\\%", "", VI_DAY50_PLOT2_hemocytes$M4_PERCENT_OF_THIS_PLOT))
VI_DAY50_PLOT3_P1_GATE$P1_PERCENT_OF_THIS_PLOT <- as.numeric(gsub("\\%", "", VI_DAY50_PLOT3_P1_GATE$P1_PERCENT_OF_THIS_PLOT))
VI_DAY50_PLOT4_E1_E3_GATE$PERCENT_OF_THIS_PLOT <- as.numeric(gsub("\\%", "", VI_DAY50_PLOT4_E1_E3_GATE$PERCENT_OF_THIS_PLOT))
VI_DAY50_PLOT12_P1_PerCP$V1_L_PERCENT_OF_THIS_PLOT <- as.numeric(gsub("\\%", "", VI_DAY50_PLOT12_P1_PerCP$V1_L_PERCENT_OF_THIS_PLOT))
VI_DAY50_PLOT12_P1_PerCP$V1_R_PERCENT_OF_THIS_PLOT <- as.numeric(gsub("\\%", "", VI_DAY50_PLOT12_P1_PerCP$V1_R_PERCENT_OF_THIS_PLOT))

# Load in Data for the samples to remove 
Viability_Samples_Remove_DAY50 <- read.csv(file="../ANALYSIS_CSVs/VIABILITY_ASSAY/DAY50/Viability_Assay_Remove_Day50.csv", header=TRUE)

# Data Frame with bad samples removed
VI_DAY50_PLOT2_hemocytes_BAD_REMOVED <- VI_DAY50_PLOT2_hemocytes[!VI_DAY50_PLOT2_hemocytes$SAMPLE_ID %in% Viability_Samples_Remove_DAY50$SAMPLE_ID, , drop=FALSE]

VI_DAY50_PLOT3_P1_GATE_BAD_REMOVED <- VI_DAY50_PLOT3_P1_GATE[!VI_DAY50_PLOT3_P1_GATE$SAMPLE_ID %in% Viability_Samples_Remove_DAY50$SAMPLE_ID, , drop=FALSE]
VI_DAY50_PLOT4_E1_E3_GATE_BAD_REMOVED <- VI_DAY50_PLOT4_E1_E3_GATE[!VI_DAY50_PLOT4_E1_E3_GATE$SAMPLE_ID %in% Viability_Samples_Remove_DAY50$SAMPLE_ID, , drop=FALSE]
VI_DAY50_PLOT5_P1_MINUS_V1R_BAD_REMOVED <- VI_DAY50_PLOT5_P1_MINUS_V1R[!VI_DAY50_PLOT5_P1_MINUS_V1R$SAMPLE_ID %in% Viability_Samples_Remove_DAY50$SAMPLE_ID, , drop=FALSE]
VI_DAY50_PLOT9_E1_MINUS_V1R_BAD_REMOVED <- VI_DAY50_PLOT9_E1_MINUS_V1R[!VI_DAY50_PLOT9_E1_MINUS_V1R$SAMPLE_ID %in% Viability_Samples_Remove_DAY50$SAMPLE_ID, , drop=FALSE]
VI_DAY50_PLOT10_E3_MINUS_V1R_BAD_REMOVED <- VI_DAY50_PLOT10_E3_MINUS_V1R[!VI_DAY50_PLOT10_E3_MINUS_V1R$SAMPLE_ID %in% Viability_Samples_Remove_DAY50$SAMPLE_ID, , drop=FALSE]
VI_DAY50_PLOT12_P1_PerCP_BAD_REMOVED <- VI_DAY50_PLOT12_P1_PerCP[!VI_DAY50_PLOT12_P1_PerCP$SAMPLE_ID %in% Viability_Samples_Remove_DAY50$SAMPLE_ID, , drop=FALSE]
```

Arc sine Percentage data
========================

``` r
# Calculate Percent Live Granulocytes 
  # Take cells here and make a percentage out of GRANULAR hemocyte count from VI_PLOT3_P1_GATE P1_COUNT
  # These commands only work correctly if the csv has all the commas removed from the numbers for the thousands separator
VI_DAY50_PLOT9_E1_MINUS_V1R$COUNT_THIS_PLOT<- as.numeric(VI_DAY50_PLOT9_E1_MINUS_V1R$COUNT_THIS_PLOT)
VI_DAY50_PLOT3_P1_GATE$P1_COUNT <- as.numeric(VI_DAY50_PLOT3_P1_GATE$P1_COUNT)
VI_DAY50_PLOT4_E1_E3_GATE$COUNT <- as.numeric(VI_DAY50_PLOT4_E1_E3_GATE$COUNT) 
VI_DAY50_PLOT4_E1_E3_GATE_E1 <- VI_DAY50_PLOT4_E1_E3_GATE %>% filter(GATE=="E1")
VI_DAY50_PLOT9_E1_MINUS_V1R$PERCENT_LIVE <- (VI_DAY50_PLOT9_E1_MINUS_V1R$COUNT_THIS_PLOT / VI_DAY50_PLOT4_E1_E3_GATE_E1$COUNT)*100

VI_DAY50_PLOT9_E1_MINUS_V1R_BAD_REMOVED$COUNT_THIS_PLOT <- as.numeric(VI_DAY50_PLOT9_E1_MINUS_V1R_BAD_REMOVED$COUNT_THIS_PLOT)
VI_DAY50_PLOT3_P1_GATE_BAD_REMOVED$P1_COUNT <- as.numeric(VI_DAY50_PLOT3_P1_GATE_BAD_REMOVED$P1_COUNT)
VI_DAY50_PLOT4_E1_E3_GATE_BAD_REMOVED$COUNT <- as.numeric(VI_DAY50_PLOT4_E1_E3_GATE_BAD_REMOVED$COUNT)
VI_DAY50_PLOT4_E1_E3_GATE_BAD_REMOVED_E1 <- VI_DAY50_PLOT4_E1_E3_GATE_BAD_REMOVED %>% filter(GATE=="E1")
VI_DAY50_PLOT9_E1_MINUS_V1R_BAD_REMOVED$PERCENT_LIVE <- (VI_DAY50_PLOT9_E1_MINUS_V1R_BAD_REMOVED$COUNT_THIS_PLOT / VI_DAY50_PLOT4_E1_E3_GATE_BAD_REMOVED_E1$COUNT)*100 

# Calculate Percent Live Agranulocytes 
VI_DAY50_PLOT10_E3_MINUS_V1R$COUNT_THIS_PLOT <- as.numeric(VI_DAY50_PLOT10_E3_MINUS_V1R$COUNT_THIS_PLOT)
VI_DAY50_PLOT4_E1_E3_GATE$COUNT <- as.numeric(VI_DAY50_PLOT4_E1_E3_GATE$COUNT)
VI_DAY50_PLOT4_E1_E3_GATE_E3 <- VI_DAY50_PLOT4_E1_E3_GATE %>% filter(GATE=="E3")

VI_DAY50_PLOT10_E3_MINUS_V1R$PERCENT_LIVE <- (VI_DAY50_PLOT10_E3_MINUS_V1R$COUNT_THIS_PLOT / VI_DAY50_PLOT4_E1_E3_GATE_E3$COUNT)*100

VI_DAY50_PLOT10_E3_MINUS_V1R_BAD_REMOVED$COUNT_THIS_PLOT <- as.numeric(VI_DAY50_PLOT10_E3_MINUS_V1R_BAD_REMOVED$COUNT_THIS_PLOT)
VI_DAY50_PLOT4_E1_E3_GATE_BAD_REMOVED$COUNT <- as.numeric(VI_DAY50_PLOT4_E1_E3_GATE_BAD_REMOVED$COUNT)
VI_DAY50_PLOT4_E1_E3_GATE_BAD_REMOVED_E3 <- VI_DAY50_PLOT4_E1_E3_GATE_BAD_REMOVED %>% filter(GATE=="E3")
VI_DAY50_PLOT10_E3_MINUS_V1R_BAD_REMOVED$PERCENT_LIVE <- (VI_DAY50_PLOT10_E3_MINUS_V1R_BAD_REMOVED$COUNT_THIS_PLOT / VI_DAY50_PLOT4_E1_E3_GATE_BAD_REMOVED_E3$COUNT)*100 

# Use transf.arcsine to arcsine transform the percentages
VI_DAY50_PLOT2_hemocytes$Arcsine <- transf.arcsin(VI_DAY50_PLOT2_hemocytes$M4_PERCENT_OF_THIS_PLOT*.01)
VI_DAY50_PLOT4_E1_E3_GATE$Arcsine <- transf.arcsin(VI_DAY50_PLOT4_E1_E3_GATE$PERCENT_OF_THIS_PLOT*0.01)
VI_DAY50_PLOT9_E1_MINUS_V1R$Arcsine <- transf.arcsin(VI_DAY50_PLOT9_E1_MINUS_V1R$PERCENT_LIVE*0.01)
VI_DAY50_PLOT10_E3_MINUS_V1R$Arcsine <- transf.arcsin(VI_DAY50_PLOT10_E3_MINUS_V1R$PERCENT_LIVE*0.01)
VI_DAY50_PLOT12_P1_PerCP$V1_L_Arcsine <- transf.arcsin(VI_DAY50_PLOT12_P1_PerCP$V1_L_PERCENT_OF_THIS_PLOT*0.01)
VI_DAY50_PLOT12_P1_PerCP$V1_R_Arcsine <- transf.arcsin(VI_DAY50_PLOT12_P1_PerCP$V1_R_PERCENT_OF_THIS_PLOT*0.01)

# Use transf.arcsine to arcsine transform the percentages for the "BAD REMOVED" samples
VI_DAY50_PLOT2_hemocytes_BAD_REMOVED$Arcsine <- transf.arcsin(VI_DAY50_PLOT2_hemocytes_BAD_REMOVED$M4_PERCENT_OF_THIS_PLOT*.01)
VI_DAY50_PLOT4_E1_E3_GATE_BAD_REMOVED$Arcsine <- transf.arcsin(VI_DAY50_PLOT4_E1_E3_GATE_BAD_REMOVED$PERCENT_OF_THIS_PLOT*0.01)
VI_DAY50_PLOT9_E1_MINUS_V1R_BAD_REMOVED$Arcsine <- transf.arcsin(VI_DAY50_PLOT9_E1_MINUS_V1R_BAD_REMOVED$PERCENT_LIVE*0.01)
VI_DAY50_PLOT10_E3_MINUS_V1R_BAD_REMOVED$Arcsine <- transf.arcsin(VI_DAY50_PLOT10_E3_MINUS_V1R_BAD_REMOVED$PERCENT_LIVE*0.01)
VI_DAY50_PLOT12_P1_PerCP_BAD_REMOVED$V1_L_Arcsine <- transf.arcsin(VI_DAY50_PLOT12_P1_PerCP_BAD_REMOVED$V1_L_PERCENT_OF_THIS_PLOT*0.01)
VI_DAY50_PLOT12_P1_PerCP_BAD_REMOVED$V1_R_Arcsine <- transf.arcsin(VI_DAY50_PLOT12_P1_PerCP_BAD_REMOVED$V1_R_PERCENT_OF_THIS_PLOT*0.01)
```

Plotting of Total Granular and Agranular Hemocytes
--------------------------------------------------

``` r
ggplot(VI_DAY50_PLOT4_E1_E3_GATE_BAD_REMOVED, aes(x=GROUP, y=PERCENT_OF_THIS_PLOT, fill=GATE)) + geom_boxplot() + ggtitle("Percent Total Granular and Agranular Hemocytes (low quality removed)") + ylab("Percent of Hemocyte Events in each quad plot") + scale_fill_manual(name="Hemocyte Type", labels=c("Granular Hemocytes", "Agranular Hemocytes"), values=c("E1"="#99a765","E3"="#96578a")) + facet_grid(.~FAMILY+GROUP, scales="free") 
```

![](Dermo_Viability_Assay_Data_analysis_files/figure-markdown_github/day50_plotting-1.png)

Percent of granular hemocytes (E1)
----------------------------------

### FAMILY A

``` r
VI_DAY50_PLOT4_FAMILY_A_E1 <- VI_DAY50_PLOT4_E1_E3_GATE %>% filter(FAMILY=="A") %>% filter(GATE=="E1")
VI_DAY50_PLOT4_E1_AOV_FAMILY_A_E1 <- aov(VI_DAY50_PLOT4_FAMILY_A_E1$Arcsine ~ VI_DAY50_PLOT4_FAMILY_A_E1$GROUP, data=VI_DAY50_PLOT4_FAMILY_A_E1)
summary(VI_DAY50_PLOT4_E1_AOV_FAMILY_A_E1)
```

    ##                                  Df  Sum Sq Mean Sq F value Pr(>F)
    ## VI_DAY50_PLOT4_FAMILY_A_E1$GROUP  1 0.03113 0.03113   1.941  0.189
    ## Residuals                        12 0.19243 0.01604

``` r
VI_DAY50_PLOT4_FAMILY_A_E1_BAD_REMOVED <- VI_DAY50_PLOT4_E1_E3_GATE_BAD_REMOVED %>% filter(FAMILY =="A") %>% filter(GATE=="E1")
VI_DAY50_PLOT4_E1_AOV_FAMILY_A_BAD_REMOVED <- aov(VI_DAY50_PLOT4_FAMILY_A_E1_BAD_REMOVED$Arcsine ~ VI_DAY50_PLOT4_FAMILY_A_E1_BAD_REMOVED$GROUP, data=VI_DAY50_PLOT4_FAMILY_A_E1_BAD_REMOVED)
summary(VI_DAY50_PLOT4_E1_AOV_FAMILY_A_BAD_REMOVED)
```

    ##                                              Df  Sum Sq Mean Sq F value
    ## VI_DAY50_PLOT4_FAMILY_A_E1_BAD_REMOVED$GROUP  1 0.03113 0.03113   1.941
    ## Residuals                                    12 0.19243 0.01604        
    ##                                              Pr(>F)
    ## VI_DAY50_PLOT4_FAMILY_A_E1_BAD_REMOVED$GROUP  0.189
    ## Residuals

### FAMILY B

``` r
VI_DAY50_PLOT4_FAMILY_B_E1 <- VI_DAY50_PLOT4_E1_E3_GATE %>% filter(FAMILY=="B") %>% filter(GATE=="E1")
VI_DAY50_PLOT4_E1_AOV_FAMILY_B_E1 <- aov(VI_DAY50_PLOT4_FAMILY_B_E1$Arcsine ~ VI_DAY50_PLOT4_FAMILY_B_E1$GROUP, data=VI_DAY50_PLOT4_FAMILY_B_E1)
summary(VI_DAY50_PLOT4_E1_AOV_FAMILY_B_E1)
```

    ##                                  Df  Sum Sq Mean Sq F value Pr(>F)
    ## VI_DAY50_PLOT4_FAMILY_B_E1$GROUP  1 0.02305 0.02305    1.59  0.231
    ## Residuals                        12 0.17400 0.01450

``` r
VI_DAY50_PLOT4_FAMILY_B_E1_BAD_REMOVED <- VI_DAY50_PLOT4_E1_E3_GATE_BAD_REMOVED %>% filter(FAMILY =="B") %>% filter(GATE=="E1")
VI_DAY50_PLOT4_E1_AOV_FAMILY_B_BAD_REMOVED <- aov(VI_DAY50_PLOT4_FAMILY_B_E1_BAD_REMOVED$Arcsine ~ VI_DAY50_PLOT4_FAMILY_B_E1_BAD_REMOVED$GROUP, data=VI_DAY50_PLOT4_FAMILY_B_E1_BAD_REMOVED)
summary(VI_DAY50_PLOT4_E1_AOV_FAMILY_B_BAD_REMOVED)
```

    ##                                              Df  Sum Sq Mean Sq F value
    ## VI_DAY50_PLOT4_FAMILY_B_E1_BAD_REMOVED$GROUP  1 0.02309 0.02309   1.462
    ## Residuals                                    11 0.17373 0.01579        
    ##                                              Pr(>F)
    ## VI_DAY50_PLOT4_FAMILY_B_E1_BAD_REMOVED$GROUP  0.252
    ## Residuals

### FAMILY D

``` r
VI_DAY50_PLOT4_FAMILY_D_E1 <- VI_DAY50_PLOT4_E1_E3_GATE %>% filter(FAMILY=="D") %>% filter(GATE=="E1")
VI_DAY50_PLOT4_E1_AOV_FAMILY_D_E1 <- aov(VI_DAY50_PLOT4_FAMILY_D_E1$Arcsine ~ VI_DAY50_PLOT4_FAMILY_D_E1$GROUP, data=VI_DAY50_PLOT4_FAMILY_D_E1)
summary(VI_DAY50_PLOT4_E1_AOV_FAMILY_D_E1)
```

    ##                                  Df  Sum Sq  Mean Sq F value Pr(>F)
    ## VI_DAY50_PLOT4_FAMILY_D_E1$GROUP  1 0.00002 0.000023   0.004  0.953
    ## Residuals                        12 0.07759 0.006466

``` r
VI_DAY50_PLOT4_FAMILY_D_E1_BAD_REMOVED <- VI_DAY50_PLOT4_E1_E3_GATE_BAD_REMOVED %>% filter(FAMILY =="D") %>% filter(GATE=="E1")
VI_DAY50_PLOT4_E1_AOV_FAMILY_D_BAD_REMOVED <- aov(VI_DAY50_PLOT4_FAMILY_D_E1_BAD_REMOVED$Arcsine ~ VI_DAY50_PLOT4_FAMILY_D_E1_BAD_REMOVED$GROUP, data=VI_DAY50_PLOT4_FAMILY_D_E1_BAD_REMOVED)
summary(VI_DAY50_PLOT4_E1_AOV_FAMILY_D_BAD_REMOVED)
```

    ##                                              Df  Sum Sq  Mean Sq F value
    ## VI_DAY50_PLOT4_FAMILY_D_E1_BAD_REMOVED$GROUP  1 0.00035 0.000346   0.046
    ## Residuals                                    10 0.07557 0.007557        
    ##                                              Pr(>F)
    ## VI_DAY50_PLOT4_FAMILY_D_E1_BAD_REMOVED$GROUP  0.835
    ## Residuals

### FAMILY E

``` r
VI_DAY50_PLOT4_FAMILY_E_E1 <- VI_DAY50_PLOT4_E1_E3_GATE %>% filter(FAMILY=="E") %>% filter(GATE=="E1")
VI_DAY50_PLOT4_E1_AOV_FAMILY_E_E1 <- aov(VI_DAY50_PLOT4_FAMILY_E_E1$Arcsine ~ VI_DAY50_PLOT4_FAMILY_E_E1$GROUP, data=VI_DAY50_PLOT4_FAMILY_E_E1)
summary(VI_DAY50_PLOT4_E1_AOV_FAMILY_E_E1)
```

    ##                                  Df  Sum Sq Mean Sq F value Pr(>F)
    ## VI_DAY50_PLOT4_FAMILY_E_E1$GROUP  1 0.00109 0.00109   0.059  0.812
    ## Residuals                        13 0.24041 0.01849

``` r
VI_DAY50_PLOT4_FAMILY_E_E1_BAD_REMOVED <- VI_DAY50_PLOT4_E1_E3_GATE_BAD_REMOVED %>% filter(FAMILY =="E") %>% filter(GATE=="E1")
VI_DAY50_PLOT4_E1_AOV_FAMILY_E_BAD_REMOVED <- aov(VI_DAY50_PLOT4_FAMILY_E_E1_BAD_REMOVED$Arcsine ~ VI_DAY50_PLOT4_FAMILY_E_E1_BAD_REMOVED$GROUP, data=VI_DAY50_PLOT4_FAMILY_E_E1_BAD_REMOVED)
summary(VI_DAY50_PLOT4_E1_AOV_FAMILY_E_BAD_REMOVED)
```

    ##                                              Df  Sum Sq  Mean Sq F value
    ## VI_DAY50_PLOT4_FAMILY_E_E1_BAD_REMOVED$GROUP  1 0.00003 0.000027   0.002
    ## Residuals                                    11 0.15674 0.014249        
    ##                                              Pr(>F)
    ## VI_DAY50_PLOT4_FAMILY_E_E1_BAD_REMOVED$GROUP  0.966
    ## Residuals

### FAMILY J

``` r
VI_DAY50_PLOT4_FAMILY_J_E1 <- VI_DAY50_PLOT4_E1_E3_GATE %>% filter(FAMILY=="J") %>% filter(GATE=="E1")
VI_DAY50_PLOT4_E1_AOV_FAMILY_J_E1 <- aov(VI_DAY50_PLOT4_FAMILY_J_E1$Arcsine ~ VI_DAY50_PLOT4_FAMILY_J_E1$GROUP, data=VI_DAY50_PLOT4_FAMILY_J_E1)
summary(VI_DAY50_PLOT4_E1_AOV_FAMILY_J_E1)
```

    ##                                  Df Sum Sq Mean Sq F value Pr(>F)
    ## VI_DAY50_PLOT4_FAMILY_J_E1$GROUP  1 0.0060 0.00599   0.145   0.71
    ## Residuals                        12 0.4944 0.04120

``` r
VI_DAY50_PLOT4_FAMILY_J_E1_BAD_REMOVED <- VI_DAY50_PLOT4_E1_E3_GATE_BAD_REMOVED %>% filter(FAMILY =="J") %>% filter(GATE=="E1")
VI_DAY50_PLOT4_E1_AOV_FAMILY_J_BAD_REMOVED <- aov(VI_DAY50_PLOT4_FAMILY_J_E1_BAD_REMOVED$Arcsine ~ VI_DAY50_PLOT4_FAMILY_J_E1_BAD_REMOVED$GROUP, data=VI_DAY50_PLOT4_FAMILY_J_E1_BAD_REMOVED)
summary(VI_DAY50_PLOT4_E1_AOV_FAMILY_J_BAD_REMOVED)
```

    ##                                              Df  Sum Sq  Mean Sq F value
    ## VI_DAY50_PLOT4_FAMILY_J_E1_BAD_REMOVED$GROUP  1 0.00002 0.000016   0.001
    ## Residuals                                     9 0.26492 0.029436        
    ##                                              Pr(>F)
    ## VI_DAY50_PLOT4_FAMILY_J_E1_BAD_REMOVED$GROUP  0.982
    ## Residuals

### FAMILY L

``` r
VI_DAY50_PLOT4_FAMILY_L_E1 <- VI_DAY50_PLOT4_E1_E3_GATE %>% filter(FAMILY=="L") %>% filter(GATE=="E1")
VI_DAY50_PLOT4_E1_AOV_FAMILY_L_E1 <- aov(VI_DAY50_PLOT4_FAMILY_L_E1$Arcsine ~ VI_DAY50_PLOT4_FAMILY_L_E1$GROUP, data=VI_DAY50_PLOT4_FAMILY_L_E1)
summary(VI_DAY50_PLOT4_E1_AOV_FAMILY_L_E1)
```

    ##                                  Df  Sum Sq  Mean Sq F value Pr(>F)
    ## VI_DAY50_PLOT4_FAMILY_L_E1$GROUP  1 0.00597 0.005968   0.386   0.55
    ## Residuals                         9 0.13928 0.015475

``` r
VI_DAY50_PLOT4_FAMILY_L_E1_BAD_REMOVED <- VI_DAY50_PLOT4_E1_E3_GATE_BAD_REMOVED %>% filter(FAMILY =="L") %>% filter(GATE=="E1")
VI_DAY50_PLOT4_E1_AOV_FAMILY_L_BAD_REMOVED <- aov(VI_DAY50_PLOT4_FAMILY_L_E1_BAD_REMOVED$Arcsine ~ VI_DAY50_PLOT4_FAMILY_L_E1_BAD_REMOVED$GROUP, data=VI_DAY50_PLOT4_FAMILY_L_E1_BAD_REMOVED)
summary(VI_DAY50_PLOT4_E1_AOV_FAMILY_L_BAD_REMOVED)
```

    ##                                              Df  Sum Sq  Mean Sq F value
    ## VI_DAY50_PLOT4_FAMILY_L_E1_BAD_REMOVED$GROUP  1 0.00597 0.005968   0.386
    ## Residuals                                     9 0.13928 0.015475        
    ##                                              Pr(>F)
    ## VI_DAY50_PLOT4_FAMILY_L_E1_BAD_REMOVED$GROUP   0.55
    ## Residuals

### Two Way ANOVA of Granular Hemocytes

``` r
VI_DAY50_PLOT4_E1_E3_GATE_E1 <- VI_DAY50_PLOT4_E1_E3_GATE %>% filter(GATE=="E1")
VI_DAY50_PLOT4_Granular_hemocytes_AOV <- lm(VI_DAY50_PLOT4_E1_E3_GATE_E1$Arcsine ~ VI_DAY50_PLOT4_E1_E3_GATE_E1$GROUP + VI_DAY50_PLOT4_E1_E3_GATE_E1$FAMILY, data=VI_DAY50_PLOT4_E1_E3_GATE_E1)
Anova(VI_DAY50_PLOT4_Granular_hemocytes_AOV, type="II")
```

    ## Anova Table (Type II tests)
    ## 
    ## Response: VI_DAY50_PLOT4_E1_E3_GATE_E1$Arcsine
    ##                                      Sum Sq Df F value Pr(>F)
    ## VI_DAY50_PLOT4_E1_E3_GATE_E1$GROUP  0.01379  1  0.7539 0.3880
    ## VI_DAY50_PLOT4_E1_E3_GATE_E1$FAMILY 0.03415  5  0.3734 0.8654
    ## Residuals                           1.37157 75

``` r
summary(VI_DAY50_PLOT4_Granular_hemocytes_AOV)
```

    ## 
    ## Call:
    ## lm(formula = VI_DAY50_PLOT4_E1_E3_GATE_E1$Arcsine ~ VI_DAY50_PLOT4_E1_E3_GATE_E1$GROUP + 
    ##     VI_DAY50_PLOT4_E1_E3_GATE_E1$FAMILY, data = VI_DAY50_PLOT4_E1_E3_GATE_E1)
    ## 
    ## Residuals:
    ##      Min       1Q   Median       3Q      Max 
    ## -0.23340 -0.08807 -0.03437  0.05618  0.42675 
    ## 
    ## Coefficients:
    ##                                              Estimate Std. Error t value
    ## (Intercept)                                  0.597934   0.042590  14.039
    ## VI_DAY50_PLOT4_E1_E3_GATE_E1$GROUPtreatment  0.027390   0.031544   0.868
    ## VI_DAY50_PLOT4_E1_E3_GATE_E1$FAMILYB        -0.013435   0.051162  -0.263
    ## VI_DAY50_PLOT4_E1_E3_GATE_E1$FAMILYD         0.009510   0.051162   0.186
    ## VI_DAY50_PLOT4_E1_E3_GATE_E1$FAMILYE        -0.026662   0.050276  -0.530
    ## VI_DAY50_PLOT4_E1_E3_GATE_E1$FAMILYJ         0.037071   0.051162   0.725
    ## VI_DAY50_PLOT4_E1_E3_GATE_E1$FAMILYL         0.008262   0.054542   0.151
    ##                                             Pr(>|t|)    
    ## (Intercept)                                   <2e-16 ***
    ## VI_DAY50_PLOT4_E1_E3_GATE_E1$GROUPtreatment    0.388    
    ## VI_DAY50_PLOT4_E1_E3_GATE_E1$FAMILYB           0.794    
    ## VI_DAY50_PLOT4_E1_E3_GATE_E1$FAMILYD           0.853    
    ## VI_DAY50_PLOT4_E1_E3_GATE_E1$FAMILYE           0.597    
    ## VI_DAY50_PLOT4_E1_E3_GATE_E1$FAMILYJ           0.471    
    ## VI_DAY50_PLOT4_E1_E3_GATE_E1$FAMILYL           0.880    
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
    ## 
    ## Residual standard error: 0.1352 on 75 degrees of freedom
    ## Multiple R-squared:  0.03334,    Adjusted R-squared:  -0.044 
    ## F-statistic: 0.4311 on 6 and 75 DF,  p-value: 0.856

``` r
VI_DAY50_PLOT4_E1_E3_GATE_E1_BAD_REMOVED <- VI_DAY50_PLOT4_E1_E3_GATE_BAD_REMOVED %>% filter(GATE=="E1")
VI_DAY50_PLOT4_Granular_hemocytes_AOV_BAD_REMOVED <- lm(VI_DAY50_PLOT4_E1_E3_GATE_E1_BAD_REMOVED$Arcsine ~ VI_DAY50_PLOT4_E1_E3_GATE_E1_BAD_REMOVED$GROUP +VI_DAY50_PLOT4_E1_E3_GATE_E1_BAD_REMOVED$FAMILY, data=VI_DAY50_PLOT4_E1_E3_GATE_E1_BAD_REMOVED)
Anova(VI_DAY50_PLOT4_Granular_hemocytes_AOV_BAD_REMOVED, type="II")
```

    ## Anova Table (Type II tests)
    ## 
    ## Response: VI_DAY50_PLOT4_E1_E3_GATE_E1_BAD_REMOVED$Arcsine
    ##                                                  Sum Sq Df F value Pr(>F)
    ## VI_DAY50_PLOT4_E1_E3_GATE_E1_BAD_REMOVED$GROUP  0.03319  1  2.1589 0.1464
    ## VI_DAY50_PLOT4_E1_E3_GATE_E1_BAD_REMOVED$FAMILY 0.02842  5  0.3698 0.8676
    ## Residuals                                       1.03006 67

``` r
summary(VI_DAY50_PLOT4_Granular_hemocytes_AOV_BAD_REMOVED)
```

    ## 
    ## Call:
    ## lm(formula = VI_DAY50_PLOT4_E1_E3_GATE_E1_BAD_REMOVED$Arcsine ~ 
    ##     VI_DAY50_PLOT4_E1_E3_GATE_E1_BAD_REMOVED$GROUP + VI_DAY50_PLOT4_E1_E3_GATE_E1_BAD_REMOVED$FAMILY, 
    ##     data = VI_DAY50_PLOT4_E1_E3_GATE_E1_BAD_REMOVED)
    ## 
    ## Residuals:
    ##      Min       1Q   Median       3Q      Max 
    ## -0.18965 -0.08873 -0.03039  0.05106  0.39962 
    ## 
    ## Coefficients:
    ##                                                          Estimate
    ## (Intercept)                                              0.584588
    ## VI_DAY50_PLOT4_E1_E3_GATE_E1_BAD_REMOVED$GROUPtreatment  0.046073
    ## VI_DAY50_PLOT4_E1_E3_GATE_E1_BAD_REMOVED$FAMILYB        -0.011967
    ## VI_DAY50_PLOT4_E1_E3_GATE_E1_BAD_REMOVED$FAMILYD         0.005789
    ## VI_DAY50_PLOT4_E1_E3_GATE_E1_BAD_REMOVED$FAMILYE        -0.037313
    ## VI_DAY50_PLOT4_E1_E3_GATE_E1_BAD_REMOVED$FAMILYJ         0.026082
    ## VI_DAY50_PLOT4_E1_E3_GATE_E1_BAD_REMOVED$FAMILYL         0.009718
    ##                                                         Std. Error t value
    ## (Intercept)                                               0.039998  14.616
    ## VI_DAY50_PLOT4_E1_E3_GATE_E1_BAD_REMOVED$GROUPtreatment   0.031357   1.469
    ## VI_DAY50_PLOT4_E1_E3_GATE_E1_BAD_REMOVED$FAMILYB          0.047858  -0.250
    ## VI_DAY50_PLOT4_E1_E3_GATE_E1_BAD_REMOVED$FAMILYD          0.048801   0.119
    ## VI_DAY50_PLOT4_E1_E3_GATE_E1_BAD_REMOVED$FAMILYE          0.047788  -0.781
    ## VI_DAY50_PLOT4_E1_E3_GATE_E1_BAD_REMOVED$FAMILYJ          0.049959   0.522
    ## VI_DAY50_PLOT4_E1_E3_GATE_E1_BAD_REMOVED$FAMILYL          0.050017   0.194
    ##                                                         Pr(>|t|)    
    ## (Intercept)                                               <2e-16 ***
    ## VI_DAY50_PLOT4_E1_E3_GATE_E1_BAD_REMOVED$GROUPtreatment    0.146    
    ## VI_DAY50_PLOT4_E1_E3_GATE_E1_BAD_REMOVED$FAMILYB           0.803    
    ## VI_DAY50_PLOT4_E1_E3_GATE_E1_BAD_REMOVED$FAMILYD           0.906    
    ## VI_DAY50_PLOT4_E1_E3_GATE_E1_BAD_REMOVED$FAMILYE           0.438    
    ## VI_DAY50_PLOT4_E1_E3_GATE_E1_BAD_REMOVED$FAMILYJ           0.603    
    ## VI_DAY50_PLOT4_E1_E3_GATE_E1_BAD_REMOVED$FAMILYL           0.847    
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
    ## 
    ## Residual standard error: 0.124 on 67 degrees of freedom
    ## Multiple R-squared:  0.05498,    Adjusted R-squared:  -0.02965 
    ## F-statistic: 0.6497 on 6 and 67 DF,  p-value: 0.6901

``` r
#NO significance, no interaction term added
```

### One Way ANOVA of Differences between Families

``` r
VI_DAY50_PLOT4_E1_E3_GATE_E1_BAD_REMOVED_CHALLENGE <- VI_DAY50_PLOT4_E1_E3_GATE_E1_BAD_REMOVED[!grepl("control", VI_DAY50_PLOT4_E1_E3_GATE_E1_BAD_REMOVED$GROUP),]
VI_DAY50_PLOT4_Granular_hemocytes_oneway_lm <- aov(VI_DAY50_PLOT4_E1_E3_GATE_E1_BAD_REMOVED_CHALLENGE$Arcsine ~ VI_DAY50_PLOT4_E1_E3_GATE_E1_BAD_REMOVED_CHALLENGE$FAMILY, data=VI_DAY50_PLOT4_E1_E3_GATE_E1_BAD_REMOVED_CHALLENGE)
summary(VI_DAY50_PLOT4_Granular_hemocytes_oneway_lm)
```

    ##                                                           Df Sum Sq
    ## VI_DAY50_PLOT4_E1_E3_GATE_E1_BAD_REMOVED_CHALLENGE$FAMILY  5 0.0271
    ## Residuals                                                 45 0.7585
    ##                                                            Mean Sq F value
    ## VI_DAY50_PLOT4_E1_E3_GATE_E1_BAD_REMOVED_CHALLENGE$FAMILY 0.005412   0.321
    ## Residuals                                                 0.016856        
    ##                                                           Pr(>F)
    ## VI_DAY50_PLOT4_E1_E3_GATE_E1_BAD_REMOVED_CHALLENGE$FAMILY  0.898
    ## Residuals

Percent of Agranular hemocytes (E3)
===================================

Percent Agranular Hemocytes out of all hemocytes
------------------------------------------------

### FAMILY A

``` r
VI_DAY50_PLOT4_E1_E3_GATE_E3 <- VI_DAY50_PLOT4_E1_E3_GATE %>% filter(GATE=="E3")
VI_DAY50_PLOT4_FAMILY_A_E3 <- VI_DAY50_PLOT4_E1_E3_GATE_E3 %>% filter(FAMILY=="A")
VI_DAY50_PLOT4_E3_AOV_FAMILY_A <- aov(VI_DAY50_PLOT4_FAMILY_A_E3$Arcsine ~ VI_DAY50_PLOT4_FAMILY_A_E3$GROUP, data=VI_DAY50_PLOT4_FAMILY_A_E3)
summary(VI_DAY50_PLOT4_E3_AOV_FAMILY_A)
```

    ##                                  Df  Sum Sq Mean Sq F value Pr(>F)
    ## VI_DAY50_PLOT4_FAMILY_A_E3$GROUP  1 0.02991 0.02991   1.855  0.198
    ## Residuals                        12 0.19351 0.01613

``` r
VI_DAY50_PLOT4_E1_E3_GATE_E3_BAD_REMOVED <- VI_DAY50_PLOT4_E1_E3_GATE_BAD_REMOVED %>% filter(GATE=="E3")
VI_DAY50_PLOT4_FAMILY_A_E3_BAD_REMOVED <- VI_DAY50_PLOT4_E1_E3_GATE_E3_BAD_REMOVED %>% filter(FAMILY =="A") 
VI_DAY50_PLOT4_E3_AOV_FAMILY_A_BAD_REMOVED <- aov(VI_DAY50_PLOT4_FAMILY_A_E3_BAD_REMOVED$Arcsine ~ VI_DAY50_PLOT4_FAMILY_A_E3_BAD_REMOVED$GROUP, data=VI_DAY50_PLOT4_FAMILY_A_E3_BAD_REMOVED)
summary(VI_DAY50_PLOT4_E3_AOV_FAMILY_A_BAD_REMOVED)
```

    ##                                              Df  Sum Sq Mean Sq F value
    ## VI_DAY50_PLOT4_FAMILY_A_E3_BAD_REMOVED$GROUP  1 0.02991 0.02991   1.855
    ## Residuals                                    12 0.19351 0.01613        
    ##                                              Pr(>F)
    ## VI_DAY50_PLOT4_FAMILY_A_E3_BAD_REMOVED$GROUP  0.198
    ## Residuals

### FAMILY B

    ##                                  Df  Sum Sq Mean Sq F value Pr(>F)
    ## VI_DAY50_PLOT4_FAMILY_B_E3$GROUP  1 0.02218 0.02218   1.567  0.235
    ## Residuals                        12 0.16988 0.01416

    ##                                              Df Sum Sq Mean Sq F value
    ## VI_DAY50_PLOT4_FAMILY_B_E3_BAD_REMOVED$GROUP  1 0.0219 0.02190   1.419
    ## Residuals                                    11 0.1698 0.01543        
    ##                                              Pr(>F)
    ## VI_DAY50_PLOT4_FAMILY_B_E3_BAD_REMOVED$GROUP  0.259
    ## Residuals

### FAMILY D

    ##                                  Df  Sum Sq  Mean Sq F value Pr(>F)
    ## VI_DAY50_PLOT4_FAMILY_D_E3$GROUP  1 0.00003 0.000026   0.004  0.951
    ## Residuals                        12 0.07681 0.006401

    ##                                              Df  Sum Sq  Mean Sq F value
    ## VI_DAY50_PLOT4_FAMILY_D_E3_BAD_REMOVED$GROUP  1 0.00030 0.000304   0.042
    ## Residuals                                    10 0.07232 0.007232        
    ##                                              Pr(>F)
    ## VI_DAY50_PLOT4_FAMILY_D_E3_BAD_REMOVED$GROUP  0.842
    ## Residuals

### FAMILY E

    ##                                  Df  Sum Sq  Mean Sq F value Pr(>F)
    ## VI_DAY50_PLOT4_FAMILY_E_E3$GROUP  1 0.00152 0.001524   0.078  0.784
    ## Residuals                        13 0.25251 0.019424

    ##                                              Df  Sum Sq  Mean Sq F value
    ## VI_DAY50_PLOT4_FAMILY_E_E3_BAD_REMOVED$GROUP  1 0.00007 0.000075   0.005
    ## Residuals                                    11 0.15528 0.014117        
    ##                                              Pr(>F)
    ## VI_DAY50_PLOT4_FAMILY_E_E3_BAD_REMOVED$GROUP  0.943
    ## Residuals

### FAMILY J

    ##                                  Df Sum Sq Mean Sq F value Pr(>F)
    ## VI_DAY50_PLOT4_FAMILY_J_E3$GROUP  1 0.0066 0.00661   0.156    0.7
    ## Residuals                        12 0.5091 0.04243

    ##                                              Df Sum Sq  Mean Sq F value
    ## VI_DAY50_PLOT4_FAMILY_J_E3_BAD_REMOVED$GROUP  1 0.0000 0.000003       0
    ## Residuals                                     9 0.2676 0.029739        
    ##                                              Pr(>F)
    ## VI_DAY50_PLOT4_FAMILY_J_E3_BAD_REMOVED$GROUP  0.992
    ## Residuals

### FAMILY L

    ##                                  Df  Sum Sq  Mean Sq F value Pr(>F)
    ## VI_DAY50_PLOT4_FAMILY_L_E3$GROUP  1 0.00629 0.006295   0.405   0.54
    ## Residuals                         9 0.13995 0.015550

    ##                                              Df  Sum Sq  Mean Sq F value
    ## VI_DAY50_PLOT4_FAMILY_L_E3_BAD_REMOVED$GROUP  1 0.00629 0.006295   0.405
    ## Residuals                                     9 0.13995 0.015550        
    ##                                              Pr(>F)
    ## VI_DAY50_PLOT4_FAMILY_L_E3_BAD_REMOVED$GROUP   0.54
    ## Residuals

### Two Way ANOVA of Agranular Hemocytes

    ## Anova Table (Type II tests)
    ## 
    ## Response: VI_DAY50_PLOT4_E1_E3_GATE_E3$Arcsine
    ##                                      Sum Sq Df F value Pr(>F)
    ## VI_DAY50_PLOT4_E1_E3_GATE_E3$GROUP  0.01150  1  0.6176 0.4344
    ## VI_DAY50_PLOT4_E1_E3_GATE_E3$FAMILY 0.03684  5  0.3957 0.8503
    ## Residuals                           1.39681 75

    ## 
    ## Call:
    ## lm(formula = VI_DAY50_PLOT4_E1_E3_GATE_E3$Arcsine ~ VI_DAY50_PLOT4_E1_E3_GATE_E3$GROUP + 
    ##     VI_DAY50_PLOT4_E1_E3_GATE_E3$FAMILY, data = VI_DAY50_PLOT4_E1_E3_GATE_E3)
    ## 
    ## Residuals:
    ##      Min       1Q   Median       3Q      Max 
    ## -0.44103 -0.07085  0.03660  0.09022  0.23443 
    ## 
    ## Coefficients:
    ##                                              Estimate Std. Error t value
    ## (Intercept)                                  0.971220   0.042980  22.597
    ## VI_DAY50_PLOT4_E1_E3_GATE_E3$GROUPtreatment -0.025016   0.031833  -0.786
    ## VI_DAY50_PLOT4_E1_E3_GATE_E3$FAMILYB         0.014089   0.051631   0.273
    ## VI_DAY50_PLOT4_E1_E3_GATE_E3$FAMILYD        -0.013637   0.051631  -0.264
    ## VI_DAY50_PLOT4_E1_E3_GATE_E3$FAMILYE         0.023385   0.050737   0.461
    ## VI_DAY50_PLOT4_E1_E3_GATE_E3$FAMILYJ        -0.041021   0.051631  -0.795
    ## VI_DAY50_PLOT4_E1_E3_GATE_E3$FAMILYL        -0.009343   0.055041  -0.170
    ##                                             Pr(>|t|)    
    ## (Intercept)                                   <2e-16 ***
    ## VI_DAY50_PLOT4_E1_E3_GATE_E3$GROUPtreatment    0.434    
    ## VI_DAY50_PLOT4_E1_E3_GATE_E3$FAMILYB           0.786    
    ## VI_DAY50_PLOT4_E1_E3_GATE_E3$FAMILYD           0.792    
    ## VI_DAY50_PLOT4_E1_E3_GATE_E3$FAMILYE           0.646    
    ## VI_DAY50_PLOT4_E1_E3_GATE_E3$FAMILYJ           0.429    
    ## VI_DAY50_PLOT4_E1_E3_GATE_E3$FAMILYL           0.866    
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
    ## 
    ## Residual standard error: 0.1365 on 75 degrees of freedom
    ## Multiple R-squared:  0.03302,    Adjusted R-squared:  -0.04434 
    ## F-statistic: 0.4268 on 6 and 75 DF,  p-value: 0.8589

    ## Anova Table (Type II tests)
    ## 
    ## Response: VI_DAY50_PLOT4_E1_E3_GATE_E3_BAD_REMOVED$Arcsine
    ##                                                  Sum Sq Df F value Pr(>F)
    ## VI_DAY50_PLOT4_E1_E3_GATE_E3_BAD_REMOVED$GROUP  0.03291  1  2.1534 0.1469
    ## VI_DAY50_PLOT4_E1_E3_GATE_E3_BAD_REMOVED$FAMILY 0.02926  5  0.3828 0.8589
    ## Residuals                                       1.02405 67

    ## 
    ## Call:
    ## lm(formula = VI_DAY50_PLOT4_E1_E3_GATE_E3_BAD_REMOVED$Arcsine ~ 
    ##     VI_DAY50_PLOT4_E1_E3_GATE_E3_BAD_REMOVED$GROUP + VI_DAY50_PLOT4_E1_E3_GATE_E3_BAD_REMOVED$FAMILY, 
    ##     data = VI_DAY50_PLOT4_E1_E3_GATE_E3_BAD_REMOVED)
    ## 
    ## Residuals:
    ##      Min       1Q   Median       3Q      Max 
    ## -0.40197 -0.04955  0.03222  0.08674  0.19279 
    ## 
    ## Coefficients:
    ##                                                         Estimate
    ## (Intercept)                                              0.98612
    ## VI_DAY50_PLOT4_E1_E3_GATE_E3_BAD_REMOVED$GROUPtreatment -0.04588
    ## VI_DAY50_PLOT4_E1_E3_GATE_E3_BAD_REMOVED$FAMILYB         0.01282
    ## VI_DAY50_PLOT4_E1_E3_GATE_E3_BAD_REMOVED$FAMILYD        -0.00819
    ## VI_DAY50_PLOT4_E1_E3_GATE_E3_BAD_REMOVED$FAMILYE         0.03554
    ## VI_DAY50_PLOT4_E1_E3_GATE_E3_BAD_REMOVED$FAMILYJ        -0.02818
    ## VI_DAY50_PLOT4_E1_E3_GATE_E3_BAD_REMOVED$FAMILYL        -0.01097
    ##                                                         Std. Error t value
    ## (Intercept)                                                0.03988  24.727
    ## VI_DAY50_PLOT4_E1_E3_GATE_E3_BAD_REMOVED$GROUPtreatment    0.03127  -1.467
    ## VI_DAY50_PLOT4_E1_E3_GATE_E3_BAD_REMOVED$FAMILYB           0.04772   0.269
    ## VI_DAY50_PLOT4_E1_E3_GATE_E3_BAD_REMOVED$FAMILYD           0.04866  -0.168
    ## VI_DAY50_PLOT4_E1_E3_GATE_E3_BAD_REMOVED$FAMILYE           0.04765   0.746
    ## VI_DAY50_PLOT4_E1_E3_GATE_E3_BAD_REMOVED$FAMILYJ           0.04981  -0.566
    ## VI_DAY50_PLOT4_E1_E3_GATE_E3_BAD_REMOVED$FAMILYL           0.04987  -0.220
    ##                                                         Pr(>|t|)    
    ## (Intercept)                                               <2e-16 ***
    ## VI_DAY50_PLOT4_E1_E3_GATE_E3_BAD_REMOVED$GROUPtreatment    0.147    
    ## VI_DAY50_PLOT4_E1_E3_GATE_E3_BAD_REMOVED$FAMILYB           0.789    
    ## VI_DAY50_PLOT4_E1_E3_GATE_E3_BAD_REMOVED$FAMILYD           0.867    
    ## VI_DAY50_PLOT4_E1_E3_GATE_E3_BAD_REMOVED$FAMILYE           0.458    
    ## VI_DAY50_PLOT4_E1_E3_GATE_E3_BAD_REMOVED$FAMILYJ           0.573    
    ## VI_DAY50_PLOT4_E1_E3_GATE_E3_BAD_REMOVED$FAMILYL           0.827    
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
    ## 
    ## Residual standard error: 0.1236 on 67 degrees of freedom
    ## Multiple R-squared:  0.05594,    Adjusted R-squared:  -0.0286 
    ## F-statistic: 0.6617 on 6 and 67 DF,  p-value: 0.6807

### One Way ANOVA of Differences between Families

``` r
VI_DAY50_PLOT4_E1_E3_GATE_E3_BAD_REMOVED_CHALLENGE <- VI_DAY50_PLOT4_E1_E3_GATE_E3_BAD_REMOVED[!grepl("control", VI_DAY50_PLOT4_E1_E3_GATE_E3_BAD_REMOVED$GROUP),]

VI_DAY50_PLOT4_Agranular_hemocytes_oneway_lm <- aov(VI_DAY50_PLOT4_E1_E3_GATE_E3_BAD_REMOVED_CHALLENGE$Arcsine ~ VI_DAY50_PLOT4_E1_E3_GATE_E3_BAD_REMOVED_CHALLENGE$FAMILY, data=VI_DAY50_PLOT4_E1_E3_GATE_E3_BAD_REMOVED_CHALLENGE)
summary(VI_DAY50_PLOT4_Agranular_hemocytes_oneway_lm)
```

    ##                                                           Df Sum Sq
    ## VI_DAY50_PLOT4_E1_E3_GATE_E3_BAD_REMOVED_CHALLENGE$FAMILY  5 0.0256
    ## Residuals                                                 45 0.7540
    ##                                                           Mean Sq F value
    ## VI_DAY50_PLOT4_E1_E3_GATE_E3_BAD_REMOVED_CHALLENGE$FAMILY 0.00512   0.306
    ## Residuals                                                 0.01676        
    ##                                                           Pr(>F)
    ## VI_DAY50_PLOT4_E1_E3_GATE_E3_BAD_REMOVED_CHALLENGE$FAMILY  0.907
    ## Residuals

Two Way ANOVA of Granular vs. Agranular
---------------------------------------

``` r
VI_DAY50_PLOT4_agranular_granular_lm <- lm(VI_DAY50_PLOT4_E1_E3_GATE$Arcsine ~ VI_DAY50_PLOT4_E1_E3_GATE$GATE + VI_DAY50_PLOT4_E1_E3_GATE$FAMILY, data=VI_DAY50_PLOT4_E1_E3_GATE)
Anova(VI_DAY50_PLOT4_agranular_granular_lm, type="II")
```

    ## Anova Table (Type II tests)
    ## 
    ## Response: VI_DAY50_PLOT4_E1_E3_GATE$Arcsine
    ##                                  Sum Sq  Df  F value Pr(>F)    
    ## VI_DAY50_PLOT4_E1_E3_GATE$GATE   4.5460   1 249.2723 <2e-16 ***
    ## VI_DAY50_PLOT4_E1_E3_GATE$FAMILY 0.0002   5   0.0017      1    
    ## Residuals                        2.8632 157                    
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

``` r
summary(VI_DAY50_PLOT4_agranular_granular_lm)
```

    ## 
    ## Call:
    ## lm(formula = VI_DAY50_PLOT4_E1_E3_GATE$Arcsine ~ VI_DAY50_PLOT4_E1_E3_GATE$GATE + 
    ##     VI_DAY50_PLOT4_E1_E3_GATE$FAMILY, data = VI_DAY50_PLOT4_E1_E3_GATE)
    ## 
    ## Residuals:
    ##      Min       1Q   Median       3Q      Max 
    ## -0.46069 -0.07265 -0.00205  0.07268  0.44488 
    ## 
    ## Coefficients:
    ##                                     Estimate Std. Error t value Pr(>|t|)
    ## (Intercept)                        0.6189329  0.0276139  22.414   <2e-16
    ## VI_DAY50_PLOT4_E1_E3_GATE$GATEE3   0.3329836  0.0210904  15.788   <2e-16
    ## VI_DAY50_PLOT4_E1_E3_GATE$FAMILYB  0.0002422  0.0360922   0.007    0.995
    ## VI_DAY50_PLOT4_E1_E3_GATE$FAMILYD -0.0021481  0.0360922  -0.060    0.953
    ## VI_DAY50_PLOT4_E1_E3_GATE$FAMILYE -0.0016953  0.0354856  -0.048    0.962
    ## VI_DAY50_PLOT4_E1_E3_GATE$FAMILYJ -0.0020598  0.0360922  -0.057    0.955
    ## VI_DAY50_PLOT4_E1_E3_GATE$FAMILYL -0.0006327  0.0384744  -0.016    0.987
    ##                                      
    ## (Intercept)                       ***
    ## VI_DAY50_PLOT4_E1_E3_GATE$GATEE3  ***
    ## VI_DAY50_PLOT4_E1_E3_GATE$FAMILYB    
    ## VI_DAY50_PLOT4_E1_E3_GATE$FAMILYD    
    ## VI_DAY50_PLOT4_E1_E3_GATE$FAMILYE    
    ## VI_DAY50_PLOT4_E1_E3_GATE$FAMILYJ    
    ## VI_DAY50_PLOT4_E1_E3_GATE$FAMILYL    
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
    ## 
    ## Residual standard error: 0.135 on 157 degrees of freedom
    ## Multiple R-squared:  0.6136, Adjusted R-squared:  0.5988 
    ## F-statistic: 41.55 on 6 and 157 DF,  p-value: < 2.2e-16

``` r
VI_DAY50_PLOT4_agranular_granular_BAD_REMOVED_lm <- lm(VI_DAY50_PLOT4_E1_E3_GATE_BAD_REMOVED$Arcsine ~ VI_DAY50_PLOT4_E1_E3_GATE_BAD_REMOVED$GATE + VI_DAY50_PLOT4_E1_E3_GATE_BAD_REMOVED$FAMILY, data=VI_DAY50_PLOT4_E1_E3_GATE_BAD_REMOVED)
Anova(VI_DAY50_PLOT4_agranular_granular_BAD_REMOVED_lm, type="II")
```

    ## Anova Table (Type II tests)
    ## 
    ## Response: VI_DAY50_PLOT4_E1_E3_GATE_BAD_REMOVED$Arcsine
    ##                                              Sum Sq  Df  F value Pr(>F)
    ## VI_DAY50_PLOT4_E1_E3_GATE_BAD_REMOVED$GATE   4.3253   1 280.4416 <2e-16
    ## VI_DAY50_PLOT4_E1_E3_GATE_BAD_REMOVED$FAMILY 0.0001   5   0.0007      1
    ## Residuals                                    2.1747 141                
    ##                                                 
    ## VI_DAY50_PLOT4_E1_E3_GATE_BAD_REMOVED$GATE   ***
    ## VI_DAY50_PLOT4_E1_E3_GATE_BAD_REMOVED$FAMILY    
    ## Residuals                                       
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

``` r
summary(VI_DAY50_PLOT4_agranular_granular_BAD_REMOVED_lm) # significance for GATE
```

    ## 
    ## Call:
    ## lm(formula = VI_DAY50_PLOT4_E1_E3_GATE_BAD_REMOVED$Arcsine ~ 
    ##     VI_DAY50_PLOT4_E1_E3_GATE_BAD_REMOVED$GATE + VI_DAY50_PLOT4_E1_E3_GATE_BAD_REMOVED$FAMILY, 
    ##     data = VI_DAY50_PLOT4_E1_E3_GATE_BAD_REMOVED)
    ## 
    ## Residuals:
    ##      Min       1Q   Median       3Q      Max 
    ## -0.44523 -0.07049 -0.00180  0.06978  0.44294 
    ## 
    ## Coefficients:
    ##                                                 Estimate Std. Error
    ## (Intercept)                                    0.6144713  0.0255937
    ## VI_DAY50_PLOT4_E1_E3_GATE_BAD_REMOVED$GATEE3   0.3419068  0.0204167
    ## VI_DAY50_PLOT4_E1_E3_GATE_BAD_REMOVED$FAMILYB  0.0004175  0.0338235
    ## VI_DAY50_PLOT4_E1_E3_GATE_BAD_REMOVED$FAMILYD -0.0012054  0.0345465
    ## VI_DAY50_PLOT4_E1_E3_GATE_BAD_REMOVED$FAMILYE -0.0008820  0.0338235
    ## VI_DAY50_PLOT4_E1_E3_GATE_BAD_REMOVED$FAMILYJ -0.0010472  0.0353820
    ## VI_DAY50_PLOT4_E1_E3_GATE_BAD_REMOVED$FAMILYL -0.0006327  0.0353820
    ##                                               t value Pr(>|t|)    
    ## (Intercept)                                    24.009   <2e-16 ***
    ## VI_DAY50_PLOT4_E1_E3_GATE_BAD_REMOVED$GATEE3   16.746   <2e-16 ***
    ## VI_DAY50_PLOT4_E1_E3_GATE_BAD_REMOVED$FAMILYB   0.012    0.990    
    ## VI_DAY50_PLOT4_E1_E3_GATE_BAD_REMOVED$FAMILYD  -0.035    0.972    
    ## VI_DAY50_PLOT4_E1_E3_GATE_BAD_REMOVED$FAMILYE  -0.026    0.979    
    ## VI_DAY50_PLOT4_E1_E3_GATE_BAD_REMOVED$FAMILYJ  -0.030    0.976    
    ## VI_DAY50_PLOT4_E1_E3_GATE_BAD_REMOVED$FAMILYL  -0.018    0.986    
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
    ## 
    ## Residual standard error: 0.1242 on 141 degrees of freedom
    ## Multiple R-squared:  0.6654, Adjusted R-squared:  0.6512 
    ## F-statistic: 46.74 on 6 and 141 DF,  p-value: < 2.2e-16

``` r
VI_DAY50_PLOT4_agranular_granular_lm_interaction_leastsquares <- lsmeans(VI_DAY50_PLOT4_agranular_granular_BAD_REMOVED_lm, "VI_DAY50_PLOT4_E1_E3_GATE_BAD_REMOVED$GATE", adjust="tukey")
cld(VI_DAY50_PLOT4_agranular_granular_lm_interaction_leastsquares, alpha=0.05, Letters=letters)
```

    ##  VI_DAY50_PLOT4_E1_E3_GATE_BAD_REMOVED$GATE    lsmean         SE  df
    ##  E1                                         0.6144713 0.02559375 141
    ##  E3                                         0.6144713 0.02559375 141
    ##   lower.CL  upper.CL .group
    ##  0.5638742 0.6650684  a    
    ##  0.5638742 0.6650684  a    
    ## 
    ## Results are averaged over the levels of: VI_DAY50_PLOT4_E1_E3_GATE_BAD_REMOVED$FAMILY 
    ## Confidence level used: 0.95 
    ## significance level used: alpha = 0.05

``` r
VI_DAY50_PLOT4_agranular_granular_BAD_REMOVED_lm_interaction <- lm(VI_DAY50_PLOT4_E1_E3_GATE_BAD_REMOVED$Arcsine ~ VI_DAY50_PLOT4_E1_E3_GATE_BAD_REMOVED$GATE + VI_DAY50_PLOT4_E1_E3_GATE_BAD_REMOVED$FAMILY + VI_DAY50_PLOT4_E1_E3_GATE_BAD_REMOVED$FAMILY:VI_DAY50_PLOT4_E1_E3_GATE_BAD_REMOVED$GATE, data=VI_DAY50_PLOT4_E1_E3_GATE_BAD_REMOVED)
Anova(VI_DAY50_PLOT4_agranular_granular_BAD_REMOVED_lm_interaction, type="II")
```

    ## Anova Table (Type II tests)
    ## 
    ## Response: VI_DAY50_PLOT4_E1_E3_GATE_BAD_REMOVED$Arcsine
    ##                                                                                         Sum Sq
    ## VI_DAY50_PLOT4_E1_E3_GATE_BAD_REMOVED$GATE                                              4.3253
    ## VI_DAY50_PLOT4_E1_E3_GATE_BAD_REMOVED$FAMILY                                            0.0001
    ## VI_DAY50_PLOT4_E1_E3_GATE_BAD_REMOVED$GATE:VI_DAY50_PLOT4_E1_E3_GATE_BAD_REMOVED$FAMILY 0.0545
    ## Residuals                                                                               2.1202
    ##                                                                                          Df
    ## VI_DAY50_PLOT4_E1_E3_GATE_BAD_REMOVED$GATE                                                1
    ## VI_DAY50_PLOT4_E1_E3_GATE_BAD_REMOVED$FAMILY                                              5
    ## VI_DAY50_PLOT4_E1_E3_GATE_BAD_REMOVED$GATE:VI_DAY50_PLOT4_E1_E3_GATE_BAD_REMOVED$FAMILY   5
    ## Residuals                                                                               136
    ##                                                                                          F value
    ## VI_DAY50_PLOT4_E1_E3_GATE_BAD_REMOVED$GATE                                              277.4446
    ## VI_DAY50_PLOT4_E1_E3_GATE_BAD_REMOVED$FAMILY                                              0.0007
    ## VI_DAY50_PLOT4_E1_E3_GATE_BAD_REMOVED$GATE:VI_DAY50_PLOT4_E1_E3_GATE_BAD_REMOVED$FAMILY   0.6986
    ## Residuals                                                                                       
    ##                                                                                         Pr(>F)
    ## VI_DAY50_PLOT4_E1_E3_GATE_BAD_REMOVED$GATE                                              <2e-16
    ## VI_DAY50_PLOT4_E1_E3_GATE_BAD_REMOVED$FAMILY                                            1.0000
    ## VI_DAY50_PLOT4_E1_E3_GATE_BAD_REMOVED$GATE:VI_DAY50_PLOT4_E1_E3_GATE_BAD_REMOVED$FAMILY 0.6254
    ## Residuals                                                                                     
    ##                                                                                            
    ## VI_DAY50_PLOT4_E1_E3_GATE_BAD_REMOVED$GATE                                              ***
    ## VI_DAY50_PLOT4_E1_E3_GATE_BAD_REMOVED$FAMILY                                               
    ## VI_DAY50_PLOT4_E1_E3_GATE_BAD_REMOVED$GATE:VI_DAY50_PLOT4_E1_E3_GATE_BAD_REMOVED$FAMILY    
    ## Residuals                                                                                  
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

``` r
summary(VI_DAY50_PLOT4_agranular_granular_BAD_REMOVED_lm_interaction)
```

    ## 
    ## Call:
    ## lm(formula = VI_DAY50_PLOT4_E1_E3_GATE_BAD_REMOVED$Arcsine ~ 
    ##     VI_DAY50_PLOT4_E1_E3_GATE_BAD_REMOVED$GATE + VI_DAY50_PLOT4_E1_E3_GATE_BAD_REMOVED$FAMILY + 
    ##         VI_DAY50_PLOT4_E1_E3_GATE_BAD_REMOVED$FAMILY:VI_DAY50_PLOT4_E1_E3_GATE_BAD_REMOVED$GATE, 
    ##     data = VI_DAY50_PLOT4_E1_E3_GATE_BAD_REMOVED)
    ## 
    ## Residuals:
    ##      Min       1Q   Median       3Q      Max 
    ## -0.41448 -0.07477  0.00047  0.07435  0.41219 
    ## 
    ## Coefficients:
    ##                                                                                             Estimate
    ## (Intercept)                                                                                 0.617498
    ## VI_DAY50_PLOT4_E1_E3_GATE_BAD_REMOVED$GATEE3                                                0.335854
    ## VI_DAY50_PLOT4_E1_E3_GATE_BAD_REMOVED$FAMILYB                                              -0.016524
    ## VI_DAY50_PLOT4_E1_E3_GATE_BAD_REMOVED$FAMILYD                                               0.003595
    ## VI_DAY50_PLOT4_E1_E3_GATE_BAD_REMOVED$FAMILYE                                              -0.034781
    ## VI_DAY50_PLOT4_E1_E3_GATE_BAD_REMOVED$FAMILYJ                                               0.026681
    ## VI_DAY50_PLOT4_E1_E3_GATE_BAD_REMOVED$FAMILYL                                               0.006128
    ## VI_DAY50_PLOT4_E1_E3_GATE_BAD_REMOVED$GATEE3:VI_DAY50_PLOT4_E1_E3_GATE_BAD_REMOVED$FAMILYB  0.033883
    ## VI_DAY50_PLOT4_E1_E3_GATE_BAD_REMOVED$GATEE3:VI_DAY50_PLOT4_E1_E3_GATE_BAD_REMOVED$FAMILYD -0.009600
    ## VI_DAY50_PLOT4_E1_E3_GATE_BAD_REMOVED$GATEE3:VI_DAY50_PLOT4_E1_E3_GATE_BAD_REMOVED$FAMILYE  0.067799
    ## VI_DAY50_PLOT4_E1_E3_GATE_BAD_REMOVED$GATEE3:VI_DAY50_PLOT4_E1_E3_GATE_BAD_REMOVED$FAMILYJ -0.055456
    ## VI_DAY50_PLOT4_E1_E3_GATE_BAD_REMOVED$GATEE3:VI_DAY50_PLOT4_E1_E3_GATE_BAD_REMOVED$FAMILYL -0.013521
    ##                                                                                            Std. Error
    ## (Intercept)                                                                                  0.033370
    ## VI_DAY50_PLOT4_E1_E3_GATE_BAD_REMOVED$GATEE3                                                 0.047192
    ## VI_DAY50_PLOT4_E1_E3_GATE_BAD_REMOVED$FAMILYB                                                0.048091
    ## VI_DAY50_PLOT4_E1_E3_GATE_BAD_REMOVED$FAMILYD                                                0.049119
    ## VI_DAY50_PLOT4_E1_E3_GATE_BAD_REMOVED$FAMILYE                                                0.048091
    ## VI_DAY50_PLOT4_E1_E3_GATE_BAD_REMOVED$FAMILYJ                                                0.050307
    ## VI_DAY50_PLOT4_E1_E3_GATE_BAD_REMOVED$FAMILYL                                                0.050307
    ## VI_DAY50_PLOT4_E1_E3_GATE_BAD_REMOVED$GATEE3:VI_DAY50_PLOT4_E1_E3_GATE_BAD_REMOVED$FAMILYB   0.068011
    ## VI_DAY50_PLOT4_E1_E3_GATE_BAD_REMOVED$GATEE3:VI_DAY50_PLOT4_E1_E3_GATE_BAD_REMOVED$FAMILYD   0.069465
    ## VI_DAY50_PLOT4_E1_E3_GATE_BAD_REMOVED$GATEE3:VI_DAY50_PLOT4_E1_E3_GATE_BAD_REMOVED$FAMILYE   0.068011
    ## VI_DAY50_PLOT4_E1_E3_GATE_BAD_REMOVED$GATEE3:VI_DAY50_PLOT4_E1_E3_GATE_BAD_REMOVED$FAMILYJ   0.071145
    ## VI_DAY50_PLOT4_E1_E3_GATE_BAD_REMOVED$GATEE3:VI_DAY50_PLOT4_E1_E3_GATE_BAD_REMOVED$FAMILYL   0.071145
    ##                                                                                            t value
    ## (Intercept)                                                                                 18.505
    ## VI_DAY50_PLOT4_E1_E3_GATE_BAD_REMOVED$GATEE3                                                 7.117
    ## VI_DAY50_PLOT4_E1_E3_GATE_BAD_REMOVED$FAMILYB                                               -0.344
    ## VI_DAY50_PLOT4_E1_E3_GATE_BAD_REMOVED$FAMILYD                                                0.073
    ## VI_DAY50_PLOT4_E1_E3_GATE_BAD_REMOVED$FAMILYE                                               -0.723
    ## VI_DAY50_PLOT4_E1_E3_GATE_BAD_REMOVED$FAMILYJ                                                0.530
    ## VI_DAY50_PLOT4_E1_E3_GATE_BAD_REMOVED$FAMILYL                                                0.122
    ## VI_DAY50_PLOT4_E1_E3_GATE_BAD_REMOVED$GATEE3:VI_DAY50_PLOT4_E1_E3_GATE_BAD_REMOVED$FAMILYB   0.498
    ## VI_DAY50_PLOT4_E1_E3_GATE_BAD_REMOVED$GATEE3:VI_DAY50_PLOT4_E1_E3_GATE_BAD_REMOVED$FAMILYD  -0.138
    ## VI_DAY50_PLOT4_E1_E3_GATE_BAD_REMOVED$GATEE3:VI_DAY50_PLOT4_E1_E3_GATE_BAD_REMOVED$FAMILYE   0.997
    ## VI_DAY50_PLOT4_E1_E3_GATE_BAD_REMOVED$GATEE3:VI_DAY50_PLOT4_E1_E3_GATE_BAD_REMOVED$FAMILYJ  -0.779
    ## VI_DAY50_PLOT4_E1_E3_GATE_BAD_REMOVED$GATEE3:VI_DAY50_PLOT4_E1_E3_GATE_BAD_REMOVED$FAMILYL  -0.190
    ##                                                                                            Pr(>|t|)
    ## (Intercept)                                                                                 < 2e-16
    ## VI_DAY50_PLOT4_E1_E3_GATE_BAD_REMOVED$GATEE3                                               5.76e-11
    ## VI_DAY50_PLOT4_E1_E3_GATE_BAD_REMOVED$FAMILYB                                                 0.732
    ## VI_DAY50_PLOT4_E1_E3_GATE_BAD_REMOVED$FAMILYD                                                 0.942
    ## VI_DAY50_PLOT4_E1_E3_GATE_BAD_REMOVED$FAMILYE                                                 0.471
    ## VI_DAY50_PLOT4_E1_E3_GATE_BAD_REMOVED$FAMILYJ                                                 0.597
    ## VI_DAY50_PLOT4_E1_E3_GATE_BAD_REMOVED$FAMILYL                                                 0.903
    ## VI_DAY50_PLOT4_E1_E3_GATE_BAD_REMOVED$GATEE3:VI_DAY50_PLOT4_E1_E3_GATE_BAD_REMOVED$FAMILYB    0.619
    ## VI_DAY50_PLOT4_E1_E3_GATE_BAD_REMOVED$GATEE3:VI_DAY50_PLOT4_E1_E3_GATE_BAD_REMOVED$FAMILYD    0.890
    ## VI_DAY50_PLOT4_E1_E3_GATE_BAD_REMOVED$GATEE3:VI_DAY50_PLOT4_E1_E3_GATE_BAD_REMOVED$FAMILYE    0.321
    ## VI_DAY50_PLOT4_E1_E3_GATE_BAD_REMOVED$GATEE3:VI_DAY50_PLOT4_E1_E3_GATE_BAD_REMOVED$FAMILYJ    0.437
    ## VI_DAY50_PLOT4_E1_E3_GATE_BAD_REMOVED$GATEE3:VI_DAY50_PLOT4_E1_E3_GATE_BAD_REMOVED$FAMILYL    0.850
    ##                                                                                               
    ## (Intercept)                                                                                ***
    ## VI_DAY50_PLOT4_E1_E3_GATE_BAD_REMOVED$GATEE3                                               ***
    ## VI_DAY50_PLOT4_E1_E3_GATE_BAD_REMOVED$FAMILYB                                                 
    ## VI_DAY50_PLOT4_E1_E3_GATE_BAD_REMOVED$FAMILYD                                                 
    ## VI_DAY50_PLOT4_E1_E3_GATE_BAD_REMOVED$FAMILYE                                                 
    ## VI_DAY50_PLOT4_E1_E3_GATE_BAD_REMOVED$FAMILYJ                                                 
    ## VI_DAY50_PLOT4_E1_E3_GATE_BAD_REMOVED$FAMILYL                                                 
    ## VI_DAY50_PLOT4_E1_E3_GATE_BAD_REMOVED$GATEE3:VI_DAY50_PLOT4_E1_E3_GATE_BAD_REMOVED$FAMILYB    
    ## VI_DAY50_PLOT4_E1_E3_GATE_BAD_REMOVED$GATEE3:VI_DAY50_PLOT4_E1_E3_GATE_BAD_REMOVED$FAMILYD    
    ## VI_DAY50_PLOT4_E1_E3_GATE_BAD_REMOVED$GATEE3:VI_DAY50_PLOT4_E1_E3_GATE_BAD_REMOVED$FAMILYE    
    ## VI_DAY50_PLOT4_E1_E3_GATE_BAD_REMOVED$GATEE3:VI_DAY50_PLOT4_E1_E3_GATE_BAD_REMOVED$FAMILYJ    
    ## VI_DAY50_PLOT4_E1_E3_GATE_BAD_REMOVED$GATEE3:VI_DAY50_PLOT4_E1_E3_GATE_BAD_REMOVED$FAMILYL    
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
    ## 
    ## Residual standard error: 0.1249 on 136 degrees of freedom
    ## Multiple R-squared:  0.6738, Adjusted R-squared:  0.6474 
    ## F-statistic: 25.54 on 11 and 136 DF,  p-value: < 2.2e-16

Plotting of Live Granular and Agranular Hemocytes
-------------------------------------------------

``` r
VI_DAY50_PLOT10_E3_MINUS_V1R_BAD_REMOVED$GATE <- "agranular"
VI_DAY50_PLOT9_E1_MINUS_V1R_BAD_REMOVED$GATE<- "granular"

VI_DAY50_PLOT9_E1_MINUS_V1R_PLOT10_combined_BAD_REMOVED <- rbind(VI_DAY50_PLOT10_E3_MINUS_V1R_BAD_REMOVED,VI_DAY50_PLOT9_E1_MINUS_V1R_BAD_REMOVED)

ggplot(VI_DAY50_PLOT9_E1_MINUS_V1R_PLOT10_combined_BAD_REMOVED, aes(x=GROUP, y=PERCENT_LIVE, fill=GATE)) + geom_boxplot() + ggtitle("Percent Live Granular and Agranular Hemocytes (low quality removed)") + ylab("Percent of Hemocyte Events in each quad plot")+ scale_fill_manual(name="Hemocyte Type", labels=c("Agranular Hemocytes", "Granular Hemocytes"), values=c("agranular"="#99a765","granular"="#96578a")) + facet_grid(.~FAMILY+GROUP, scales="free") 
```

![](Dermo_Viability_Assay_Data_analysis_files/figure-markdown_github/day50_plotting_live-1.png)

### Percent Live Granular Hemocytes

### FAMILY A

    ##                                            Df  Sum Sq Mean Sq F value
    ## VI_DAY50_PLOT9_E1_MINUS_V1R_FAMILY_A$GROUP  1 0.04616 0.04616   3.516
    ## Residuals                                  12 0.15755 0.01313        
    ##                                            Pr(>F)  
    ## VI_DAY50_PLOT9_E1_MINUS_V1R_FAMILY_A$GROUP 0.0853 .
    ## Residuals                                          
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

    ##                                                        Df  Sum Sq Mean Sq
    ## VI_DAY50_PLOT9_E1_MINUS_V1R_FAMILY_A_BAD_REMOVED$GROUP  1 0.04616 0.04616
    ## Residuals                                              12 0.15755 0.01313
    ##                                                        F value Pr(>F)  
    ## VI_DAY50_PLOT9_E1_MINUS_V1R_FAMILY_A_BAD_REMOVED$GROUP   3.516 0.0853 .
    ## Residuals                                                              
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

### FAMILY B

    ##                                            Df  Sum Sq  Mean Sq F value
    ## VI_DAY50_PLOT9_E1_MINUS_V1R_FAMILY_B$GROUP  1 0.00290 0.002900   1.032
    ## Residuals                                  12 0.03371 0.002809        
    ##                                            Pr(>F)
    ## VI_DAY50_PLOT9_E1_MINUS_V1R_FAMILY_B$GROUP   0.33
    ## Residuals

    ##                                                        Df   Sum Sq
    ## VI_DAY50_PLOT9_E1_MINUS_V1R_FAMILY_B_BAD_REMOVED$GROUP  1 0.004699
    ## Residuals                                              11 0.027818
    ##                                                         Mean Sq F value
    ## VI_DAY50_PLOT9_E1_MINUS_V1R_FAMILY_B_BAD_REMOVED$GROUP 0.004699   1.858
    ## Residuals                                              0.002529        
    ##                                                        Pr(>F)
    ## VI_DAY50_PLOT9_E1_MINUS_V1R_FAMILY_B_BAD_REMOVED$GROUP    0.2
    ## Residuals

### FAMILY D

    ##                                            Df  Sum Sq  Mean Sq F value
    ## VI_DAY50_PLOT9_E1_MINUS_V1R_FAMILY_D$GROUP  1 0.00367 0.003669   0.468
    ## Residuals                                  12 0.09416 0.007847        
    ##                                            Pr(>F)
    ## VI_DAY50_PLOT9_E1_MINUS_V1R_FAMILY_D$GROUP  0.507
    ## Residuals

    ##                                                        Df  Sum Sq  Mean Sq
    ## VI_DAY50_PLOT9_E1_MINUS_V1R_FAMILY_D_BAD_REMOVED$GROUP  1 0.00588 0.005882
    ## Residuals                                              10 0.08546 0.008546
    ##                                                        F value Pr(>F)
    ## VI_DAY50_PLOT9_E1_MINUS_V1R_FAMILY_D_BAD_REMOVED$GROUP   0.688  0.426
    ## Residuals

### FAMILY E

    ##                                            Df  Sum Sq  Mean Sq F value
    ## VI_DAY50_PLOT9_E1_MINUS_V1R_FAMILY_E$GROUP  1 0.00962 0.009618   0.706
    ## Residuals                                  13 0.17716 0.013628        
    ##                                            Pr(>F)
    ## VI_DAY50_PLOT9_E1_MINUS_V1R_FAMILY_E$GROUP  0.416
    ## Residuals

    ##                                                        Df Sum Sq  Mean Sq
    ## VI_DAY50_PLOT9_E1_MINUS_V1R_FAMILY_E_BAD_REMOVED$GROUP  1 0.0059 0.005898
    ## Residuals                                              11 0.1139 0.010356
    ##                                                        F value Pr(>F)
    ## VI_DAY50_PLOT9_E1_MINUS_V1R_FAMILY_E_BAD_REMOVED$GROUP    0.57  0.466
    ## Residuals

### FAMILY J

    ##                                            Df Sum Sq Mean Sq F value
    ## VI_DAY50_PLOT9_E1_MINUS_V1R_FAMILY_J$GROUP  1 0.0575 0.05753   1.098
    ## Residuals                                  12 0.6289 0.05241        
    ##                                            Pr(>F)
    ## VI_DAY50_PLOT9_E1_MINUS_V1R_FAMILY_J$GROUP  0.315
    ## Residuals

    ##                                                        Df  Sum Sq  Mean Sq
    ## VI_DAY50_PLOT9_E1_MINUS_V1R_FAMILY_J_BAD_REMOVED$GROUP  1 0.00017 0.000174
    ## Residuals                                               9 0.03587 0.003986
    ##                                                        F value Pr(>F)
    ## VI_DAY50_PLOT9_E1_MINUS_V1R_FAMILY_J_BAD_REMOVED$GROUP   0.044  0.839
    ## Residuals

### FAMILY L

    ##                                            Df  Sum Sq  Mean Sq F value
    ## VI_DAY50_PLOT9_E1_MINUS_V1R_FAMILY_L$GROUP  1 0.00331 0.003309   0.768
    ## Residuals                                   9 0.03879 0.004310        
    ##                                            Pr(>F)
    ## VI_DAY50_PLOT9_E1_MINUS_V1R_FAMILY_L$GROUP  0.404
    ## Residuals

    ##                                                        Df  Sum Sq  Mean Sq
    ## VI_DAY50_PLOT9_E1_MINUS_V1R_FAMILY_L_BAD_REMOVED$GROUP  1 0.00331 0.003309
    ## Residuals                                               9 0.03879 0.004310
    ##                                                        F value Pr(>F)
    ## VI_DAY50_PLOT9_E1_MINUS_V1R_FAMILY_L_BAD_REMOVED$GROUP   0.768  0.404
    ## Residuals

### Two Way ANOVA of LIVE Granular Hemocytes

    ## Anova Table (Type II tests)
    ## 
    ## Response: VI_DAY50_PLOT9_E1_MINUS_V1R$Arcsine
    ##                                     Sum Sq Df F value  Pr(>F)  
    ## VI_DAY50_PLOT9_E1_MINUS_V1R$GROUP  0.02880  1  1.7636 0.18821  
    ## VI_DAY50_PLOT9_E1_MINUS_V1R$FAMILY 0.16953  5  2.0765 0.07768 .
    ## Residuals                          1.22463 75                  
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

    ## 
    ## Call:
    ## lm(formula = VI_DAY50_PLOT9_E1_MINUS_V1R$Arcsine ~ VI_DAY50_PLOT9_E1_MINUS_V1R$GROUP + 
    ##     VI_DAY50_PLOT9_E1_MINUS_V1R$FAMILY, data = VI_DAY50_PLOT9_E1_MINUS_V1R)
    ## 
    ## Residuals:
    ##      Min       1Q   Median       3Q      Max 
    ## -0.74403 -0.05291  0.01865  0.05546  0.24466 
    ## 
    ## Coefficients:
    ##                                             Estimate Std. Error t value
    ## (Intercept)                                 1.278253   0.040244  31.762
    ## VI_DAY50_PLOT9_E1_MINUS_V1R$GROUPtreatment  0.039583   0.029807   1.328
    ## VI_DAY50_PLOT9_E1_MINUS_V1R$FAMILYB         0.113861   0.048344   2.355
    ## VI_DAY50_PLOT9_E1_MINUS_V1R$FAMILYD         0.009261   0.048344   0.192
    ## VI_DAY50_PLOT9_E1_MINUS_V1R$FAMILYE         0.047887   0.047507   1.008
    ## VI_DAY50_PLOT9_E1_MINUS_V1R$FAMILYJ        -0.028161   0.048344  -0.583
    ## VI_DAY50_PLOT9_E1_MINUS_V1R$FAMILYL         0.035476   0.051538   0.688
    ##                                            Pr(>|t|)    
    ## (Intercept)                                  <2e-16 ***
    ## VI_DAY50_PLOT9_E1_MINUS_V1R$GROUPtreatment   0.1882    
    ## VI_DAY50_PLOT9_E1_MINUS_V1R$FAMILYB          0.0211 *  
    ## VI_DAY50_PLOT9_E1_MINUS_V1R$FAMILYD          0.8486    
    ## VI_DAY50_PLOT9_E1_MINUS_V1R$FAMILYE          0.3167    
    ## VI_DAY50_PLOT9_E1_MINUS_V1R$FAMILYJ          0.5620    
    ## VI_DAY50_PLOT9_E1_MINUS_V1R$FAMILYL          0.4934    
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
    ## 
    ## Residual standard error: 0.1278 on 75 degrees of freedom
    ## Multiple R-squared:  0.1383, Adjusted R-squared:  0.06938 
    ## F-statistic: 2.007 on 6 and 75 DF,  p-value: 0.07525

    ## Anova Table (Type II tests)
    ## 
    ## Response: VI_DAY50_PLOT9_E1_MINUS_V1R_BAD_REMOVED$Arcsine
    ##                                                 Sum Sq Df F value  Pr(>F)
    ## VI_DAY50_PLOT9_E1_MINUS_V1R_BAD_REMOVED$GROUP  0.00927  1  1.2031 0.27664
    ## VI_DAY50_PLOT9_E1_MINUS_V1R_BAD_REMOVED$FAMILY 0.11131  5  2.8892 0.02017
    ## Residuals                                      0.51627 67                
    ##                                                 
    ## VI_DAY50_PLOT9_E1_MINUS_V1R_BAD_REMOVED$GROUP   
    ## VI_DAY50_PLOT9_E1_MINUS_V1R_BAD_REMOVED$FAMILY *
    ## Residuals                                       
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

    ## 
    ## Call:
    ## lm(formula = VI_DAY50_PLOT9_E1_MINUS_V1R_BAD_REMOVED$Arcsine ~ 
    ##     VI_DAY50_PLOT9_E1_MINUS_V1R_BAD_REMOVED$GROUP + VI_DAY50_PLOT9_E1_MINUS_V1R_BAD_REMOVED$FAMILY, 
    ##     data = VI_DAY50_PLOT9_E1_MINUS_V1R_BAD_REMOVED)
    ## 
    ## Residuals:
    ##      Min       1Q   Median       3Q      Max 
    ## -0.23337 -0.04586  0.01489  0.05457  0.16888 
    ## 
    ## Coefficients:
    ##                                                        Estimate Std. Error
    ## (Intercept)                                             1.28913    0.02832
    ## VI_DAY50_PLOT9_E1_MINUS_V1R_BAD_REMOVED$GROUPtreatment  0.02435    0.02220
    ## VI_DAY50_PLOT9_E1_MINUS_V1R_BAD_REMOVED$FAMILYB         0.11818    0.03388
    ## VI_DAY50_PLOT9_E1_MINUS_V1R_BAD_REMOVED$FAMILYD         0.01493    0.03455
    ## VI_DAY50_PLOT9_E1_MINUS_V1R_BAD_REMOVED$FAMILYE         0.03843    0.03383
    ## VI_DAY50_PLOT9_E1_MINUS_V1R_BAD_REMOVED$FAMILYJ         0.02626    0.03537
    ## VI_DAY50_PLOT9_E1_MINUS_V1R_BAD_REMOVED$FAMILYL         0.03429    0.03541
    ##                                                        t value Pr(>|t|)
    ## (Intercept)                                             45.526  < 2e-16
    ## VI_DAY50_PLOT9_E1_MINUS_V1R_BAD_REMOVED$GROUPtreatment   1.097 0.276639
    ## VI_DAY50_PLOT9_E1_MINUS_V1R_BAD_REMOVED$FAMILYB          3.488 0.000864
    ## VI_DAY50_PLOT9_E1_MINUS_V1R_BAD_REMOVED$FAMILYD          0.432 0.666958
    ## VI_DAY50_PLOT9_E1_MINUS_V1R_BAD_REMOVED$FAMILYE          1.136 0.260092
    ## VI_DAY50_PLOT9_E1_MINUS_V1R_BAD_REMOVED$FAMILYJ          0.742 0.460400
    ## VI_DAY50_PLOT9_E1_MINUS_V1R_BAD_REMOVED$FAMILYL          0.968 0.336358
    ##                                                           
    ## (Intercept)                                            ***
    ## VI_DAY50_PLOT9_E1_MINUS_V1R_BAD_REMOVED$GROUPtreatment    
    ## VI_DAY50_PLOT9_E1_MINUS_V1R_BAD_REMOVED$FAMILYB        ***
    ## VI_DAY50_PLOT9_E1_MINUS_V1R_BAD_REMOVED$FAMILYD           
    ## VI_DAY50_PLOT9_E1_MINUS_V1R_BAD_REMOVED$FAMILYE           
    ## VI_DAY50_PLOT9_E1_MINUS_V1R_BAD_REMOVED$FAMILYJ           
    ## VI_DAY50_PLOT9_E1_MINUS_V1R_BAD_REMOVED$FAMILYL           
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
    ## 
    ## Residual standard error: 0.08778 on 67 degrees of freedom
    ## Multiple R-squared:  0.1847, Adjusted R-squared:  0.1117 
    ## F-statistic:  2.53 on 6 and 67 DF,  p-value: 0.02875

    ##  VI_DAY50_PLOT9_E1_MINUS_V1R_BAD_REMOVED$FAMILY   lsmean         SE df
    ##  A                                              1.289134 0.02831666 67
    ##  B                                              1.289134 0.02831666 67
    ##  D                                              1.313483 0.02430280 67
    ##  E                                              1.313483 0.02430280 67
    ##  J                                              1.313483 0.02430280 67
    ##  L                                              1.313483 0.02430280 67
    ##  lower.CL upper.CL .group
    ##  1.232614 1.345654  a    
    ##  1.232614 1.345654  a    
    ##  1.264975 1.361992   b   
    ##  1.264975 1.361992   b   
    ##  1.264975 1.361992   b   
    ##  1.264975 1.361992   b   
    ## 
    ## Results are averaged over the levels of: VI_DAY50_PLOT9_E1_MINUS_V1R_BAD_REMOVED$GROUP 
    ## Confidence level used: 0.95 
    ## P value adjustment: tukey method for comparing a family of 6 estimates 
    ## significance level used: alpha = 5

    ## Anova Table (Type II tests)
    ## 
    ## Response: VI_DAY50_PLOT9_E1_MINUS_V1R_BAD_REMOVED$Arcsine
    ##                                                                                               Sum Sq
    ## VI_DAY50_PLOT9_E1_MINUS_V1R_BAD_REMOVED$GROUP                                                0.00927
    ## VI_DAY50_PLOT9_E1_MINUS_V1R_BAD_REMOVED$FAMILY                                               0.11131
    ## VI_DAY50_PLOT9_E1_MINUS_V1R_BAD_REMOVED$GROUP:VI_DAY50_PLOT9_E1_MINUS_V1R_BAD_REMOVED$FAMILY 0.05686
    ## Residuals                                                                                    0.45942
    ##                                                                                              Df
    ## VI_DAY50_PLOT9_E1_MINUS_V1R_BAD_REMOVED$GROUP                                                 1
    ## VI_DAY50_PLOT9_E1_MINUS_V1R_BAD_REMOVED$FAMILY                                                5
    ## VI_DAY50_PLOT9_E1_MINUS_V1R_BAD_REMOVED$GROUP:VI_DAY50_PLOT9_E1_MINUS_V1R_BAD_REMOVED$FAMILY  5
    ## Residuals                                                                                    62
    ##                                                                                              F value
    ## VI_DAY50_PLOT9_E1_MINUS_V1R_BAD_REMOVED$GROUP                                                 1.2510
    ## VI_DAY50_PLOT9_E1_MINUS_V1R_BAD_REMOVED$FAMILY                                                3.0044
    ## VI_DAY50_PLOT9_E1_MINUS_V1R_BAD_REMOVED$GROUP:VI_DAY50_PLOT9_E1_MINUS_V1R_BAD_REMOVED$FAMILY  1.5346
    ## Residuals                                                                                           
    ##                                                                                               Pr(>F)
    ## VI_DAY50_PLOT9_E1_MINUS_V1R_BAD_REMOVED$GROUP                                                0.26767
    ## VI_DAY50_PLOT9_E1_MINUS_V1R_BAD_REMOVED$FAMILY                                               0.01715
    ## VI_DAY50_PLOT9_E1_MINUS_V1R_BAD_REMOVED$GROUP:VI_DAY50_PLOT9_E1_MINUS_V1R_BAD_REMOVED$FAMILY 0.19218
    ## Residuals                                                                                           
    ##                                                                                               
    ## VI_DAY50_PLOT9_E1_MINUS_V1R_BAD_REMOVED$GROUP                                                 
    ## VI_DAY50_PLOT9_E1_MINUS_V1R_BAD_REMOVED$FAMILY                                               *
    ## VI_DAY50_PLOT9_E1_MINUS_V1R_BAD_REMOVED$GROUP:VI_DAY50_PLOT9_E1_MINUS_V1R_BAD_REMOVED$FAMILY  
    ## Residuals                                                                                     
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

    ## 
    ## Call:
    ## lm(formula = VI_DAY50_PLOT9_E1_MINUS_V1R_BAD_REMOVED$Arcsine ~ 
    ##     VI_DAY50_PLOT9_E1_MINUS_V1R_BAD_REMOVED$GROUP + VI_DAY50_PLOT9_E1_MINUS_V1R_BAD_REMOVED$FAMILY, 
    ##     data = VI_DAY50_PLOT9_E1_MINUS_V1R_BAD_REMOVED)
    ## 
    ## Residuals:
    ##      Min       1Q   Median       3Q      Max 
    ## -0.23337 -0.04586  0.01489  0.05457  0.16888 
    ## 
    ## Coefficients:
    ##                                                        Estimate Std. Error
    ## (Intercept)                                             1.28913    0.02832
    ## VI_DAY50_PLOT9_E1_MINUS_V1R_BAD_REMOVED$GROUPtreatment  0.02435    0.02220
    ## VI_DAY50_PLOT9_E1_MINUS_V1R_BAD_REMOVED$FAMILYB         0.11818    0.03388
    ## VI_DAY50_PLOT9_E1_MINUS_V1R_BAD_REMOVED$FAMILYD         0.01493    0.03455
    ## VI_DAY50_PLOT9_E1_MINUS_V1R_BAD_REMOVED$FAMILYE         0.03843    0.03383
    ## VI_DAY50_PLOT9_E1_MINUS_V1R_BAD_REMOVED$FAMILYJ         0.02626    0.03537
    ## VI_DAY50_PLOT9_E1_MINUS_V1R_BAD_REMOVED$FAMILYL         0.03429    0.03541
    ##                                                        t value Pr(>|t|)
    ## (Intercept)                                             45.526  < 2e-16
    ## VI_DAY50_PLOT9_E1_MINUS_V1R_BAD_REMOVED$GROUPtreatment   1.097 0.276639
    ## VI_DAY50_PLOT9_E1_MINUS_V1R_BAD_REMOVED$FAMILYB          3.488 0.000864
    ## VI_DAY50_PLOT9_E1_MINUS_V1R_BAD_REMOVED$FAMILYD          0.432 0.666958
    ## VI_DAY50_PLOT9_E1_MINUS_V1R_BAD_REMOVED$FAMILYE          1.136 0.260092
    ## VI_DAY50_PLOT9_E1_MINUS_V1R_BAD_REMOVED$FAMILYJ          0.742 0.460400
    ## VI_DAY50_PLOT9_E1_MINUS_V1R_BAD_REMOVED$FAMILYL          0.968 0.336358
    ##                                                           
    ## (Intercept)                                            ***
    ## VI_DAY50_PLOT9_E1_MINUS_V1R_BAD_REMOVED$GROUPtreatment    
    ## VI_DAY50_PLOT9_E1_MINUS_V1R_BAD_REMOVED$FAMILYB        ***
    ## VI_DAY50_PLOT9_E1_MINUS_V1R_BAD_REMOVED$FAMILYD           
    ## VI_DAY50_PLOT9_E1_MINUS_V1R_BAD_REMOVED$FAMILYE           
    ## VI_DAY50_PLOT9_E1_MINUS_V1R_BAD_REMOVED$FAMILYJ           
    ## VI_DAY50_PLOT9_E1_MINUS_V1R_BAD_REMOVED$FAMILYL           
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
    ## 
    ## Residual standard error: 0.08778 on 67 degrees of freedom
    ## Multiple R-squared:  0.1847, Adjusted R-squared:  0.1117 
    ## F-statistic:  2.53 on 6 and 67 DF,  p-value: 0.02875

    ##  VI_DAY50_PLOT9_E1_MINUS_V1R_BAD_REMOVED$FAMILY   lsmean         SE df
    ##  A                                              1.215734 0.04304051 62
    ##  B                                              1.215734 0.04304051 62
    ##  D                                              1.342843 0.02722121 62
    ##  E                                              1.342843 0.02722121 62
    ##  J                                              1.342843 0.02722121 62
    ##  L                                              1.342843 0.02722121 62
    ##  lower.CL upper.CL .group
    ##  1.129697 1.301771  a    
    ##  1.129697 1.301771  a    
    ##  1.288429 1.397258   b   
    ##  1.288429 1.397258   b   
    ##  1.288429 1.397258   b   
    ##  1.288429 1.397258   b   
    ## 
    ## Results are averaged over the levels of: VI_DAY50_PLOT9_E1_MINUS_V1R_BAD_REMOVED$GROUP 
    ## Confidence level used: 0.95 
    ## P value adjustment: tukey method for comparing a family of 6 estimates 
    ## significance level used: alpha = 5

### One Way ANOVA of Differences between Families

``` r
VI_DAY50_PLOT9_V1R_BAD_REMOVED_CHALLENGE <- VI_DAY50_PLOT9_E1_MINUS_V1R_BAD_REMOVED[!grepl("control", VI_DAY50_PLOT9_E1_MINUS_V1R_BAD_REMOVED$GROUP),]

VI_DAY50_PLOT9_Granular_hemocytes_oneway_lm <- aov(VI_DAY50_PLOT9_V1R_BAD_REMOVED_CHALLENGE$Arcsine ~ VI_DAY50_PLOT9_V1R_BAD_REMOVED_CHALLENGE$FAMILY, data=VI_DAY50_PLOT9_V1R_BAD_REMOVED_CHALLENGE)
summary(VI_DAY50_PLOT9_Granular_hemocytes_oneway_lm)
```

    ##                                                 Df  Sum Sq  Mean Sq
    ## VI_DAY50_PLOT9_V1R_BAD_REMOVED_CHALLENGE$FAMILY  5 0.07253 0.014506
    ## Residuals                                       45 0.31204 0.006934
    ##                                                 F value Pr(>F)  
    ## VI_DAY50_PLOT9_V1R_BAD_REMOVED_CHALLENGE$FAMILY   2.092 0.0839 .
    ## Residuals                                                       
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

### Live Agranular Hemocytes

### FAMILY A

    ##                                             Df   Sum Sq   Mean Sq F value
    ## VI_DAY50_PLOT10_E3_MINUS_V1R_FAMILY_A$GROUP  1 0.001998 0.0019983   6.708
    ## Residuals                                   12 0.003575 0.0002979        
    ##                                             Pr(>F)  
    ## VI_DAY50_PLOT10_E3_MINUS_V1R_FAMILY_A$GROUP 0.0237 *
    ## Residuals                                           
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

    ##                                                         Df   Sum Sq
    ## VI_DAY50_PLOT10_E3_MINUS_V1R_FAMILY_A_BAD_REMOVED$GROUP  1 0.001998
    ## Residuals                                               12 0.003575
    ##                                                           Mean Sq F value
    ## VI_DAY50_PLOT10_E3_MINUS_V1R_FAMILY_A_BAD_REMOVED$GROUP 0.0019983   6.708
    ## Residuals                                               0.0002979        
    ##                                                         Pr(>F)  
    ## VI_DAY50_PLOT10_E3_MINUS_V1R_FAMILY_A_BAD_REMOVED$GROUP 0.0237 *
    ## Residuals                                                       
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

### FAMILY B

    ##                                             Df    Sum Sq   Mean Sq F value
    ## VI_DAY50_PLOT10_E3_MINUS_V1R_FAMILY_B$GROUP  1 0.0004902 0.0004902   3.221
    ## Residuals                                   12 0.0018261 0.0001522        
    ##                                             Pr(>F)  
    ## VI_DAY50_PLOT10_E3_MINUS_V1R_FAMILY_B$GROUP 0.0979 .
    ## Residuals                                           
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

    ##                                                         Df    Sum Sq
    ## VI_DAY50_PLOT10_E3_MINUS_V1R_FAMILY_B_BAD_REMOVED$GROUP  1 0.0002935
    ## Residuals                                               11 0.0013458
    ##                                                           Mean Sq F value
    ## VI_DAY50_PLOT10_E3_MINUS_V1R_FAMILY_B_BAD_REMOVED$GROUP 0.0002935   2.399
    ## Residuals                                               0.0001223        
    ##                                                         Pr(>F)
    ## VI_DAY50_PLOT10_E3_MINUS_V1R_FAMILY_B_BAD_REMOVED$GROUP   0.15
    ## Residuals

### FAMILY D

    ##                                             Df   Sum Sq   Mean Sq F value
    ## VI_DAY50_PLOT10_E3_MINUS_V1R_FAMILY_D$GROUP  1 0.000298 0.0002977   0.687
    ## Residuals                                   12 0.005202 0.0004335        
    ##                                             Pr(>F)
    ## VI_DAY50_PLOT10_E3_MINUS_V1R_FAMILY_D$GROUP  0.423
    ## Residuals

    ##                                                         Df   Sum Sq
    ## VI_DAY50_PLOT10_E3_MINUS_V1R_FAMILY_D_BAD_REMOVED$GROUP  1 0.000000
    ## Residuals                                               10 0.003777
    ##                                                           Mean Sq F value
    ## VI_DAY50_PLOT10_E3_MINUS_V1R_FAMILY_D_BAD_REMOVED$GROUP 0.0000004   0.001
    ## Residuals                                               0.0003777        
    ##                                                         Pr(>F)
    ## VI_DAY50_PLOT10_E3_MINUS_V1R_FAMILY_D_BAD_REMOVED$GROUP  0.973
    ## Residuals

### FAMILY E

    ##                                             Df   Sum Sq  Mean Sq F value
    ## VI_DAY50_PLOT10_E3_MINUS_V1R_FAMILY_E$GROUP  1 0.001808 0.001808   1.715
    ## Residuals                                   13 0.013706 0.001054        
    ##                                             Pr(>F)
    ## VI_DAY50_PLOT10_E3_MINUS_V1R_FAMILY_E$GROUP  0.213
    ## Residuals

    ##                                                         Df   Sum Sq
    ## VI_DAY50_PLOT10_E3_MINUS_V1R_FAMILY_E_BAD_REMOVED$GROUP  1 0.001468
    ## Residuals                                               11 0.011334
    ##                                                          Mean Sq F value
    ## VI_DAY50_PLOT10_E3_MINUS_V1R_FAMILY_E_BAD_REMOVED$GROUP 0.001468   1.425
    ## Residuals                                               0.001030        
    ##                                                         Pr(>F)
    ## VI_DAY50_PLOT10_E3_MINUS_V1R_FAMILY_E_BAD_REMOVED$GROUP  0.258
    ## Residuals

### FAMILY J

    ##                                             Df  Sum Sq  Mean Sq F value
    ## VI_DAY50_PLOT10_E3_MINUS_V1R_FAMILY_J$GROUP  1 0.01036 0.010356   1.918
    ## Residuals                                   12 0.06478 0.005399        
    ##                                             Pr(>F)
    ## VI_DAY50_PLOT10_E3_MINUS_V1R_FAMILY_J$GROUP  0.191
    ## Residuals

    ##                                                         Df    Sum Sq
    ## VI_DAY50_PLOT10_E3_MINUS_V1R_FAMILY_J_BAD_REMOVED$GROUP  1 0.0003305
    ## Residuals                                                9 0.0008407
    ##                                                           Mean Sq F value
    ## VI_DAY50_PLOT10_E3_MINUS_V1R_FAMILY_J_BAD_REMOVED$GROUP 0.0003305   3.538
    ## Residuals                                               0.0000934        
    ##                                                         Pr(>F)  
    ## VI_DAY50_PLOT10_E3_MINUS_V1R_FAMILY_J_BAD_REMOVED$GROUP 0.0927 .
    ## Residuals                                                       
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

### FAMILY L

    ##                                             Df   Sum Sq   Mean Sq F value
    ## VI_DAY50_PLOT10_E3_MINUS_V1R_FAMILY_L$GROUP  1 0.000044 0.0000444   0.122
    ## Residuals                                    9 0.003288 0.0003653        
    ##                                             Pr(>F)
    ## VI_DAY50_PLOT10_E3_MINUS_V1R_FAMILY_L$GROUP  0.735
    ## Residuals

    ##                                                         Df   Sum Sq
    ## VI_DAY50_PLOT10_E3_MINUS_V1R_FAMILY_L_BAD_REMOVED$GROUP  1 0.000044
    ## Residuals                                                9 0.003288
    ##                                                           Mean Sq F value
    ## VI_DAY50_PLOT10_E3_MINUS_V1R_FAMILY_L_BAD_REMOVED$GROUP 0.0000444   0.122
    ## Residuals                                               0.0003653        
    ##                                                         Pr(>F)
    ## VI_DAY50_PLOT10_E3_MINUS_V1R_FAMILY_L_BAD_REMOVED$GROUP  0.735
    ## Residuals

### Two Way ANOVA of LIVE Agranular Hemocytes

    ## Anova Table (Type II tests)
    ## 
    ## Response: VI_DAY50_PLOT10_E3_MINUS_V1R$Arcsine
    ##                                      Sum Sq Df F value Pr(>F)
    ## VI_DAY50_PLOT9_E1_MINUS_V1R$GROUP  0.002171  1   1.548 0.2173
    ## VI_DAY50_PLOT9_E1_MINUS_V1R$FAMILY 0.006712  5   0.957 0.4497
    ## Residuals                          0.105204 75

    ## 
    ## Call:
    ## lm(formula = VI_DAY50_PLOT10_E3_MINUS_V1R$Arcsine ~ VI_DAY50_PLOT9_E1_MINUS_V1R$GROUP + 
    ##     VI_DAY50_PLOT9_E1_MINUS_V1R$FAMILY, data = VI_DAY50_PLOT9_E1_MINUS_V1R)
    ## 
    ## Residuals:
    ##       Min        1Q    Median        3Q       Max 
    ## -0.251553 -0.008941  0.002128  0.014238  0.054109 
    ## 
    ## Coefficients:
    ##                                             Estimate Std. Error t value
    ## (Intercept)                                 1.521660   0.011796 129.003
    ## VI_DAY50_PLOT9_E1_MINUS_V1R$GROUPtreatment  0.010870   0.008736   1.244
    ## VI_DAY50_PLOT9_E1_MINUS_V1R$FAMILYB         0.017076   0.014170   1.205
    ## VI_DAY50_PLOT9_E1_MINUS_V1R$FAMILYD         0.003032   0.014170   0.214
    ## VI_DAY50_PLOT9_E1_MINUS_V1R$FAMILYE        -0.004973   0.013924  -0.357
    ## VI_DAY50_PLOT9_E1_MINUS_V1R$FAMILYJ        -0.011505   0.014170  -0.812
    ## VI_DAY50_PLOT9_E1_MINUS_V1R$FAMILYL        -0.005032   0.015106  -0.333
    ##                                            Pr(>|t|)    
    ## (Intercept)                                  <2e-16 ***
    ## VI_DAY50_PLOT9_E1_MINUS_V1R$GROUPtreatment    0.217    
    ## VI_DAY50_PLOT9_E1_MINUS_V1R$FAMILYB           0.232    
    ## VI_DAY50_PLOT9_E1_MINUS_V1R$FAMILYD           0.831    
    ## VI_DAY50_PLOT9_E1_MINUS_V1R$FAMILYE           0.722    
    ## VI_DAY50_PLOT9_E1_MINUS_V1R$FAMILYJ           0.419    
    ## VI_DAY50_PLOT9_E1_MINUS_V1R$FAMILYL           0.740    
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
    ## 
    ## Residual standard error: 0.03745 on 75 degrees of freedom
    ## Multiple R-squared:  0.0777, Adjusted R-squared:  0.003918 
    ## F-statistic: 1.053 on 6 and 75 DF,  p-value: 0.3984

    ## Anova Table (Type II tests)
    ## 
    ## Response: VI_DAY50_PLOT10_E3_MINUS_V1R_BAD_REMOVED$Arcsine
    ##                                                    Sum Sq Df F value
    ## VI_DAY50_PLOT10_E3_MINUS_V1R_BAD_REMOVED$GROUP  0.0000579  1  0.1374
    ## VI_DAY50_PLOT10_E3_MINUS_V1R_BAD_REMOVED$FAMILY 0.0042481  5  2.0160
    ## Residuals                                       0.0282371 67        
    ##                                                  Pr(>F)  
    ## VI_DAY50_PLOT10_E3_MINUS_V1R_BAD_REMOVED$GROUP  0.71203  
    ## VI_DAY50_PLOT10_E3_MINUS_V1R_BAD_REMOVED$FAMILY 0.08753 .
    ## Residuals                                                
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

    ## 
    ## Call:
    ## lm(formula = VI_DAY50_PLOT10_E3_MINUS_V1R_BAD_REMOVED$Arcsine ~ 
    ##     VI_DAY50_PLOT10_E3_MINUS_V1R_BAD_REMOVED$GROUP + VI_DAY50_PLOT10_E3_MINUS_V1R_BAD_REMOVED$FAMILY, 
    ##     data = VI_DAY50_PLOT10_E3_MINUS_V1R_BAD_REMOVED)
    ## 
    ## Residuals:
    ##       Min        1Q    Median        3Q       Max 
    ## -0.072228 -0.008396  0.001522  0.012232  0.048361 
    ## 
    ## Coefficients:
    ##                                                           Estimate
    ## (Intercept)                                              1.528e+00
    ## VI_DAY50_PLOT10_E3_MINUS_V1R_BAD_REMOVED$GROUPtreatment  1.925e-03
    ## VI_DAY50_PLOT10_E3_MINUS_V1R_BAD_REMOVED$FAMILYB         1.456e-02
    ## VI_DAY50_PLOT10_E3_MINUS_V1R_BAD_REMOVED$FAMILYD         2.795e-05
    ## VI_DAY50_PLOT10_E3_MINUS_V1R_BAD_REMOVED$FAMILYE        -7.539e-03
    ## VI_DAY50_PLOT10_E3_MINUS_V1R_BAD_REMOVED$FAMILYJ         7.150e-03
    ## VI_DAY50_PLOT10_E3_MINUS_V1R_BAD_REMOVED$FAMILYL        -5.729e-03
    ##                                                         Std. Error t value
    ## (Intercept)                                              6.622e-03 230.741
    ## VI_DAY50_PLOT10_E3_MINUS_V1R_BAD_REMOVED$GROUPtreatment  5.192e-03   0.371
    ## VI_DAY50_PLOT10_E3_MINUS_V1R_BAD_REMOVED$FAMILYB         7.924e-03   1.838
    ## VI_DAY50_PLOT10_E3_MINUS_V1R_BAD_REMOVED$FAMILYD         8.080e-03   0.003
    ## VI_DAY50_PLOT10_E3_MINUS_V1R_BAD_REMOVED$FAMILYE         7.912e-03  -0.953
    ## VI_DAY50_PLOT10_E3_MINUS_V1R_BAD_REMOVED$FAMILYJ         8.272e-03   0.864
    ## VI_DAY50_PLOT10_E3_MINUS_V1R_BAD_REMOVED$FAMILYL         8.281e-03  -0.692
    ##                                                         Pr(>|t|)    
    ## (Intercept)                                               <2e-16 ***
    ## VI_DAY50_PLOT10_E3_MINUS_V1R_BAD_REMOVED$GROUPtreatment   0.7120    
    ## VI_DAY50_PLOT10_E3_MINUS_V1R_BAD_REMOVED$FAMILYB          0.0705 .  
    ## VI_DAY50_PLOT10_E3_MINUS_V1R_BAD_REMOVED$FAMILYD          0.9972    
    ## VI_DAY50_PLOT10_E3_MINUS_V1R_BAD_REMOVED$FAMILYE          0.3441    
    ## VI_DAY50_PLOT10_E3_MINUS_V1R_BAD_REMOVED$FAMILYJ          0.3904    
    ## VI_DAY50_PLOT10_E3_MINUS_V1R_BAD_REMOVED$FAMILYL          0.4914    
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
    ## 
    ## Residual standard error: 0.02053 on 67 degrees of freedom
    ## Multiple R-squared:  0.1312, Adjusted R-squared:  0.05334 
    ## F-statistic: 1.686 on 6 and 67 DF,  p-value: 0.1381

    ## Anova Table (Type II tests)
    ## 
    ## Response: VI_DAY50_PLOT10_E3_MINUS_V1R_BAD_REMOVED$Arcsine
    ##                                                                                                   Sum Sq
    ## VI_DAY50_PLOT10_E3_MINUS_V1R_BAD_REMOVED$GROUP                                                 0.0000579
    ## VI_DAY50_PLOT10_E3_MINUS_V1R_BAD_REMOVED$FAMILY                                                0.0042481
    ## VI_DAY50_PLOT10_E3_MINUS_V1R_BAD_REMOVED$GROUP:VI_DAY50_PLOT10_E3_MINUS_V1R_BAD_REMOVED$FAMILY 0.0040771
    ## Residuals                                                                                      0.0241600
    ##                                                                                                Df
    ## VI_DAY50_PLOT10_E3_MINUS_V1R_BAD_REMOVED$GROUP                                                  1
    ## VI_DAY50_PLOT10_E3_MINUS_V1R_BAD_REMOVED$FAMILY                                                 5
    ## VI_DAY50_PLOT10_E3_MINUS_V1R_BAD_REMOVED$GROUP:VI_DAY50_PLOT10_E3_MINUS_V1R_BAD_REMOVED$FAMILY  5
    ## Residuals                                                                                      62
    ##                                                                                                F value
    ## VI_DAY50_PLOT10_E3_MINUS_V1R_BAD_REMOVED$GROUP                                                  0.1486
    ## VI_DAY50_PLOT10_E3_MINUS_V1R_BAD_REMOVED$FAMILY                                                 2.1803
    ## VI_DAY50_PLOT10_E3_MINUS_V1R_BAD_REMOVED$GROUP:VI_DAY50_PLOT10_E3_MINUS_V1R_BAD_REMOVED$FAMILY  2.0925
    ## Residuals                                                                                             
    ##                                                                                                 Pr(>F)
    ## VI_DAY50_PLOT10_E3_MINUS_V1R_BAD_REMOVED$GROUP                                                 0.70117
    ## VI_DAY50_PLOT10_E3_MINUS_V1R_BAD_REMOVED$FAMILY                                                0.06768
    ## VI_DAY50_PLOT10_E3_MINUS_V1R_BAD_REMOVED$GROUP:VI_DAY50_PLOT10_E3_MINUS_V1R_BAD_REMOVED$FAMILY 0.07821
    ## Residuals                                                                                             
    ##                                                                                                 
    ## VI_DAY50_PLOT10_E3_MINUS_V1R_BAD_REMOVED$GROUP                                                  
    ## VI_DAY50_PLOT10_E3_MINUS_V1R_BAD_REMOVED$FAMILY                                                .
    ## VI_DAY50_PLOT10_E3_MINUS_V1R_BAD_REMOVED$GROUP:VI_DAY50_PLOT10_E3_MINUS_V1R_BAD_REMOVED$FAMILY .
    ## Residuals                                                                                       
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

    ## 
    ## Call:
    ## lm(formula = VI_DAY50_PLOT10_E3_MINUS_V1R_BAD_REMOVED$Arcsine ~ 
    ##     VI_DAY50_PLOT10_E3_MINUS_V1R_BAD_REMOVED$GROUP + VI_DAY50_PLOT10_E3_MINUS_V1R_BAD_REMOVED$FAMILY + 
    ##         VI_DAY50_PLOT10_E3_MINUS_V1R_BAD_REMOVED$FAMILY:VI_DAY50_PLOT10_E3_MINUS_V1R_BAD_REMOVED$GROUP, 
    ##     data = VI_DAY50_PLOT10_E3_MINUS_V1R_BAD_REMOVED)
    ## 
    ## Residuals:
    ##       Min        1Q    Median        3Q       Max 
    ## -0.065964 -0.008823  0.001200  0.011576  0.054626 
    ## 
    ## Coefficients:
    ##                                                                                                          Estimate
    ## (Intercept)                                                                                               1.51053
    ## VI_DAY50_PLOT10_E3_MINUS_V1R_BAD_REMOVED$GROUPtreatment                                                   0.02645
    ## VI_DAY50_PLOT10_E3_MINUS_V1R_BAD_REMOVED$FAMILYB                                                          0.02725
    ## VI_DAY50_PLOT10_E3_MINUS_V1R_BAD_REMOVED$FAMILYD                                                          0.01910
    ## VI_DAY50_PLOT10_E3_MINUS_V1R_BAD_REMOVED$FAMILYE                                                          0.03086
    ## VI_DAY50_PLOT10_E3_MINUS_V1R_BAD_REMOVED$FAMILYJ                                                          0.03502
    ## VI_DAY50_PLOT10_E3_MINUS_V1R_BAD_REMOVED$FAMILYL                                                          0.01035
    ## VI_DAY50_PLOT10_E3_MINUS_V1R_BAD_REMOVED$GROUPtreatment:VI_DAY50_PLOT10_E3_MINUS_V1R_BAD_REMOVED$FAMILYB -0.01668
    ## VI_DAY50_PLOT10_E3_MINUS_V1R_BAD_REMOVED$GROUPtreatment:VI_DAY50_PLOT10_E3_MINUS_V1R_BAD_REMOVED$FAMILYD -0.02686
    ## VI_DAY50_PLOT10_E3_MINUS_V1R_BAD_REMOVED$GROUPtreatment:VI_DAY50_PLOT10_E3_MINUS_V1R_BAD_REMOVED$FAMILYE -0.05167
    ## VI_DAY50_PLOT10_E3_MINUS_V1R_BAD_REMOVED$GROUPtreatment:VI_DAY50_PLOT10_E3_MINUS_V1R_BAD_REMOVED$FAMILYJ -0.03875
    ## VI_DAY50_PLOT10_E3_MINUS_V1R_BAD_REMOVED$GROUPtreatment:VI_DAY50_PLOT10_E3_MINUS_V1R_BAD_REMOVED$FAMILYL -0.02227
    ##                                                                                                          Std. Error
    ## (Intercept)                                                                                                 0.00987
    ## VI_DAY50_PLOT10_E3_MINUS_V1R_BAD_REMOVED$GROUPtreatment                                                     0.01168
    ## VI_DAY50_PLOT10_E3_MINUS_V1R_BAD_REMOVED$FAMILYB                                                            0.01324
    ## VI_DAY50_PLOT10_E3_MINUS_V1R_BAD_REMOVED$FAMILYD                                                            0.01396
    ## VI_DAY50_PLOT10_E3_MINUS_V1R_BAD_REMOVED$FAMILYE                                                            0.01508
    ## VI_DAY50_PLOT10_E3_MINUS_V1R_BAD_REMOVED$FAMILYJ                                                            0.01508
    ## VI_DAY50_PLOT10_E3_MINUS_V1R_BAD_REMOVED$FAMILYL                                                            0.01396
    ## VI_DAY50_PLOT10_E3_MINUS_V1R_BAD_REMOVED$GROUPtreatment:VI_DAY50_PLOT10_E3_MINUS_V1R_BAD_REMOVED$FAMILYB    0.01622
    ## VI_DAY50_PLOT10_E3_MINUS_V1R_BAD_REMOVED$GROUPtreatment:VI_DAY50_PLOT10_E3_MINUS_V1R_BAD_REMOVED$FAMILYD    0.01681
    ## VI_DAY50_PLOT10_E3_MINUS_V1R_BAD_REMOVED$GROUPtreatment:VI_DAY50_PLOT10_E3_MINUS_V1R_BAD_REMOVED$FAMILYE    0.01747
    ## VI_DAY50_PLOT10_E3_MINUS_V1R_BAD_REMOVED$GROUPtreatment:VI_DAY50_PLOT10_E3_MINUS_V1R_BAD_REMOVED$FAMILYJ    0.01775
    ## VI_DAY50_PLOT10_E3_MINUS_V1R_BAD_REMOVED$GROUPtreatment:VI_DAY50_PLOT10_E3_MINUS_V1R_BAD_REMOVED$FAMILYL    0.01701
    ##                                                                                                          t value
    ## (Intercept)                                                                                              153.041
    ## VI_DAY50_PLOT10_E3_MINUS_V1R_BAD_REMOVED$GROUPtreatment                                                    2.265
    ## VI_DAY50_PLOT10_E3_MINUS_V1R_BAD_REMOVED$FAMILYB                                                           2.058
    ## VI_DAY50_PLOT10_E3_MINUS_V1R_BAD_REMOVED$FAMILYD                                                           1.368
    ## VI_DAY50_PLOT10_E3_MINUS_V1R_BAD_REMOVED$FAMILYE                                                           2.047
    ## VI_DAY50_PLOT10_E3_MINUS_V1R_BAD_REMOVED$FAMILYJ                                                           2.323
    ## VI_DAY50_PLOT10_E3_MINUS_V1R_BAD_REMOVED$FAMILYL                                                           0.742
    ## VI_DAY50_PLOT10_E3_MINUS_V1R_BAD_REMOVED$GROUPtreatment:VI_DAY50_PLOT10_E3_MINUS_V1R_BAD_REMOVED$FAMILYB  -1.028
    ## VI_DAY50_PLOT10_E3_MINUS_V1R_BAD_REMOVED$GROUPtreatment:VI_DAY50_PLOT10_E3_MINUS_V1R_BAD_REMOVED$FAMILYD  -1.598
    ## VI_DAY50_PLOT10_E3_MINUS_V1R_BAD_REMOVED$GROUPtreatment:VI_DAY50_PLOT10_E3_MINUS_V1R_BAD_REMOVED$FAMILYE  -2.957
    ## VI_DAY50_PLOT10_E3_MINUS_V1R_BAD_REMOVED$GROUPtreatment:VI_DAY50_PLOT10_E3_MINUS_V1R_BAD_REMOVED$FAMILYJ  -2.184
    ## VI_DAY50_PLOT10_E3_MINUS_V1R_BAD_REMOVED$GROUPtreatment:VI_DAY50_PLOT10_E3_MINUS_V1R_BAD_REMOVED$FAMILYL  -1.309
    ##                                                                                                          Pr(>|t|)
    ## (Intercept)                                                                                               < 2e-16
    ## VI_DAY50_PLOT10_E3_MINUS_V1R_BAD_REMOVED$GROUPtreatment                                                   0.02705
    ## VI_DAY50_PLOT10_E3_MINUS_V1R_BAD_REMOVED$FAMILYB                                                          0.04381
    ## VI_DAY50_PLOT10_E3_MINUS_V1R_BAD_REMOVED$FAMILYD                                                          0.17614
    ## VI_DAY50_PLOT10_E3_MINUS_V1R_BAD_REMOVED$FAMILYE                                                          0.04494
    ## VI_DAY50_PLOT10_E3_MINUS_V1R_BAD_REMOVED$FAMILYJ                                                          0.02350
    ## VI_DAY50_PLOT10_E3_MINUS_V1R_BAD_REMOVED$FAMILYL                                                          0.46107
    ## VI_DAY50_PLOT10_E3_MINUS_V1R_BAD_REMOVED$GROUPtreatment:VI_DAY50_PLOT10_E3_MINUS_V1R_BAD_REMOVED$FAMILYB  0.30772
    ## VI_DAY50_PLOT10_E3_MINUS_V1R_BAD_REMOVED$GROUPtreatment:VI_DAY50_PLOT10_E3_MINUS_V1R_BAD_REMOVED$FAMILYD  0.11516
    ## VI_DAY50_PLOT10_E3_MINUS_V1R_BAD_REMOVED$GROUPtreatment:VI_DAY50_PLOT10_E3_MINUS_V1R_BAD_REMOVED$FAMILYE  0.00439
    ## VI_DAY50_PLOT10_E3_MINUS_V1R_BAD_REMOVED$GROUPtreatment:VI_DAY50_PLOT10_E3_MINUS_V1R_BAD_REMOVED$FAMILYJ  0.03279
    ## VI_DAY50_PLOT10_E3_MINUS_V1R_BAD_REMOVED$GROUPtreatment:VI_DAY50_PLOT10_E3_MINUS_V1R_BAD_REMOVED$FAMILYL  0.19540
    ##                                                                                                             
    ## (Intercept)                                                                                              ***
    ## VI_DAY50_PLOT10_E3_MINUS_V1R_BAD_REMOVED$GROUPtreatment                                                  *  
    ## VI_DAY50_PLOT10_E3_MINUS_V1R_BAD_REMOVED$FAMILYB                                                         *  
    ## VI_DAY50_PLOT10_E3_MINUS_V1R_BAD_REMOVED$FAMILYD                                                            
    ## VI_DAY50_PLOT10_E3_MINUS_V1R_BAD_REMOVED$FAMILYE                                                         *  
    ## VI_DAY50_PLOT10_E3_MINUS_V1R_BAD_REMOVED$FAMILYJ                                                         *  
    ## VI_DAY50_PLOT10_E3_MINUS_V1R_BAD_REMOVED$FAMILYL                                                            
    ## VI_DAY50_PLOT10_E3_MINUS_V1R_BAD_REMOVED$GROUPtreatment:VI_DAY50_PLOT10_E3_MINUS_V1R_BAD_REMOVED$FAMILYB    
    ## VI_DAY50_PLOT10_E3_MINUS_V1R_BAD_REMOVED$GROUPtreatment:VI_DAY50_PLOT10_E3_MINUS_V1R_BAD_REMOVED$FAMILYD    
    ## VI_DAY50_PLOT10_E3_MINUS_V1R_BAD_REMOVED$GROUPtreatment:VI_DAY50_PLOT10_E3_MINUS_V1R_BAD_REMOVED$FAMILYE ** 
    ## VI_DAY50_PLOT10_E3_MINUS_V1R_BAD_REMOVED$GROUPtreatment:VI_DAY50_PLOT10_E3_MINUS_V1R_BAD_REMOVED$FAMILYJ *  
    ## VI_DAY50_PLOT10_E3_MINUS_V1R_BAD_REMOVED$GROUPtreatment:VI_DAY50_PLOT10_E3_MINUS_V1R_BAD_REMOVED$FAMILYL    
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
    ## 
    ## Residual standard error: 0.01974 on 62 degrees of freedom
    ## Multiple R-squared:  0.2566, Adjusted R-squared:  0.1247 
    ## F-statistic: 1.946 on 11 and 62 DF,  p-value: 0.05017

One Way ANOVA of Challenged Families
------------------------------------

``` r
VI_DAY50_PLOT10_V1R_BAD_REMOVED_CHALLENGE <- VI_DAY50_PLOT10_E3_MINUS_V1R_BAD_REMOVED[!grepl("control", VI_DAY50_PLOT10_E3_MINUS_V1R_BAD_REMOVED$GROUP),]

VI_DAY50_PLOT10_V1R_BAD_REMOVED_CHALLENGE_oneway_lm <- aov(VI_DAY50_PLOT10_V1R_BAD_REMOVED_CHALLENGE$Arcsine ~ VI_DAY50_PLOT10_V1R_BAD_REMOVED_CHALLENGE$FAMILY, data=VI_DAY50_PLOT10_V1R_BAD_REMOVED_CHALLENGE)
summary(VI_DAY50_PLOT10_V1R_BAD_REMOVED_CHALLENGE_oneway_lm)
```

    ##                                                  Df  Sum Sq   Mean Sq
    ## VI_DAY50_PLOT10_V1R_BAD_REMOVED_CHALLENGE$FAMILY  5 0.00506 0.0010119
    ## Residuals                                        45 0.02179 0.0004843
    ##                                                  F value Pr(>F)  
    ## VI_DAY50_PLOT10_V1R_BAD_REMOVED_CHALLENGE$FAMILY    2.09 0.0842 .
    ## Residuals                                                        
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

### Two Way ANOVA of GATE and FAMILY for Live Hemocytes

``` r
VI_DAY50_PLOT9_E1_MINUS_V1R_PLOT10_combined_BAD_REMOVED_AOV <- lm(VI_DAY50_PLOT9_E1_MINUS_V1R_PLOT10_combined_BAD_REMOVED$Arcsine ~ VI_DAY50_PLOT9_E1_MINUS_V1R_PLOT10_combined_BAD_REMOVED$FAMILY + VI_DAY50_PLOT9_E1_MINUS_V1R_PLOT10_combined_BAD_REMOVED$GATE, data=VI_DAY50_PLOT9_E1_MINUS_V1R_PLOT10_combined_BAD_REMOVED)
Anova(VI_DAY50_PLOT9_E1_MINUS_V1R_PLOT10_combined_BAD_REMOVED_AOV, type="II")
```

    ## Anova Table (Type II tests)
    ## 
    ## Response: VI_DAY50_PLOT9_E1_MINUS_V1R_PLOT10_combined_BAD_REMOVED$Arcsine
    ##                                                                 Sum Sq  Df
    ## VI_DAY50_PLOT9_E1_MINUS_V1R_PLOT10_combined_BAD_REMOVED$FAMILY 0.06976   5
    ## VI_DAY50_PLOT9_E1_MINUS_V1R_PLOT10_combined_BAD_REMOVED$GATE   1.27972   1
    ## Residuals                                                      0.59599 141
    ##                                                                 F value
    ## VI_DAY50_PLOT9_E1_MINUS_V1R_PLOT10_combined_BAD_REMOVED$FAMILY   3.3008
    ## VI_DAY50_PLOT9_E1_MINUS_V1R_PLOT10_combined_BAD_REMOVED$GATE   302.7586
    ## Residuals                                                              
    ##                                                                   Pr(>F)
    ## VI_DAY50_PLOT9_E1_MINUS_V1R_PLOT10_combined_BAD_REMOVED$FAMILY  0.007528
    ## VI_DAY50_PLOT9_E1_MINUS_V1R_PLOT10_combined_BAD_REMOVED$GATE   < 2.2e-16
    ## Residuals                                                               
    ##                                                                   
    ## VI_DAY50_PLOT9_E1_MINUS_V1R_PLOT10_combined_BAD_REMOVED$FAMILY ** 
    ## VI_DAY50_PLOT9_E1_MINUS_V1R_PLOT10_combined_BAD_REMOVED$GATE   ***
    ## Residuals                                                         
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

``` r
summary(VI_DAY50_PLOT9_E1_MINUS_V1R_PLOT10_combined_BAD_REMOVED_AOV)
```

    ## 
    ## Call:
    ## lm(formula = VI_DAY50_PLOT9_E1_MINUS_V1R_PLOT10_combined_BAD_REMOVED$Arcsine ~ 
    ##     VI_DAY50_PLOT9_E1_MINUS_V1R_PLOT10_combined_BAD_REMOVED$FAMILY + 
    ##         VI_DAY50_PLOT9_E1_MINUS_V1R_PLOT10_combined_BAD_REMOVED$GATE, 
    ##     data = VI_DAY50_PLOT9_E1_MINUS_V1R_PLOT10_combined_BAD_REMOVED)
    ## 
    ## Residuals:
    ##      Min       1Q   Median       3Q      Max 
    ## -0.24488 -0.02953  0.00564  0.03032  0.15738 
    ## 
    ## Coefficients:
    ##                                                                       Estimate
    ## (Intercept)                                                           1.510963
    ## VI_DAY50_PLOT9_E1_MINUS_V1R_PLOT10_combined_BAD_REMOVED$FAMILYB       0.065072
    ## VI_DAY50_PLOT9_E1_MINUS_V1R_PLOT10_combined_BAD_REMOVED$FAMILYD       0.006855
    ## VI_DAY50_PLOT9_E1_MINUS_V1R_PLOT10_combined_BAD_REMOVED$FAMILYE       0.016165
    ## VI_DAY50_PLOT9_E1_MINUS_V1R_PLOT10_combined_BAD_REMOVED$FAMILYJ       0.016876
    ## VI_DAY50_PLOT9_E1_MINUS_V1R_PLOT10_combined_BAD_REMOVED$FAMILYL       0.013256
    ## VI_DAY50_PLOT9_E1_MINUS_V1R_PLOT10_combined_BAD_REMOVED$GATEgranular -0.185976
    ##                                                                      Std. Error
    ## (Intercept)                                                            0.013398
    ## VI_DAY50_PLOT9_E1_MINUS_V1R_PLOT10_combined_BAD_REMOVED$FAMILYB        0.017707
    ## VI_DAY50_PLOT9_E1_MINUS_V1R_PLOT10_combined_BAD_REMOVED$FAMILYD        0.018085
    ## VI_DAY50_PLOT9_E1_MINUS_V1R_PLOT10_combined_BAD_REMOVED$FAMILYE        0.017707
    ## VI_DAY50_PLOT9_E1_MINUS_V1R_PLOT10_combined_BAD_REMOVED$FAMILYJ        0.018523
    ## VI_DAY50_PLOT9_E1_MINUS_V1R_PLOT10_combined_BAD_REMOVED$FAMILYL        0.018523
    ## VI_DAY50_PLOT9_E1_MINUS_V1R_PLOT10_combined_BAD_REMOVED$GATEgranular   0.010688
    ##                                                                      t value
    ## (Intercept)                                                          112.771
    ## VI_DAY50_PLOT9_E1_MINUS_V1R_PLOT10_combined_BAD_REMOVED$FAMILYB        3.675
    ## VI_DAY50_PLOT9_E1_MINUS_V1R_PLOT10_combined_BAD_REMOVED$FAMILYD        0.379
    ## VI_DAY50_PLOT9_E1_MINUS_V1R_PLOT10_combined_BAD_REMOVED$FAMILYE        0.913
    ## VI_DAY50_PLOT9_E1_MINUS_V1R_PLOT10_combined_BAD_REMOVED$FAMILYJ        0.911
    ## VI_DAY50_PLOT9_E1_MINUS_V1R_PLOT10_combined_BAD_REMOVED$FAMILYL        0.716
    ## VI_DAY50_PLOT9_E1_MINUS_V1R_PLOT10_combined_BAD_REMOVED$GATEgranular -17.400
    ##                                                                      Pr(>|t|)
    ## (Intercept)                                                           < 2e-16
    ## VI_DAY50_PLOT9_E1_MINUS_V1R_PLOT10_combined_BAD_REMOVED$FAMILYB      0.000337
    ## VI_DAY50_PLOT9_E1_MINUS_V1R_PLOT10_combined_BAD_REMOVED$FAMILYD      0.705227
    ## VI_DAY50_PLOT9_E1_MINUS_V1R_PLOT10_combined_BAD_REMOVED$FAMILYE      0.362830
    ## VI_DAY50_PLOT9_E1_MINUS_V1R_PLOT10_combined_BAD_REMOVED$FAMILYJ      0.363799
    ## VI_DAY50_PLOT9_E1_MINUS_V1R_PLOT10_combined_BAD_REMOVED$FAMILYL      0.475371
    ## VI_DAY50_PLOT9_E1_MINUS_V1R_PLOT10_combined_BAD_REMOVED$GATEgranular  < 2e-16
    ##                                                                         
    ## (Intercept)                                                          ***
    ## VI_DAY50_PLOT9_E1_MINUS_V1R_PLOT10_combined_BAD_REMOVED$FAMILYB      ***
    ## VI_DAY50_PLOT9_E1_MINUS_V1R_PLOT10_combined_BAD_REMOVED$FAMILYD         
    ## VI_DAY50_PLOT9_E1_MINUS_V1R_PLOT10_combined_BAD_REMOVED$FAMILYE         
    ## VI_DAY50_PLOT9_E1_MINUS_V1R_PLOT10_combined_BAD_REMOVED$FAMILYJ         
    ## VI_DAY50_PLOT9_E1_MINUS_V1R_PLOT10_combined_BAD_REMOVED$FAMILYL         
    ## VI_DAY50_PLOT9_E1_MINUS_V1R_PLOT10_combined_BAD_REMOVED$GATEgranular ***
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
    ## 
    ## Residual standard error: 0.06501 on 141 degrees of freedom
    ## Multiple R-squared:  0.6937, Adjusted R-squared:  0.6806 
    ## F-statistic: 53.21 on 6 and 141 DF,  p-value: < 2.2e-16

``` r
# Adding an Interaction term
VI_DAY50_PLOT9_E1_MINUS_V1R_PLOT10_combined_BAD_REMOVED_AOV_interaction <- lm(VI_DAY50_PLOT9_E1_MINUS_V1R_PLOT10_combined_BAD_REMOVED$Arcsine ~ VI_DAY50_PLOT9_E1_MINUS_V1R_PLOT10_combined_BAD_REMOVED$FAMILY + VI_DAY50_PLOT9_E1_MINUS_V1R_PLOT10_combined_BAD_REMOVED$GATE + VI_DAY50_PLOT9_E1_MINUS_V1R_PLOT10_combined_BAD_REMOVED$FAMILY:VI_DAY50_PLOT9_E1_MINUS_V1R_PLOT10_combined_BAD_REMOVED$GATE, data=VI_DAY50_PLOT9_E1_MINUS_V1R_PLOT10_combined_BAD_REMOVED )
Anova(VI_DAY50_PLOT9_E1_MINUS_V1R_PLOT10_combined_BAD_REMOVED_AOV_interaction , type="II")
```

    ## Anova Table (Type II tests)
    ## 
    ## Response: VI_DAY50_PLOT9_E1_MINUS_V1R_PLOT10_combined_BAD_REMOVED$Arcsine
    ##                                                                                                                              Sum Sq
    ## VI_DAY50_PLOT9_E1_MINUS_V1R_PLOT10_combined_BAD_REMOVED$FAMILY                                                              0.06976
    ## VI_DAY50_PLOT9_E1_MINUS_V1R_PLOT10_combined_BAD_REMOVED$GATE                                                                1.27972
    ## VI_DAY50_PLOT9_E1_MINUS_V1R_PLOT10_combined_BAD_REMOVED$FAMILY:VI_DAY50_PLOT9_E1_MINUS_V1R_PLOT10_combined_BAD_REMOVED$GATE 0.04215
    ## Residuals                                                                                                                   0.55384
    ##                                                                                                                              Df
    ## VI_DAY50_PLOT9_E1_MINUS_V1R_PLOT10_combined_BAD_REMOVED$FAMILY                                                                5
    ## VI_DAY50_PLOT9_E1_MINUS_V1R_PLOT10_combined_BAD_REMOVED$GATE                                                                  1
    ## VI_DAY50_PLOT9_E1_MINUS_V1R_PLOT10_combined_BAD_REMOVED$FAMILY:VI_DAY50_PLOT9_E1_MINUS_V1R_PLOT10_combined_BAD_REMOVED$GATE   5
    ## Residuals                                                                                                                   136
    ##                                                                                                                              F value
    ## VI_DAY50_PLOT9_E1_MINUS_V1R_PLOT10_combined_BAD_REMOVED$FAMILY                                                                3.4261
    ## VI_DAY50_PLOT9_E1_MINUS_V1R_PLOT10_combined_BAD_REMOVED$GATE                                                                314.2471
    ## VI_DAY50_PLOT9_E1_MINUS_V1R_PLOT10_combined_BAD_REMOVED$FAMILY:VI_DAY50_PLOT9_E1_MINUS_V1R_PLOT10_combined_BAD_REMOVED$GATE   2.0701
    ## Residuals                                                                                                                           
    ##                                                                                                                                Pr(>F)
    ## VI_DAY50_PLOT9_E1_MINUS_V1R_PLOT10_combined_BAD_REMOVED$FAMILY                                                               0.006013
    ## VI_DAY50_PLOT9_E1_MINUS_V1R_PLOT10_combined_BAD_REMOVED$GATE                                                                < 2.2e-16
    ## VI_DAY50_PLOT9_E1_MINUS_V1R_PLOT10_combined_BAD_REMOVED$FAMILY:VI_DAY50_PLOT9_E1_MINUS_V1R_PLOT10_combined_BAD_REMOVED$GATE  0.072882
    ## Residuals                                                                                                                            
    ##                                                                                                                                
    ## VI_DAY50_PLOT9_E1_MINUS_V1R_PLOT10_combined_BAD_REMOVED$FAMILY                                                              ** 
    ## VI_DAY50_PLOT9_E1_MINUS_V1R_PLOT10_combined_BAD_REMOVED$GATE                                                                ***
    ## VI_DAY50_PLOT9_E1_MINUS_V1R_PLOT10_combined_BAD_REMOVED$FAMILY:VI_DAY50_PLOT9_E1_MINUS_V1R_PLOT10_combined_BAD_REMOVED$GATE .  
    ## Residuals                                                                                                                      
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

``` r
VI_DAY50_PLOT9_E1_MINUS_V1R_PLOT10_combined_BAD_REMOVED_AOV_interaction_leastsquares <- lsmeans(VI_DAY50_PLOT9_E1_MINUS_V1R_PLOT10_combined_BAD_REMOVED_AOV_interaction, "VI_DAY50_PLOT9_E1_MINUS_V1R_PLOT10_combined_BAD_REMOVED$FAMILY", adjust="tukey")
cld(VI_DAY50_PLOT9_E1_MINUS_V1R_PLOT10_combined_BAD_REMOVED_AOV_interaction_leastsquares, alpha=0.05, Letters=letters)
```

    ##  VI_DAY50_PLOT9_E1_MINUS_V1R_PLOT10_combined_BAD_REMOVED$FAMILY   lsmean
    ##  A                                                              1.529424
    ##  B                                                              1.529424
    ##  D                                                              1.529424
    ##  E                                                              1.529424
    ##  J                                                              1.529424
    ##  L                                                              1.529424
    ##          SE  df lower.CL upper.CL .group
    ##  0.01705522 136 1.495697 1.563152  a    
    ##  0.01705522 136 1.495697 1.563152  a    
    ##  0.01705522 136 1.495697 1.563152  a    
    ##  0.01705522 136 1.495697 1.563152  a    
    ##  0.01705522 136 1.495697 1.563152  a    
    ##  0.01705522 136 1.495697 1.563152  a    
    ## 
    ## Results are averaged over the levels of: VI_DAY50_PLOT9_E1_MINUS_V1R_PLOT10_combined_BAD_REMOVED$GATE 
    ## Confidence level used: 0.95 
    ## P value adjustment: tukey method for comparing a family of 6 estimates 
    ## significance level used: alpha = 0.05

``` r
VI_DAY50_PLOT9_E1_MINUS_V1R_PLOT10_combined_BAD_REMOVED_AOV_interaction_leastsquares_gate <- lsmeans(VI_DAY50_PLOT9_E1_MINUS_V1R_PLOT10_combined_BAD_REMOVED_AOV_interaction, "VI_DAY50_PLOT9_E1_MINUS_V1R_PLOT10_combined_BAD_REMOVED$GATE", adjust="tukey")
cld(VI_DAY50_PLOT9_E1_MINUS_V1R_PLOT10_combined_BAD_REMOVED_AOV_interaction_leastsquares_gate, alpha=0.05, Letters=letters)
```

    ##  VI_DAY50_PLOT9_E1_MINUS_V1R_PLOT10_combined_BAD_REMOVED$GATE   lsmean
    ##  agranular                                                    1.529424
    ##  granular                                                     1.529424
    ##          SE  df lower.CL upper.CL .group
    ##  0.01705522 136 1.495697 1.563152  a    
    ##  0.01705522 136 1.495697 1.563152  a    
    ## 
    ## Results are averaged over the levels of: VI_DAY50_PLOT9_E1_MINUS_V1R_PLOT10_combined_BAD_REMOVED$FAMILY 
    ## Confidence level used: 0.95 
    ## significance level used: alpha = 0.05

Summary Statistics Day 50
-------------------------

``` r
# Summary Statistics for Percentages 
total_viabaility_statistics_day50 <- summarySE(data=VI_DAY50_PLOT4_E1_E3_GATE_BAD_REMOVED, "PERCENT_OF_THIS_PLOT", groupvars=c("GROUP", "GATE","FAMILY"))

viability_statistics_live_day50 <- summarySE(data=VI_DAY50_PLOT9_E1_MINUS_V1R_PLOT10_combined_BAD_REMOVED, "PERCENT_LIVE", groupvars=c("GROUP", "GATE","FAMILY"), conf.interval= 0.95)

# Summary Statistics for size #need to get this document from Hannah
mean_size <- read.csv(file="../ANALYSIS_CSVs/VIABILITY_ASSAY/DAY7/VIABILITY_ASSAY_MEAN_VALUES_CORRECTED_EDITED.csv", header=TRUE)
class(mean_size$MEAN)
```

    ## [1] "numeric"

``` r
mean_size_BAD_REMOVED <- mean_size[!mean_size$SAMPLE_ID %in% Viability_Samples_Remove$SAMPLE_ID, , drop=FALSE]
mean_size_statistics <- summarySE(data=mean_size_BAD_REMOVED, "MEAN", groupvars=c("GROUP","GATE","PLOT","FAMILY"), conf.interval = 0.95)
```

    ## Warning in qt(conf.interval/2 + 0.5, datac$N - 1): NaNs produced

### Compiled Graphing

``` r
#Plotting all granular agranular 
subset_day50_agranular_granular <- VI_DAY50_PLOT4_E1_E3_GATE_BAD_REMOVED[,c(1,2,5,7,10,11,12)]
subset_day50_agranular_granular$DAY <- "50"
subset_day7_agranular_granular <- VI_PLOT4_restructured_BAD_REMOVED[,c(1,2,6,5,11,10,12)]
subset_day7_agranular_granular$DAY <- "7"

colnames(subset_day7_agranular_granular) <- c("SAMPLE_ID","FAMILY","GROUP","PLOT","GATE","PERCENT_OF_THIS_PLOT","Arcsine","DAY")
compiled_day7_day_50_all_agranular_granular <- rbind(subset_day7_agranular_granular, subset_day50_agranular_granular )

ggplot(compiled_day7_day_50_all_agranular_granular, aes(x=GROUP,y=PERCENT_OF_THIS_PLOT, fill=GATE)) + geom_boxplot() + ggtitle("Percent of Granular and Agranular Hemocytes \n on Day 7 and Day 50 (low quality removed)") + ylab("Percent of Hemocyte Events in each quad plot") + facet_grid(DAY~FAMILY, scales="free") + scale_fill_manual(name="Hemocyte Type", labels=c("Granular Hemocytes", "Agranular Hemocytes"), values=c("E1"="#99a765","E3"="#96578a")) 
```

![](Dermo_Viability_Assay_Data_analysis_files/figure-markdown_github/viability_assay_compiled_graphing-1.png)

``` r
# Plotting all live agranular and granular
subset_day7_live_agranular_granular <- VI_PLOT9_PLOT10_BAD_REMOVED_combined[,c(1,2,5,6,9,10)]
subset_day7_live_agranular_granular$DAY <- "7"
subset_day50_live_agranular_granular <- VI_DAY50_PLOT9_E1_MINUS_V1R_PLOT10_combined_BAD_REMOVED[,c(1,2,7,5,10,11)]
subset_day50_live_agranular_granular$DAY <- "50"

compiled_day7_day50_live_agranular_granular <- rbind(subset_day7_live_agranular_granular, subset_day50_live_agranular_granular)

ggplot(compiled_day7_day50_live_agranular_granular, aes(x=GROUP, y=PERCENT_LIVE, fill=PLOT)) + 
  geom_boxplot() + ggtitle("Percent of Live Granular and Agranular Hemocytes \n on Day 7 and Day 50 (low quality removed)") + ylab("Percent of Hemocyte Events in each quad plot") + 
  facet_grid(DAY~FAMILY, scales="free")  + scale_fill_manual(name="Hemocyte Type", labels=c("Granular Hemocytes", "Agranular Hemocytes"), values=c("PLOT9_FL3-A"="#99a765","PLOT10_FL3-A"="#96578a"))
```

![](Dermo_Viability_Assay_Data_analysis_files/figure-markdown_github/viability_assay_compiled_graphing-2.png)

### Two Way ANOVA of GATE and DAY

``` r
compiled_agranular_granular_lm <- lm(compiled_day7_day_50_all_agranular_granular$Arcsine ~ compiled_day7_day_50_all_agranular_granular$GATE + compiled_day7_day_50_all_agranular_granular$DAY + compiled_day7_day_50_all_agranular_granular$GATE:compiled_day7_day_50_all_agranular_granular$DAY, data=compiled_day7_day_50_all_agranular_granular)
Anova(compiled_agranular_granular_lm, type="II")
```

    ## Anova Table (Type II tests)
    ## 
    ## Response: compiled_day7_day_50_all_agranular_granular$Arcsine
    ##                                                                                                   Sum Sq
    ## compiled_day7_day_50_all_agranular_granular$GATE                                                 12.2959
    ## compiled_day7_day_50_all_agranular_granular$DAY                                                   0.0304
    ## compiled_day7_day_50_all_agranular_granular$GATE:compiled_day7_day_50_all_agranular_granular$DAY  0.8538
    ## Residuals                                                                                         3.8401
    ##                                                                                                   Df
    ## compiled_day7_day_50_all_agranular_granular$GATE                                                   1
    ## compiled_day7_day_50_all_agranular_granular$DAY                                                    1
    ## compiled_day7_day_50_all_agranular_granular$GATE:compiled_day7_day_50_all_agranular_granular$DAY   1
    ## Residuals                                                                                        250
    ##                                                                                                   F value
    ## compiled_day7_day_50_all_agranular_granular$GATE                                                 800.5016
    ## compiled_day7_day_50_all_agranular_granular$DAY                                                    1.9793
    ## compiled_day7_day_50_all_agranular_granular$GATE:compiled_day7_day_50_all_agranular_granular$DAY  55.5874
    ## Residuals                                                                                                
    ##                                                                                                     Pr(>F)
    ## compiled_day7_day_50_all_agranular_granular$GATE                                                 < 2.2e-16
    ## compiled_day7_day_50_all_agranular_granular$DAY                                                     0.1607
    ## compiled_day7_day_50_all_agranular_granular$GATE:compiled_day7_day_50_all_agranular_granular$DAY 1.465e-12
    ## Residuals                                                                                                 
    ##                                                                                                     
    ## compiled_day7_day_50_all_agranular_granular$GATE                                                 ***
    ## compiled_day7_day_50_all_agranular_granular$DAY                                                     
    ## compiled_day7_day_50_all_agranular_granular$GATE:compiled_day7_day_50_all_agranular_granular$DAY ***
    ## Residuals                                                                                           
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1

``` r
compiled_day7_day50_live_agranular_granular_lm <- lm(compiled_day7_day50_live_agranular_granular$Arcsine ~ compiled_day7_day50_live_agranular_granular$PLOT + compiled_day7_day50_live_agranular_granular$DAY + compiled_day7_day50_live_agranular_granular$PLOT:compiled_day7_day50_live_agranular_granular$DAY, data=compiled_day7_day50_live_agranular_granular)
Anova(compiled_day7_day50_live_agranular_granular_lm, type="II")
```

    ## Anova Table (Type II tests)
    ## 
    ## Response: compiled_day7_day50_live_agranular_granular$Arcsine
    ##                                                                                                  Sum Sq
    ## compiled_day7_day50_live_agranular_granular$PLOT                                                 4.1908
    ## compiled_day7_day50_live_agranular_granular$DAY                                                  1.0083
    ## compiled_day7_day50_live_agranular_granular$PLOT:compiled_day7_day50_live_agranular_granular$DAY 0.4460
    ## Residuals                                                                                        2.7670
    ##                                                                                                   Df
    ## compiled_day7_day50_live_agranular_granular$PLOT                                                   1
    ## compiled_day7_day50_live_agranular_granular$DAY                                                    1
    ## compiled_day7_day50_live_agranular_granular$PLOT:compiled_day7_day50_live_agranular_granular$DAY   1
    ## Residuals                                                                                        250
    ##                                                                                                  F value
    ## compiled_day7_day50_live_agranular_granular$PLOT                                                 378.638
    ## compiled_day7_day50_live_agranular_granular$DAY                                                   91.100
    ## compiled_day7_day50_live_agranular_granular$PLOT:compiled_day7_day50_live_agranular_granular$DAY  40.293
    ## Residuals                                                                                               
    ##                                                                                                     Pr(>F)
    ## compiled_day7_day50_live_agranular_granular$PLOT                                                 < 2.2e-16
    ## compiled_day7_day50_live_agranular_granular$DAY                                                  < 2.2e-16
    ## compiled_day7_day50_live_agranular_granular$PLOT:compiled_day7_day50_live_agranular_granular$DAY 1.021e-09
    ## Residuals                                                                                                 
    ##                                                                                                     
    ## compiled_day7_day50_live_agranular_granular$PLOT                                                 ***
    ## compiled_day7_day50_live_agranular_granular$DAY                                                  ***
    ## compiled_day7_day50_live_agranular_granular$PLOT:compiled_day7_day50_live_agranular_granular$DAY ***
    ## Residuals                                                                                           
    ## ---
    ## Signif. codes:  0 '***' 0.001 '**' 0.01 '*' 0.05 '.' 0.1 ' ' 1
