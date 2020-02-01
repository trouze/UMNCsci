var x1 binary; #Firestation in city 1
var x2 binary; #Firestation in city 2
var x3 binary; #Firestation in city 3
var x4 binary; #Firestation in city 4
var x5 binary; #Firestation in city 5
var x6 binary; #Firestation in city 6

minimize Firestations : x1+x2+x3+x4+x5+x6;

subject to City 1 : x3+x4>=1;
subject to : x3+x4+x5>=1;
subject to : x4+x5+x6>=1;
subject to : x2+x5+x6>=1;
subject to : x1+x2>=1;
subject to : x1+x2+x6>=1;
