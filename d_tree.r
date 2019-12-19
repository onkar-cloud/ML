library(caret)
library(rpart.plot)
library(rpart)
data = read.csv("breast_cancer.csv",sep=',',header= T)
data = data[,-1]

d = (data[,1])
I = data[2:31]
data = cbind(I,d)

intrain = createDataPartition(y = data$d, p= .7, list = FALSE)
training = data[intrain,]
testing = data[-intrain,]
#check dimensions of train & test set
dim(training); dim(testing);
trctrl <- trainControl(method = "repeatedcv", number = 5, repeats = 1)
#set.seed(55)
dtree_fit <- train(d ~., data = training, method = "rpart",
                   parms = list(split = "gini"),
                   trControl=trctrl,
                   tuneLength = 10)
 	
prp(dtree_fit$finalModel, box.palette = "Purples", tweak = 1)
print(dtree_fit)
test_pred <- predict(dtree_fit, newdata = testing)
print(confusionMatrix(test_pred, testing$d ))
