load coe.mat;

%some coefficient and constant
K = 4;%PNG coefficient
S = 0.21;%reference area
g = 9.8;

%engine property
thrust_time_idx = [0 1.9 1.9+12.3];%s, [thrust_start, boost_thrust_end, thrust_end]
thrust = [44000 14000 0];%N, [boost_thrust,thrust,zero_trust]

%mass property
mass = [161 130 112.7]; %kg, [total_mass, mass_after_boost_thrust, mass_after_thrust]

%terminate condition
t_max = 200;%s, max flying time of missile
t_min = 3;%s, min flying time of missile
h_max = 25000;%m, max flying height of missile
h_min = 0;%m, min flying height of missile
vm_term = 400;%m/s, min termination speed of missile
vmt_term = 150;%m/s, min closing speed of missile and target
r_damage = 20;%m, damage radius of missile

%seeker
r_seeker_active = 10000;%m, seeker active range of missile
halfa_seeker_lock = 15;%degree, half locking angle of missile seeker

%some constraints
nn_lim = 30; %normal load constraint
TGO_max = 200;%s,TGO constraint