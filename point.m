classdef point
    properties
        %position
        x = 0;
        y = 0;
        fxdA = false;
        fxdPt = false;
        ptID;
        vX = 0;
        vY = 0;
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
            obj.fxdA = fxdA;
            obj.fxdPt = fxdPt;
            
            obj.mass = 0;
        end
        
        function velocity = move()
            % 1 is x, 2 is y
            velocity(1) = 
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
            dv(1) = 
            dv(2) = 
        end
    end

    % Static Methods
    methods (Static)
        function del = delete()
            del = 0;
            try
                clear obj;
            catch 
                del = 1;
            end
        end
        
        function ptMass = sumMass(lines)
            ptMass = 0;
            for i = 1:length(lines)
                ptMass + lines(i).mass;
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