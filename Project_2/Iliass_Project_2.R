library(quantmod)
library(ggplot2)

setwd("~/Dropbox/Math567/Discovering-Statistics-Using-R/Project_2/")

getSymbols("AAPL", src="google") # from google finance
getSymbols("MSFT")

#2013
MSFT_2013Q1Q2 <- MSFT['2013-01-01::2013-06-01']
MSFT_2013Q3Q4 <- MSFT['2013-07-01::2013-12-01']


chartSeries(MSFT_2013Q1Q2)
#addMACD()
addBBands()
ggplot(MSFT_2015Q1Q2)

###########################################
# Chart for Apple

#2013
Apple
apple2013Q1Q2 <-AAPL['2013-01-01::2013-06-01']
apple2013Q3Q4 <-AAPL['2013-07-01::2013-12-01']
apple2013 <-AAPL['2013-01-01::2013-12-31']
plot(apple2013)
#2014
apple2014Q1Q2 <-AAPL['2014-01-01::2014-06-01']
apple2014Q3Q4 <-AAPL['2014-07-01::2014-12-01']
# 2015
apple2015Q1Q2 <-AAPL['2015-01-01::2015-06-01']
apple2015Q3Q4 <-AAPL['2015-07-01::2015-12-01']

chartSeries(apple2013Q1Q2)
addMACD()
addBBands()
ggplot(AAPL[[close]])

ggplot(data = apple2013Q1Q2, aes(y = date, y = apple2013Q1Q2$AAPL.Close))
 
#######################################
# Nasdaq
getSymbols("NDX")
NDX_2013Q1Q2 <-NDX['2013-01-01::2013-06-01']
NDX_2013Q3Q4 <-NDX['2013-07-01::2013-12-01']

chartSeries(NDX_2013Q1Q2)

cor(apple2013Q1Q2$AAPL.Close, MSFT_2013Q1Q2$MSFT.Close, NDX_2013Q1Q2$NDX.Close)
cor(NDX_2013Q1Q2$NDX.Close, apple2013Q1Q2$AAPL.Close)

###################
