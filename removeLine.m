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
        
        % Attempts to get line on click.
        try
            lineIndex = getLine(axes);
        end

        if obj.String == "Remove Beam"
            return;
        end

        % Removes line from plot and data
        delete(allPlottedLines(lineIndex));
        allPlottedLines(lineIndex) = [];
        allLines(lineIndex) = [];
        currentState = currentState + 1;
        obj.String = "Remove Beam";
        enableAll();
    else
        obj.String = "Remove Beam";
        enableAll();
    end
end