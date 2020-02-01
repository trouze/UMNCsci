set P; #set of products

param a {P}; #production rate
param b; #number of hours in a week
param c {P};
param u {P};

var x {P}; #amt of products to produce in a week

maximize profit: sum {j in P} c[j]*x[j];

s.t. capacity {j in P}: 0 <= x[j] <= u[j];
s.t. rate: sum{j in P} x[j]/a[j] <= b;