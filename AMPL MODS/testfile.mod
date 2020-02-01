param nodes integer;

set N = 1 .. nodes;

param c {i in N, j in N};

var x{N,N} >= 0, <= 1;

minimize dist: sum{i in N, j in N} c[i,j]*x[i,j];

s.t. node1: -x[1,2] - x[1,3] = -1;
s.t. node2: x[1,2] + x[3,2] = 0;
s.t. node3: x[1,3] - x[3,2] - x[3,4] = 0;
s.t. node4: x[2,4] + x[3,4] = 1;
