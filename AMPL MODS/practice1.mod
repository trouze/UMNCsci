set Worker;
set Job;

var x {Worker,Job} >=0;

minimize totalcost: 
sum {i in Worker, j in Job} c[i,j]*x[i,j];

s.t. eachworker1job {i in Worker}:
sum {j in Job} x[i,j]=1;

s.t. eachjobisdnebyoneworker {j in Job}:
sum {i in Worker} x[i,j] = 1;
data;

set Worker := bob jim sally julie;
set Job := ironing laundry cooking dishes;

param c : ironing laundry cooking dishes :=
bob 50 50 1e4 20
jim 70 40 20 30
sally 90 30 50 1e4
julie 70 20 60 70;