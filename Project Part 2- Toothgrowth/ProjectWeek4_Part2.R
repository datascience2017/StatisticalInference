#Part 2: Basic Inferential Data Analysis

library(datasets)
library(ggplot2)

#Load the ToothGrowth data.
datasets::ToothGrowth
ToothGrowth <- data.frame(datasets::ToothGrowth)

#Summary of the dataset: ToothGrowth.
#This dataset shows Effect of Vitamin c on Tooth Growth in Guinea Pigs.
#The response is the length of odontoblasts (cells responsible for tooth growth) in 60 guinea pigs. Each animal received one of three dose levels of vitamin C (0.5, 1, and 2 mg/day) by one of two delivery methods, (orange juice or ascorbic acid (a form of vitamin C and coded as VC).
#A data frame with 60 observations on 3 variables.
#The first variable Tooth length ('len') is	numeric	 
#The second variable Supplement type (supp) is a factor variable with levels	(VC or OJ).
# The third variable Dose(dose) is numeric	and shows the Dose in milligrams/day
summary(ToothGrowth)

#Basic exploratory data analyses
#The plot below shows the effect of the dosage of supplement on the Tooth Lengh. 
ggplot(data=ToothGrowth,aes(x=dose,y=len, fill=supp))  + geom_bar(stat = "identity") + 
  facet_grid(.~supp) + xlab("Dose in milligrams/day") + ylab("Tooth Length") + 
  guides(fill=guide_legend(title="Supplement Type")) +
  ggtitle("Tooth Growth by Supplement Type and Dosage") + theme(plot.title = element_text(hjust = 0.5))
# It appears that there is a direct relationship in the increase in Tooth Length to the Dosage of supplement. 
# But we are unable to state which Supplement Type (OJ or VC) cause more tooth growth.

#The plot below shows the effect of the dosage of type of supplement on the Tooth Lengh. 
ggplot(data=ToothGrowth,aes(x=supp,y=len))  + geom_bar(stat = "identity") + 
  facet_grid(.~dose) + xlab("Supplement Type") + ylab("Tooth Length") + 
  ggtitle("Tooth Growth by Supplement Type and Dosage") + 
  theme(plot.title = element_text(hjust = 0.5))

# In this plot we observe that OJ supplement leads to better teeth growth for dosage quantities of 0.5 and 1, but is equal to VC supplement for dosage quantity of 2. Hence we cannot completely sure if the supplement type is the cause for difference in tooth length.



# Hypothesis tests to compare tooth growth by supplement type.. 
# We will try to find out if the observed difference tooth length between the guinea pigs who received OJ or VC is statistically different than zero.
# We will use a t.test to determine if there is a difference in the teeth length based on the supplement type.
# We will run the t.test based on supplement and check if the p-value > 0.05 and if the confidence interval includes 0.
t <- t.test(ToothGrowth$len[ToothGrowth$supp=="OJ"], ToothGrowth$len[ToothGrowth$supp=="VC"], paired = FALSE, var.equal = FALSE)
t

#We observe that the p-value using the above test is 0.06063 and Confidence Interval(-0.1710156  7.5710156), which includes 0.
#Hence we cannot believe that there is strong evidence to prove that observed difference tooth length between the guinea pigs who received OJ or VC is statistically different than zero.


# Hypothesis tests to compare tooth growth by dosage level.
# We will try to find out if the observed difference tooth length between the guinea pigs who received different dosage levels of supplement is statistically different than zero.
# We will do a paired testing between the dosage levels.

# Testing between dosage levels 1 and 0.5 milligrams/day
t_1_0.5 <- t.test(ToothGrowth$len[ToothGrowth$dose==1], ToothGrowth$len[ToothGrowth$dose==0.5], paired = FALSE, var.equal = TRUE)
t_1_0.5
# Testing between dosage levels 2 and 1 milligrams/day
t_2_1 <- t.test(ToothGrowth$len[ToothGrowth$dose==2], ToothGrowth$len[ToothGrowth$dose==1], paired = FALSE, var.equal = TRUE)
t_2_1
# Testing between dosage levels 2 and 0.5 milligrams/day
t_2_0.5 <- t.test(ToothGrowth$len[ToothGrowth$dose==2], ToothGrowth$len[ToothGrowth$dose==0.5], paired = FALSE, var.equal = TRUE)
t_2_0.5
# Based on three results above, the p-value for all three combinations is lower than the significance level 0.05. Hence we can say that difference tooth length between the guinea pigs who received different dosage levels of supplement is statistically different than zero.
# Or that there is direct relation between the tooth growth and dosage levels received.

# Conclusions and the assumptions for the conclusions
# Assumptions
# We assume that the guinea pigs were randomly assigned to one of the groups that received the supplement type(OJ and VC) and that they were sampled from a nearly normal population.

#Conclusion
#We can conclude the following results from our hypothesis testing
# 1. The supplement type(OJ or VC) has no effect on tooth growth. 
# Based on plot#2 we observe that OJ supplement leads to better teeth growth for dosage quantities of 0.5 and 1. But for dosage level 2: tooth growth caused by OJ is slightly lower to VC supplement.
# 2. Increased the dosage level leads to increased tooth growth. We observe that there is direct effect on the tooth growth caused by dosage levels, irrespective of the supplement type (OJ r VC).
