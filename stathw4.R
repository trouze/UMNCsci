###problem1a
dat <- read.csv("RateprofThree.csv")
summary(dat)

###problem1b
mod1 <- lm(quality~pepper, data=dat)
summary(mod1)

###problem1c
plot(dat$pepper,dat$quality,type="l")

###problem1f
mod2 <- lm(quality~gender+pepper,data=dat)
summary(mod2)
plot(mod2)

##problem2a
dat <- read.table('http://gattonweb.uky.edu/sheather/book/docs/datasets/airfares.txt', header=T)
mod3 <- lm(Fare~Distance,data=dat)
summary(mod3)
#problem2b
plot(Fare~Distance,data=dat)
abline(mod3,col='red')
#problem2c
attach(dat)
plot(rstandard(mod3)~Distance)
abline(h=2)
#problem2d
newdat <- dat[-c(13,17),]
attach(newdat)
mod4 <- lm(Fare~Distance+I(Distance^2), data=newdat)
summary(mod4)




