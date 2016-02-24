library(bootstrap)

#----Set the working directory------
setwd("~/Dropbox/Math567/Discovering-Statistics-Using-R/Seminar_3/")

#----Set the working directory------
imageDirectory<-"~/Dropbox/Math567/Discovering-Statistics-Using-R/Seminar_3/"

#----------- loading the data --------------------
data <- read.csv('Seminar_2.csv', header = TRUE, sep = "")

x <- rnorm(data[[1]])
col1 <- data[[1]]
col2 <- data[[2]]

theta <- function(x){
median(x)
}
result1 <- jackknife(col1, theta)
result1$jack.bias

result2 <-jackknife(col2, theta)
result2$jack.bias
