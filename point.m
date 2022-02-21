classdef point
    properties
        %position
        x = 0;
        y = 0;
        
        %connected lines
        cLines = {}; 
    end
    
    methods
        function obj = point(x,y,cLines)
            obj.x = x;
            obj.y = y;
            obj.cLines = cLines;
        end
    end %methods
    
end