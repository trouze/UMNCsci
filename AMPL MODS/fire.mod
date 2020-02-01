var x1 , binary; # Firestation in City 1
var x2 , binary; # Firestation in City 2
var x3 , binary; # Firestation in City 3
var x4 , binary; # Firestation in City 4
var x5 , binary; # Firestation in City 5
var x6 , binary; # Firestation in City 6

minimize firestations : x1 + x2 + x3 + x4 + x5 + x6;

s.t. a : x1 + x2 >= 1;
s.t. b : x1 + x2 + x6 >= 1;
s.t. c : x3 + x4 >= 1;
s.t. d : x3 + x4 + x5 >= 1;
s.t. e : x4 + x5 + x6 >= 1;
s.t. f : x2 + x5 + x6 >= 1;
