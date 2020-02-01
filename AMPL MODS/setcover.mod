set DIST; # set of districts
set COUNTRY; # set of countries

param deviation {DIST};
param A {COUNTRY,DIST};

var x {DIST} binary;

maximize total_sales: sum{i in DIST} deviation[i]*x[i];

s.t. constraint{j in COUNTRY}: sum{i in DIST}A[j,i]*x[i] = 1;