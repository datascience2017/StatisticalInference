#Simulation Exercise_Statistical Inference Project_Part 1 
#Bernadette Chettiar
library(ggplot2)
library(knitr)

##### Overview: 
# The xponential distribution can be simulated in R with rexp(n, lambda) where lambda is the rate parameter. 
# The purpose of this data analysis is to investigate the exponential distribution and compare it to the Central Limit Theorem. 
# For this study, lambda will be set = 0.2 for all simulations.
# The mean of exponential distribution is 1/lambda and the standard deviation is also 1/lambda.
# We will investigate the distribution of averages of 40 exponentials by doing over thousand simulations.



#### Simulations: 
set.seed(394651)
lambda <- 0.2 
#n is the number of exponentials
n <- 40 
number_Of_simulations <- 1000 
#Create a matrix with 1000 simulations(1000 rows) each with 40(columns) samples drawn from the exponential distribution.
newdata <- matrix(rexp(n * number_Of_simulations, rate = lambda), number_Of_simulations)
#Calculating the mean
newdata_average <- rowMeans(newdata)

####Sample Mean versus Theoretical Mean: 
# Show the sample mean and compare it to the theoretical mean of the distribution.
SampleMean <- mean(newdata_average)
hist(newdata_average,col="gray", main="Histogram of Sample Mean")
paste('Sample mean is', round(SampleMean,3))



TheoreticalMean <- 1/lambda
paste('The Theoretical Mean is', round(TheoreticalMean,3))


#Include figures with titles. In the figures, highlight the means you are comparing. 
#Include text that explains the figures and what is shown on them, and provides appropriate numbers.

#**Based on the values of the Sample Mean and Theoretical Mean, we can say that both means are very close.**



#### Sample Variance versus Theoretical Variance: 

#**Show how variable the sample is (via variance) and compare it to the theoretical variance of the distribution.**

SampleVariance <- var(newdata_average)
paste('The Sample Variance is', round(SampleVariance,3))

TheoreticalVariance <- (1 / lambda)^2 / (n) 
paste('The Theoretical Variance is', round(TheoreticalVariance,3))

#**Based on the values of the above, we can say that the Sample Variance and the Theoretical Variance are very close.**

#Include figures (output from R) with titles. Highlight the variances you are comparing. 
#Include text that explains your understanding of the differences of the variances.

##### Distribution
newdata_average_df <- data.frame(newdata_average)

g <- ggplot(newdata_average_df, aes(x =newdata_average))

g <- g + geom_histogram(aes(y=..density..), colour="black",fill="gainsboro")
g <- g + labs(title = "Distribution of Random Exponetial Numbers", x = "Average of 40 Samples", y = "Density") +theme(plot.title = element_text(hjust = 0.5))
g <- g + geom_vline(aes(xintercept = SampleMean, colour = "yellow"))
g <- g + geom_vline(aes(xintercept = TheoreticalMean, colour = "brown"))
g <- g + stat_function(fun = dnorm, args = list(mean = SampleMean), colour = "forestgreen", size = 1.0)
g <- g + stat_function(fun = dnorm, args = list(mean = TheoreticalMean), colour = "orange", size = 1.0)
g

####Conclusion
# 1. From the plot above, we observe both distributions almost overlap each other. 
# 2. The distribution of sample means follows a normal distribution
# 3. also see that the curve resemles a bell curve or normal distribution. 
# Hence based on the findings above we can state that the distribution does indeed demonstrate Central Limit Theorem.

