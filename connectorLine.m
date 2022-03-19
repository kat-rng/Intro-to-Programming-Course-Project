classdef connectorLine
    % Line Values
    properties
        point1;
        point2;
        lengthInit;
        lengthNow;
        angleInit;
        angleNow;
        material;
        materialStrength;
    end

    % Add Methods
    methods
        function obj = connectorLine(point1, point2, mat, materialStr)
            obj.point1 = point1;
            obj.point2 = point2;
            
            % Setting up initial values
            obj.lengthInit = findLength(point1, point2);
            obj.lengthNow = obj.lengthInit;
            obj.angleInit = findAngle(point1, point2);
            obj.angleNow = obj.angleInit;
            
            obj.material = mat;
            obj.materialStrength = materialStr;
        end
    end

    % Static Methods
    methods (Static)
        function delLine = delete()
            delLine = 0;
            try
                clear obj;
            catch
                delLine = 1;
            end
        end
        
        function dist = findLength(point1, point2)
            % Literally the pythagorean theorem
            dist = sqrt((point1.x - point2.x)^2 + (point1.y - point2.y)^2);
        end
        function angle = findAngle(point1, point2)
            % Opposite over adjacent, finds angle above x axis
            angle = atan((point1.y - point2.y)/(point1.x - point2.x));
        end
    end
end