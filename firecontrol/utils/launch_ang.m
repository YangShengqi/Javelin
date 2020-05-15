function [theta_mi, psi_mi, theta_mt, psi_mt] = launch_ang(xt, yt, zt, vt, theta_t, psi_t, xm, ym, zm, vpj, qsj)
    rx = xt - xm; 
    ry = yt - ym; 
    rz = zt - zm;
    r = sqrt(rx^2 + ry^2 + rz^2);
    vxt = vt*cos(theta_t)*cos(psi_t);
    vyt = vt*sin(theta_t);
    vzt = -vt*cos(theta_t)*sin(psi_t);
    
    b = rx*vxt + ry*vyt +rz*vzt;
    td = (b + sqrt(b^2+r^2*(vpj^2-vt^2))) / (vpj^2-vt^2);
    theta_mi = asin(ry/(vpj*td));
    qj = abs(deg2rad(180)-qsj);
    qqz = asin(vt*sin(qj)/(vpj*cos(theta_mi)));
    psi_mi = qsj - qqz;
    
    theta_mt = asin(ry/r);
    psi_mt = qsj;
end