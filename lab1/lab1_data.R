
library(readxl)
EPI_data <- read.csv("./2010EPI_data.csv", skip = 1, header = TRUE)
#or
EPI_data_xl <- read_xls("./2010EPI_data.xls", sheet = 4)

# Note: replace default data frame name – cannot start with numbers!
View(EPI_data)
View(EPI_data_xl)
#
attach(EPI_data) 	# sets the ‘default’ object
fix(EPI_data) 	# launches a simple data editor

EPI <- EPI_data$EPI
EPI 			# prints out values EPI_data$EPI
tf <- is.na(EPI) # records True values if the value is NA
E <- EPI[!tf] # filters out NA values, new array

#other data
#GRUMP_data <- read.csv(”<path>/GPW3_GRUMP_SummaryInformation_2010.csv")

