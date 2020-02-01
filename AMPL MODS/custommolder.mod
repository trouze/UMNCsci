var x1 >= 0;  # 6-oz juice glasses (hundreds of cases per week)
var x2 >= 0;  # 10-oz cocktail glasses

maximize profit: 500*x1 + 450*x2;

s.t. production: 6*x1 + 5*x2 <= 60;

s.t. storage: 10*x1 + 20*x2 <= 150;

s.t. sales: x1 <= 8;