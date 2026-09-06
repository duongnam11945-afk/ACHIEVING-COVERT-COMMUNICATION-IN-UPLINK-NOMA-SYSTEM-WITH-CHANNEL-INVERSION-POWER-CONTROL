clc; clear; close all;

sigma_w_dBm = -10; sigma_w = 10.^(sigma_w_dBm/10)*10^-3;
sigma_b = sigma_w;

lamda_ab = 1; lamda_aw = lamda_ab; lamda_cw = lamda_ab; lamda_cb = lamda_ab;

Ra = 1; Rc = Ra;

Q_dBm = 0:0.5:60; Q = 10.^(Q_dBm/10)*10^-3;

Pcm_dBm = 45; Pcm = 10.^(Pcm_dBm/10)*10^-3;
Pa_dBm = 28; Pa = 10.^(Pa_dBm/10)*10^-3;

epsilon = 0.3;
theta = 0.15;

eta_theo = zeros(1,length(Q));
eta_sim = zeros(1,length(Q));
Psi_av_theo = zeros(1,length(Q));
Psi_av_sim = zeros(1,length(Q));
delta_c_theo = zeros(1,length(Q));
delta_c_sim = zeros(1,length(Q));
for i = 1:length(Q)
    
    [eta_theo(i), eta_sim(i)] = a2_ETR_eta(Q(i), Rc, sigma_b, Pa, lamda_ab, Ra, lamda_cb, Pcm);
    [Psi_av_theo(i),Psi_av_sim(i)] = a1_DEP_aver(Q(i), Pa, lamda_aw, Pcm, lamda_cw, lamda_cb);
    [delta_c_theo(i), delta_c_sim(i)] = a2_Delta_c(Q(i), Rc, sigma_b, Pa, lamda_ab);
end

Psi_av_asy = (lamda_cw*Pcm)/(Pa*lamda_aw+Pcm*lamda_cw);
figure(1)

yyaxis left
plot(Q_dBm(1:4:end), Psi_av_theo(1:4:end), 'b-*','linewidth',1.5,'markersize',5); hold on;
plot(Q_dBm, Psi_av_asy*ones(1,length(Q_dBm)), 'b-','linewidth',1.5);
plot(Q_dBm(1:4:end), delta_c_theo(1:4:end), 'b-.','linewidth',1.5,'markersize',5);
plot(Q_dBm, (1-epsilon)*ones(1,length(Q_dBm)), 'b--','linewidth',1.5,'markersize',6);
plot(Q_dBm, theta*ones(1,length(Q_dBm)), 'b:','linewidth',1.8,'markersize',6);
plot(Q_dBm(1:4:end), delta_c_sim(1:4:end), 'ko','linewidth',1.5,'markersize',4);
ylabel('Probability'); xlabel('Q dBm');
axis([0 55 0 1])

yyaxis right
plot(Q_dBm,eta_theo,'r-','linewidth',1.5); hold on;
plot(Q_dBm,eta_sim,'ko','linewidth',1.5, 'markersize',4); hold on;
ylabel('The effective transmission rate'); xlabel('Q dBm');
axis([0 55 0 0.5])

legend('\xi^*','\xi_{asy}^*','\delta_c','\epsilon','\theta','Simulation','\eta');




