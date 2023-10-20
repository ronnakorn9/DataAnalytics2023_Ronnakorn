data(swiss)

### all-par scatter plot for given set of attributes
pairs(~ Fertility + Education + Catholic, data = swiss, subset = Education < 20, main = "Swiss data, Education < 20")

### removing filter
pairs(~ Fertility + Education + Catholic, data = swiss, main = "Swiss data, Education < 20")
### seem like there's a few point when education > 20
