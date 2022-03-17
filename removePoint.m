function removePoint(obj, src)
    % Removes the point clicked. Must be activated for every point.
    global allPoints;
    global allPlottedPoints;
    [~, a] = size(allPoints);

    % Check if points exist
    if a == 0
        return
    end
    disableAll(obj);

    % Get point and make sure its close
    deletePt = getPoint();
    disp("test");
    
    % Delete
    for i = 1:a
        if (allPoints(i).x == deletePt.x) && (allPoints(i).y == deletePt.y)
            delete(allPlottedPoints(i));
            allPlottedPoints(i) = [];
            allPoints(i) = [];
            break;
        end
    end
    enableAll();
end