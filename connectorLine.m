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
        lnID;
        
        mInertiaZ = 0;
        width = 0;
        height = 0;
        area = 0;
        youngsMod = 0;
    end

    % Add Methods
    methods
        function obj = connectorLine(point1, point2, mat, materialStr, width, height, id)
            obj.lnID = id;
            obj.point1 = point1;
            obj.point2 = point2;
            
            % Calculating initial values of angles and length
            obj.lengthInit = findLength(point1, point2);
            obj.lengthNow = obj.lengthInit;
            obj.angleInit = findAngle(point1, point2);
            obj.angleNow = obj.angleInit;
            
            obj.material = mat;
            obj.materialStrength = materialStr;
            obj.height = height;
            obj.width = width;
            obj.area = width * height;
        end
        
        % material requirement
        function force = axial(lengthI, lengthF, area, youngsMod)
            % Force = P = (deflection*area*young's modulus)/(length)
            force = (lengthI-lengthF)*area*youngsMod/lengthI;
            
            % The outputted force is *supposed to be* the force felt on
            % point 1 in the direction of the unit vector pointing towards
            % point 2
        end
        
        function tForce = totalForce(self, pointNo)
            force = axial(self.lengthInit,self.lengthF,self.area,self.youngsMod);
            angle = findAngle(self.point1, self.point2);
            tForce = forceToXY(force, angle);
            
            % for the case of axial forces at least, multiplying by
            % negative 1 gives the force value for point 2, as this is like
            % inverting the angle
            if pointNo == 2
                tForce = tForce*(-1);
            end
        end
        
        function dist = findLength(point1, point2)
            % Literally the pythagorean theorem
            dist = sqrt((point1.x - point2.x)^2 + (point1.y - point2.y)^2);
        end
        
        function angle = findAngle(point1, point2)
            % This probably won't work as I don't *think* that it will give
            % angles past pi radians, will have to check
            
            % Opposite over adjacent, finds angle above x axis
            angle = atan((point1.y - point2.y)/(point1.x - point2.x));
        end
        
        function xy = forceToXY(force, angle)
            % obtains the components of the forces
            xy = zeros(2,1);
            % NOTE: xy should always be formatted as a 2,1 matrix
                
            %using trigonometry to find the sum of the two components 
            %of the forces
            xy(1) = xy(1) + force*cos(angle);
            xy(2) = xy(2) + force*sin(angle);
        end
    end

    % Static Methods
    methods (Static)
        
        
    end
end