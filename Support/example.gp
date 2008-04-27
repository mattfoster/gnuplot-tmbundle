#! /usr/bin/gnuplot

set title "GNUplot bundle test" # What's going on here?!

f(x) = sin(x) + sin(0.5 * x) + sin(0.25 * x) \
 + sin(0.125 * x) + sin(0.0625 * x) \
 + sin(0.03125 * x) + sin(0.015625 * x) 

plot f(x) with lines # test

set terminal pdf 
 
set key 

set 