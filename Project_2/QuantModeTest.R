library(quantmod)
library(ggplot2)

setwd("~/Dropbox/Math567/Discovering-Statistics-Using-R/Project_2/")

getSymbols("AAPL", src="google") # from google finance
getS
chartSeries(AAPL, subset='last 3 months')
addBBands()

appleQ3Q4 <-AAPL['2015-06-01::2015-12-01']

chartSeries(appleQ3Q4)
plot(appleQ3Q4)

       