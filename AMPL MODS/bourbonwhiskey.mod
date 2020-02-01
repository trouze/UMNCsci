var x1 >= 0;  # Bottles of Bourbon 
var x2 >= 0;  # Bottles of Whiskey

maximize revenue : 6*x1 + 5.4*x2;

subject to machinecap : 3*x1 + 4*x2 <= 20000;
subject to capital : .3*x1 + .38*x2 <= 4000;
