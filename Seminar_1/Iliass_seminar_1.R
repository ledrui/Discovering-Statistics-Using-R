library(ggplot2)

#----Set the working directory------
setwd("~/Dropbox/Math567/Discovering-Statistics-Using-R/Seminar_1/")

#----Set the working directory------
imageDirectory<-"~/Dropbox/Math567/Discovering-Statistics-Using-R/Seminar_1/"

#------------Analysing the data ---------------------

#--------- Load the data from directory------------


data1 <- read.csv('data.csv')

#---- Histogram -------:

hist.test <- ggplot(data1, aes(data1[[1]])) + labs(legend.position = "none") + geom_histogram( colour="black", fill="white") + labs(x="numbers", y = "Random values")
hist.test

# Add a curve to the Histograms

hist.test + stat_function(fun = dnorm, args = list(mean = mean(data1[] na.rm = TRUE), sd = sd(data1[[1]], na.rm = TRUE)), colour = "black", size = 1)

hist1 <- hist(data1[[1]])

dnorn1 <-dnorm(data1[[1]])
hist(dnorn1)
# Add the curves to the Histograms:
