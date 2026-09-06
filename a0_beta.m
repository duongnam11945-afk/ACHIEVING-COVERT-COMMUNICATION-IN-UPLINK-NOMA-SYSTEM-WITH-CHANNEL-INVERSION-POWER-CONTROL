function [beta_theo,beta_sim] = a0_beta(tau,K1 , lamda_cw, Q, lamda_cb, Pcm)

% ================== Theory beta
if tau <= K1
    beta_theo = 0;
else
    beta_theo = 1- (Q*lamda_cw)/((tau-K1)*lamda_cb+Q*lamda_cw)*exp(-(tau-K1)/(lamda_cw*Pcm));
end
beta_theo;

% =================== Simulation beta
Ntry = 3*10^5;
hcb = sqrt(lamda_cb/2) * (randn(1,Ntry) + 1i*randn(1,Ntry));
abs_hcb = abs(hcb).^2;
index1 = find(abs_hcb >= Q/Pcm);
abs_hcb = abs_hcb(index1);
hcw = sqrt(lamda_cw/2) * (randn(1,length(index1)) + 1i*randn(1,length(index1)));
abs_hcw = abs(hcw).^2;
Temp = K1+(Q./abs_hcb).*abs_hcw;
index2 = find(Temp <= tau);
beta_sim = length(index2)/length(index1);


end 