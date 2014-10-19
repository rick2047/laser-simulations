classdef laserProfile
%     Defines a laser object
    
    properties
        param;
        omega;
        totalTime;
        dt;
        isGaussian;
        time;
        amplitude;
    end
    
    methods
        function obj = laserProfile(param, omega, t, dt, gaussian)
            obj.param = param;
            obj.omega = omega;
            obj.totalTime = t;
            obj.dt = dt;
            obj.isGaussian = gaussian;
            obj.time = linspace(0,2*obj.totalTime,2*obj.totalTime/obj.dt);
            if gaussian
                obj.amplitude =  exp(-param*(obj.time-obj.totalTime).^2);
            else
                obj.amplitude = 1/pi * param/(param^2+(obj.time-obj.totalTime).^2);
            end
            obj.amplitude = pi/trapz(obj.amplitude) .* obj.amplitude .* cos(omega*(obj.time-obj.totalTime));
            obj.amplitude = obj.amplitude./obj.dt;
        end
        
        function obj = plot(obj)
            fig = figure(1);
            plot(obj.time, obj.amplitude);
            ylabel('Amplitude');
            xlabel('Time');
            title('Laser Profile');
            if obj.isGaussian
                file_name = 'gaussian';
            else
                file_name = 'Lorentzian';
            end
            file_name = [file_name '_' num2str(obj.param) '_' num2str(obj.omega) '_matlab.png'];
            saveas(fig,file_name);
            
        end
        
    end
    
end



