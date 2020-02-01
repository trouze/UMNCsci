set DIST;     # distibution centers
set DEALER;   # dealers

param cost {DIST,DEALER};  # cost to ship one unit from DC i to dealer j
param supply {DIST};       # supply at each DC
param demand {DEALER};     

var x {i in DIST,j in DEALER} >= 0;  # number of units to ship from DC i to dealer j

minimize totalcost: 
  sum {i in DIST, j in DEALER} cost[i,j]*x[i,j];

s.t. distsupply {i in DIST}:
  sum {j in DEALER} x[i,j] = supply[i];

s.t. dealerdemand {j in DEALER}:
  sum {i in DIST} x[i,j] = demand[j];