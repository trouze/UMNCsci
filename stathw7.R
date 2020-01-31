bridge <- read.table("http://gattonweb.uky.edu/sheather/book/docs/datasets/bridge.txt",header=T)
mod0 <- lm(Time ~ 1 + CCost + Dwgs, data=bridge)
summary(mod0)

par(mfrow=c(1,2))
plot(mod0,c(1,2))


summary(a <- powerTransform(Time ~ 1 + CCost + Dwgs, data=bridge))
boxcox(Time ~ 1 + log(CCost) + Dwgs,data=bridge)

mod1 <- lm(log(Time) ~ 1 + log(CCost) + log(Dwgs), data=bridge)
summary(mod1)
par(mfrow=c(1,2))
plot(mod1,c(1,2))

predict(mod1,newdata=data.frame(CCost=300,Dwgs=6),interval="prediction",level=0.95)
