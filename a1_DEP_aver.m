function [Psi_av_theo, Psi_av_sim] = a1_DEP_aver(Q, Pa, lamda_aw, Pcm, lamda_cw, lamda_cb)
K2=((Pa*lamda_aw+Pcm*lamda_cw)*Q)/(lamda_aw*lamda_cb*Pa*Pcm);
% ================== Theory Psi_average
Psi_av_theo=((lamda_cw*Q)/(lamda_aw*lamda_cb*Pa))*exp(K2)*expint(K2);
% =================== Simulation Psi_average
Ntry = 3*10^5;
haw = sqrt(lamda_aw/2) * (randn(1,Ntry) + 1i*randn(1,Ntry));
abs_haw = abs(haw).^2;
Psi_sim = ((lamda_cw .* Q) ./ (lamda_cw .* Q + Pa .* abs_haw .* lamda_cb)) .* exp((-Pa .* abs_haw) ./ (Pcm .* lamda_cw));
Psi_av_sim=mean(Psi_sim);
end 