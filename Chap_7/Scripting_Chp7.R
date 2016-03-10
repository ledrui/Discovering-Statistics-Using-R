library(car)
library(QuantPsyc)
library(boot)


setwd("~/Dropbox/Math567/Discovering-Statistics-Using-R/Chap_7/")

album1 <-read.delim("Album Sales 1.dat", header = TRUE)

# running the prediction using lm()

album.Sales.1 <-lm(sales ~ adverts, data = album1, na.action = na.exclude)
summary(album.Sales.1)
sqrt(0.3347)

