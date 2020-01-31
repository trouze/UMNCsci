#find probablilities
P <- c()
for(i in 1:10){
  cuml <- c(0.1,0.23,0.48,0.61,0.7,0.82,0.84,0.9,0.95,1)
  P <- append(P,(cuml[i]*(1-cuml[i])*(1-cuml[i])*3)+(cuml[i]*cuml[i]*(1-cuml[i])*3)+(cuml[i]^3),after=length(P))
}
lilp <- c()
for(i in 1:9){
  lilp <- append(lilp, P[i+1]-P[i],after=length(lilp))
}

#run simulation for proposed process
run.sim <- function() {
  arrivaltime <- c()
  bearingfail <- c() 
  ###
  bearing.dist <- function() { 
    sample(x=seq(1000,1900,100),1,replace=T,prob=c(.1,.13,.25,.13,.09,.12,.02,.06,.06,.05)) 
  }
  arrival.dist <- function(n) {
    sample(x=c(5,10,15),n,replace=T,prob=c(0.6,0.3,0.1))
  }
  
  bearingfail <- bearing.dist()
  while(sum(bearingfail) < 100000) bearingfail <- append(bearingfail,bearing.dist(),after=length(bearingfail))
  
  arrivaltime <- arrival.dist(length(bearingfail))
  
  ##cost
  failures <- sum(length(bearingfail))
  delaytime <- sum(arrivaltime)
  
  downtime <- failures*40
  totrepairtime <- failures*40
  
  failures*48 + delaytime*10 + downtime*10 + totrepairtime*(1/2)
}

totalcost <- replicate(1000,run.sim())
mean(totalcost)
var(totalcost)



