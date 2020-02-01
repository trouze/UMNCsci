set P;

param a {P};
param b;
param c {P};
param u {P};

var x {P};

maximize profit: sum {j in P} c{j}*x{j};

s.t. cap: {j in P} 0 <= x{j} <= u{j};
s.t. rate: sum {j in P} x{j}/a{j} <= b;