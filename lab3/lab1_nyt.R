nyt1<-read.csv("./data/nyt1.csv")
nyt1<-nyt1[which(nyt1$Impressions>0 & nyt1$Clicks>0 & nyt1$Age>0),]
### data goes from 458441 -> 22062

nnyt1<-dim(nyt1)[1]		# shrink it down!

sampling.rate=0.9
num.test.set.labels=nnyt1*(1.-sampling.rate)

### spliting train-test
training <-sample(1:nnyt1,sampling.rate*nnyt1, replace=FALSE)
train<-subset(nyt1[training,],select=c(Age,Impressions))
testing<-setdiff(1:nnyt1,training)
test<-subset(nyt1[testing,],select=c(Age,Impressions))

### split out target variable
cg<-nyt1$Gender[training]
true.labels<-nyt1$Gender[testing]

### knn classifier
classif<-knn(train,test,cg,k=5) #
classif<-kknn(train,test,cg,k=5) #
classif
attributes(.Last.value) 

