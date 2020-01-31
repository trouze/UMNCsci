# this function generates a random exponential variable via U[0,1]
exp <- function(){
  x <- runif(5)
  expvar <- c()
  for(i in 1:5){
    expvar <- append(expvar,-1*log(1-x[i]), after=length(expvar))
  }
  return(expvar)
}
# this function generates an Antithetic exponential RV via U[0,1]
AVexp <- function(){
  x <- runif(5)
  expvar <- c()
  for(i in 1:5){
    expvar <- append(expvar,-1*log(1-(1-x[i])), after=length(expvar))
  }
  return(expvar)
}

# determine theta via MC simulation
u1 <- matrix(replicate(1000,exp()),ncol=5) # we generate 1000 exp RVs w/ 5 columns
over21 <- c()
for(b in 1:1000){
  eachrow <- c()
  for(i in 1:5){
    eachrow <- append(eachrow,i*u1[b,i]) # compute i*Xi for each row in the matrix u1
  }
  over21 <- append(over21,sum(eachrow)) # concatenate a list of sum i=1,..,5 i*Xi to test if over 21.6
}
theta1 <- sum(over21>=21.6)/1000
prob1 <- over21/1000
var1 <- var(prob1)

# generate exponential AV random variables
u2 <- matrix(replicate(1000,AVexp()),ncol=5)

# via AV
over21AV <- c()
for(c in 1:1000){
    eachrowAV <- c()
  for(j in 1:5){
    eachrowAV <- append(eachrowAV,j*u2[c,j])
  }
  over21AV <- append(over21AV,sum(eachrowAV))
}
AVtheta <- sum(over21AV>=21.6)/1000
prob2 <- over21AV/1000
AVvar <- (var(prob1)/2)+(cov(prob1,prob2)/2)
