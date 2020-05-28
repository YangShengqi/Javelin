%% calculate according to 0~360 qsj
clear
addpath('../utils', '../model/PSDD')
motion_style = 2;
xt=100000; yt=6000; zt=0; vt=340; theta_t=deg2rad(0); psi_t=deg2rad(0);
ym=6000; vm=340; vpj=1000;
opt_idx = 1;
qsj = deg2rad(0);
interval = 30;
num = 360/interval+1;
Ropt = zeros(1, num);
qtheta = zeros(1, num);
Ropt_q = [];
q = 0/57.3 : 5/57.3 : 30/57.3;
while opt_idx <= 180/interval+1
    for qq = q
        Ra = 10000;
        Rb = 250000;
        while (Rb-Ra) > 50
            Rg = Ra + 0.618*(Rb-Ra);
            [xm, ym, zm] = launch_pos(xt, yt, zt, ym, Rg, qsj);
            [theta_mi, psi_mi, theta_mt, psi_mt] = launch_ang(xt, yt, zt, vt, theta_t, psi_t, xm, ym, zm, vpj, qsj);
            theta_mi = theta_mi + qq;
            init_m = [xm, ym, zm, vm, theta_mi, psi_mi];
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
        Ropt_q = [Ropt_q R]; %#ok<AGROW>
    end
    [Ropt(opt_idx), qq_idx] = max(Ropt_q);
    qtheta(opt_idx) = q(qq_idx);
    Ropt_q = [];
    qsj = deg2rad(interval * opt_idx);
    opt_idx = opt_idx + 1;
end
Ropt(end:-1:180/interval+2) = Ropt(1:180/interval);
qtheta(end:-1:180/interval+2) = qtheta(1:180/interval);
disp([Ropt]);

qi = deg2rad(0:interval:360);
qs = deg2rad(0:1:360);
Ropt_sp = spline(qi, Ropt, qs);
figure(1);
polar(qs, Ropt_sp/1000);
grid on;
legend('Ropt/km');

figure(2);
yyaxis left;
plot(rad2deg(qs), Ropt_sp/1000);
xlabel('qsj/deg');
ylabel('R/km');
yyaxis right;
plot(rad2deg(qi), rad2deg(qtheta));
ylabel('qtheta/deg');
grid on;
legend('Ropt');

%% calculate according to one qsj
clear
addpath('../utils', '../model/PSDD')
motion_style = 2;
xt=100000; yt=6000; zt=0; vt=340; theta_t=deg2rad(0); psi_t=deg2rad(0);
ym=6000; vm=340; vpj=1000;
qsj = deg2rad(90);
Ropt_q = [];
q = 0/57.3 : 5/57.3 : 30/57.3;

for qq = q
    Ra = 10000;
    Rb = 250000;
    while (Rb-Ra) > 50
        Rg = Ra + 0.618*(Rb-Ra);
        [xm, ym, zm] = launch_pos(xt, yt, zt, ym, Rg, qsj);
        [theta_mi, psi_mi, theta_mt, psi_mt] = launch_ang(xt, yt, zt, vt, theta_t, psi_t, xm, ym, zm, vpj, qsj);
        theta_mi = theta_mi + qq;
        init_m = [xm, ym, zm, vm, theta_mi, psi_mi];
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
    Ropt_q = [Ropt_q R]; %#ok<AGROW>
end
[Ropt, qq_idx] = max(Ropt_q);
disp([Ropt, rad2deg(q(qq_idx))]);
