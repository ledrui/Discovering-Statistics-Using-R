## Obama's Job Approval
library(pollstR)
library(car)
library(ggplot2)

setwd("~/Dropbox/Math567/Discovering-Statistics-Using-R/Project_1/")
imageDirectory <- "~/Dropbox/Math567/Discovering-Statistics-Using-R/Project_1"

slug <- "obama-job-approval"
start_date <- as.Date("2009-1-1")

## polster Chart
chart <- pollstr_chart(slug)
estimates <- chart[["estimates_by_date"]]

## filtering by date 
estimates <- estimates[ estimates$choice == "Approve" | estimates$choice == "Disapprove",]

## Ploting
ggplot(estimates, aes(x = date, y = value, color = choice)) + geom_line()
ggsave(file = paste(imageDirectory,"2 O_job_app.png",sep="/"))

