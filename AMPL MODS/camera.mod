#AMPL code for Minimum vertex problem

set Nodes;

set Edges within {Nodes, Nodes};

var x {Nodes} binary; 

minimize vc_size: sum{i in Nodes} x[i];

s.t. cover_edges {(i,j) in Edges}: x[i] +x[j] >= 1;