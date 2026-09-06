clc; clear; close all;

sigma_w_dBm = -10; sigma_w = 10.^(sigma_w_dBm/10)*10^-3;
sigma_b = sigma_w;

lamda_ab = 1; lamda_aw = lamda_ab; lamda_cw = lamda_ab; lamda_cb = lamda_ab;

Ra = 2:1:16;
Pa_dBm = 25; Pa = 10.^(Pa_dBm/10)*10^-3;
Pcm_dBm = 40; Pcm = 10.^(Pcm_dBm/10)*10^-3;

Q_dBm = 0:1:60; Q = 10.^(Q_dBm/10)*10^-3;


epsilon = 0.15;
theta = 0.15;

Rc=1;

Q_sao1 = zeros(1,length(Ra));
eta_sao1 = zeros(1,length(Ra));
for i = 1:length(Ra)
    [Q_sao1(i), eta_sao1(i)] = a3_Q_Eta_optimal(Q, Rc, sigma_b, Pa, lamda_ab, Ra(i), lamda_cb, Pcm, lamda_aw, lamda_cw, epsilon, theta );
end

Rc=3;
Q_sao2 = zeros(1,length(Ra));
eta_sao2 = zeros(1,length(Ra));
for i = 1:length(Ra)
    [Q_sao2(i), eta_sao2(i)] = a3_Q_Eta_optimal(Q, Rc, sigma_b, Pa, lamda_ab, Ra(i), lamda_cb, Pcm, lamda_aw, lamda_cw, epsilon, theta );
end

Rc=5;
Q_sao3 = zeros(1,length(Ra));
eta_sao3 = zeros(1,length(Ra));
for i = 1:length(Ra)
    [Q_sao3(i), eta_sao3(i)] = a3_Q_Eta_optimal(Q, Rc, sigma_b, Pa, lamda_ab, Ra(i), lamda_cb, Pcm, lamda_aw, lamda_cw, epsilon, theta );
end

figure(1)
plot(Ra,eta_sao1,'r-o','linewidth',1.6,'markersize',6); hold on;
plot(Ra,eta_sao2,'b--o','linewidth',1.6,'markersize',6);
plot(Ra,eta_sao3,'g:o','linewidth',1.8,'markersize',6);
xlabel('R_a'); ylabel('The effective transmission rate \eta')
legend('R_c = 1 bit/s/Hz, \varepsilon = 0.15 ', 'R_c = 3 bit/s/Hz, \varepsilon = 0.15 ', 'R_c = 5 bit/s/Hz, \varepsilon = 0.15 ');


