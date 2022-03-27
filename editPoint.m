function editPoint(button, axes)
    % Opens Window to allows user to edit the values of an existing point.
    % Redraws point when done.
    global currentState;
    currentState = currentState + 1;
    state = mod(currentState, 2);

    global allPoints
    global allPlottedPoints
    global allLines;
    global allPlottedLines;

    if state == 1
        disableAll(button);
        button.String = "Click to Cancel";
        
        [editPoint, editPtIndex] = getPoint(axes);

        fig = popUpWindow("Edit Point");
    
        xValueLabel = uicontrol(fig, "Style", "text", "String", "X Value: ", "Position", []);
        xValueEdit = uicontrol(fig, "Style", "edit", "Value", editPoint.x, "Position", []);
        yValueLabel = uicontrol(fig, "Style", "text", "String", "Y Value: ", "Position", []);
        yValueEdit = uicontrol(fig, "Style", "edit", "Value", editPoint.y, "Position", []);

        saveButton = uicontrol(fig, "Style", "pushbutton", "String", "Save", "Position", []);
        cancelButton = uicontrol(fig, "Style", "pushbutton", "String", "Cancel", "Position", []);
    else
        button.String = "Edit Point";
        enableAll();
    end

end