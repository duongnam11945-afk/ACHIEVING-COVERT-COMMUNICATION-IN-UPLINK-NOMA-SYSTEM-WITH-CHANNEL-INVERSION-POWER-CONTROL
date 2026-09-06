function [eta_theo, eta_sim] = a2_ETR_eta(Q, Rc, sigma_b, Pa, lamda_ab, Ra, lamda_cb, Pcm)
K3=(1/(lamda_ab*Pa))*(Q/(2^Rc -1)-sigma_b);
K4=(2^Ra-1)*sigma_b/(lamda_ab*Pa);
% ================== Theory delta_a
if Q <= sigma_b*(2^Rc-1)*2^Ra
    delta_a_theo = 1;
else
    delta_a_theo = 1+exp(-K3)-exp(-K4);
end
% =================== Simulation delta_a
Ntry = 3*10^5;
hab = sqrt(lamda_ab/2) * (randn(1,Ntry) + 1i*randn(1,Ntry));
abs_hab = abs(hab).^2;
index = find((K3*lamda_ab>=abs_hab) & (abs_hab >=K4*lamda_ab));
delta_a_sim = 1-length(index)/length(abs_hab);

% ================== Theory eta
eta_theo = 1/2 * exp(-Q / (lamda_cb * Pcm)) .* Ra .* (1 - delta_a_theo);
% =================== Simulation eta
eta_sim = 1/2 * exp(-Q / (lamda_cb * Pcm)) .* Ra .* (1 - delta_a_sim);
end 
