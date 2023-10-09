clear; clc;
syms s T D

G = ((s+2)*(s-2)*(s+5)*(s-5))/((s+1)*(s-1)*(s+3)*(s-3)*(s+6)*(s-6));


% T = (G*D)/(1+G*D)

roots = [ -1, -1, -3, -3, -6, -6]
fs = RR_poly(roots, 1)

D = solve(1 + G*D == fs, D)

b = RR_poly([-2 2 -5 5], 1); 
a = RR_poly([-1 1 -3 3 -6 6], 1); 
f = RR_poly([-1 -1 -3 -3 -6 -6],1); 
[x, y] = RR_diophantine(a, b, f)
