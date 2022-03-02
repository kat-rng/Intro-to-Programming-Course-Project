classdef point
    properties
        %position
        x = 0;
        y = 0;
        
        %connected 
        cLines = {}; 
    end
    
    % Add Methods
    methods
        % Constructor
        function obj = point(x,y)
            obj.x = x;
            obj.y = y;
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
    end
    
end