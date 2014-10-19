classdef propagate
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
        
        
    end
    
end

