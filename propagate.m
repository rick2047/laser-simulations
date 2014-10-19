classdef propagate < handle
    %Simulates propagation of fields
    properties
        hbar;
        d;
        omega0;
        laser;
        cg;
        ce;
    end
    
    methods
        function obj = propagate(d,hbar,laser,omega0)
            obj.hbar = hbar;
            obj.d = d;
            obj.omega0 = omega0;
            obj.laser = laser;
            obj.cg =[];
            obj.ce = [];
        end
        
        function obj = timePropagate(obj,cg,ce)
            cg0 = cg;
            ce0 = ce;
            for time = 1:size(obj.laser.time,2)
                obj.cg = [obj.cg abs(cg0).^2/(abs(cg0).^2+abs(ce0).^2)];
                obj.ce = [obj.ce abs(ce0).^2/(abs(cg0).^2+abs(ce0).^2)];
                oldcg0 = cg0;
                cg0 = cg0 + 1j * obj.laser.dt/obj.hbar * obj.d * obj.laser.amplitude(time) * ce0 * exp(-1j * obj.omega0 * (obj.laser.time(time)-obj.laser.totalTime));
                ce0 = ce0 + 1j * obj.laser.dt/obj.hbar * obj.d * obj.laser.amplitude(time) * oldcg0 * exp(1j * obj.omega0 * (obj.laser.time(time)-obj.laser.totalTime));
            end
        end
        
        function plot(obj)
            fig = figure;
            plot(obj.laser.time,obj.cg);
            hold all;
            plot(obj.laser.time,obj.ce);
            title('Population Progression');
            xlabel('Time');
            ylabel('Population');
            legend('Ground State','Excited State','Location','NorthWest');
            
            if obj.laser.isGaussian
                file_name = 'Gaussian';
            else
                file_name = 'Lorentzian';
            end
            file_name = [file_name '_' num2str(obj.laser.param) '_' num2str(obj.laser.omega) ';' num2str(obj.omega0) '.png'];
            saveas(fig,file_name);
        end
    end
    
end

