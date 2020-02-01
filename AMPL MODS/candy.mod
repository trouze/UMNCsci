var x1 >=0;  # ounces of sugar in Easy out
var x2 >=0;  # ounces of nuts in Easy out
var x3 >=0;  # ounces of chocolate in Easy Out
var x4 >=0;  # ounces of sugar in Slugger
var x5 >=0;  # ounces of nuts in Slugger
var x6 >=0;  # ounces of chocolate in Slugger

maximize revenue: .25*x1 + .25*x2 + .25*x3 + .2*x4 + .2*x5 + .2*x6;
s.t. sugar: x1 + x4 <= 100;
s.t. nuts: x2 + x5 <= 20;
s.t. chocolate: x3 + x6 <= 30;
s.t. EasyNuts: .8*x2 - .2*x1 - .2*x3 >= 0;
s.t. SluggerNuts: .9*x5 - .1*x4 - .1*x6 >= 0;
s.t. SluggerChocolate: .9*x6 - .1*x4 - .1*x5 >= 0;

