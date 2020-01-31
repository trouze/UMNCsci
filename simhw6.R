## helper functions for experimental design
design.matrix <- function(k,factor.list=rep(list(c(-1,1)), times=k)) expand.grid(factor.list)
main.effect   <- function(D,f,r) (D[,f] %*% r)/(nrow(D)/2)
interaction   <- function(D,f1,f2,r) ((D[,f1] * D[,f2]) %*% r)/(nrow(D)/2)

## read in results from dump truck simulation
X <- read.csv("newestoutput.csv")
attach(X)

## factor coding
##             -   +
## numcarts  16   20
## numselfcheckouts  1  2



D <- design.matrix(2)
n <- 10  # num replications

## compute the results as shown in Simio
mean.response <- tapply(CustomersLost, Scenario, mean)
var.response <- tapply(CustomersLost, Scenario, var)

## point estimates for main effects and interaction
main.effect(D, 1, mean.response)
main.effect(D, 2, mean.response)
interaction(D, 1, 2, mean.response)

## compute CIs
e1 <- numeric(n)
e2 <- numeric(n)
e12 <- numeric(n)
for (i in 1:n) {
    e1[i] <- main.effect(D, 1, CustomersLost[ Replication == i ])
    e2[i] <- main.effect(D, 2, CustomersLost[ Replication == i ])
    e12[i] <- interaction(D, 1, 2, CustomersLost[ Replication == i ])
}
mean(e1)
mean(e2)
mean(e12)

## helper function to compute a ci
ci <- function(x, alpha=.05) {
    xbar <- mean(x)
    s2 <- var(x)
    n <- length(x)
    cp <- qt(1-alpha/2, df=n-1)
    xbar + c(-1,1) * cp * sqrt(s2/n)
}

ci(e1, alpha=.03333)   # Bonferroni criteria so that overall confidence is 90%
ci(e2, alpha=.03333)
ci(e12, alpha=.03333)

## boxplots of the main effects and interaction
gg <- data.frame(effect=c(e1,e2,e12), factor=rep(c("numcarts","numselfcheckouts","interaction"), each=10))
with(gg, boxplot(effect ~ factor, ylab="effect"))

## add control data
X$numcarts <- rep(c(16,20), each=10, times=2)
X$numselfcheckouts <- rep(c(1,2), each=20)

## linear model
fm <- lm(CustomersLost ~ numcarts + numselfcheckouts, data=X)
summary(fm)  # should match the main effects

## linear model with interaction term
fm2 <- lm(CustomersLost ~ numcarts + numselfcheckouts +
        numcarts:numselfcheckouts, data=X)
summary(fm2)  # now be careful with the interpretaton of the main effects

b1 <- coef(fm2)[2]
b2 <- coef(fm2)[3]
b3 <- coef(fm2)[4]

b1 + b3*12 # effect of going from 16 to 20 carts when numselfcheckouts is 1
b1 + b3*10 # when numselfcheckouts is 2

mean(c(b1+b3*12, b1+b3*10)) # should match main effect of carts


# problem 2
u <- runif(1000)
x <- runif(1000)
onex1j <- x^2
onex2j <- x^3
twox1j <- x^2
twox2j <- (1-x)^3

# Covariance of systems
a <- cov(onex1j,onex2j)
b <- cov(twox1j,twox2j)

# Independent Var(x1j-x2j) of systems
indx1j <- u^2
c <- var(indx1j)+var(onex2j)


d <- var(indx1j)+var(twox2j)


# CRN variance of systems
sys1 <- c - 2*a
sys2 <- d - 2*b








