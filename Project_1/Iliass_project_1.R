library(pollstR)
library(car)
library(ggplot2)

setwd("~/Dropbox/Math567/Discovering-Statistics-Using-R/Project_1/")

imageDirectory <- "~/Dropbox/Math567/Discovering-Statistics-Using-R/Project_1"
start_date <- as.Date("2015-2-1")

## 2016 National Republican Primary
gop_chart <- pollstr_chart('2016-national-gop-primary')
gop_chart <- data.frame("gop_chart")
#gop_frame <- gop_chart[["estimates_by_date"]]

gop_frame <-gop_chart[gop_chart$date > as.Date("2015-02-01")]

#gop_frame <-gop_frame[gop_frame$date > as.Date("2015-02-01")]

## plotting
gop_plot <- (ggplot(gop_frame, aes(x = date, y = value, color = choice)) + geom_line())
gop_plot

## 2016 National Democrate Primary
dem_chart <- pollstr_chart('2016-president-dem-primary', convert =TRUE)  
print(dem_chart)

## plotting
dem_plot <- (ggplot(dem_chart[["estimates_by_date"]], aes(x = date, y = value, color = choice))+ geom_line())

### 2016 South Carolina Republican Presidential Primary
sc_chart <- pollstr_chart("2016-senate-dem-primary", state = SC)
sc_polls <- pollstr_polls(page = 1000,  topic = "2016-senate-dem-primary" )
sc_polls

### President Obama's Job Approval


### Congress Job Approval
slug <- "congress-job-approval"

## polster Chart
chart_congress <- pollstr_chart(slug)

# Filter by date
estimates_congress <- chart_congress[["estimates_by_date"]]

# Generate the plot using ggplot2 and save
ggplot(estimates_congress, aes(x = date, y = value, color = choice)) + geom_line()
ggsave(file = paste(imageDirectory,"Congress_job_app.png",sep="/"))



