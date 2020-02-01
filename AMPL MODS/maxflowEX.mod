set Nodes; # set of nodes in a network

set Arcs := {i in Nodes, j in Nodes : i<>j}; # set of arcs in a network

param capacity {(i,j) in Arcs} >= 0; # arc capacities

var x {Arcs}; # variables of flow over each arc

maximize STflow: x["T","S"];

s.t. balance {i in Nodes}: sum{(j,i) in Arcs} x[j,i] = sum{(i,j) in Arcs} x[i,j];

s.t. capacities {(i,j) in Arcs}: 0 <= x[i,j] <= capacity[i,j];