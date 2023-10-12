%AJG_C2D_matched_test 
% This program intializes and calls the function "AJG_C2D_matched" 
% The variables are changeable and by commenting out or deleting them we can change the input
% This code also demonstrates how to properly call "AJG_C2D_matched" - syms is defined outside the function so that any amount of vari-
%ables can be used in the transfer function. If we move the syms call into the function then we would need to control the number of-
%variables coming in.


syms z p h omega; % These variables will start as symbolics unless otherwise defined later in the code

h = 0.01;
z = 5;
p = 10;
causal = "strict";
omega = 50;


Ds = RR_tf([1 z],[1 p 0], 1); %D(s)=(s+z1)/[s*(s+p1)]

[Dz] = AJG_C2D_matched(Ds, h, causal, omega) %call the function

% If we would like to check our answer for Dz against the MATLAB version, we can run this code
% Beware that all variables must be defined as numbers to run this code 
a_Ds = tf([1 z],[1 p 0]);
[actualDz] = c2d(a_Ds, h, 'matched')