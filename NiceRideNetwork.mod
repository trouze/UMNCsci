set stations; # set of origin stations
set arcs := {i in stations,j in stations : i<>j};

### parameters based on previous data and current state
param OPTIMAL_Bikes {i in stations}; # use forecast to determine these values per station
param current_bikes {i in stations}; # current number of bikes above or below hourly forecast 

param c {(i,j) in arcs}; #cost to transfer 1 bike from station i to station j
param Fc {(i,j) in arcs}; #fixed cost to transfer bike from station i to j (overhead)

### decision variables
var x {arcs} integer, >= -15, <= 15; # num of bikes to transfer from i to j
var y {arcs} binary; # indicator if x[i,j] is greater than 0, binary

minimize cost : sum{(i,j) in arcs} abs(x[i,j])*c[i,j] + sum{(i,j) in arcs} y[i,j]*Fc[i,j];

s.t. yvar {(i,j) in arcs} : y[i,j] >= x[i,j]/100; # set y var if bikes are moved
s.t. yvar2 {(i,j) in arcs} : y[i,j] >= x[i,j]/-100; # set y var if bikes are moved
s.t. Demand {i in stations} : sum{j in stations : i<>j} x[i,j] - OPTIMAL_Bikes[i] + current_bikes[i] = 0;
s.t. one_transfer {(i,j) in arcs} : y[i,j] + y[j,i] <= 1; # transfer bikes only in one direction


 