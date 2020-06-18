%% calculate according to 0~360 qsj
clear
addpath('../utils', '../model/PSDD')
motion_style = 2;
xt=100000; yt=6000; zt=0; vt=340; theta_t=deg2rad(0); psi_t=deg2rad(0);
ym=6000; vm=340; vpj=1000;
pi_idx = 1;
qsj = deg2rad(0);
ql = deg2rad(0);
interval = 30;
num = 360/interval+1;
Rpi = zeros(1, num);

while pi_idx <= 180/interval+1
    Ra = 20000;
    Rb = 180000;
    while (Rb-Ra) > 50
        Rg = Ra + 0.618*(Rb-Ra);
        [xm, ym, zm] = launch_pos(xt, yt, zt, ym, Rg, qsj);
        [theta_mi, psi_mi, theta_mt, psi_mt] = launch_ang(xt, yt, zt, vt, theta_t, psi_t, xm, ym, zm, vpj, qsj);
        theta_mt = theta_mt + ql;
        init_m = [xm, ym, zm, vm, theta_mt, psi_mt];
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
    Rpi(pi_idx) = R;
    qsj = deg2rad(interval * pi_idx);
    disp(pi_idx);
    pi_idx = pi_idx + 1;
end
Rpi(end:-1:180/interval+2) = Rpi(1:180/interval);
disp(Rpi);

qi = deg2rad(0:interval:360);
qs = deg2rad(0:1:360);
Rpi_sp = spline(qi, Rpi, qs);
figure(1);
polar(qs, Rpi_sp/1000);
grid on;
legend('Rpi/km');

figure(2);
plot(rad2deg(qs), Rpi_sp/1000);
xlabel('qsj/deg');
ylabel('R/km');
grid on;
legend('Rpi');

%% calculate according to one qsj
clear
addpath('../utils', '../model/PSDD')
motion_style = 2;
xt=100000; yt=6000; zt=0; vt=340; theta_t=deg2rad(0); psi_t=deg2rad(0);
ym=6000; vm=340; vpj=1000;
qsj = deg2rad(30);
ql = deg2rad(0);

Ra = 30000;
Rb = 220000;
while (Rb-Ra) > 50
    Rg = Ra + 0.618*(Rb-Ra);
    [xm, ym, zm] = launch_pos(xt, yt, zt, ym, Rg, qsj);
    [theta_mi, psi_mi, theta_mt, psi_mt] = launch_ang(xt, yt, zt, vt, theta_t, psi_t, xm, ym, zm, vpj, qsj);
    theta_mt = theta_mt + ql;
    init_m = [xm, ym, zm, vm, theta_mt, psi_mt];
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
Rpi = (Ra + Rb)/2;
disp(Rpi);
