## Obama's Job Approval
library(pollstR)
library(car)
library(ggplot2)

imageDirectory <- "~/Dropbox/Math567/Discovering-Statistics-Using-R/Project_1"

slug <- "obama-job-approval"
start_date <- as.Date("2013-1-1")
end_date <- as.Date("2014-1-1")

chart <- pollstr_chart(slug)
estimates <- chart[["estimates_by_date"]]

estimates <- estimates[estimates$date >= start_date & estimates$date < end_date, ]

## and the opinion poll results
polls <- pollstr_polls(chart = slug, 
                        after = start_date, 
                        before = end_date,
                        max_pages = 1000000)

## cleanning up the opinion poll
question <- subset(polls[["questions"]], chart == slug 
	        & subpopulation %in% c("Adults", "Likely Voters", "Registered Voters"))

## recoding the choices into tree categories

approvalcat <- c("Approve" = "Approve",
                 "Disapprove" = "Disapprove",
                 "Undecided" = "Undecided",
                 "Neither" = "Undecided",
                 "Refused" = NA,
                 "Neutral" = "Undecided",
                 "Strongly Approve" = "Approve",
                 "Somewhat Approve" = "Approve", 
                 "Somewhat Disapprove" = "Disapprove",
                 "Strongly Disapprove" = "Disapprove")

questions2 <-
    (questions
     %>% mutate(choice = plyr::revalue(choice, approvalcat))
     %>% group_by(id, subpopulation, choice)
     %>% summarise(value = sum(value)))

## Now we have to merge the question data with the poll metadata
polldata <- merge(polls$polls, question2, by = "id")

## Now we plot the opinion poll result along wiht the Huffpost Pollster trend 
## estimates
plot <- (ggplot()
		 + geom_point(data = polldata,
		              mapping = aes(y = value, x = end_date, color = choice),
		              alpha = 0.3)
		 + geom_line(data = estimates,
		             mapping = aes(y = value, x = date, color = choice))
		 + scale_x_date("date")
		 + scale_color_manual(values = c("Approve" = "black", 
		                                 "Disapprove" = "red", 
		                                 "Undecided" = "blue"))
		 )

plot