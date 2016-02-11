library(pollstR)
library(car)
library(ggplot2)

imageDirectory <- "~/Dropbox/Math567/Discovering-Statistics-Using-R/Project_1"
start_date <- as.Date("2015-2-1")

## Republican party
gop_chart <- pollstr_chart('2016-national-gop-primary')
gop_estimate <- gop_chart[["estimates_by_date"]]
gop_estimate <- gop_estimate[gop_estimate$Date >= start_date]
## plotting
gop_plot <- (ggplot(gop_estimate, aes(x = date, y = value, color = choice))+ geom_line())
gop_plot
## Democrate party
dem_chart <- pollstr_chart('2016-president-dem-primary', convert =TRUE)  
print(dem_chart)

## plotting
dem_plot <- (ggplot(dem_chart[["estimates_by_date"]], aes(x = date, y = value, color = choice))+ geom_line())