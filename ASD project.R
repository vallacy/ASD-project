####################################
## Independent Consulting Project ##
### code created by Valerie Ryan ###
###### last updated 6/25/2020 ######
####################################
#clear workspace
#rm(list=ls())

#set working directory
setwd("C:/Users/Your File Path")

#read in csv files
asd <- read.csv("ASD.csv", header=T)
pre <- read.csv("pre survey.csv", header=T)
post <- read.csv("post survey.csv", header=T)
tx <- read.csv("tx group.csv", header=T)
control <- read.csv("control group.csv", header=T)
tx_2 <- read.csv("tx wilcoxon.csv", header=T)
control_2 <- read.csv("control wilcoxon.csv", header=T)

#load packages
library(psych)
library(MASS)
library(effsize)
library(ggpubr)

################################################
## Wilcoxon signed-rank test (paired samples) ##
################################################

# Treatment Group

#test comparing total scores on attitude scale for treatment group at baseline and follow-up
wilcox.test(tx_2$a_tot, tx_2$a_tot_2, paired=TRUE)

#test comparing total scores on knowledge scale for treatment group at baseline and follow-up
wilcox.test(tx_2$k_tot, tx_2$k_tot_2, paired=TRUE)

#descriptive statistics for total scores on attitude scale for treatment group at baseline and follow-up
describe(tx_2$a_tot)
describe(tx_2$a_tot_2)

#histograms showing total score distributions on attitude scale for treatment group at baseline and follow-up
hist(tx_2$a_tot)
hist(tx_2$a_tot_2)

#descriptive statistics for total scores on knowledge scale for treatment group at baseline and follow-up
describe(tx_2$k_tot)
describe(tx_2$k_tot_2)

#histograms showing total score distributions on knowledge scale for treatment group at baseline and follow-up
hist(tx_2$k_tot)
hist(tx_2$k_tot_2)

#calculate effect size, Cliff's delta, for difference between baseline and follow-up in treatment group total score on attitude scale 
cliff.delta(tx_2$a_tot, tx_2$a_tot_2, conf.level=.95, 
            use.unbiased=TRUE, use.normal=FALSE, 
            return.dm=FALSE)

#calculate effect size, Cliff's delta, for difference between baseline and follow-up in treatment group total score on knowledge scale 
cliff.delta(tx_2$k_tot, tx_2$k_tot_2, conf.level=.95, 
            use.unbiased=TRUE, use.normal=FALSE, 
            return.dm=FALSE)

#create boxplot for treatment group
ggboxplot(tx, x = "observation", y = "a_tot", 
          color = "observation", palette = c("#00AFBB", "#E7B800"),
          order = c("1", "2"),
          title = "Treatment Group Scores on Attitudes Toward Students with ASD Pre- and Post-Lecture",
          ylab = "Attitude Scale Score", xlab = "Time Point",
          legend = '')

# Control Group

#test comparing total scores on attitude scale for control group at baseline and follow-up
wilcox.test(control_2$a_tot, control_2$a_tot_2, paired=TRUE)

#test comparing total scores on knowledge scale for control group at baseline and follow-up
wilcox.test(control_2$k_tot, control_2$k_tot_2, paired=TRUE)

#descriptive statistics for total scores on attitude scale for control group at baseline and follow-up
describe(control_2$a_tot)
describe(control_2$a_tot_2)

#histograms showing total score distributions on attitude scale for control group at baseline and follow-up
hist(control_2$a_tot)
hist(control_2$a_tot_2)

#descriptive statistics for total scores on knowledge scale for control group at baseline and follow-up
describe(control_2$k_tot)
describe(control_2$k_tot_2)

#histograms showing total score distributions on knowledge scale for control group at baseline and follow-up
hist(control_2$k_tot)
hist(control_2$k_tot_2)

################################
## Wilcoxon Mann Whitney test ##
################################

#difference between treatment and control group in scores on attitude scale at follow-up
wilcox.test(a_tot ~ tx, data=post) #results not significant

#difference between treatment and control group in scores on knowledge scale at follow-up
wilcox.test(k_tot ~ tx, data=post) #results not significant

#############################
## Non-Significant Results ##
#############################

#Results likely non-significant due to very small sample size

###################################
## One-Way Between-Subject ANOVA ##
###################################

# Treatment Group vs Control Group

#attitude scale at baseline
aov.btw <- aov(a_tot ~ tx, data=pre)
summary(aov.btw)

##graphical output
boxplot(a_tot~tx,data=pre)

#knowledge scale at baseline
aov.btw.k <- aov(k_tot ~ tx, data=pre)
summary(aov.btw.k)

##graphical output
boxplot(k_tot~tx,data=pre)

#attitude scale at follow-up
aov.btw.1 <- aov(a_tot ~ tx, data=post)
summary(aov.btw.1)

##graphical output
boxplot(a_tot~tx,data=post)

#knowledge scale at follow-up
aov.btw.k.1 <- aov(k_tot ~ tx, data=post)
summary(aov.btw.k.1)

##graphical output
boxplot(k_tot~tx,data=post)

##################################
## one-Way Within-Subject ANOVA ##
##################################

# Treatment Group

#attitude scale, differences between baseline and follow-up
aov.oneway = aov(a_tot~observation+Error(ID/observation),tx)
summary(aov.oneway)

##graphical output
boxplot(a_tot~observation,data=tx)

#knowledge scale, differences between baseline and follow-up
aov.oneway.k = aov(k_tot~observation+Error(ID/observation),tx)
summary(aov.oneway.k)

##graphical output
boxplot(k_tot~observation,data=tx)

# Control Group

#attitude scale, differences between baseline and follow-up
aov.oneway = aov(a_tot~observation+Error(ID/observation),control)
summary(aov.oneway)

##graphical output
boxplot(a_tot~observation,data=control)

#knowledge scale, differences between baseline and follow-up
aov.oneway.k = aov(k_tot~observation+Error(ID/observation),control)
summary(aov.oneway.k)

##graphical output
boxplot(k_tot~observation,data=control)

###################################
## Factorial ANOVA, Mixed Design ##
###################################

#attitude scale, differences between baseline and follow-up between treatment and control groups
aov.factorial = aov(a_tot~(observation*tx)+Error(ID/(observation))+(tx),asd)
summary(aov.factorial)

##graphical summary of means for each group at each time point
boxplot(a_tot~observation*tx,data=asd)

#knowledge scale, differences between baseline and follow-up between treatment and control groups
aov.factorial.k = aov(k_tot~(observation*tx)+Error(ID/(observation))+(tx),asd)
summary(aov.factorial.k)

##graphical summary of means for each group at each time point
boxplot(k_tot~observation*tx,data=asd)