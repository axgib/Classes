clear; clc; clf; close all;

data = importdata("noisy_sine_data.mat");

fig1 = figure;
fig1 = plot(data.t, data.u);
fig1 = title("Noise");


deltaT = 0.001;
N = length(data.t);
T = N * deltaT;

freqRes = 1/(T);


delta_omega = 2*pi/(N*deltaT);

dft = [];
lastTerm = 0;
for k = 1:N
    m = k;
    dft(k) = data.u(k)*exp(m*delta_omega*k*deltaT) + lastTerm;
    lastTerm = dft(k);
end

fig2 = figure;
plot(abs(dft));
fig2 = title("DFT");
fig2 = xlabel("\omega_m (rad/s)");
fig2 = ylabel("|U(\omega\_m)|");

fft = fft(data.u);
omega_m = [1:2*pi:1000*2*pi];

fig3 = figure;
plot(omega_m, abs(fft));
fig3 = title("FFT");
fig3 = xlabel("\omega_m (rad/s)");
fig3 = ylabel("|U(\omega\_m)|");

fft_sqrd = abs(fft).^2;

fig4 = figure;
plot(omega_m, fft_sqrd);
fig4 = title("FFT sqrd");
fig4 = xlabel("\omega_m (rad/s)");
fig4 = ylabel("|U(\omega\_m)|^2");
%% 3.2
clc; clear; clf; close all;
omega = linspace(0, pi, 1000);
%e_omega = exp(omega);

z_avg = [];

count = 1;
for w = omega
    z_avg(count) = 1/5 * (1 + exp(-1i*w) + exp(-2*1i*w) + exp(-3*1i*w) + exp(-4*1i*w));
    count = count +1;
end

fig5 = figure;
plot(omega, abs(z_avg));
hold on;
%plot(omega, abs(z_P_avg));
fig5 = ylabel("|H|");
fig5 = title("H(e^\omega)");


%% 3.4
clear; clc; close all;

N3 = 10000; %data points
noise = randn(1,N3);

fig6 = figure;
plot(noise);
fig6 = title("white noise normal distribution");

avg_noise = [];
for w = 5:length(noise)
    avg_noise(w - 4) = 1/5*(noise(w) + noise(w -1) + noise(w -2) + noise(w - 3) + noise(w - 4));
end

hold on;
plot(avg_noise)

v = [avg_noise];
e = noise(5:end);

[Rve, lags] = xcorr(v, e, 20, 'biased');
fig7 = figure;
plot(lags, Rve);
