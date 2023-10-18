# library(gdata) 
#faster xls reader but requires perl!
# bronx1<-read.xls(file.choose(),pattern="BOROUGH",stringsAsFactors=FALSE,sheet=1,perl="<SOMEWHERE>/perl/bin/perl.exe") 
# bronx1<-bronx1[which(bronx1$GROSS.SQUARE.FEET!="0" & bronx1$LAND.SQUARE.FEET!="0" & bronx1$SALE.PRICE!="$0"),]

#alternate
# library("xlsx")
# library("xlsx", lib.loc="/Library/Frameworks/R.framework/Versions/3.0/Resources/library")
# bronx1<-read.xlsx("<SOMEWHERE>/rollingsales_bronx.xls",pattern="BOROUGH",stringsAsFactors=FALSE,sheetIndex=1,startRow=5,header=TRUE)

# alternate 2
library(readxl)
bronx1 <- read_xls("./data/rollingsales_bronx.xls", sheet = 1, skip = 4)

### check column names
colnames(bronx1)
### fixing column names
colnames(bronx1) <- make.names(colnames(bronx1))


View(bronx1)
# warning: some sale price is 0



# attach(bronx1) # If you choose to attach, leave out the "data=." in lm regression
### remove column with all NA, "EASE.MENT" and "APART.MENT.NUMBER"
### remove 0 in result dataframe
# fixed_bronx1 <-  bronx1[, -c(7, 10)]
# fixed_bronx1[fixed_bronx1 == 0] <- NA
# fixed_bronx1 <- na.omit(fixed_bronx1)
### too much got removed 5268 -> 140 rows

fixed_bronx1 <- bronx1[bronx1$SALE.PRICE != 0 & bronx1$GROSS.SQUARE.FEET != 0 & bronx1$LAND.SQUARE.FEET != 0, ]
### now has 5268 -> 2437

attach(fixed_bronx1) 

### the value are already numeric without $ or ,
### read_xls probably fix that
# SALE.PRICE<-sub("\\$","",SALE.PRICE) 
# SALE.PRICE<-as.numeric(gsub(",","", SALE.PRICE)) 
# GROSS.SQUARE.FEET<-as.numeric(gsub(",","", GROSS.SQUARE.FEET)) 
# LAND.SQUARE.FEET<-as.numeric(gsub(",","", LAND.SQUARE.FEET)) 


plot(log(GROSS.SQUARE.FEET), log(SALE.PRICE)) 
m1<-lm(log(SALE.PRICE)~log(GROSS.SQUARE.FEET))
summary(m1)
abline(m1,col="red",lwd=2)
plot(resid(m1))

# Model 2

m2<-lm(log(SALE.PRICE)~log(GROSS.SQUARE.FEET)+log(LAND.SQUARE.FEET)+factor(NEIGHBORHOOD))
summary(m2)
plot(resid(m2))
# Suppress intercept - using "0+ ..."
m2a<-lm(log(SALE.PRICE)~0+log(GROSS.SQUARE.FEET)+log(LAND.SQUARE.FEET)+factor(NEIGHBORHOOD))
summary(m2a)
plot(resid(m2a))

# Model 3
m3<-lm(log(SALE.PRICE)~0+log(GROSS.SQUARE.FEET)+log(LAND.SQUARE.FEET)+factor(NEIGHBORHOOD)+factor(BUILDING.CLASS.CATEGORY))
summary(m3)
plot(resid(m3))

# Model 4
m4<-lm(log(SALE.PRICE)~0+log(GROSS.SQUARE.FEET)+log(LAND.SQUARE.FEET)+factor(NEIGHBORHOOD)*factor(BUILDING.CLASS.CATEGORY))
summary(m4)
plot(resid(m4))

### complete
