library(car)

#----------Set the working directory------
setwd("~/Dropbox/Math567/Discovering-Statistics-Using-R/Seminar_2/")



#----------- loading the data --------------------
data <- read.csv('Seminar_2.csv', header = TRUE, sep = "")
dataFrame <- data.frame(data)

#------------ Shapiro-wilk Test------------

#-------------- Levene's Test ------------------
leveneTest(dataFrame[[1]], dataFrame[[2]])

#--------------- Hartley's Test-----------------
