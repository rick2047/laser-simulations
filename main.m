%main test script
clc;
clear all;
close all;
omega = 25;
time = 50;
dt = time/512;
omega0 = omega:.1:omega+4.9;
d = 1;
hbar = 1;
param = .09;
cg = 1;
ce = 0;
area = 0:2*pi/6:(11*pi-2*pi/6);
cg_list = zeros(size(area,2),size(omega0,2));
ce_list = zeros(size(area,2),size(omega0,2));
index_area = 1;

for a=area
    index_omega = 1;
    for w = omega0
        gaussian = laserProfile(param,w, a, time, dt, 1);
        p = propagate(d, hbar, gaussian,omega);
        p.timePropagate(cg,ce);
        cg_list(index_area,index_omega) = p.cg(end);
        ce_list(index_area,index_omega) = p.ce(end);
        index_omega = index_omega+1;
    end
    index_area = index_area +1;
end

detune = [-(omega0(end:-1:2)-omega) omega0-omega];

[W, A] = meshgrid(detune,area);
ce = zeros(length(area),length(detune));

for w = 1:length(detune)
    if w<length(omega0)
        ce(:,w)=ce_list(:,length(omega0)-w);
    else
        ce(:,w)=ce_list(:,w+1-length(omega0));
    end
end

[CS h] = contour(W,A,ce);
clabel(CS,h,'FontSize',10);
grid on;
xlabel('Detuning');
ylabel('Intensity');
title('Excited state population evolution');
