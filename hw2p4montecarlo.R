vals <- matrix(data=NA, nrow = 2, ncol= 10000)

covariance.sim <- function(){
  samp <- replicate(n=10000,runif(1)) #randomly sample a uniform distribution
  vals[1,1:10000] <- samp
  vals[2,1:10000] <- exp(samp)
  return(vals)
}
runmatrix <- matrix(data=covariance.sim(),nrow=2) #turn function output into a matrix
cov(runmatrix[1,1:10000],runmatrix[2,1:10000]) # calculate covariance of simulation
