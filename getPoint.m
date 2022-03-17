function pointReturn = getPoint(obj, axes)
    % Returns a point's values after clicking on the point itself.
    % Gets closest point to list of all points within range.
    global allPoints;
    [~, a] = size(allPoints);
    while true
        clickLoc = axes.IntersectionPoint;
        avaliablePts = [];
    
        for i = 1:a
            dist = sqrt((allPoints(i).x - clickLoc(1)) + (allPoints(i).y - clickLoc(2)));
            if dist < 4
                avaliablePts = [avaliablePts; [dist, allPoints(i)]];
            else
                continue
            end
        end
        [l, ~] = size(avaliablePts);
        if l == 0
            continue
        elseif l == 1
            pointReturn = avaliablePts(1,2);
            break;
        else
            closestPt = min(avaliablePts);
            pointReturn = closestPt(2);
            break;
        end
    end
end