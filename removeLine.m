function removeLine(obj, axes)
    % Removes line after being clicked. Done once.
    global allLines;
    global allPlottedLines;
    [~, l] = size(allLines);
    
    dimAxesX = get(axes, 'XLim');
    dimAxesY = get(axes, 'YLim');
    maxDist = sqrt(((dimAxesX(1) - (dimAxesX(2)))/250)^2 + ((dimAxesY(1) - dimAxesY(2))/250)^2);
    
    global currentState;
    currentState = currentState + 1;
    state = mod(currentState, 2);
    
    if state == 1
        % Check if points exist
        if l == 0
            currentState = currentState + 1;
            return
        end
        disableAll(obj);
        obj.String = "Click to Cancel";
        
        while true
            % Get point clicked - used to determine closest line
            [x, y] = ginput(1);
            lineDistance = [];
    
            % Calc closest line
            for i = 1:l
                v1 = allLines(i).point1;
                v2 = allLines(i).point2;
                t =(-1) * ((((v1.x - x) * (v2.x - v1.x))+((v1.y - y) * (v2.y - v1.y))) / ((v2.x - v1.x)^2 + (v2.y - v1.y)^2));
                if (t <= 1) && (t >= 0)
                    if (v1.x == v2.x)
                        dist = abs(v1.x - x);
                    else
                        m = allLines(i).slope;
                        c1 = ((-1)* m * x)-y;
                        c2 = ((-1) * m * v1.y)-v1.y;
                        dist = (abs(c2-c1))/(sqrt(m^2 + 1));
                    end
                else
                    d1 = sqrt((v2.x - x)^2 + (v2.y - y)^2);
                    d2 = sqrt((v1.x - x)^2 + (v1.y - y)^2);
                    dist = min(d1, d2);
                end
    
                lineDistance = [lineDistance; dist, i];
            end
            [closestDist, lineID] = min(lineDistance(:, 1));
            if closestDist < maxDist
                break;
            end
        end
    
        delete(allPlottedLines(lineID));
        allPlottedLines(lineID) = [];
        allLines(lineID) = [];
        currentState = currentState + 1;
        obj.String = "Remove Connecting Line";
        enableAll();
    else
        obj.String = "Remove Connecting Line";
        enableAll();
    end
end