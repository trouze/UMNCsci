set OBJECTS;

param knapsacks > 0 integer;
set KNAP= 1 .. knapsacks;

param weight {OBJECTS} > 0;
param value {OBJECTS} > 0;

var x{OBJECTS,KNAP} binary;

maximize tot_value: sum{i in OBJECTS, j in KNAP} value[i]*x[i,j];

s.t. tot_weight {j in KNAP}: sum{i in OBJECTS} weight[i]*x[i,j] <= 50;
s.t. no_duplicates {i in OBJECTS}: sum{j in KNAP} x[i,j] <=1;