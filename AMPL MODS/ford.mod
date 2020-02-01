set Plant;
set Cars;

param c {Plant,Cars}; # variable cost per car
param f {Plant}; # fixed cost
param capacity {Plant}; # capacity of each plant production
param demand {Cars}; # cars that must be produced
param M := 2000; # a large number

var x {Plant,Cars} >= 0; # of cars produced at plant i
var y {Plant} binary;

minimize totalcost:
(sum {i in Plant, j in Cars} c[i,j]*x[i,j]) + sum {i in Plant} f[i]*y[i];
# variable per-unit cost plus fixed costs

s.t. cdemand {j in Cars}:
sum {i in Plant} x[i,j] = 500000; # of cars that must be produced

s.t. ccapacity {i in Plant}: {i in Plant} x[i,j] <= 200000;
# capacity of each plant production

s.t. fixedcharge {i in Plant}:
sum {j in Cars} x[i,j] <= M*y[i]; #incur fixed charge only if we open plant

s.t. 