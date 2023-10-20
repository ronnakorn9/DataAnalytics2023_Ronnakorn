#Landlock
EPILand<-EPI[!Landlock]
ELand <- EPILand[!is.na(EPILand)]
#
hist(ELand)
# capped x-axis within 30 - 95, set bin size to 1 and set y-axis to probability distribution
hist(ELand, seq(30., 95., 1.0), prob=TRUE)

# part 2
plot(ecdf(EPI_data$EPI),do.points=FALSE,verticals = TRUE)
plot(ecdf(EPI_data$EPI),do.points=TRUE,verticals = TRUE)
