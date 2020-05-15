function [xl, yl, zl] = launch_pos(xt, yt, zt, ym, Rg, qsj)
    qcj = asin((yt-ym)/Rg);
    xl = xt - Rg*cos(qcj)*cos(qsj);
    yl = ym;
    zl = zt + Rg*cos(qcj)*sin(qsj);
end