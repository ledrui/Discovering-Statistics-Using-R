library(pollstR)
library(ggplot2)

gop_test <- pollstr_polls(topic = '2016-president-gop-primary', state = 'SC', after = "2015-7-1") 


questions <- subset(gop_test[["questions"]]subpopulation == "Likely Voters"))


##ggplot(gop_chart, aes(x=gop_chart$as.Date="2015-2-1", y=gop_chart$value, color=choice)) + geom_line()