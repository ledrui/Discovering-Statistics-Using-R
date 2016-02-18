## Obama's Job Approval
library(pollstR)
library(car)
library(ggplot2)

setwd("~/Dropbox/Math567/Discovering-Statistics-Using-R/Project_1/")
imageDirectory <- "~/Dropbox/Math567/Discovering-Statistics-Using-R/Project_1"

slug <- "obama-job-approval"
start_date <- as.Date("2009-1-1")
end_date <- as.Date("2016-1-1")

## polster Chart
chart <- pollstr_chart(slug)
estimates <- chart[["estimates_by_date"]]
estimates <- estimate[estimates[["choice"]] = "Approve" | estimates[["choice"]] = "Disapprove"]
ggplot(estimates, aes(x = date, y = value, color = choice)) + geom_line()
ggsave(file = paste(imageDirectory,"2 O_job_app.png",sep="/"))

estimates <- estimates[estimates$date >= start_date & estimates$date < end_date,  ]
ggplot(estimates, aes(x = date, y = value, color = choice))

## and the opinion poll results
polls <- pollstr_polls(chart = slug, after = start_date, before = end_date, max_pages = 1000000);

## cleanning up the opinion poll

