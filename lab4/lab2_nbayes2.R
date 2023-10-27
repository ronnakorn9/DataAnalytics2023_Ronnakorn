library('e1071')

data(Titanic)
mdl <- naiveBayes(Survived ~ ., data = Titanic)
mdl
# etc.

