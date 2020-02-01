var x1 >= 0;  # of parkas produced
var x2 >= 0;  # of goose produced
var x3 >= 0;  # of insulated pants
var x4 >= 0;  # of gloves produced
var s1 >= 0;  # of parkas short
var s2 >= 0;  # of goose short
var s3 >= 0;  # of pants short
var s4 >= 0;  # of gloves short

maximize netprofit : (30*x1+40*x2+20*x3+10*x4) - (15*s1+20*s2+10*s3+8*s4);

s.t. cutting 