set I; # potential DC locations
set J; # set of stores

param c {I}; # opening costs
param t {I,J}; # transportation costs
param d {J}; # demand

var y {I} binary; # decisions for opening DCs
var x {I,J} >=0; # decision for quantity of goods sent from DCs to Stores

minimize total_cost: sum{i in I} (c[i]+sum{j in J} t[i,j]*x[i,j])*y[i];

s.t. demand {j in J}: sum{i in I} x[i,j] >= d[j];
