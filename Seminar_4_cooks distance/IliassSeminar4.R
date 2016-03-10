

setwd("~/Dropbox/Math567/Discovering-Statistics-Using-R/Seminar_4_cooks distance/")

#----access the album2 data----
album2<-read.delim("Album Sales 2.dat", header = TRUE)

#---Run the multiple regression model----

lm_moldel<-lm(sales ~ adverts + airplay + attract, data = album2)

summary(lm_moldel)



##------ Analysing cook's Distance on the multiple regression albumSales.3


cooks.D <- cooks.distance(lm_moldel)

cooks.D > 3*mean(cooks.D) ## MatLab threshold 

influential <- find(cooks.D > 0.05)   ## di > 0.05 if k > 3
influential
albumSales.2[cooks.distance()]
plot(cooks.D, ylab = "cook's distance")
points(1, cooks.D[1], col = 'red')
points(164, cooks.D[164], col = 'red')
points(169, cooks.D[169], col = 'red')




##----------------Hat Values------------------------------

hat_v <- hatvalues(lm_moldel)
# average hat value (k+1)/n
(3+1)/200
# result [1]:0.02
# exceptional hat_v are > 3 the average hat
influential_hat <- hat_v > 3*0.02
influential_hat
# Result four data point have hat _v > threshold 7, 12, 138, 181, 184

# ploting
plot(hat_v, ylab = "hat value")
# 
points(7,hat_v[7], col = 'green')
points(12, hat_v[12], col = 'green')
points(138, hat_v[138], col = 'green')
points(181, hat_v[181], col = 'green')
points(184, hat_v[184], col = 'green')
