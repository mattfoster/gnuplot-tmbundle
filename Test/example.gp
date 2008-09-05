set terminal aqua 
set key off

set title "Gnuplot bundle test" # Comment test

f(x) = sin(x) + sin(0.5 * x) + sin(0.25 * x) + \
  sin(0.125 * x) + sin(0.0625 * x) + sin(0.03125 * x)  + sin(0.015625 * x) 

plot f(x) with lines # test
