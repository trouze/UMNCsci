var x1 >= 0 , integer;  # Flights by 707 to A
var x2 >= 0 , integer;  # Flights by 707 to B
var x3 >= 0 , integer;  # Flights by 707 to C
var x4 >= 0 , integer;  # Flights by 707 to D
var x5 >= 0 , integer;  # Flights by Prop to A
var x6 >= 0 , integer;  # Flights by Prop to B
var x7 >= 0 , integer;  # Flights by Prop to C
var x8 >= 0 , integer;  # Flights by DC9 to A
var x9 >= 0 , integer;  # Flights by DC9 to B
var x10 >= 0 , integer;  # Flights by DC9 to C
var x11 >= 0 , integer;  # Flights by DC9 to D

minimize cost : 6000*x1 + 7000*x2 + 8000*x3 + 10000*x4 + 1000*x5 + 2000*x6 + 4000*x7 + 2000*x8 + 3500*x9 + 6000*x10 + 10000*x11;

s.t. Service1 : x1 + x5 + x8 >= 4;
s.t. Service2 : x2 + x6 + x9 >= 4;
s.t. Service3 : x3 + x7 + x10 >= 4;
s.t. Service4 : x4 + x11 >= 2;
s.t. Flytime1 : x1+2*x2+5*x3+10*x4 <= 180;
s.t. Flytime2 : 2*x5+4*x6+8*x7 <= 270;
s.t. Flytime3 : x8+2*x9+6*x10+12*x11 <= 36;
