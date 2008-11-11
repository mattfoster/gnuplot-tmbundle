
set terminal pdf
set output '~/test.pdf'

set for [i = 1:10] style line i lc rgb "blue" # Broken, should still be line.set
set for [n = 1:10] # Works file as line.set 

plot [0:pi] for [n=1:2] sin(x*n)/n with filledcurves
plot for [ filename in ]
plot [0:e] for [n=1:2] sin(x*n)/n with filledcurves

plot for [filename in "A.dat B.dat C.dat"] filename using 1:2 with lines
plot for [filename in 'A.dat B.dat C.dat'] filename using 1:2 with lines
plot for [basename in "A B C"] basename.".dat" using 1:2 with lines
unset for [tag = 100:200] label tag
