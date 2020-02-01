# print the values of the decision variables
print "Values of decision variables";
display {j in 1.._nvars} (_varname[j],_var[j]);

# print the ranges on the coefficients in the obj fcn
print "Ranges on coefficients in obj fcn";
display {j in 1.._nvars} (_varname[j],_var[j].down,_var[j].current,_var[j].up);

# print the shadow prices
print "Shadow prices";
display {j in 1.._ncons} (_conname[j],_con[j]);

# print the RHS ranges
print "Ranges on the RHS";
display {j in 1.._ncons} (_conname[j],_con[j].down,_conname[j].current,_con[j].up);