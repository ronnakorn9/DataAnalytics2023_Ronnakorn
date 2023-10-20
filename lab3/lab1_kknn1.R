require(kknn)
data(iris)
m <- dim(iris)[1]
### sampling 1/3 of data as validation set
val <- sample(1:m, size = round(m/3), replace = FALSE, 
	prob = rep(1/m, m)) 

iris.learn <- iris[-val,]
iris.valid <- iris[val,]
iris.kknn <- kknn(Species~., iris.learn, iris.valid, distance = 1,
	kernel = "triangular")
summary(iris.kknn)
fit <- fitted(iris.kknn)
table(iris.valid$Species, fit)
pcol <- as.character(as.numeric(iris.valid$Species))
### check which data points in validation set got misclassified
pairs(iris.valid[1:4], pch = pcol, col = c("green3", "red")[(iris.valid$Species != fit)+1])

