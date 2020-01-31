create.sample <- function(){
  i <- 1
  menheight <- c()
  womenheight <- c()
  sampleofppl <- rbinom(10,1,0.48) #prob of 1 (man) is 0.48
  while (i < length(sampleofppl)) {
    if (sampleofppl[i]==1) {
      mval <- rnorm(1,mean=69.1,sd=2.9)
      menheight <- append(menheight,mval,after=length(menheight))
    }
    if (sampleofppl[i]==0) {
      wval <- rnorm(1,mean=64.5,sd=2.7)
      womenheight <- append(womenheight,wval,after=length(womenheight))
    }
    i <- i+1
  }
  heights <- c(menheight,womenheight)
  avg <- mean(heights)
  return(avg)
}
h <- c()
for (i in 1:10000) {
  h <- append(h,create.sample(),after=length(h))
}
xbar <- mean(h)
xsd <- sd(h)
PIupper <- xbar + qnorm(0.95)*xsd
PIlower <- xbar - qnorm(0.95)*xsd

##find max height

create.samplemax <- function(){
  i <- 1
  menheight <- c()
  womenheight <- c()
  sampleofppl <- rbinom(10,1,0.48) #prob of 1 (man) is 0.48
  while (i < length(sampleofppl)) {
    if (sampleofppl[i]==1) {
      mval <- rnorm(1,mean=69.1,sd=2.9)
      menheight <- append(menheight,mval,after=length(menheight))
    }
    if (sampleofppl[i]==0) {
      wval <- rnorm(1,mean=64.5,sd=2.7)
      womenheight <- append(womenheight,wval,after=length(womenheight))
    }
    i <- i+1
  }
  heights <- c(menheight,womenheight)
  max <- max(heights)
  return(max)
}
m <- c()
for (i in 1:10000) {
  m <- append(m,create.samplemax(),after=length(h))
}
maxxbar <- mean(m)
maxxsd <- sd(m)
maxPIupper <- maxxbar + qnorm(0.95)*maxxsd
maxPIlower <- maxxbar - qnorm(0.95)*maxxsd





