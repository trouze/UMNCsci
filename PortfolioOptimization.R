require(PortfolioAnalytics)
require(quantmod)
require(forecast)
set.seed(123) # set seed for reproduction's sake

my.stocks<- c('BTC-USD', 'AAPL', 'ETH-USD', 'MSFT', 'XRP-USD', 'FB', 'LTC-USD', 'GOOG')
my.startdate <- "2017-12-01"
my.enddate <- "2018-12-01"

# instantiate portfolio environment
portf <- new.env()

# get risk free rate over chosen historical dates for Sharpe calculation
t3 <- getSymbols.FRED(Symbols = "DGS3MO", auto.assign = FALSE)
t3 <- t3[paste(my.startdate,my.enddate,sep="::")]
riskfree <- mean(na.omit(coredata(t3)))/100

# get stock data
for(i in 1:length(my.stocks)){
  getSymbols.yahoo(Symbols=my.stocks[i], env=portf, from=my.startdate, to=my.enddate)
}

# calculate daily stock return and daily return data cleaning
returns_dly <- lapply(portf, function(x) { periodReturn(tail(Ad(x), sapply(mget(my.stocks[1], envir = portf), nrow)), 'daily') })
returns_dly <- setNames(Reduce(merge, returns_dly), names(returns_dly))
returns_dly <- returns_dly[-1,]
returns_dly <- na.omit(returns_dly)

# calculate annual returns of each stock
returns_annual <- c()
for(m in 1:length(names(returns_dly))){
  returns_annual <- append(returns_annual,mean(na.omit(returns_dly[,m]))*(length(returns_dly)/length(names(returns_dly))),after=length(returns_annual))
}

# calculate covariance
var_annual <- c()
for(n in 1:length(names(returns_dly))){
  var_annual <- append(var_annual,var(na.omit(returns_dly[,n]))*(length(returns_dly)/length(names(returns_dly))),after=length(var_annual))
}

# setup for Monte Carlo simulation of portfolios

num_portfolios <- 10000
num_assets <- length(my.stocks)

# instantiate list for portfolio analyzation

port_returns <- matrix(ncol=1,nrow=num_portfolios)
port_volatility <- matrix(ncol=1,nrow=num_portfolios)
sharpe_ratio <- matrix(ncol=1,nrow=num_portfolios)
stock_weights <- matrix(ncol=num_assets,nrow=num_portfolios)

# MC Simulation of Portfolio Weightings
for(singlePortfolio in 1:num_portfolios){
  pWeights <- runif(num_assets)  # create Uniform random vars
  pWeights <- pWeights/sum(pWeights)  # normalize
  pReturn <- pWeights %*% returns_annual # take dot product of weights and annual returns
  pVolatility <- sqrt(sum(pWeights %*% (var_annual %*% t(pWeights)))) # find stdev of returns
  pSharpe <- (pReturn-riskfree) / pVolatility # calculate Sharpe Ratio of portfolio
  # build out our simulation results
  port_returns[singlePortfolio,1] <- pReturn
  port_volatility[singlePortfolio,1] <- pVolatility
  sharpe_ratio[singlePortfolio,1] <- pSharpe
  stock_weights[singlePortfolio,] <- pWeights
}
results <- cbind(port_returns,port_volatility,sharpe_ratio,stock_weights)
colnames(results) <- c('Return ', 'Volatility ', 'Sharpe',names(returns_dly))
results <- as.data.frame(results)

# find max sharpe and min volatility portfolio
maxsharpe <- which.max(results$Sharpe)
minvol <- which.min(results$Volatility)
maxsharpe.portfolio <- results[maxsharpe,]
minvol.portfolio <- results[minvol,]

# plot setup
color <- colorRampPalette(c('blue','green','yellow'))
mat <- results[,-4:-11]
mat$Col <- color(20)[as.numeric(cut(mat$Sharpe,breaks = 20))]
plot(mat$Volatility,mat$Return,xlim=c(0.4,1.5), ylim=c(-0.6,1.2),pch = 20,col = mat$Col)

# export data for manipulation in excel
write.csv(results,"portfolioexport.csv", row.names = FALSE)

# plotting results
optweights <- as.data.frame(maxsharpe.portfolio)
v <- 0
while(v < 3){
  optweights <- optweights[-1]
  v <- v+1
}

# get log return data
logreturns_dly <- lapply(portf, function(x) { periodReturn(tail(Ad(x), sapply(mget(my.stocks[1], envir = portf), nrow)), 'daily', type='log') })
logreturns_dly <- setNames(Reduce(merge, logreturns_dly), names(logreturns_dly))
logreturns_dly <- logreturns_dly[-1,]
logreturns_dly <- as.data.frame(logreturns_dly)
logreturns_dly[is.na(logreturns_dly)] <- 0
logreturns_dly <- na.omit(logreturns_dly)

# utilize optimal weights

a <- as.matrix(optweights) %*% t(as.matrix(na.omit(logreturns_dly)))
a <- t(a)

# visualize portfolio vs individual stocks
plot(cumsum(a), type='l', lwd=3,ylim=c(-1.5,2.5), main='Weighted Portfolio vs. Individual Stocks', xlab='Days', ylab='Return')
lines(cumsum(as.matrix(logreturns_dly[,1])), col='blue')
lines(cumsum(as.matrix(logreturns_dly[,2])), col='red')
lines(cumsum(as.matrix(logreturns_dly[,3])), col='green')
lines(cumsum(as.matrix(logreturns_dly[,4])), col='peru')
lines(cumsum(as.matrix(logreturns_dly[,5])), col='yellow')
lines(cumsum(as.matrix(logreturns_dly[,6])), col='orange')
lines(cumsum(as.matrix(logreturns_dly[,7])), col='purple')
lines(cumsum(as.matrix(logreturns_dly[,8])), col='brown')
legend(2,4,legend=c("Optimal Portfolio", names(optweights)), col=c('black','blue','red','green','peru','yellow','orange','purple','brown'),lty=1)
