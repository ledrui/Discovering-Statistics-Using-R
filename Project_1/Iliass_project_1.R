library(pollstR)
library(car)
library(ggplot2)

imageDirectory <- "~/Dropbox/Math567/Discovering-Statistics-Using-R/Project_1"

## Republican party
gop_chart <- pollstr_chart('2016-national-gop-primary')
print(gop_chart)

## plotting
gop_plot <- (ggplot(chart1[["estimates_by_date"]], aes(x = date, y = value, color = choice))+ geom_line())

## Democrate party
dem_chart <- pollstr_chart('2016-president-dem-primary', convert =TRUE)  
print(dem_chart)

## plotting
dem_plot <- (ggplot(chart1[["estimates_by_date"]], aes(x = date, y = value, color = choice))+ geom_line())