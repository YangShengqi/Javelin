%% fit data produce
clear
clc
addpath('../utils', '../model/PSDD')
xt=100000; zt=0; theta_t=deg2rad(0); psi_t=deg2rad(0);
vpj=1000;
vm_idx = 340*0.7 : 340*0.2 : 340*1.5;
vt_idx = 340*0.7 : 340*0.2 : 340*1.5;
hm_idx = 12000 : 1000 : 15000;
h_interval = 1000;
qsj_interval = 30;
qsj_num = 360/qsj_interval+1;
q = 0/57.3 : 7.5/57.3 : 30/57.3;
key = cell(length(vm_idx), length(vt_idx), 7);
rvalue = cell(length(vm_idx), length(vt_idx), 7);
qvalue = cell(length(vm_idx), length(vt_idx), 7);
ym_i = 1;
for ym = hm_idx
    for i = -3:1:3    
        for vm = vm_idx
            for vt = vt_idx
                yt = ym + h_interval*i;
                aero_idx = 1;
                qsj = deg2rad(0);
                Raero = zeros(1, qsj_num);
                qtheta = zeros(1, qsj_num);
                Raero_q = [];
                while aero_idx <= 180/qsj_interval+1
                    for qq = q
                        Ra = 10000;
                        Rb = 250000;
                        while (Rb-Ra) > 100
                            Rg = Ra + 0.618*(Rb-Ra);
                            [xl, yl, zl] = launch_pos(xt, yt, zt, ym, Rg, qsj);
                            [theta_mi, psi_mi, theta_mt, psi_mt] = launch_ang(xt, yt, zt, vt, theta_t, psi_t, xl, yl, zl, vpj, qsj);
                            theta_mi = theta_mi + qq;
                            init_m = [xl, yl, zl, vm, theta_mi, psi_mi];
                            init_t = [xt, yt, zt, vt, theta_t, psi_t];
                            init;
                            sim('psmissile_forDLZ');
                            KO = ko(end);
                            if KO == 0
                                Ra = Rg;
                            else
                                Rb = Rg;
                            end
                        end
                        R = (Ra + Rb)/2;
                        Raero_q = [Raero_q R]; %#ok<AGROW>
                    end
                    [Raero(aero_idx), qq_idx] = max(Raero_q);
                    qtheta(aero_idx) = q(qq_idx);
                    Raero_q = [];
                    qsj = deg2rad(qsj_interval * aero_idx);
                    %disp(aero_idx);
                    aero_idx = aero_idx + 1;
                end
                Raero(end:-1:180/qsj_interval+2) = Raero(1:180/qsj_interval);
                qtheta(end:-1:180/qsj_interval+2) = qtheta(1:180/qsj_interval);
                key{vm_idx==vm, vt_idx==vt, i+4} = fit_condition(vm/340,vt/340,ym/1000,yt/1000);
                rvalue{vm_idx==vm, vt_idx==vt, i+4} = Raero;
                qvalue{vm_idx==vm, vt_idx==vt, i+4} = qtheta;
                disp(['Raero vm ' num2str(vm) ' vt ' num2str(vt) ' hm ' num2str(ym) ' ht ' num2str(yt) ' rvalue ' num2str(Raero./1000)]);
            end
        end
    end
    ym_i = ym_i + 1;
    save(['aero_', num2str(ym_i), '.mat'], 'key', 'rvalue', 'qvalue');
    key = cell(length(vm_idx), length(vt_idx), 7);
    rvalue = cell(length(vm_idx), length(vt_idx), 7);
    qvalue = cell(length(vm_idx), length(vt_idx), 7);
end
%% fit
clear
addpath('../utils')
qsj_interval = 30;
qsj_num = 360/qsj_interval+1;
vm_idx = 340*0.7 : 340*0.2 : 340*1.5;
vt_idx = 340*0.7 : 340*0.2 : 340*1.5;
hm_idx = 5000 : 1000 : 15000;
coe_aero = cal_coe('aero.mat', 15, qsj_num, vm_idx, vt_idx, hm_idx);
save('coe_aero.mat', 'coe_aero');