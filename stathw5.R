census <- read.csv("cps1985.csv")
mod0 <- lm(wage ~ 1 + exper +educ +sex + union, data=census)
summary(mod0)
plot(mod0)


census7 <- census[ which(census$exper == 7 & census$union == 'No'), ]
mod1 <- lm(wage ~ 1 + educ + sex,data=census7)
summary(mod1)

censusM <- census7[ which(census7$sex == 'M'), ]
mod2 <- lm(wage ~ 1 + educ, data=censusM)
summary(mod2)

educ <- seq(from=0,to=18,by=1)
fem <- -6.5799 + 0.9151*educ
male <- -4.7328 + 0.9151*educ
plot(fem, type='l', ylab='wage', xlab='years of education',main='Problem J')
lines(male)


houston <- read.csv("http://gattonweb.uky.edu/sheather/book/docs/datasets/HoustonChronicle.csv", header = TRUE)
names(houston)[2:3] <- c('Repeat', 'LowIncome') # re-name two variables
mod3 <- lm(Repeat~1+LowIncome,data=houston)

factorYear <- as.factor(houston$Year)
mod4 <- lm(Repeat ~ 1 + factorYear, data=houston)

mod5 <- lm(Repeat ~ 1 + LowIncome + factorYear + LowIncome:factorYear, data=houston)
mod6 <- lm(Repeat ~ 1 + LowIncome, data=houston)
anova(mod6,mod5)
f <- ((1751.9-1747.8)/1)/(1747.8/119)
1-pf(f,1,119)




