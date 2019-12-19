	IO = read.csv("breast_cancer.csv")
	IO = IO[,-1]

	II = as.numeric(IO[,1])
	I = IO[2:31]
	IO = cbind(I,II)
	ran = sample(2,nrow(IO),T)


#shufflin for many different times (i.e. 25 timez)
	k = 0
	while(k <= 25)
	{
		A = IO[which(ran == 1),]
		B = IO[which(ran == 2),]
		IO = rbind(A , B)
		k =k+1
	}
		I = IO[1:30]
	
	LO = list()
	a = 1
	b = ceiling(nrow(IO)/5)
	for ( i in 1:4)
	{
		LO[[i]] = IO[a:b,]
		a = b+1
		b = b+ceiling(nrow(IO)/5)
	}
	LO[[5]] = IO[a:nrow(IO),]
	

	Z =0
	for(i in 1:5)
	{
		Z = rbind(Z,as.matrix(LO[[i]]))
	}
		Z = Z[-1,]

	accuracy=c()
	a = 1
	b = ceiling(nrow(IO)/5)

#finding bays' probabilities using normal distribution and assigning the class to each example.
#calculation for accuracy
	for(f in 1:5)
	{
		acc = 0
		mode = 0
		if(f<5)
		{
			for(i in 1:ceiling(nrow(I)/5))
			{
				P1 = 1
				P2 = 1
				for(c in 1:30)
				{
					Z0 = Z[-a:-b,]
					Z1 = Z0[which(Z0[,31] == 1),]
					Z2 = Z0[which(Z0[,31] == 2),]
					P1 = P1 * dnorm(LO[[f]][i,c],mean(Z1[,c]),sd(Z1[,c]))
					P2 = P2 * dnorm(LO[[f]][i,c],mean(Z2[,c]),sd(Z2[,c]))
				}	
					P1 = P1 * nrow(Z1)/nrow(Z0)
					P2 = P2 * nrow(Z2)/nrow(Z0)
					if(P1>P2)
						mode[i] = 1
		
					else
						mode[i] = 2
			}
			
			true = length(which(LO[[f]][,31] == mode))
			acc = true/(b-a+1)
			accuracy[f] = acc*100

			a = b+1
			b = b+ceiling(nrow(IO)/5)
		}
		else
		{
			for(i in 1:(nrow(I) - a + 1))
			{
				P1 = 1
				P2 = 1
				for(c in 1:30)
				{
					Z0 = Z[-a:-(nrow(I)),]
					Z1 = Z0[which(Z0[,31] == 1),]
					Z2 = Z0[which(Z0[,31] == 2),]
					P1 = P1 * dnorm(LO[[f]][i,c],mean(Z1[,c]),sd(Z1[,c]))
					P2 = P2 * dnorm(LO[[f]][i,c],mean(Z2[,c]),sd(Z2[,c]))
				}	
					P1 = P1 * nrow(Z1)/nrow(Z0)
					P2 = P2 * nrow(Z2)/nrow(Z0)
					if(P1>P2)
						mode[i] = 1
		
					else
						mode[i] = 2
			}
			
			true = length(which(LO[[f]][,31] == mode))
			acc = true/(nrow(I)-a+1)
			accuracy[f] = acc*100
		}

		cat("\n")
		cat("accuracy of fold ",f, "= ",accuracy[f],"\n" )
	}	

	cat("\n")
	cat("average prediction accuracy = ",mean(accuracy),"\n") 

