d = read.csv("x.csv",sep=',',header= T)
y = read.csv("y.csv",sep=',',header= T)
x0 = (rep(1,80))
data = cbind(x0,d,y)
given = cbind(x0,d)
pos = which(data[,4] == 1)
neg = which(data[,4] == 0)
x1 = data[,2]
x2 = data[,3]


z =0
for(i in 1:ncol(given))
{
	z[i] = as.numeric(readline("enter values of theta one at a time:"))
}
print(z)

z0 = c(1,1,1)
fr = 1
while(abs(sum(z0 - z)) > 0.00001)
{
	z0 = z
	
	g = function(ip)

	{
		f= (1. / (1+exp(-ip)))
		return(f)
	}

	h = 0
	for(i in 1:nrow(given))
	{
		ox = sum(z * given[i,])
		#(z) %*% t(given[i,])
		#print(ox)
		h[i] = g(ox)
	}
	x11()
	plot(h)
	#print(h)

	#H = matrix(0,ncol(given),ncol(given))
	dJ =0
	#for( j in 1: ncol(given))
	{#print("hii")
		J = 0
		hh = 0
		#for( k in 1:ncol(given))
		{
			#for( i in 1:nrow(given))
			{
				J = (t(as.matrix(given)) %*% as.matrix(h - y) )
			
				#hh = t(as.matrix(given)) %*	% diag((h)) %*% diag(( 1 - h)) %*% as.matrix(given)
				for(i in 1:nrow(given))
				{
					hh = hh + h[i] * (1-h[i]) * (t(as.matrix(given[i,])) %*% as.matrix(given[i,]))
				}
			}
				dJ = J/nrow(given)
			
				H = hh/nrow(given)
		}
	}

				#print(H); print(dJ)
				z = z - solve(H) %*% dJ
			fr = fr+1
			print(z0)
}

plot(x1[pos],x2[pos],xlim=c(15,60),ylim=c(40,90), xlab=" ",ylab=" ",col="dark red", pch = "+")
par(new=T)

plot(x1[neg],x2[neg], xlim=c(15,60), ylim=c(40,90), xlab=" ",ylab=" ",col="dark red", pch = "-")
par(new=T)
abline(-(z[1]/z[3]), -(z[2]/z[3]))
