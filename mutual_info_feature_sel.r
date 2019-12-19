

library(infotheo)
data = read.csv("breast_cancer.csv")[,-1]
#y = data[,1]
#data = data[,-1]

dat = discretize(data)
mut_inf = mutinformation(dat)[-1,1]
print(mut_inf)
