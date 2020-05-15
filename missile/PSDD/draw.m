figure;
plot3(xt(:,1),xt(:,3),xt(:,2));
axis([-inf,inf,-inf,inf,0,8000])
hold on
plot3(xm(:,1),xm(:,3),xm(:,2));
grid on