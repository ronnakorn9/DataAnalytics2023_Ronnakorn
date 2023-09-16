
library(ggplot2)


#Cumulative Density Function
plot(ecdf(EPI), do.points=FALSE, verticals=TRUE) 
#Quantile-Quantile?
par(pty="s") 
qqnorm(EPI); qqline(EPI)
#Simulated data from t-distribution:
x <- rt(250, df = 5)
qqnorm(x); qqline(x)
#Make a Q-Q plot against the generating distribution by: x<-seq(30,95,1)
qqplot(qt(ppoints(250), df = 5), x, xlab = "Q-Q plot for t dsn")
qqline(x)

help(distributions)
# try different ones.....

x <- seq(0, 1, length.out = 21)
y <- seq(0.2, 0.9, length.out = 21)
dist_x <- dcauchy(x, location = 0, scale = 1, log = FALSE)
dist_Y <- dcauchy(x, location = 0, scale = 1, log = FALSE)
data_frame <- data.frame(dist_x, dist_Y)

ggplot(data_frame, aes(x=dist_x)) + geom_density(alpha=.3)

