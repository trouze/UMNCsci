unifgen <- function() {
  sum <- 0
  count <- 0
  while(sum < 1){
    u <- runif(1)
    sum <- sum + u
    count <- count + 1
  }
  return(count)
}

sampler <- function() {
  n <- 2
  x1 <- unifgen()
  x2 <- unifgen()
  meanj <- 0
  mean <- 0
  varj <- 0
  varc <- 0
  finalvar <- 0
  hw <- 1
  xtotal <- x1 + x2
  while(hw > 0.005){
    x <- unifgen() 
    xtotal <- xtotal + x
    n <- n + 1
    mean <- xtotal/n
    varc <- ((x-mean)^2)
    varj <- varj + varc
    finalvar <- varj/(n-1)
    hw <- qnorm(.975)*(sqrt(finalvar)/sqrt(n))
  }
  print(n)
  print(mean)
  print(finalvar)
  print(hw)
}
