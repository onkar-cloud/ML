
library(randomForest)

library(caret)



data = read.csv("datasets-numeric-bodyfat.csv")

dt = sort(sample(nrow(data), nrow(data)*.8))
train<-data[dt,]

test<-data[-dt,]

y = train[,ncol(data)]
rf.mdl <- randomForest(train[,-ncol(data)], y, ntrees=500)


#rf.cv <- crossValidation(rf.mdl, train[,-ncol(data)], p=0.10, n=5, ntree=501)
decision <-predict(rf.mdl,test[,-ncol(data)])
actual = test[,ncol(data)]
print(decision)

print(actual)
