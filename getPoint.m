function [pointReturn, ptIndex] = getPoint(axes)
    % Returns a point's values after clicking on the point itself.
    % Gets closest point to list of all points within range.
    global allPoints;
    [~, a] = size(allPoints);

    global currentState;

    dimAxesX = get(axes, 'XLim');
    dimAxesY = get(axes, 'YLim');
    maxDist = sqrt(((dimAxesX(1) - (dimAxesX(2)))/250)^2 + ((dimAxesY(1) - dimAxesY(2))/250)^2);

    while true
        state = mod(currentState, 2);
        if state == 0
            return;
        end
        [x, y] = ginput(1);
        avaliablePts = [];
        
        for i = 1:a
            dist = sqrt((allPoints(i).x - x)^2 + (allPoints(i).y - y)^2);
            if dist < maxDist
                avaliablePts = [avaliablePts; dist, i];
            end
        end
        [l, ~] = size(avaliablePts);
        if l == 0
            continue
        elseif l == 1
            pointReturn = allPoints(avaliablePts(1, 2));
            ptIndex = avaliablePts(1, 2);
            break;
        else
            closestPt = min(avaliablePts);
            pointReturn = allPoints(closestPt(2));
            ptIndex = closestPt(2);
            break;
        end
    end

end