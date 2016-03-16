library(quantmod)
library(ggplot2)
start = c(as.Date("1986-03-01"),as.Date("2011-01-01"),as.Date("2011-07-01"),as.Date("2012-01-01"),as.Date("2012-07-01"),as.Date("2013-01-01"),as.Date("2013-07-01"),as.Date("2014-01-01"),as.Date("2014-07-01"),as.Date("2015-01-01"),as.Date("2015-07-01"),as.Date("2016-01-01"))
end = c(Sys.Date(),as.Date("2011-06-30"),as.Date("2011-12-30"),as.Date("2012-06-30"),as.Date("2012-12-30"),as.Date("2013-06-30"),as.Date("2013-12-30"),as.Date("2014-06-30"),as.Date("2014-12-30"),as.Date("2015-06-30"),as.Date("2015-12-30"),Sys.Date())

i=11

getSymbols(c('AAPL','MSFT'), from = start[i], to = end[i])
#create data frames for necessary data
MSFT.df = data.frame(date=time(MSFT), Cl(MSFT))

date=time(MSFT)-rep(start[i],nrow(MSFT.df))
MSFT.reg = lm(formula = MSFT.df$MSFT.Close ~ date)

print(summary(MSFT.reg))

for(i in 1:12){
  getSymbols(c('AAPL','MSFT'), from = start[i], to = end[i])
  #create data frames for necessary data
  AAPL.df = data.frame(date=time(AAPL), Cl(AAPL))
  
  date=time(AAPL)-rep(start[i],nrow(AAPL.df))
  AAPL.reg = lm(formula = AAPL.df$AAPL.Close ~ date)
  
  print(summary(AAPL.reg))
}
