function [Q_sao, eta_sao] = a3_Q_Eta_optimal(Q, Rc, sigma_b, Pa, lamda_ab, Ra, lamda_cb, Pcm, lamda_aw, lamda_cw, epsilon, theta )
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
if Psi_av_asy< 1- epsilon
    eta_sao=0;
    Q_sao=0;
else
    eta1 = max(eta_theo);
    index_cong = find(eta_theo==eta1);
    Q_cong = Q(index_cong);

    Temp1 = abs(Psi_av_theo-(1-epsilon));
    index1 = find(Temp1==min(Temp1));
    Q1 = Q(index1);

    Temp2 = abs(delta_c_theo-theta);
    index2 = find(Temp2==min(Temp2));
    Q2=Q(index2);
    
    Q_temp = [Q_cong Q1 Q2];
    %Gia tri toi uu
    Q_sao = max(Q_temp);
    index =find(Q==Q_sao);
    eta_sao=eta_theo(index);
end
end

