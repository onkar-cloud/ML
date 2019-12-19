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

	

	#dJ =0
	for( i in 1:nrow(x))
	{
		#J = 0
		
		
		for( j in 1: ncol(x))
		{
			z[j] = z[j] + .002*(y[i] - h[i]) * (x[i,j])
		}
			#dJ[j] = z[j]
					
	}
	
	#fr = fr+1
	print(abs(sum(z0 - z)))	
}

#[1]  41.57076404 -46.15746928   0.59042605  -2.33252190   0.56045280
# [6]  -0.37806586   1.88377548   4.07856953   1.58895799  -0.01503296
#[11]   0.19273691  -0.92590122  -0.83152802   0.52365727   0.09575345


