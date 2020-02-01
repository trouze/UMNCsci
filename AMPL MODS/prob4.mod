var x1 >= 0;  # chairs
  var x2 >= 0;  # benches
  var x3 >= 0;  # tables
  maximize z: 3*x1 + 3*x2 + 5*x3;  # total contribution
  s.t. tube: 1.2*x1 + 1.1*x2 + 1.2*x3 <= 1000;  # time available
  s.t. weld: .8*x1 + 2*x2 + 2.3*x3 <= 1200;            # time available
  s.t. supply: 2*x1 + 2*x2 + 4.5*x3 <= 2000;    # lbs of tubing
