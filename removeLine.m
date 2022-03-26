function removeLine(obj, axes)
    % Removes line after being clicked. Done once.
    global allPoints;
    global allLines;
    global allPlottedLines;
    [~, l] = size(allLines);
    
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
        
        lineID = getLine(axes);
    
        pt1Index = getIndex(allLines(lineID).point1.ptID);
        pt2Index = getIndex(allLines(lineID).point2.ptID);

        allPoints(pt1Index).mass = allPoints(pt1Index).mass - (allLines(lineID).mass * 0.5);
        allPoints(pt2Index).mass = allPoints(pt2Index).mass - (allLines(lineID).mass * 0.5);

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