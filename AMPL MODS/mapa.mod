var x1 >=0;  # Boxes of Grano
var x2 >=0;  # Boxes of Wheatie

maximize profit : 1*x1 + 1.35*x2;

subject to space : .2*x1 + .4*x2 <= 60;
subject to demand : x1 <= 200;
subject to demand2 : x2<= 120;

