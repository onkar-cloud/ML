library(plyr)
library(tibble)

train = read.csv("train_loan.csv")[,-1]
test = read.csv("test_loan.csv")[,-1]

y = train[,ncol(train)]
train = train[,-ncol(train)]
n_train = nrow(train)
data = rbind(train,test)
n_data = nrow(data)

data[,4] = abs(as.numeric(data[,4]))
data[which(data[,7] == 0),7] <- median(data[,7],na.rm=T)
data[which(data[,8] == 0),8] <- median(data[,8],na.rm=T)
data[(which(is.na(data[,9]))),9] <- median(data[,9],na.rm=T)

for(i in 1:(ncol(data)))
{
	data[,i][which(data[,i] == "")] <- names(which.max(deframe(count(data[,i]))))	
	data[(which(is.na(data[,i]))),i] <- names(which.max(deframe(count(data[,i]))))	
	data[,i] = as.numeric(data[,i])	
}

train = data[1:n_train,]
test = data[((n_train+1):n_data),]


