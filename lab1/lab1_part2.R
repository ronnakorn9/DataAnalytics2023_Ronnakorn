### part 2
### more exploration on EPI data
library(readxl)
EPI_data <- read.csv("./2010EPI_data.csv", skip = 1, header = TRUE)
attach(EPI_data)
EPI <- EPI_data$EPI

qqnorm(ENVHEALTH); qqline(ENVHEALTH)

qqnorm(ECOSYSTEM); qqline(ECOSYSTEM)

boxplot(CO2KWH_w, DALY_tr)

boxplot(SO2_tr, NOX_tr, NMVOC_tr)
### basic regression
multivariate <- read.csv("./multivariate.csv", header = TRUE)
summary(multivariate)
View(multivariate)

attach(multivariate)
mm <-lm(Homeowners~Immigrant)
summary(mm)
# plot it
plot(Homeowners~Immigrant)
abline(mm)
abline(mm,col=2,lwd=3)

# checking homeowner vs area
mm <-lm(Homeowners~area)
summary(mm)
# plot it
plot(Homeowners~area)
abline(mm)
abline(mm,col=2,lwd=3)
# result: a very visible positive correlation

### plotting graph
library(ggplot2)
# mtcars is a built-in dataset
plot(mtcars$wt, mtcars$mpg) # weight vs miles per gallon
qplot(mtcars$wt, mtcars$mpg) # change the visual
ggplot(mtcars, aes(x=wt, y= mpg)) + geom_point()

# temperature line plot
plot(pressure$temperature, pressure$pressure, type = "l")
points(pressure$temperature, pressure$pressure)
# equivalent command in ggplot
ggplot(pressure, aes(x = temperature, y = pressure)) + geom_line() + geom_point()

# bar plot
help(mtcars)
barplot(table(mtcars$cyl)) # Number of cylinders
ggplot(mtcars, aes(x = cyl)) + geom_bar()
# change cyl from continuous value to categorical value
ggplot(mtcars, aes(x = factor(cyl))) + geom_bar() # notice the change in x-axis

# histrogram
hist(mtcars$mpg)
hist(mtcars$mpg, breaks = 20) # breaks = how many bin
# now using ggplot
ggplot(mtcars, aes(x=mpg)) + geom_histogram()
ggplot(mtcars, aes(x=mpg)) + geom_histogram() + geom_density()
ggplot(mtcars, aes(x=mpg)) + geom_histogram(binwidth = 5) + geom_density()