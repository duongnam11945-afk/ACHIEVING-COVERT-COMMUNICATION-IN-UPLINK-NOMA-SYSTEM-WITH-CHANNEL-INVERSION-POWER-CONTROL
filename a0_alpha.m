function [alpha_theo,alpha_sim] = a0_alpha(tau, sigma_w, lamda_cw, Q, lamda_cb, Pcm)

% ================== Theory alpha
if tau <= sigma_w
    alpha_theo = 1;
else
    alpha_theo = lamda_cw *Q/(lamda_cw*Q + (tau-sigma_w)*lamda_cb) * exp(-(tau-sigma_w)/(lamda_cw*Pcm));
end
alpha_theo;

% =================== Simulation alpha
Ntry = 3*10^5;
hcb = sqrt(lamda_cb/2) * (randn(1,Ntry) + 1i*randn(1,Ntry));
abs_hcb = abs(hcb).^2;
index1 = find(abs_hcb >= Q/Pcm);
abs_hcb = abs_hcb(index1);
hcw = sqrt(lamda_cw/2) * (randn(1,length(index1)) + 1i*randn(1,length(index1)));
abs_hcw = abs(hcw).^2;
Temp = Q./abs_hcb .* abs_hcw + sigma_w;
index2 = find(Temp >= tau);
alpha_sim = length(index2)/length(index1);


end

