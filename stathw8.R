titanic <- read.csv("TitanicPartial.csv",header=T)
# problem a
men1 <- sum(titanic$Sex=="male" & titanic$Pclass==1 & titanic$Survived==1)/sum(titanic$Sex=="male" & titanic$Pclass==1)
men2 <- sum(titanic$Sex=="male" & titanic$Pclass==2 & titanic$Survived==1)/sum(titanic$Sex=="male" & titanic$Pclass==2)
men3 <- sum(titanic$Sex=="male" & titanic$Pclass==3 & titanic$Survived==1)/sum(titanic$Sex=="male" & titanic$Pclass==3)
women1 <- sum(titanic$Sex=="female" & titanic$Pclass==1 & titanic$Survived==1)/sum(titanic$Sex=="female" & titanic$Pclass==1)
women2 <- sum(titanic$Sex=="female" & titanic$Pclass==2 & titanic$Survived==1)/sum(titanic$Sex=="female" & titanic$Pclass==2)
women3 <- sum(titanic$Sex=="female" & titanic$Pclass==3 & titanic$Survived==1)/sum(titanic$Sex=="female" & titanic$Pclass==3)

# problem b
mod1 <- glm(Survived~1+as.factor(Pclass), family=binomial, data=titanic)
summary(mod0)

# problem d
mod2 <- glm(Survived~1+Pclass,family=binomial,data=titanic)
summary(mod2)

# problem f
mod3 <- glm(Survived~1+as.factor(Pclass)+Age+Sex, family=binomial, data=titanic)
output <- summary(mod3)

# problem h
oddsph <- exp(output$coefficients[4])-1
# problem i
oddspi <- exp(output$coefficients[5])-1
# problem j
jack <- 1/(1+exp(-output$coefficients[1]-output$coefficients[3]-output$coefficients[4]*20-output$coefficients[5]))
# problem k
predict(mod3,newdata=data.frame(Age=20,Pclass=3,Sex="male"),type="response")
# problem l
anv <- anova(mod1,mod3,test="Chisq")
# problem m
options(digits=22)
1-pchisq(869.81-647.28,df=711-709)
# problem n
mod4 <- glm(Survived ~ 1 + as.factor(Pclass) + Age + Sex + as.factor(Pclass):Sex, family=binomial, data=titanic)
summary(mod4)
extractAIC(mod3)
extractAIC(mod4,k=log(714))





