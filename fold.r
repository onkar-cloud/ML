library(plyr)
library(tibble)
set.seed(777070)
IO = iris[1:5]
II = as.numeric(IO[,5])
I = IO[1:4]
IO = cbind(I,II)
ran = sample(3,150,T)

#shufflin for many different times (i.e. 25 timez)
	k = 0
		while(k <= 25)
		{
		A = IO[which(ran == 1),]
		B = IO[which(ran == 2),]
		C = IO[which(ran == 3),]
		IO = rbind(A , B , C)
		k =k+1
		}
		I = IO[1:4]
		
n=as.numeric(readline("enter no of folds that will equally divide 150 samples=  "))
	LO = list()
	a = 1
	b = 150/n
	for ( i in 1:n)
	{
		LO[[i]] = IO[a:b,]
		a = b+1
		b = b+(150/n)
	}
		
	L = list()
	a = 1
	b = 150/n
	for ( i in 1:n)
	{
		L[[i]] = I[a:b,]
		a = b+1
		b = b+(150/n)
	}
	
Z =0
for(i in 1:n)
	{
		Z = rbind(Z,as.matrix(L[[i]]))
	}
		Z = Z[-1,]
    
 #finding distances of query data example of test fold from each of ex in historical data (i.e. other folds)
 #finding k nearest ex
 #assigning majority class lable to the query example
    
    meanA = c()
for(k in seq(1,15,by = 1))
{  
	accuracy=c()
	for(f in 1:n)
	{
		acc = 0
		mode = 0
		for(i in 1:150/n)
		{
			d = as.matrix(dist(rbind(L[[f]][i,],Z[which(rownames(Z) != rownames(L[[f]])),])))[-1,1]
			ds = sort(d)

		
			dss = as.numeric(names(ds))
			#nn = dss[1:15]
			st = 0
		
			for(z in 1:k)
			{
			st[z] = as.numeric(IO[which(as.numeric(rownames(IO)) == dss[z]),5])
			}
			
			
			#handelling the clashes if any
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
	
				mode[i] = a[which.min(sum_d)]
			}
			else
				mode[i] = as.numeric(names(which.max(deframe(count(st)))))
		
		}
		true = length(which(LO[[f]][,5] == mode))
			acc = true/150 * n
			accuracy[f] = acc*100
		
	}	
	cat("\n")
	cat("\n")
	cat("accuracy of each fold for ",k, 'neighbour = ', accuracy,"\n" )
	cat("\n")
	cat("average prediction accuracy for ", k, "_N-N :",mean(accuracy),"\n") 
	
	meanA[k] = mean(accuracy)
	
}
    cat("\n")
	cat("\n")
	cat("\n")
    cat("optimised value of k is",  which.max(meanA))
    cat("\n")
