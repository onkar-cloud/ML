d= read.csv("datasets-numeric-bodyfat.csv")
y = d[,15]
x0 = rep(1,nrow(d))
x = cbind(x0,d[,-15])

z =0
#for(i in 1:ncol(x))
#{
#	z[i] = as.numeric(readline("enter values of theta one at a time:"))
#}

for(i in 2:ncol(x))
{
	x[,i] = abs((x[,i] - min(x[,i])) / (max(x[,i]) - min(x[,i])))
}
z = rep(0, ncol(x))
print(z)

z0 = rep(3, ncol(x))
fr = 1
while(abs(sum(z0 - z)) > 0.0002)
{
	z0 = z
	print(z0)
	
	h = 0
	for(i in 1:nrow(x))
	{
		h[i] = sum(z * x[i,])
	}
	#x11()
	#plot(h)

	

	dJ =0
	for( j in 1: ncol(x))
	{
		J = 0
		
		
		for( i in 1:nrow(x))
		{
			J = J + (y[i] - h[i]) * (x[i,j])
		}
			dJ[j] = z[j] + .002*J
					
	}
	z =  dJ
	#fr = fr+1
	print(abs(sum(z0 - z)))	
}





#z
#[1]  41.57125663 -46.15771003   0.59042500  -2.33166740   0.56015665
#[6]  -0.37800243   1.88378472   4.07773815   1.58919891  -0.01537821
#[11]   0.19276156  -0.92599155  -0.83156261   0.52359531   0.09576963


