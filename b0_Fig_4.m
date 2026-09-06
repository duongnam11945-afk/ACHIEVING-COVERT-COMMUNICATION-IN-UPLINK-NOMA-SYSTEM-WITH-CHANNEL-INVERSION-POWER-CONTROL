clc; clear; close all;

sigma_w_dBm = -10; sigma_w = 10.^(sigma_w_dBm/10)*10^-3;
sigma_b = sigma_w;

lamda_ab = 1; lamda_aw = lamda_ab; lamda_cw = lamda_ab; lamda_cb = lamda_ab;

Ra = 1; Rc = Ra;

Q_dBm = 0:1:60; Q = 10.^(Q_dBm/10)*10^-3;


epsilon = 0.15;
theta = 0.15;
Pcm_dBm = 18:2:60; Pcm = 10.^(Pcm_dBm/10)*10^-3;

Pa_dBm = 15; Pa = 10.^(Pa_dBm/10)*10^-3;
Q_sao1 = zeros(1,length(Pcm_dBm));
eta_sao1 = zeros(1,length(Pcm_dBm));
for i = 1:length(Pcm_dBm)
    [Q_sao1(i), eta_sao1(i)] = a3_Q_Eta_optimal(Q, Rc, sigma_b, Pa, lamda_ab, Ra, lamda_cb, Pcm(i), lamda_aw, lamda_cw, epsilon, theta );
end

Pa_dBm = 25; Pa = 10.^(Pa_dBm/10)*10^-3;
Q_sao2 = zeros(1,length(Pcm_dBm));
eta_sao2 = zeros(1,length(Pcm_dBm));
for i = 1:length(Pcm_dBm)
    [Q_sao2(i), eta_sao2(i)] = a3_Q_Eta_optimal(Q, Rc, sigma_b, Pa, lamda_ab, Ra, lamda_cb, Pcm(i), lamda_aw, lamda_cw, epsilon, theta );
end

Pa_dBm = 35; Pa = 10.^(Pa_dBm/10)*10^-3;
Q_sao3 = zeros(1,length(Pcm_dBm));
eta_sao3 = zeros(1,length(Pcm_dBm));
for i = 1:length(Pcm_dBm)
    [Q_sao3(i), eta_sao3(i)] = a3_Q_Eta_optimal(Q, Rc, sigma_b, Pa, lamda_ab, Ra, lamda_cb, Pcm(i), lamda_aw, lamda_cw, epsilon, theta );
end

figure(1)
plot(Pcm_dBm,eta_sao1,'r-o','linewidth',2,'markersize',6); hold on;
plot(Pcm_dBm,eta_sao2,'b--o','linewidth',2,'markersize',6);
plot(Pcm_dBm,eta_sao3,'g:o','linewidth',2,'markersize',6);
xlabel('P_c^{max}'); ylabel('The effective transmission rate \eta')
legend('P_a = 15 dBm, \varepsilon = 0.15 ', 'P_a = 25 dBm, \varepsilon = 0.15 ', 'P_a = 35 dBm, \varepsilon = 0.15 ')


