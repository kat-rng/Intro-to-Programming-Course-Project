function removePoint(obj, axes)
    % Removes the point clicked. Must be activated for every point.
    global allPoints;
    global allPlottedPoints;
    global allLines;
    global allPlottedLines;
    [~, a] = size(allPoints);
    [~, l] = size(allLines);

    % Check if points exist
    if a == 0
        return
    end
    disableAll(obj);

    % Get point and make sure its close
    [deletePt, delIndex] = getPoint(axes);
    
    % Delete ConnectedLines
    toBeDeleted = [];
    for b = 1:l
        if (allLines(b).point1.ptID == deletePt.ptID) || (allLines(b).point2.ptID == deletePt.ptID)
            toBeDeleted = [b, toBeDeleted];
        end    
    end
    [~, del] = size(toBeDeleted);
    for j = 1:del
        delete(allPlottedLines(toBeDeleted(j)));
        allPlottedLines(toBeDeleted(j)) = [];
        allLines(toBeDeleted(j)) = [];
    end

    % Delete Point
    delete(allPlottedPoints(delIndex));
    allPlottedPoints(delIndex) = [];
    allPoints(delIndex) = [];
    enableAll();
end