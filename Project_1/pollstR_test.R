library(pollstR)
library(car)
library(ggplot2)

imageDirectory <- "~/Dropbox/Math567/Discovering-Statistics-Using-R/Project_1"

chart1 <- pollstr_chart('2016-national-gop-primary')
print(chart1)

## plotting
plot1 <- (ggplot(chart1[["estimates_by_date"]], aes(x = date, y = value, color = choice))+ geom_line())

## Obama Favorable rating
## charts
(ggplot(obama_favorable[["estimates_by_date"]], aes(x = date, y = value, color = choice))+geom_line())

## polls
obama_favorable_polls <- pollstr_polls(max_pages = 10000, chart = 'obama-favorable-rating', after = "2014-3-1")
str(obama_favorable_polls)