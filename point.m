classdef point
    properties
        %position
        x;
        y;
        fxdA; 
        fxdPt; 
        ptID;
        v = zeros(2,1);
        mass = 0;

        %connected 
        cLines = []; 
        
        %should be 1 for first point on the line, 2 for second point on the
        %line
        cLinesNo = [];
    end
    
    % Add Methods
    methods
        % Constructors
        function obj = point(x, y, fxdPt, fxdA, id)
            %The x and y coordinates of the point
            obj.x = x;
            obj.y = y;
            obj.ptID = id;
            
            %whether the object is fixed
            % 0 = false, 1 = true
            obj.fxdA = fxdA;
            obj.fxdPt = fxdPt;
            
            obj.mass = 0;
        end
        
        function xy = sumF(self)
            % standard xy format
            xy = zeros(2,1);
            
            % iterate through cLines and add the forceToXY from each
            for i = 1:length(self.cLines)
                xy = xy + self.cLines(i).totalForce(self.cLines(i), self.cLinesNo(i));
            end
        end
        
        function dv = changeVelocity(self, timestep)
            % get the sum of forces
            fxy = self.sumF(self);
            
            % a = f/m
            % dv = time step * f/m
            dv(1) = timestep * fxy(1) / self.mass;
            dv(2) = timestep * fxy(2) / self.mass;
            
            % TODO add this to the velocity of the object
        end
        
        function ptMass = sumMass(lines)
            ptMass = 0;
            for i = 1:length(lines)
                ptMass= ptMass + lines(i).mass;
            end
        end
        
        function xy = forceToXY(forces, angles)
            % obtains the components of the forces
            for i = 1:length(forces)
                xy = zeros(2,1);
                
                %using trigonometry to find the sum of the two components 
                %of the forces
                xy(1) = xy(1) + forces(i)*cos(angles(i));
                xy(2) = xy(2) + forces(i)*sin(angles(i));
            end
        end
    end
end