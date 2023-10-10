clear; clc;
syms s T D;

G = ((s+2)*(s-2)*(s+5)*(s-5))/((s+1)*(s-1)*(s+3)*(s-3)*(s+6)*(s-6));


% T = (G*D)/(1+G*D);

roots = [ -1, -1, -3, -3, -6, -6];
fs = RR_poly(roots, 1);

D = solve(1 + G*D == fs, D);

%2a Find a controller that makes T with given poles
b = RR_poly([-2 2 -5 5], 1); 
a = RR_poly([-1 1 -3 3 -6 6], 1); 
f = RR_poly([-1 -1 -3 -3 -6 -6],1) 
[x, y] = RR_diophantine(a, b, f);
test = trim(a*x + b*y), residual = norm(f-test);
fprintf("m = " + y.n + " n = " + x.n)

%2b Is the controller proper? Change f(s) by adding poles at -20
% D = y/x, orders:m/n, proper if n-m>=0
b2b = b;
a2b = a;
f2b = RR_poly([-1 -1 -3 -3 -6 -6 -20 -20 -20 -20 -20],1)
[x2b, y2b] = RR_diophantine(a2b, b2b, f2b)
fprintf("m = " + y2b.n + " n = " + x2b.n + "\n")