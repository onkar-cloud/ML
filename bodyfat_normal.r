d= read.csv("datasets-numeric-bodyfat.csv")
y = d[,15]
x = cbind(rep(1,nrow(d)),d[,-15])

for(i in 2:ncol(x))
{
	x[,i] = abs((x[,i] - min(x[,i])) / (max(x[,i]) - min(x[,i])))
}
library('corpcor')
theta = pseudoinverse(as.matrix(x)) %*% as.matrix(y)
print(theta)

