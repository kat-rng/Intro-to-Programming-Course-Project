function removePoint(obj, axes)
    % Removes the point clicked. Must be activated for every point.
    global currentState;
    currentState = currentState + 1;
    state = mod(currentState, 2);

    global allPoints;
    global allPlottedPoints;
    global allLines;
    global allPlottedLines;
    [~, a] = size(allPoints);
    [~, l] = size(allLines);


    if state == 1
        % Check if points exist
        if a == 0
            currentState = currentState + 1;
            return
        end
        disableAll(obj);
        obj.String = "Click to Cancel";
    
        % Get point and make sure its close
        [deletePt, delIndex] = getPoint(axes);
        if obj.String == "Remove Point"
            return;
        end
        
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
        obj.String = "Remove Point";
        currentState = currentState + 1;
    else
        obj.String = "Remove Point";
        enableAll();
end