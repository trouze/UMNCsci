var x1 >= 0; # of cars produced at plant 1
var x2 >= 0; # of cars produced at plant 2
var x3 >= 0; # of cars produced at plant 3
var x4 >= 0; # of cars produced at plant 4
var y1 , binary; # if plant 1 is used
var y2 , binary; # if plant 2 is used
var y3 , binary; # if plant 3 is used
var y4 , binary; # if plant 4 is used

minimize cost : 7*y1 + .012*x1 + 6*y2 + .015*x2 + 4*y3 + .017*x3 + 2*y4 + .019*x4;

s.t. a : x1 <= 200000;
s.t. b : x2 <= 200000;
s.t. c : x3 <= 200000;
s.t. d : x4 <= 200000;
s.t. e : x1 + x2 + x3 + x4 >= 500000;
s.t. f : y3 + y4 - y1 <= 1;
s.t. g : x1 <= 1000000000000*y1;
s.t. h : x2 <= 1000000000000*y2;
s.t. i : x3 <= 1000000000000*y3;
s.t. j : x4 <= 1000000000000*y4;
