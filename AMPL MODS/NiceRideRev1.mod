set stations; # set of origin stations
#set destinationstations; # set of destination stations
set arcs := {i in stations,j in stations : i<>j};

### parameters based on previous data and current state
param DEMAND_Differential {i in stations}; # use forecast to determine these values per station
param DEMAND_Bikes {i in stations}; # use forecast to determine these values per station
param avail_docks {j in stations}; # enter number of available docks at station i, capacity - avail docks = avail bikes
param avail_bikes {i in stations}; # enter number of available bikes at station i, capacity - avail bikes = avail docks

param nodedemdock {j in stations} := DEMAND_Docks[j]-avail_docks[j];
param nodedembike {i in stations} := DEMAND_Bikes[i]-avail_bikes[i];

param c {(i,j) in arcs}; #cost to transfer 1 bike from station i to station j
param Fc {(i,j) in arcs}; #fixed cost to transfer bike from station i to j (overhead)
param P {i in stations}; # penalty for unmet bike demand at station i
param D {j in stations}; # penalty for unmet dock demand at station j

### decision variables
var x {arcs} integer, >= 0; # num of bikes to transfer from i to j
var y {arcs} binary; # indicator if x[i,j] is greater than 0, binary
var w {stations} >=0; # num of bikes demanded that are unmet at station i
var z {stations} >=0; # num of docks demanded that are unmet at station i

minimize cost : sum{(i,j) in arcs} x[i,j]*c[i,j] + sum{(i,j) in arcs} y[i,j]*Fc[i,j] + sum{i in stations} w[i]*P[i] + sum{j in stations} z[j]*D[j];

s.t. yvar {(i,j) in arcs} : y[i,j] >= x[i,j]/max(avail_bikes[i]); # set y var if bikes are moved
s.t. demanddock {(i,j) in arcs} : nodedemdock[j] + z[j] <= x[j,i];
s.t. demandbike {(i,j) in arcs} : nodedembike[i] + w[i] <= x[i,j];
 