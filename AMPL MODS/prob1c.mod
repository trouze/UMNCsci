var x1;
var x2;
var x3 >=0;

maximize audience: 1800000*x1 + 1000000*x2 + 250000*x3;

s.t. budget: 20000*x1 + 10000*x2 + 2000*x3 <= 1000000;
s.t. tvmin: x1 >= 10;
s.t. personwk: x1 + 3*x2 + (1/7)*x3 <= 100;
s.t. radioreq: x3 <=120;
