hist.day1
hist.day3 + stat_function(fun = dnorm, args = list(mean = mean(dlf$day3, na.rm=TRUE), sd=sd(dlf$day3, na,rm=TRUE)), colour="black", size=1)
hist.day3

