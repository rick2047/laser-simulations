%main test script
clc;
clear all;
close all;
laser=laserProfile(0.009,10,50,0.01,1);
laser.plot();
p = propagate(1,1,laser,10);
p.timePropagate(1,0);
p.plot();