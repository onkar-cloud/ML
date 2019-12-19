library(plyr)
library(tibble)
print("please enter the attributes of the query example") #here we ask for query example
a=as.numeric(readline("enter value of Sepal.Length="))
b=as.numeric(readline("enter value of Sepal.Width="))
c=as.numeric(readline("enter value of Petal.Length="))
d=as.numeric(readline("enter value of Petal.Width="))

query = c(a,b,c,d)

#historical data
IO = iris[1:5]
II = as.numeric(IO[,5])
I = IO[1:4]
IO = cbind(I,II)

#finding distances of query data from each of ex in historical data
	d = as.matrix(dist(rbind(query,I)))[-1,1]
	ds = sort(d)
	dss = as.numeric(names(ds))
	st = 0
		
#finding five nearest ex
	for(z in 1:4)
	{
		st[z] = as.numeric(IO[which(as.numeric(rownames(IO)) == dss[z]),5])
	}
		
#assigning majority class lable to the query example
	q = deframe(count(st))
	qq=which( q == max(q))
	if(length(qq) > 1)
	{
		a=as.numeric(names(qq))
		sum_d = 0
		for(m in (1:length(qq)))
		{
		sum_d[m]=sum(d[which(st == a[m])])
		}
		
		mode = a[which.min(sum_d)]
	}else
		mode = as.numeric(names(which.max(deframe(count(st)))))


	if(mode == 1)
	cat(" query belongs to setosa cluster", "\n")

	if(mode == 2)
	cat(" query belongs to versicolor cluster", "\n")

	if(mode == 3)
	cat(" query belongs to verginica cluster", "\n")
