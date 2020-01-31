myrgen <- function(n,x) {
  gen1 <- function() {
    p <- runif(1)
    if(p>0.5){
      i <- (exp(-2*p))/-2
      }
    if (p<=0.5){
      i <- (exp(2*p))/2
    }
    return(i)
  }
  replicate(n,gen1())
}


# compare to R's function rpois()
myrvs <- myrgen(1000,0.5)
hist(myrvs)

