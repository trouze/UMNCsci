machine1 <- function(){
  x1 <- rbinom(1,1,.35)
  return(x1)
}
machine2 <- function(){
  x2 <- rbinom(1,1,.45)
  return(x2)
}
###play best machine strategy
playbestmachine <- function(){
  pickmachine <- runif(1)
  p1 <- 0.5
  p2 <- 0.5
  plays <- 0
  wins1 <- 0
  wins2 <- 0
  loss1 <- 0 
  loss2 <- 0
  n <- 1000
  while(plays<=n){
    if(pickmachine>0.5){
      # start and play on machine 1
      while(p1>=p2 && plays<=n){
        play <- machine1()
        plays <- plays + 1
        if(play==1) wins1 <- wins1 + 1
        else loss1 <- loss1 + 1
        p1 <- (wins1+1)/(wins1+loss1+2)
      }
      while(p1<p2 && plays<=n){
        # switch to machine 2
        play <- machine2()
        plays <- plays + 1
        if(play==1) wins2 <- wins2 + 1
        else loss2 <- loss2 + 1
        p2 <- (wins2+1)/(wins2+loss2+2)
      }
    }
    else{
      # start and play on machine 2
      while(p2>=p1 && plays<=n){
        play <- machine2()
        plays <- plays + 1
        if(play==1) wins2 <- wins2 + 1
        else loss2 <- loss2 + 1
        p2 <- (wins2+1)/(wins2+loss2+2)
      }
      while(p1>p2 && plays<=n){
        # switch to machine 1
        play <- machine1()
        plays <- plays + 1
        if(play==1) wins1 <- wins1 + 1
        else loss1 <- loss1 + 1
        p1 <- (wins1+1)/(wins1+loss1+2)
      }
    }
  }
  return(sum(wins1,wins2))
}

# play the winner strategy
