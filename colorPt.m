function colorPt(pointToColor, color)
    % Color's the designated point based on the given color, given as a 
    % string.
    global allPoints;
    global allPlottedPoints;
    [~, a] = size(allPoints);

    for i = 1:a
        if (allPoints(i).ptID == pointToColor.ptID)
            allPlottedPoints(i).Color = color;
            break;
        end
    end

end