library(quantmod)
library(ggplot2)

imageDirectory<-"~/Dropbox/Math567/Discovering-Statistics-Using-R/Project_2/images/" #set directory to save image
######A function to make it quick to save graphs in the image directory
saveInImageDirectory<-function(filename){
	imageFile <- file.path(imageDirectory, filename)
	ggsave(imageFile)	
}
######Initiate packages

#time periods
start = c(as.Date("1986-03-01"),as.Date("2011-01-01"),as.Date("2011-07-01"),as.Date("2012-01-01"),as.Date("2012-07-01"),as.Date("2013-01-01"),as.Date("2013-07-01"),as.Date("2014-01-01"),as.Date("2014-07-01"),as.Date("2015-01-01"),as.Date("2015-07-01"),as.Date("2016-01-01"))
end = c(Sys.Date(),as.Date("2011-06-30"),as.Date("2011-12-30"),as.Date("2012-06-30"),as.Date("2012-12-30"),as.Date("2013-06-30"),as.Date("2013-12-30"),as.Date("2014-06-30"),as.Date("2014-12-30"),as.Date("2015-06-30"),as.Date("2015-12-30"),Sys.Date())

#select period and get data
i = 1  #1986 to now
i = 2  #2011 1-6
i = 3  #2011 7-12
i = 4  #2012 1-6
i = 5  #2012 7-12
i = 6  #2013 1-6
i = 7  #2013 7-12
i = 8  #2014 1-6
i = 9  #2014 7-12
i = 10 #2015 1-6
i = 11 #2015 7-12
i = 12 #2016

for (i in (1:12)){
  
   getSymbols(c('AAPL','MSFT','^IXIC','NDX'), from = start[i], to = end[i] )
}


#getSymbols(c('AAPL','MSFT','^IXIC','NDX'), from = start[1], to = end[1])
#create data frames for necessary data
MSFT.df = data.frame(date=time(MSFT), Cl(MSFT))
AAPL.df = data.frame(date=time(AAPL), Cl(AAPL))
NDX.df = data.frame(date=time(NDX), Cl(NDX))
IXIC.df = data.frame(date=time(IXIC), Cl(IXIC))

multiples = outer(AAPL.df$date >= as.Date("2014-06-09"),7) +
            outer(AAPL.df$date < as.Date("2014-06-09"),1)
AAPL.df$adjClose = AAPL.df$AAPL.Close * multiples

#individual scatter plot
ggplot(data = MSFT.df, aes(x = date, y = MSFT.Close)) + geom_point() + geom_smooth(se = F) + labs(x = "Date", y = "Close")
ggplot(data = AAPL.df, aes(x = date, y = AAPL.Close)) + geom_point() + geom_smooth(se = F) + labs(x = "Date", y = "Close")
#ggplot(data = AAPL.df, aes(x = date, y = adjClose)) + geom_point() + geom_smooth(se = F) + labs(x = "Date", y = "Close")
ggplot(data = NDX.df, aes(x = date, y = NDX.Close)) + geom_point() + geom_smooth(se = F) + labs(x = "Date", y = "Close")
ggplot(data = IXIC.df, aes(x = date, y = IXIC.Close)) + geom_point() + geom_smooth(se = F) + labs(x = "Date", y = "Close")

#superimposed scatter plot
date = c(MSFT.df$date,AAPL.df$date)
close = c(MSFT.df$MSFT.Close, AAPL.df$AAPL.Close)
label = c(rep('MSFT',nrow(MSFT.df)), rep('AAPL',nrow(AAPL.df)))
df2 = data.frame(date,close,label) 
ggplot(data = df2, aes(x = date, y = close, color = label)) + geom_point() + geom_smooth(se = F) + labs(x = "Date", y = "Close")
plot(MSFT.df$date, MSFT[Close])
#save graph
saveInImageDirectory("NDX3.png")
              
#correlation 
df = merge(MSFT.df, AAPL.df, by = "date")   
df = merge(df, IXIC.df, by = "date")
df = merge(df, NDX.df, by = "date")     
data = data.frame(MSFT = df$MSFT.Close, AAPL = df$AAPL.Close, IXIC = df$IXIC.Close, NDX = df$NDX.Close)
#data = data.frame(MSFT = df$MSFT.Close, AAPL = df$adjClose, IXIC = df$IXIC.Close, NDX = df$NDX.Close)
cor(data, use = "complete.obs", method = "pearson")

#get regression coefficient start date is the time 0
date=time(MSFT)-rep(start[i],nrow(MSFT.df))
MSFT.reg = lm(formula = MSFT.df$MSFT.Close ~ MSFT.df$date)
date=time(AAPL)-rep(start[i],nrow(AAPL.df))
AAPL.reg = lm(formula = AAPL.df$AAPL.Close ~ date)
#AAPL.reg = lm(formula = AAPL.df$adjClose ~ date)
summary(MSFT.reg)
summary(AAPL.reg)

#draw regression line
ggplot(data = MSFT.df, aes(x = date, y = MSFT.Close)) + geom_point() + geom_smooth(method = 'lm', se = F) + labs(x = "Date", y = "Close")
ggplot(data = AAPL.df, aes(x = date, y = AAPL.Close)) + geom_point() + geom_smooth(method = 'lm', se = F) + labs(x = "Date", y = "Close")
#ggplot(data = AAPL.df, aes(x = date, y = adjClose)) + geom_point() + geom_smooth(method = 'lm', se = F) + labs(x = "Date", y = "Close")
