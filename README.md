# Introduction
This project includes a 3DOF MRAAM model and universal fire control algorithm of air-to-air missile. The model is built in NSE coordinate system. 
It mainly contains two parts, target maneuver model and missile model. The target maneuver model provides some kinds of target maneuver styles, 
such as uniform linear motion, terminal maneuver, horizontal escape maneuver and so on. The more maneuver styles will be added in the future.
![entire model](https://github.com/YangShengqi/Javelin/blob/master/img/entire_model.PNG)
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
![missile model](https://github.com/YangShengqi/Javelin/blob/master/img/missile_model.PNG)

# Requirement
* MATLAB 2018b 

# Documents
* missile
   * PSDD: horizontal trajectory missile model   
      * coe.mat: aerodynamic coefficient load file；
	  * init.m: missile parameters initialize file;
      * draw.m: plot file；
      * missile.slx: missile simulink model.
* firecontrol
   * model: missile model used for DLZ calculation, including various maneuvering styles of target used for DLZ calculation
   * utils: some tool functions
   * Raero: Raero calculation
      * data: Raero data for fitting
	  * Raero_cal.m: Raero calculation for one or some conditions
	  * Raero_fit.m: Raero fitting for various conditions
   * Ropt: as same as Raero
   * Rmax: as same as Raero
   * Rpi: as same as Raero
   * Rmin: as same as Raero
   
# TODO
This project is still under development. More detailed missile model and some fire control algorithms are going to be added. 
This project will be built into a integrated project with missile model and fire control algorithms.

# Acknowledgment
I would like to thank Engineer Xiaogang Li and Engineer Yingli Si for providing technical support.
