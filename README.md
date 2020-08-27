# Introduction
This project includes a 3DOF MRAAM model. The primary model is built by simulink in NSE coordinate system. 
It mainly contains two parts, target maneuver model and missile model. The target maneuver model provides some kinds of 
target maneuver styles, such as uniform linear motion, terminal maneuver, horizontal escape maneuver and so on. The more maneuver styles will 
be added in the future.
![entire model](https://gitee.com/yangshengqi/Javelin/blob/master/img/entire_model.PNG)
The missile model is 3DOF which contains the following module.
* relative motion：describes the relative motion of missile and target；
* guidance law：PNG；
* aerodynamics：make calculation according to aerodynamic coefficient；
* propulsion and mass：calculate propulsion and mass；
* atmospheric parameters：calculate atmospheric parameters；
* dynamics and kinematics：3DOF dynamics and kinematics model of missile and target；
* seeker：provide active and lock logic of missile seeker；
* terminate conditions：provide missile terminate conditions；
* TGO calculation：provide TGO calculation.
![missile model](https://gitee.com/yangshengqi/Javelin/blob/master/img/missile_model.PNG)

# Requirement
* MATLAB 2018b 

# Documents
* model
   * coe.mat: aerodynamic coefficient load file；
   * init.m: missile parameters initialize file;
   * draw.m: plot file；
   * missile.slx: missile simulink model.
* model_with_target: with some target maneuver style
   
# TODO
This project is still under development. More detailed missile model are going to be added. 
