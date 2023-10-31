%HW 2 Problem 2.2

clear; clc; close all;

a = 0.9;
N = 1000;
e = randn(1, N);

omega = linspace(0, pi, N/2);

H = abs(1 + a.*exp(-1*i*omega));
spectrum = H.^2 * 1; %heuristic for spectrum white noise
loglog(omega, spectrum)
hold on;


W = [e(1)];
for count = 2:length(e)
    W(count) = e(count) + a * e(count - 1);
end

Re = xcorr(W);
omega_adj = [N:2*N-1 2*N-1 1:N-1];
spectrum_est = fft(Re(omega_adj))/N;



loglog(omega, real(spectrum_est(1:2:N)))

legend('\Phi', '\Phi_est');
xlabel("log(\omega)")
ylabel("log(\Phi)")
title("Spectrum and Periodogram Estimate")




%% Problem 3

clear; clc; close all;

data = load("mass_spring_damper.mat");
deltaT = 0.1; %s
u = data.u;
y = data.y;
t = data.t;
%      b1*F(k-1)  b2*F(k)  a1*x(k-1)   a2*x(k-2)
PHI = [u(2:end-1) u(3:end) -y(2:end-1) -y(1:end-2)];

Y = y(3:end);
theta = PHI\Y

figure;
myY = PHI*theta;
plot(t, y, "-k")
hold on
plot(t(1:end-2), myY)
legend("measured y(k)", "simulated y_sim(k)");
xlabel("time t")
ylabel("Distance - x (m)")
title("3.2 - Compare measured output y(k) with simulated y_sim(k)")

b1 = theta(1);
b2 = theta(2);
a1 = theta(3);
a2 = theta(4);


poles_z = roots([1 a1 a2]);
poles_s = log(poles_z)/deltaT;

gain = (b1 + b2)/(1 + a1 + a2);%when s = 0
myK = 1/gain; %N/m

syms d m
r = roots([m d myK]);
sol = solve(r == poles_s, m, d);

k = myK
m = double(sol.m) %kg
d = double(sol.d) %Ns/m

figure;
Go = tf( 1, [m, d, k])

lsim(Go, u, t)
hold on;
plot(t, y)
legend("TF with mdk","measured y")

