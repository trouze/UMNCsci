GOOG <- read.csv('GooglePrice.csv')
plot.ts(GOOG$AdjClose)

acf(GOOG$AdjClose)
pacf(GOOG$AdjClose)

fitARIMA <- arima(GOOG$AdjClose, order = c(1,0,0))
acf(fitARIMA$residuals)

predict(fitARIMA, n.ahead=1)

GNP <- read.csv('GrossNationalProduct.csv')
plot.ts(GNP)

Quarter <- c(1:223)
GNP <- cbind(Quarter,GNP)
dif1 <- diff(GNP$gnp)
plot.ts(dif1)

acf(dif1)
pacf(dif1)

fit1 <- arima(dif1, order=c(1,0,0))
fit2 <- arima(dif1, order=c(2,0,0))

acf(fit1$residuals)
acf(fit2$residuals)
predict(fit2, n.ahead=1)

set.seed(2)
yt <- arima.sim(n=1000, list(ma=c(-0.5,-0.2)), sd=sqrt(0.01)) - 1
myacf <- acf(yt)
pacf(yt)

mean(yt)
var(yt)
myacf$acf[1:5]

ma2 <- arima(yt, order=c(0,0,2))
