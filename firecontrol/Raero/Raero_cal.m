%% calculate according to 0~360 qsj
clear
addpath('../utils', '../model/PSDD')
xt=100000; yt=6000; zt=0; vt=340; theta_t=deg2rad(0); psi_t=deg2rad(0);
ym=6000; vm=340; vpj=1000;
aero_idx = 1;
qsj = deg2rad(0);
ql = deg2rad(0);
interval = 30;
num = 360/interval+1;
Raero = zeros(1, num);
qtheta = zeros(1, num);
Raero_q = [];
q = 0/57.3 : 5/57.3 : 30/57.3;
while aero_idx <= 180/interval+1
    for qq = q
        Ra = 10000;
        Rb = 100000;
        while (Rb-Ra) > 50
            Rg = Ra + 0.618*(Rb-Ra);
            [xm, ym, zm] = launch_pos(xt, yt, zt, ym, Rg, qsj);
            [theta_mi, psi_mi, theta_mt, psi_mt] = launch_ang(xt, yt, zt, vt, theta_t, psi_t, xm, ym, zm, vpj, qsj);
            theta_mi = theta_mi + qq;
            psi_mi = psi_mi + ql;
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
        Raero_q = [Raero_q R]; %#ok<AGROW>
    end
    [Raero(aero_idx), qq_idx] = max(Raero_q);
    qtheta(aero_idx) = q(qq_idx);
    Raero_q = [];
    qsj = deg2rad(interval * aero_idx);
    disp(aero_idx);
    aero_idx = aero_idx + 1;
end
Raero(end:-1:180/interval+2) = Raero(1:180/interval);
qtheta(end:-1:180/interval+2) = qtheta(1:180/interval);

qi = deg2rad(0:interval:360);
qs = deg2rad(0:1:360);
Raero_sp = spline(qi, Raero, qs);
figure(1);
polar(qs, Raero_sp/1000);
grid on;
legend('Raero/km');

figure(2);
yyaxis left;
plot(rad2deg(qs), Raero_sp/1000);
xlabel('qsj/deg');
ylabel('R/km');
yyaxis right;
plot(rad2deg(qi), rad2deg(qtheta));
ylabel('qtheta/deg');
grid on;
legend('Raero');

%% calculate according to one qsj
clear
addpath('../utils', '../model/PSDD')
xt=100000; yt=6000; zt=0; vt=340; theta_t=deg2rad(0); psi_t=deg2rad(0);
ym=6000; vm=6000; vpj=1000;
qsj = deg2rad(90);
ql = deg2rad(0);
interval = 30;
num = 360/interval+1;
Raero_q = [];
q = 0/57.3 : 5/57.3 : 30/57.3;

for qq = q
    Ra = 10000;
    Rb = 100000;
    while (Rb-Ra) > 50
        Rg = Ra + 0.618*(Rb-Ra);
        [xm, ym, zm] = launch_pos(xt, yt, zt, ym, Rg, qsj);
        [theta_mi, psi_mi, theta_mt, psi_mt] = launch_ang(xt, yt, zt, vt, theta_t, psi_t, xm, ym, zm, vpj, qsj);
        theta_mi = theta_mi + qq;
        psi_mi = psi_mi + ql;
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
    Raero_q = [Raero_q R]; %#ok<AGROW>
end
[Raero, qq_idx] = max(Raero_q);
disp([Raero, rad2deg(q(qq_idx))]);
