var xs1 >= 0; # flow from node s to node 1
var xs2 >= 0; # flow from node s to node 2
var x13 >= 0; # flow from node 1 to node 3
var x14 >= 0; # flow from node 1 to node 4
var x24 >= 0; # flow from node 2 to node 4
var x21 >= 0; # flow from node 2 to node 1
var x3t >= 0; # flow from node 3 to node t
var x43 >= 0; # flow from node 4 to node 3
var x4t >= 0; # flow from node 4 to node t
var xts >= 0; # flow from node t to node s

maximize flow : xts;

s.t. a : xs1 <= 4;
s.t. b : xs2 <= 6;
s.t. c : x13 <= 6;
s.t. d : x14 <= 2;
s.t. e : x24 <= 4;
s.t. f : x21 <= 4;
s.t. g : x3t <= 6;
s.t. h : x43 <= 1;
s.t. i : x4t <= 2;
s.t. j : xts <= 100000000000;
s.t. k : xs1 + xs2 - xts = 0;
s.t. l : x14 + x13 - xs1 - x21 = 0;
s.t. m : x21 + x24 - xs2 = 0;
s.t. n : x3t - x13 - x43 = 0;
s.t. o : x4t + x43 - x14 - x24 = 0;
s.t. p : xts - x3t - x4t = 0;

