load('coe.mat');

%some coefficient and constant
K = 4;%PNG coefficient
S = 0.03;%m2, reference area
g = 9.8;

%engine property
thrust_time_idx = [0 4 12];%s, [thrust_start, boost_thrust_end, thrust_end]
thrust = [35000 18000 0];%N, [boost_thrust,thrust,zero_trust]

%mass property
mass = [200 170 130];%kg, [total_mass, mass_after_boost_thrust, mass_after_thrust]

%terminate condition
t_max = 100;%s, max flying time of missile
t_min = 3;%s, min flying time of missile
h_max = 25000;%m, max flying height of missile
h_min = 0;%m, min flying height of missile
vm_term = 400;%m/s, min termination speed of missile
vmt_term = -150;%m/s, min closing speed of missile and target
r_damage = 50;%m, damage radius of missile

%seeker
r_seeker_active = 20000;%m, seeker active range of missile
halfa_seeker_lock = 15;%degree, half locking angle of missile seeker

%some constraints
nn_lim = 40; %normal load constraint
TGO_max = 200;%s,TGO constraint

overload_height = [0 3000 6000 7000 9000 12000 15000 25000];%m, typical height
overload = [9 9 7.5 7 6 5 4 2];%g, maneuver overload of typical height

turn_omega_height = [0 3048 6096 9144 12192];%m, typical height
turn_omega = [18.5 14.3 10.2 6.7 3.9];%degree/s, turnning angular velocity of typical height

%v:[0,inf], theta:(-pi,pi], psi:(-pi,pi]
init_t = [30000 13000 0 200 deg2rad(0) deg2rad(180)];
init_m = [0 13000 0 180 0 deg2rad(0)];