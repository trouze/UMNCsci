# at the roulette table, you start with $200 
place.bet <- function() runif(1) <= 18/38
betlist <- rep(10,10) # initialize bet list

play <- function() { # play our system one time
  amthistory <- 200 #amount history for compiling
  amt <- 200 #amount of cash in pocket
  betamt <- betlist[1]+betlist[length(betlist)] #current bet amount
  while (amt > 0 && amt < 300 && amt >= betamt) {
    betamt <- betlist[1]+betlist[length(betlist)] #current bet amount
    if (place.bet()) {
      amt <- amt + betamt # i won
      betlist <- betlist[-length(betlist)]
      betlist <- betlist[-1]
    } else {
      amt <- amt - betamt   # i lost :(
      betlist <- append(betlist,betamt,after=length(betlist))
    }
    amthistory <- c(amthistory, amt)
  }
  return(amthistory)
}

numwins <- 0
for (i in 1:10000) {
  h <- play()
  if (h[length(h)] == 300) {
    numwins <- numwins + 1 # count the win
  }
}
numwins/10000 # estimated probability of ending with 300

plot(play()) # plot one instance of playing our simple system