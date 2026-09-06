function [delta_c_theo, delta_c_sim] = a2_Delta_c(Q, Rc, sigma_b, Pa, lamda_ab)
K3=(1/(lamda_ab*Pa))*(Q/(2^Rc -1)-sigma_b);
% ================== Theory delta_c
if Q <= sigma_b*(2^Rc-1)
    delta_c_theo = 1;
else
    delta_c_theo = exp(-K3);
end
delta_c_theo;
% =================== Simulation alpha
Ntry = 3*10^5;
hab = sqrt(lamda_ab/2) * (randn(1,Ntry) + 1i*randn(1,Ntry));
abs_hab = abs(hab).^2;
index = find(abs_hab > K3*lamda_ab);
delta_c_sim = length(index)/length(abs_hab);
delta_c_sim;
end 