option solver cplex;                # use a good solver
option cplex_options 'sensitivity'; # for post-optimality analysis
option presolve 0;                  # turn off the pre-solve phase
option display_eps 1e-10;
#option omit_zero_rows 1;            # don't display zero-valued variables