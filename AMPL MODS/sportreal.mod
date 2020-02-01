set T;  # cities
set S;  # divisions

param D {T cross T};  # distance
param G {S cross S};  # away-game matrix
param b {i in S} := 2;     # number of teams in division i

var x {v in T, i in S} binary;  # 1 if team v is in division i


# correct number of teams in each division
s.t. numteams {i in S}: sum {v in T} x[v,i] = b[i];

# each team belongs to exactly 1 division
s.t. onediv {v in T}: sum {i in S} x[v,i] = 1;

minimize totaldistance :
sum {i in S, j in S, u in T, v in T} x[u,i]*x[v,j]*G[i,j]*D[u,v];

data;
set T := B P C D;
set S := 1 2;

param D: B P C D :=
B 0 47 87 85
P 47 0 114 39
C 87 114 0 92
D 85 39 92 0;

param G: 1 2 :=
1 4 2
2 2 4;

