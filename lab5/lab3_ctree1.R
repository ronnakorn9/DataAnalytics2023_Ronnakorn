require(rpart)
library("rpart.plot")

swiss_rpart <- rpart(Fertility ~ Agriculture + Education + Catholic, data = swiss)
plot(swiss_rpart) # try some different plot options
text(swiss_rpart) # try some different text options
rpart.plot(swiss_rpart, main = "Predicting fertility")


require(party)
treeSwiss<-ctree(Species ~ ., data=iris)
plot(treeSwiss)

cforest(Species ~ ., data=iris, controls=cforest_control(mtry=2, mincriterion=0))

treeFert<-ctree(Fertility ~ Agriculture + Education + Catholic, data = swiss)
plot(treeFert)


c_forest <- cforest(Fertility ~ Agriculture + Education + Catholic, data = swiss, controls=cforest_control(mtry=2, mincriterion=0))
help(cforest)
# look at help info, vary parameters.

library(tree)
tr <- tree(Species ~ ., data=iris)
tr
tr$frame
par(cex = 0.8)
plot(tr)
text(tr, use.n=TRUE, xpd=TRUE, cex=.8)
#find "prettier" ways to plot the tree



