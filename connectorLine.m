classdef connectorLine
    % Line Values
    properties
        pointX1 = 0;
        pointX2 = 0;
        pointY1 = 0;
        pointY2 = 0;
        length;
        material;
        materialStrength;
    end

    % Add Methods
    methods
        function obj = connectorLine(point1, point2, mat, materialStr)
            obj.pointX1 = point1.x;
            obj.pointX2 = point2.x;
            obj.pointY1 = point1.y;
            obj.pointY2 = point2.y;

            obj.length = sqrt((pointX1 - pointX2)^2 + (pointY1 - pointY2)^2);
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
    end
end