set J; # set of jobs

set S := {j in J, k in J :j <= k};

param r {J}; # releasing time
param p {J}; # processing time
param M := max{j in J}r[j] + sum{i in J}p[i];

var t {J} >= 0; # starting time
var x {S} binary;
var y >= 0;

minimize completion_time: y;

s.t. constraint1 {j in J}: y >= t[j] + p[j];
s.t. constraint2 {j in J}: t[j] >= r[j];
s.t. constraint3 {j in J, k in J: j <= k}: t[j] + p[j] <= t[k] + M*(1 - x[j,k]);
s.t. constraint4 {j in J, k in J: j <= k}: t[k] + p[k] <= t[j] + M*x[j,k];
