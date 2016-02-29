library(quantmod)
library(ggplot2)

setwd("~/Dropbox/Math567/Discovering-Statistics-Using-R/Project_2/")

getSymbols("AAPL", src="google") # from google finance
getSymbols("MSFT")

MSFT_2015Q1Q2 <- MSFT['2015-01-01::2015-06-01']
chartSeries(MSFT_2015Q1Q2)
#addMACD()
addBBands()
ggplot(MSFT_2015Q1Q2)

# Chart for 
chartSeries(AAPL, subset='last 3 months')

apple2015Q3Q4 <-AAPL['2015-06-01::2015-12-01']

chartSeries(apple2015Q3Q4)
addMACD()
addBBands()
plot(apple2015Q3Q4)

