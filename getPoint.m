function deletePt = getPoint()
    % Returns a point's values after clicking on the point itself.
    % Gets closest point to list of all points within range.
    global allPoints;
    [~, a] = size(allPoints);

    while true
        [x, y] = ginput(1);
        avaliablePts = [];
    
        for i = 1:a
            dist = sqrt((allPoints(i).x - x)^2 + (allPoints(i).y - y)^2);
            if dist < 4
                avaliablePts = [avaliablePts; dist, i];
            end
        end
        [l, ~] = size(avaliablePts);
        if l == 0
            continue
        elseif l == 1
            deletePt = allPoints(avaliablePts(1, 2));
            break;
        else
            closestPt = min(avaliablePts);
            deletePt = closestPt(2);
            break;
        end
    end

end