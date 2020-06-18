%% fit data produce
clear
clc
addpath('../utils', '../model/PSDD')
motion_style = 1;
xt=100000; zt=0; theta_t=deg2rad(0); psi_t=deg2rad(0);
vpj=1000;
vm_idx = 340*0.7 : 340*0.2 : 340*1.5;
vt_idx = 340*0.7 : 340*0.2 : 340*1.5;
hm_idx = 12000 : 1000 : 15000;
h_interval = 1000;
qsj_interval = 30;
qsj_num = 360/qsj_interval+1;
key = cell(length(vm_idx), length(vt_idx), 7);
rvalue = cell(length(vm_idx), length(vt_idx), 7);
ym_i = 1;
for ym = hm_idx
    for i = -3:1:3    
        for vm = vm_idx
            for vt = vt_idx
                yt = ym + h_interval*i;
                max_idx = 1;
                qsj = deg2rad(0);
                Rmax = zeros(1, qsj_num);
                while max_idx <= 180/qsj_interval+1
                    Ra = 10000;
                    Rb = 200000;
                    while (Rb-Ra) > 100
                        Rg = Ra + 0.618*(Rb-Ra);
                        [xl, yl, zl] = launch_pos(xt, yt, zt, ym, Rg, qsj);
                        [theta_mi, psi_mi, theta_mt, psi_mt] = launch_ang(xt, yt, zt, vt, theta_t, psi_t, xl, yl, zl, vpj, qsj);
                        init_m = [xl, yl, zl, vm, theta_mt, psi_mt];
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
                    Rmax(max_idx) = R;                  
                    qsj = deg2rad(qsj_interval * max_idx);
                    %disp(aero_idx);
                    max_idx = max_idx + 1;
                end
                Rmax(end:-1:180/qsj_interval+2) = Rmax(1:180/qsj_interval);              
                key{vm_idx==vm, vt_idx==vt, i+4} = fit_condition(vm/340,vt/340,ym/1000,yt/1000);
                rvalue{vm_idx==vm, vt_idx==vt, i+4} = Rmax;
                disp(['Rmax vm ' num2str(vm) ' vt ' num2str(vt) ' hm ' num2str(ym) ' ht ' num2str(yt) ' rvalue ' num2str(Rmax./1000)]);
            end
        end
    end
    ym_i = ym_i + 1;
    save(['max_', num2str(ym_i), '.mat'], 'key', 'rvalue', 'qvalue');
    key = cell(length(vm_idx), length(vt_idx), 7);
    rvalue = cell(length(vm_idx), length(vt_idx), 7);
end
%% fit
clear
addpath('../utils')
qsj_interval = 30;
qsj_num = 360/qsj_interval+1;
vm_idx = 340*0.7 : 340*0.2 : 340*1.5;
vt_idx = 340*0.7 : 340*0.2 : 340*1.5;
hm_idx = 5000 : 1000 : 15000;
coe_max = cal_coe('max.mat', 15, qsj_num, vm_idx, vt_idx, hm_idx);
save('coe_max.mat', 'coe_max');