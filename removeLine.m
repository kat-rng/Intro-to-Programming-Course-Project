function removeLine(obj, axes)
    % Removes line after being clicked. Done once.
    global allPoints;
    global allLines;
    global allPlottedLines;
    
    global currentState;
    currentState = currentState + 1;
    state = mod(currentState, 2);
    
    if state == 1
        while state == 1
            % Check if lines exist
            [~, l] = size(allLines);
            if l == 0
                currentState = currentState + 1;
                enableAll();
                obj.String = "Remove Beam";
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
        end
    else
        % Cancel
        obj.String = "Remove Beam";
        enableAll();
    end
end