require(rpart)
summary(swiss)

### this is regression
swiss_rpart <- rpart(Fertility ~ Agriculture + Education + Catholic, data = swiss)

plot(swiss_rpart) # try some different plot options
text(swiss_rpart, cex=.8) # try some different text options

plot(swiss_rpart,compress=TRUE,margin=0.1) # add margin so the text don't get cut
text(swiss_rpart, use.n=TRUE, cex=.8) # add the leaf size and shrink the text by factor of 0.8

### plot the tree in rpart way
rpart.plot(swiss_rpart)

