function [Psi_theo, Psi_sim] = a0_DEP_Psi(alpha_theo,alpha_sim,beta_theo,beta_sim)
% ================== Theory Psi
Psi_theo=alpha_theo + beta_theo;
% =================== Simulation Psi
Psi_sim=alpha_sim+beta_sim;
end 