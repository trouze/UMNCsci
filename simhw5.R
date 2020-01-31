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
  x <- c(unifgen(),unifgen())
  meanj <- 0
  varj <- 0
  hw <- 1
  while(hw > 0.005){
    x <- append(x,unifgen(),after=length(x))
    meanj <- (1/n)*sum(x)
    varj <- var(x)
    hw <- qnorm(.975)*(varj/sqrt(n))
    n <- n + 1
  }
  return(n)
}