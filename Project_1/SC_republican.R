
chart5<-pollstR::pollstr_chart(slug = "2016-south-carolina-presidential-republican-primary")

library(pollstR)
library(ggplot2)

slug = "2016-south-carolina-presidential-republican-primary"
start_date <- as.Date("2015-7-1")
end_date <- as.Date("2016-2-4")

chart <- pollstr_chart(slug)
candidates1<-chart$estimates_by_date[chart$estimates_by_date$choice %in% c("Trump","Kasich","Cruz","Bush","Rubio","Christie","Carson") ,]
estimates <- chart[["estimates_by_date"]]

estimates <- estimates[estimates$date >= start_date 
                       & estimates$date < end_date, ]

data1<-merge(estimates,candidates1)


chart6<-pollstR::pollstr_polls(chart =slug,after = start_date, before= end_date, max_pages = 1000000 )

candidates<-chart6$questions[chart6$questions$choice %in% c("Trump","Cruz","Kasich","Bush","Rubio","Christie","Carson") , ]

questions <-subset(chart6[["questions"]],subpopulation = "Likely Voters")
data <- merge(questions, candidates)

(ggplot()
+ geom_point(data = data,
             mapping = aes(y = value, x = end_date, color = choice),
             alpha = 0.3)
+ geom_line(data = data1,
            mapping = aes(y = value, x = date, color = choice))
+ scale_x_date("date")
)
