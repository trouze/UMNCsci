# problem 3a for integration via MC sim
int <- function(t) 10*exp(-0.03*((t-7)^2))
s <- 0
t <- 17
n <- 10000
rand <- runif(n)

cars <- (t-s)/n * sum(int(s+(t-s)*rand))


##problem3c
s <- 1
t <- 3
n <- 10000
u <- runif(n)

carsin2 <- (t-s)/n * sum(int(s+(t-s)*rand))
p <- (exp(-1*carsin2) * carsin2^5) / (5*4*3*2)
