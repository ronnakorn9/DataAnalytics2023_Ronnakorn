library(ggplot2)
summary(kyphosis)

my_cols <- c("#00AFBB", "#FC4E07")  
ggplot(data = kyphosis, aes(x=Age, y=Number)) + geom_point()
pairs(kyphosis[,2:4], pch = 35,  cex = 1, col = my_cols[kyphosis$Kyphosis],
      lower.panel=NULL)

fitK <- ctree(Kyphosis ~ Age + Number + Start, data=kyphosis)
plot(fitK, main="Conditional Inference Tree for Kyphosis")
plot(fitK, main="Conditional Inference Tree for Kyphosis",type="simple")

#etc.

