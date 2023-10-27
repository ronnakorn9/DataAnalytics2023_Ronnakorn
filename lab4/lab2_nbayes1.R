require(mlbench)
### add required library
library('e1071')
data(HouseVotes84)

### construct model
model <- naiveBayes(Class ~ ., data = HouseVotes84)
predict(model, HouseVotes84[1:10,-1])
predict(model, HouseVotes84[1:10,-1], type = "raw")

pred <- predict(model, HouseVotes84[,-1])
table(pred, HouseVotes84$Class)
### result
# pred         democrat republican
# democrat        238         13
# republican       29        155


## Example of using a contingency table:
data(Titanic)
m <- naiveBayes(Survived ~ ., data = Titanic)
m
pred <- predict(m, as.data.frame(Titanic)[,1:3])
table(pred, as.data.frame(Titanic)[,4])
# pred  No Yes
# No   7   7
# Yes  9   9
### not very good result

## Example with metric predictors:
data(iris)
m <- naiveBayes(Species ~ ., data = iris)
## alternatively:
m <- naiveBayes(iris[,-5], iris[,5])
m
table(predict(m, iris[,-5]), iris[,5])
