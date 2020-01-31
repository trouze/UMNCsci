## solve the gridworld example in the RL book using MC simulation
require(tidyverse)
S <- c("S1", "S2", "S3")
D <- c(1:36, "F", "S1", "S2", "S3")       # state space
A <- c("d","u","l","r") # action space

## we are in state s and we take action a. return the next state.
transition <- function(s, a) {
    idx <- match(a, A)
    switch(s,
           S1 = "S1",
           S2 = "S2",
           S3 = "S3",
           "1" = c("S3","2","1","10")[idx],
           "2" = c("1","3","2","11")[idx],
           "3" = c("2","4","3","12")[idx],
           "4" = c("3","5","4","13")[idx],
           "5" = c("4","6","5","14")[idx],
           "6" = c("5","7","6","15")[idx],
           "7" = c("6","8","7","16")[idx],
           "8" = c("7","9","8","17")[idx],
           "9" = c("8","9","9","18")[idx],
           "10" = c("S2","11","1","20")[idx],
           "11" = c("10","12","2","21")[idx],
           "12" = c("11","13","3","22")[idx],
           "13" = c("12","14","4","23")[idx],
           "14" = c("13","15","5","24")[idx],
           "15" = c("14","16","6","25")[idx],
           "16" = c("15","17","7","26")[idx],
           "17" = c("16","18","8","27")[idx],
           "18" = c("17","19","9","28")[idx],
           "19" = c("18","19","19","29")[idx],
           "20" = c("S1","21","10","20")[idx],
           "21" = c("20","22","11","21")[idx],
           "22" = c("21","23","12","22")[idx],
           "23" = c("22","24","13","23")[idx],
           "24" = c("23","25","14","24")[idx],
           "25" = c("24","26","15","25")[idx],
           "26" = c("25","27","16","26")[idx],
           "27" = c("26","28","17","27")[idx],
           "28" = c("27","29","18","31")[idx],
           "29" = c("28","30","19","32")[idx],
           "30" = c("29","30","30","33")[idx],
           "31" = c("31","32","28","34")[idx],
           "32" = c("31","33","29","35")[idx],
           "33" = c("32","33","30","36")[idx],
           "34" = c("34","35","31","F")[idx],
           "35" = c("35","36","32","F")[idx],
           "36" = c("35","36","33","F")[idx],
           F = "F",
           NA
           )
}
        
## Simulate an episode of grid world.
## inputs: state, policy
## outputs: actions taken, states visited, reward received
RT <- function(s, policy) {
    actions <- c()
    states <- s
    reward <- 0
    epsilon <- 0.1   # set this equal to zero for a strict policy

    repeat {

        ## choose an action according to the epsilon-soft policy
        if (runif(1) < epsilon) {
            a <- sample(setdiff(A, policy[s]), 1)
        } else {
            a <- policy[s]
        }
        actions <- append(actions, a)

        sprime <- transition(s, a) # transition from s to sprime
        states <- append(states, sprime)
        reward <- reward - 1       # a transition was made
        
        if (sprime == F) break
        s <- sprime
    }
    list(actions, states, reward)
}

## On-policy first-visit MC control for epsilon-soft policies to learn
## an optimal policy as described in section 5.4 of the RL book.

## initialization
policy <- c(rep("u", 40), NA) # an arbitrary, epsilon-soft policy
names(policy) <- D

Q <- array(0, dim=c(length(D), length(A)), dimnames=list(D, A))
counter <- array(0, dim=c(length(D), length(A)), dimnames=list(D, A))
forever <- 100000
k <- 0

## Generate episodes and observe the return. Here we update Q[s,a] and
## the policy for all states that were (first)-visited during the
## episode.
repeat {
    s <- sample(S[-length(S)], 1) # random starting state
    episode <- RT(s, policy)      # generate an episode
    actions <- episode[[1]]
    states <- episode[[2]]        # last state will be "T". there is no action for "T"
    reward <- episode[[3]]        # reward at end of episode
    F <- length(actions)
    G <- 0

    ## iterate through the episode in reverse so that we can
    ## check for first visits.
    for (t in F:1) { 
        G <- G - 1   # reward is -1 on all transitions

        ## is this the first visit to states[t]?
        first.visit <- TRUE
        if (t > 1) { # more than one state was visited, so check for 1st visit
            for (i in (t-1):1) {
                if (states[t]==states[i] && actions[t]==actions[i]) {
                    first.visit <- FALSE
                    break
                }
            }
        }
        if (!first.visit) next   # go to the next t

        ## incrementally update the average action-value Q[s,a]
        ## so that we don't need to store all of the returns.
        ## counter[s,a] is needed to keep track of the number
        ## of observations in the average.
        counter[states[t], actions[t]] <- counter[states[t], actions[t]] + 1
        Q[states[t], actions[t]] <- Q[states[t], actions[t]] +
            (G - Q[states[t], actions[t]])/counter[states[t], actions[t]]

        ## find the action(s) that acheive the max value and update the policy.
        q.star <- max(Q[states[t],])
        idx <- which(near(q.star, Q[states[t],]))
        if (length(idx) > 1) idx <- sample(idx, 1)  # there could be ties
        policy[states[t]] <- A[idx]
    }
    k <- k + 1
    if (k >= forever) break
}

## display the action-value function and the optimal policy.
print(Q)
print(t(policy))
