# decision variables 
C <- 21 #station capacity
lambda <- 8.5 #bike arrival rate (needs dock) per 4 hour period
mu <- 8 #customer arrival rate (needs bike) per 4 hour period

I <- diag(1,C,C) #diagonal identity matrix
R <- matrix(nrow=C,ncol=C) #transition matrix

#below we develop R transition matrix

R[1,1] <- -lambda
for(i in 1:C-1){
  R[i,i+1] <- lambda
}
for(j in 1:C-1){
  R[j+1,j] <- mu
}
for(k in 2:C){
  R[k,k] <- -(lambda+mu)
}
for (x in 1:C){
  for(y in 1:C){
    if (is.na(R[x,y])) {
      R[x,y]<-0}}
}

S <- solve(I-R) # fundamental matrix which will tell us probability of having an empty or full station given we start at state i

#below function determines number of dissatisfied users based on initial inventory of bikes
bikepenalty <- 1 # penalty for not having a bike- can be set based on cost data of lost customers etc.
dockpenalty <- 1 # penalty for not having an open dock- can be set based on cost data of lost customers etc.
output <- matrix(1,C,1) # output vector that maps initial inventory to number of dissatisfied users
for(inv in 1:C){
  FI <- S[inv,1]*bikepenalty*mu+S[inv,C]*dockpenalty*lambda
  output[inv,1] <- FI*6 #multiply by 6 to find daily dissatisfied users (6x4=24)
}
print(output)
sink("NiceRide1.csv", append=TRUE)
cat("StationID",output,"\n\n")
  

