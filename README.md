# FarEastJavelin
This project includes a 3DOF MRAAM model. The model is built in NSE coordinate system. It contains the following module.
* relative motion：describes the relative motion of missile and target；
* guidance law：PNG；
* aerodynamics：make calculation according to aerodynamic coefficient；
* propulsion and mass：make calculation according to aerodynamic coefficient propulsion and mass；
* atmospheric parameters：calculate atmospheric parameters；
* dynamics and kinematics：3DOF dynamics and kinematics model of missile and target；
* seeker：provide active and lock logic of missile seeker；
* terminate conditions：provide missile terminate conditions；
* TGO calculation：provide TGO calculation.

# Requirement
* MATLAB 2018b 

# Documents
* coe.mat: aerodynamic coefficient load file；
* init.m: missile parameters initialize file;
* draw.m: plot file；
* missile.slx: missile simulink model.

# TODO
This project is still under development. More detailed missile model and some fire control algorithms are going to be added. 
This project will be built into a integrated project with missile model and fire control algorithms.

# Acknowledgment
I would like to thank Engineer Xiaogang Li and Engineer Yingli Si for providing technical support.