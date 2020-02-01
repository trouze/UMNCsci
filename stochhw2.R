# IE 4011 Homework #2

# Mass functions evaluated for x=0,1,2...,M
M <- 15

# Parameters of Poisson r.v.'s X and Y
LamX <- 2
LamY <- 3
LamW <- 5

# Put the Mass Function of X into the vector MassFunctionX
# Be careful, vector indexing starts at 1, so: MassFunctionX[x+1] = P(X = x) 
MassFunctionW <- numeric(M+1)
for (w in 0:M){
  MassFunctionW[w+1] <- dpois(w, LamW)
}

# The preceding can be done without a loop with the following command
# MassFunctionX <- dpois(0:M,LamX)

# Put the Mass Function of Y into the vector MassFunctionY
MassFunctionY <- numeric(M+1)
for (x in 0:M){
  MassFunctionY[x+1] <- dpois(x, LamY)
}

# Convolution to Compute Mass Function of Z = X + Y
MassFunctionZ <- numeric(M+1)
for (z in 0:M){
  for (x in 0:z){
    # P(Z=z) = P(X=0)*P(Y=z) + P(X=1)*P(Y=z-1) + P(X=2)*P(Y=z-2) +...+ P(X=z)*P(Y=0)
    # The loop over x computes the above summation via P(Z=z) = P(Z=z) + P(X=x)*P(Y=z-x)
    MassFunctionZ[z+1] <- MassFunctionZ[z+1] + MassFunctionX[x+1]*MassFunctionY[z-x+1]
  }
}

# Remove file "HW_2_Output.txt" if it already exists
file.remove("HW_2_Output.txt")

# Print the Output to "HW_2_Output.txt" using 'sink' and 'cat' commands
sink("HW_2_Output2.txt", append=TRUE)
cat("PART A\n\n")
for (w in 0:M){
  cat("P(W = ",w,") = ", MassFunctionW[w+1], "\n", sep="")
}
cat("\n")
for (x in 0:M){
  cat("P(Y = ",x,") = ", MassFunctionY[x+1], "\n", sep="")
}
cat("\n")
cat("PART B\n\n")
for (x in 0:M){
  cat("P(Z = ",x,") = ", MassFunctionZ[x+1], "\n", sep="")
}
sink()
