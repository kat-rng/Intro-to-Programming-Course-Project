classdef point
    properties
        %position
        x = 0;
        y = 0;
        fxd = false;
        ptID;

        %connected 
        cLines = []; 
    end
    
    % Add Methods
    methods
        % Constructors
        function obj = point(x, y, fxd, id)
            %The x and y coordinates of the point
            obj.x = x;
            obj.y = y;
            obj.ptID = id;
            
            %whether the object is fixed
            obj.fxd = fxd;
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
        
        function xy = forceToXY(forces, angles, xy)
            % obtains the components of the forces
            for i = 1:length(forces)
                xy(1:2) = 0;
                
                %using trigonometry to find the sum of the two components 
                %of the forces
                xy(1) = xy(1) + forces(i)*cos(angles(i));
                xy(2) = xy(2) + forces(i)*sin(angles(i));                
            end
        end
    end
    
end