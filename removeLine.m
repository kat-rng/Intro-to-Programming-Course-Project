function removeLine(obj, axes)
    % Removes line after being clicked. Done once.
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