library(cvTools)
library(robustbase)
data(coleman) # only have 20 rows...
call <- call("lmrob", formula = Y ~ .)
# set up folds for cross-validation
folds <- cvFolds(nrow(coleman), K = 5, R = 10)
help(cvTool)

# perform cross-validation
# using root trimmed mean squared prediction error
cvTool(call, data = coleman, y = coleman$Y, cost = rtmspe, folds = folds, costArgs = list(trim = 0.1))
#vary K and R
folds <- cvFolds(nrow(coleman), K = 5, R = 20)
cvTool(call, data = coleman, y = coleman$Y, cost = rtmspe, folds = folds, costArgs = list(trim = 0.1))
folds <- cvFolds(nrow(coleman), K = nrow(coleman), R = 5)
cvTool(call, data = coleman, y = coleman$Y, cost = rtmspe, folds = folds, costArgs = list(trim = 0.1))
### leave-one-out only return 1 result since any repeated split would be the same anyway


#look at cvfits, use densityplot, 
tuning <- list(tuning.psi=seq(1, 10., length.out = 100))
cvFitsLmrob <- cvTuning(call, data = coleman, y = coleman$Y, tuning = tuning, cost = rtmspe, folds = folds, costArgs = list(trim = 0.1))
# look at output
cvFitsLmrob
# summarize
aggregate(cvFitsLmrob, summary)
