classdef connectorLine
    % Line Values
    properties
        point1;
        point2;
        length;
        material;
        materialStrength;
    end

    % Add Methods
    methods
        function obj = connectorLine(point1, point2, mat, materialStr)
            obj.point1 = point1;
            obj.point2 = point2;

            obj.length = sqrt((point1.x - point2.x)^2 + (point1.y - point2.y)^2);
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