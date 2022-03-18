classdef connectorLine
    % Line Values
    properties
        point1;
        point2;
        length;
        slope;
        material;
        materialStrength;
        lnID;
    end

    % Add Methods
    methods
        function obj = connectorLine(point1, point2, mat, materialStr, id)
            obj.point1 = point1;
            obj.point2 = point2;
            obj.lnID = id;

            obj.length = sqrt((point1.x - point2.x)^2 + (point1.y - point2.y)^2);
            obj.slope = (point2.y - point1.y)/(point2.x - point1.x);
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