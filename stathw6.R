rateprof <- read.csv('Rateprof8.csv')

mod0 <- lm(quality ~ . , data = rateprof)
step(mod0,direction = "backward",k=2)

mod0 <- lm(quality ~ . , data = rateprof)
step(mod0,direction = "backward",k=log(366))
mod6 <- lm(quality~1+clarity+easiness,data=rateprof)
extractAIC(mod6,k=log(366))

mod1 <- lm(quality ~ 1, data=rateprof)
step(mod1,direction = "forward",scope=list(lower=mod1,upper=mod0),k=2)

# set.seed allows for reproducible results
set.seed(3032)
# error vector: 100 values from N(0, 1) distributions
e = rnorm(n = 100, mean = 0, sd = 1)
#predictor vectors
x1 = rnorm(n = 100, mean = 5, sd = 100)
x2 = x1 + 2
#response vector
y = x1 + 0.1*x2 + e
#putting together in one dataframe
dat1 = data.frame(x1 = x1, x2 = x2, y = y)

cor(dat1$x1,dat1$x2)
mod2 <- lm(y~1+x1+x2,data=dat1)
summary(mod2)


# set.seed allows for reproducible results
set.seed(3032)
# error vector
e = rnorm(n = 100, mean = 0, sd = 1)
# predictor vectors
x1 = rnorm(n = 100, mean = 5, sd = 100)
x2 = rnorm(n = 100, mean = -4, sd = 125)
#response vector
y = x1 + 0.1*x2 + e
#putting together in one dataframe
dat2 = data.frame(x1 = x1, x2 = x2, y = y)
cor(dat2$x1,dat2$x2)

mod3 <- lm(y~1+x1+x2,data=dat2)
summary(mod3)

# set.seed allows for reproducible results
set.seed(3032)
# error vector
e = rnorm(n = 100, mean = 0, sd = 1)
# predictor vectors
x1 = rnorm(n = 100, mean = 5, sd = 100)
x2 = x1 -9 + rnorm(100, 0, 0.25)
# response vector
y = x1 + 0.1*x2 + e
# putting together in one dataframe
dat3 = data.frame(x1 = x1, x2 = x2, y = y)

cor(dat3$x1,dat3$x2)
mod4 <- lm(y~1+x1+x2, data=dat3)
summary(mod4)

# change the seed to collect a different sample data
set.seed(3033)
# error vector
e = rnorm(n = 100, mean = 0, sd = 1)
#predictor vectors
x1 = rnorm(n = 100, mean = 5, sd = 100)
x2 = x1 -9 + rnorm(100, 0, 0.25)
#response vector
y = x1 + 0.1*x2 + e
#putting together in one dataframe
dat4 = data.frame(x1 = x1, x2 = x2, y = y)
cor(dat4$x1,dat4$x2)
mod5 <- lm(y~1+x1+x2,data=dat4)
summary(mod5)
