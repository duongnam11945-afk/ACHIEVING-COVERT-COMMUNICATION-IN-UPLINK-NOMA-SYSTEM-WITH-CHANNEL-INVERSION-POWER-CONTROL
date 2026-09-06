clc; clear; close all;

sigma_w_dBm = -10; sigma_w = 10.^(sigma_w_dBm/10)*10^-3;
sigma_b = sigma_w;

lamda_ab = 1; lamda_cb = lamda_ab; lamda_aw = lamda_ab; lamda_cw = lamda_ab;

Ra = 1; Rc = Ra;   

Q_dBm = 15; Q = 10.^(Q_dBm/10)*10^-3;
Pcm_dBm = 50; Pcm = 10.^(Pcm_dBm/10)*10^-3;
Pa_dBm = 15; Pa = 10.^(Pa_dBm/10)*10^-3;

abs_haw =  0.7;
K1 = Pa * abs_haw + sigma_w;

tau_dBm = 0:1:50; tau = 10.^(tau_dBm/10)*10^-3;
alpha_theo=zeros(1,length(tau_dBm));
alpha_sim=zeros(1,length(tau_dBm));
beta_theo=zeros(1,length(tau_dBm));
beta_sim=zeros(1,length(tau_dBm));
Psi_theo=zeros(1,length(tau_dBm));
Psi_sim=zeros(1,length(tau_dBm));

for i=1:length(tau_dBm)
    [alpha_theo(i),alpha_sim(i)] = a0_alpha(tau(i), sigma_w, lamda_cw, Q, lamda_cb, Pcm);
    [beta_theo(i),beta_sim(i)] = a0_beta(tau(i), K1, lamda_cw, Q, lamda_cb, Pcm);
    [Psi_theo(i), Psi_sim(i)] = a0_DEP_Psi(alpha_theo(i),alpha_sim(i),beta_theo(i),beta_sim(i));
end
tau_opt =K1;tau_opt_dBm=10*log10(tau_opt*1000);
Psi_opt = lamda_cw*Q/(lamda_cw*Q+Pa*abs_haw*lamda_cb)*exp(-Pa*abs_haw/(Pcm*lamda_cw));
figure(1)
plot(tau_dBm,alpha_theo,'b-','LineWidth',1.5);hold on;
plot(tau_dBm,beta_theo,'c-','LineWidth',1.5);
plot(tau_dBm,Psi_theo,'m--','LineWidth',1.5);
plot(tau_opt_dBm,Psi_opt,'r*','LineWidth',1.2,'MarkerSize',14);
plot(tau_dBm(1:3:end),alpha_sim(1:3:end),'ko','LineWidth',1.5,'MarkerSize',5);
plot(tau_dBm(1:3:end),beta_sim(1:3:end),'ko','LineWidth',1.5,'MarkerSize',5);
plot(tau_dBm(1:3:end),Psi_sim(1:3:end),'ko','LineWidth',1.5,'MarkerSize',5);
xlabel('\tau (dBm)');ylabel('Probability');
legend('\alpha Theo', '\beta Theo','DEP-\xi Theo','\xi^*','Simulation')
axis([0 50 -0.01 1.04])























