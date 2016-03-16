library(quantmod)
library(ggplot2)

imageDirectory<-"C:/Users/liuya/Downloads" #set directory to save image
######A function to make it quick to save graphs in the image directory
saveInImageDirectory<-function(filename){
	imageFile <- file.path(imageDirectory, filename)
	ggsave(imageFile)	
}
######Initiate packages

######we use index to select the period, and keep consistency of time used by all methods 
######Please select corresponding i according to comments to show the plot, 
######  correlation table, regression, and prediction of desired period

######start and end are two list containing time information of all time period
start = c(as.Date("1986-03-01"),as.Date("2011-01-01"),as.Date("2011-07-01"),as.Date("2012-01-01"),as.Date("2012-07-01"),as.Date("2013-01-01"),as.Date("2013-07-01"),as.Date("2014-01-01"),as.Date("2014-07-01"),as.Date("2015-01-01"),as.Date("2015-07-01"),as.Date("2016-01-01"))
end = c(Sys.Date(),as.Date("2011-06-30"),as.Date("2011-12-30"),as.Date("2012-06-30"),as.Date("2012-12-30"),as.Date("2013-06-30"),as.Date("2013-12-30"),as.Date("2014-06-30"),as.Date("2014-12-30"),as.Date("2015-06-30"),as.Date("2015-12-30"),Sys.Date())

######index used to select period
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
i = 12 #2016 to now

######get stock value
getSymbols(c('AAPL','MSFT','^IXIC','NDX'), from = start[i], to = end[i])

######create data frames for desired data
MSFT.df = data.frame(date=time(MSFT), Cl(MSFT))
AAPL.df = data.frame(date=time(AAPL), Cl(AAPL))
NDX.df = data.frame(date=time(NDX), Cl(NDX))
IXIC.df = data.frame(date=time(IXIC), Cl(IXIC))

######adjust Apple's stock value by multiplying all value after split by 7,
###### and put the adjusted value in a new column
multiples = outer(AAPL.df$date >= as.Date("2014-06-09"),7) +
            outer(AAPL.df$date < as.Date("2014-06-09"),1)
AAPL.df$adjClose = AAPL.df$AAPL.Close * multiples

######individual scatter plot
ggplot(data = MSFT.df, aes(x = date, y = MSFT.Close)) + geom_point() + geom_smooth(se = F) + labs(x = "Date", y = "Close")
ggplot(data = AAPL.df, aes(x = date, y = AAPL.Close)) + geom_point() + geom_smooth(se = F) + labs(x = "Date", y = "Close")
#uncomment following line, if want to plot adjusted value of Apple 
#ggplot(data = AAPL.df, aes(x = date, y = adjClose)) + geom_point() + geom_smooth(se = F) + labs(x = "Date", y = "Close")
ggplot(data = NDX.df, aes(x = date, y = NDX.Close)) + geom_point() + geom_smooth(se = F) + labs(x = "Date", y = "Close")
ggplot(data = IXIC.df, aes(x = date, y = IXIC.Close)) + geom_point() + geom_smooth(se = F) + labs(x = "Date", y = "Close")

######superimposed scatter plot
date = c(MSFT.df$date,AAPL.df$date)
close = c(MSFT.df$MSFT.Close, AAPL.df$AAPL.Close)
label = c(rep('MSFT',nrow(MSFT.df)), rep('AAPL',nrow(AAPL.df)))
df2 = data.frame(date,close,label)#a data frame contains data of both Microsoft and Apple 
ggplot(data = df2, aes(x = date, y = close, color = label)) + geom_point() + geom_smooth(se = F) + labs(x = "Date", y = "Close")

#command to save graph
#change file name according to need
saveInImageDirectory("NDX3.png")
              
######correlation table 
df = merge(MSFT.df, AAPL.df, by = "date")   
df = merge(df, IXIC.df, by = "date")
df = merge(df, NDX.df, by = "date") #merge     
data = data.frame(MSFT = df$MSFT.Close, AAPL = df$AAPL.Close, IXIC = df$IXIC.Close, NDX = df$NDX.Close)
#uncomment following line to show the correlation table using adjusted Apple's value
#data = data.frame(MSFT = df$MSFT.Close, AAPL = df$adjClose, IXIC = df$IXIC.Close, NDX = df$NDX.Close)
cor(data, use = "complete.obs", method = "pearson")

######get regression coefficient (start date is considered to be time 0)
date=time(MSFT)-rep(start[i],nrow(MSFT.df))#set start date to time 0
MSFT.reg = lm(formula = MSFT.df$MSFT.Close ~ date)#build model
date=time(AAPL)-rep(start[i],nrow(AAPL.df))#set start date to time 0
AAPL.reg = lm(formula = AAPL.df$AAPL.Close ~ date)#build model
#AAPL.reg = lm(formula = AAPL.df$adjClose ~ date)#uncomment this line, if want to use adjusted Apple's value
summary(MSFT.reg)
summary(AAPL.reg)

######draw regression line
ggplot(data = MSFT.df, aes(x = date, y = MSFT.Close)) + geom_point() + geom_smooth(method = 'lm', se = F) + labs(x = "Date", y = "Close")
ggplot(data = AAPL.df, aes(x = date, y = AAPL.Close)) + geom_point() + geom_smooth(method = 'lm', se = F) + labs(x = "Date", y = "Close")
#uncomment this line, if want to use adjusted value of Apple
#ggplot(data = AAPL.df, aes(x = date, y = adjClose)) + geom_point() + geom_smooth(method = 'lm', se = F) + labs(x = "Date", y = "Close")

#get regression coefficient 
m=MSFT.reg$coefficients[2]
b=MSFT.reg$coefficients[1]

######function to make prediction of stock value using a regression model
######take the linear model, the start date of the linear model, and the date of prediction 
pricepredict<-function(rmodel,modelStartDate,predictDate){
  m=rmodel$coefficients[2]
  b=rmodel$coefficients[1]
  nstart=as.Date(modelStartDate)
  nend=as.Date(predictDate)
  ntime=nend-nstart
  predictAt=as.integer(ntime)
  y=m*predictAt+b
  return(y)
}

#####predict Microsoft stock value at 6 30, 2016 
pricepredict(MSFT.reg,start[i],"2016-06-30")

#prediction<-predict.lm(MSFT.reg,rep(182,200) )
#head(prediction)
#summary(prediction)
