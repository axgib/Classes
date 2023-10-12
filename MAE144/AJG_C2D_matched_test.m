
syms z p h omega



h = 0.01;
z = 5;
p = 10;
causal = "strict";
omega = 50;


Ds = RR_tf([1 z],[1 p 0], 1); %D(s)=(s+z1)/[s*(s+p1)]

[Dz] = AJG_C2D_matched(Ds, h, causal, omega)

a_Ds = tf([1 z],[1 p 0]);
[actualDz] = c2d(a_Ds, h, 'matched')