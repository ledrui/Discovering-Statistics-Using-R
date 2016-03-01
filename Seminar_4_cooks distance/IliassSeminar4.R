

setwd("~/Dropbox/Math567/Discovering-Statistics-Using-R/Seminar_4_cooks distance/")

#----access the album2 data----
album2<-read.delim("Album Sales 2.dat", header = TRUE)

#---Run the multiple regression model----
albumSales.2<-lm(sales ~ adverts, data = album2)
lm_moldel<-lm(sales ~ adverts + airplay + attract, data = album2)
summary(albumSales.2)
summary(lm_moldel)



##------ Analysing cook's Distance on the multiple regression albumSales.3


cooks.D <- cooks.distance(lm_moldel)

cooks.D > 3*mean(cooks.D) ## MatLab threshold 

influential <- find(cooks.D > 0.05)   ## di > 0.05 if k > 3
influential
plot(cooks.D, ylab = "cook's distance")
points(1, cooks.D[1], col = 'red')
points(164, cooks.D[164], col = 'red')
points(169, cooks.D[169], col = 'red')




##----------------Hat Values------------------------------

