#### Begin optimization problem for optimal rebalancing based on system current state

set stations; # set of origin stations
#set destinationstations; # set of destination stations
set arcs := {i in stations,j in stations : i<>j};

### parameters based on previous data and current state
param DEMAND_Docks {j in stations}; # use forecast to determine these values per station
param avail_docks {j in stations}; # enter number of available docks at station i, capacity - avail docks = avail bikes

param DEMAND_Bikes {i in stations}; # use forecast to determine these values per station
param avail_bikes {i in stations}; # enter number of available bikes at station i, capacity - avail bikes = avail docks

param c {(i,j) in arcs}; #cost to transfer 1 bike from station i to station j
param Fc {(i,j) in arcs}; #fixed cost to transfer bike from station i to j (overhead)
param P {i in stations}; # penalty for unmet bike demand at station i
param D {j in stations}; # penalty for unmet dock demand at station j

### decision variables
var x {arcs} >= 0; # num of bikes to transfer from i to j
var y {arcs} binary; # indicator if x[i,j] is greater than 0, binary
var w {stations} >=0; # num of bikes demanded that are unmet at station i
var z {stations} >=0; # num of docks demanded that are unmet at station i

### objective function
minimize cost : sum{(i,j) in arcs} x[i,j]*c[i,j] + sum{(i,j) in arcs} y[i,j]*Fc[i,j] + sum{i in stations} w[i]*P[i] + sum{j in stations} z[j]*D[j];

### constraints
s.t. pickup_limit {i in stations} : sum{j in stations : i<>j} x[i,j] <= avail_bikes[i]; # limit bikes that can be picked up from a station
s.t. dropoff_limit {i in stations} : sum{j in stations : i<>j} x[i,j] <= avail_docks[i]; # limit on bikes that can be dropped off
s.t. yvar {(i,j) in arcs} : y[i,j] >= x[i,j]/max(avail_bikes[i]); # set y var if bikes are moved
s.t. one_transfer {(i,j) in arcs} : y[i,j] + y[j,i] <= 1; # transfer bikes only in one direction
s.t. wconst {i in stations}: w[i] >= DEMAND_Bikes[i] - avail_bikes[i] - DEMAND_Docks[i] + z[i] + sum{j in stations :i<>j} x[i,j] - sum{l in stations : l<>i} x[l,i];
s.t. zconst {i in stations}: z[i] >= DEMAND_Docks[i] - avail_docks[i] - DEMAND_Bikes[i] + w[i] - sum{j in stations:i<>j} x[i,j] + sum{l in stations : l<>i} x[l,i];
