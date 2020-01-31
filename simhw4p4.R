arrivals <- c(12,20,33,44,55,56,61,63,66,70,73,75,78,80,82,85,87,90)
binfreq <- c(1,2,1,5,6,3)
a <- c()
for(i in binfreq){
  a <- append(a,(exp(-0.18)*(0.18)^i)/factorial(i))
}

b <- a[1:6]/sum(a)
chisq.test(binfreq,y=NULL, b)