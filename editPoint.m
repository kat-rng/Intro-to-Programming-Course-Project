function editPoint(button, axes)
    % Opens Window to allows user to edit the values of an existing point.
    % Redraws point when done.
    global currentState;
    currentState = currentState + 1;
    state = mod(currentState, 2);

    % Get general values
    global allPoints;
    [~, a] = size(allPoints);

    screenInfo = get(0, 'ScreenSize');
    maxWidth = screenInfo(3);
    maxHeight = screenInfo(4);
    appWidth = 0.35 * maxWidth;
    appHeight = 0.35 * maxHeight;
    subTitleFontSize = appHeight * 0.021 * 2;
    buttonFontSize = appHeight * 0.018 * 2;

    global allPoints
    global allPlottedPoints
    global allLines;
    global allPlottedLines;

    if state == 1
        % Test to see if function should run.
        if a < 1
            currentState = currentState + 1;
            return;
        end

        disableAll(button);
        button.String = "Click to Cancel";

        % Get closest point and location in index
        try
            [editPoint, editPtIndex] = getPoint(axes);
        end

        if mod(currentState, 2) == 0
            return;
        end
        button.Enable = 'off';
        
        % Open figure to edit point
        editFig = popUpWindow("Edit Point");
    
        % Point Coords
        xValueLabel = uicontrol(editFig, "Style", "text", "String", "X Value: ", "Position", [0.2 * appWidth, 0.8 * appHeight, 0.3 * appWidth, 0.1 * appHeight], "FontSize", subTitleFontSize);
        xValueEdit = uicontrol(editFig, "Style", "edit", "String", editPoint.x, "Position", [0.5 * appWidth, 0.8 * appHeight, 0.3 * appWidth, 0.1 * appHeight]);
        yValueLabel = uicontrol(editFig, "Style", "text", "String", "Y Value: ", "Position", [0.2 * appWidth, 0.7 * appHeight, 0.3 * appWidth, 0.1 * appHeight], "FontSize", subTitleFontSize);
        yValueEdit = uicontrol(editFig, "Style", "edit", "String", editPoint.y, "Position", [0.5 * appWidth, 0.7 * appHeight, 0.3 * appWidth, 0.1 * appHeight]);

        % Fixed Motion Values
        ptMotionFixedLabel = uicontrol(editFig, "Style", "text", "String", "Fixed Position?: ", "Position", [0.2 * appWidth, 0.6 * appHeight, 0.3 * appWidth, 0.1 * appHeight], "FontSize", subTitleFontSize);
        ptMotionFixedValue = uicontrol(editFig, "Style", "popupmenu", "Position", [0.5 * appWidth, 0.6 * appHeight, 0.3 * appWidth, 0.1 * appHeight]);
        ptMotionFixedValue.String = {"False", "True"};
        ptMotionFixedValue.Value = editPoint.fxdPt + 1;

        % Fixed Rotational Values - REMOVED - Not enough time to implement.
        %ptRotFixedLabel = uicontrol(editFig, "Style", "text", "String", "Fixed Rotation?: ", "Position", [0.2 * appWidth, 0.5 * appHeight, 0.3 * appWidth, 0.1 * appHeight], "FontSize", subTitleFontSize);
        %ptRotFixedValue = uicontrol(editFig, "Style", "popupmenu", "Position", [0.5 * appWidth, 0.5 * appHeight, 0.3 * appWidth, 0.1 * appHeight]);
        %ptRotFixedValue.String = {"False", "True"};
        %ptRotFixedValue.Value = editPoint.fxdA + 1;

        % Button Functions
        saveButton = uicontrol(editFig, "Style", "pushbutton", "String", "Save", "Position", [0.1 * appWidth, 0.2 * appHeight, 0.3 * appWidth, 0.1 * appHeight], "BackgroundColor","#8BA7A9", "FontSize", buttonFontSize);
        cancelButton = uicontrol(editFig, "Style", "pushbutton", "String", "Cancel", "Position", [0.6 * appWidth, 0.2 * appHeight, 0.3 * appWidth, 0.1 * appHeight], "BackgroundColor","#8BA7A9", "FontSize", buttonFontSize);
        saveButton.Callback = @(btn, event) savePoint(editFig, editPtIndex, str2double(xValueEdit.String), str2double(yValueEdit.String), ptMotionFixedValue.Value, 0, axes);
        cancelButton.Callback = @(btn, event) close(editFig);
        
        % Wait for figure to close
        uiwait(editFig);

        button.String = "Edit Point";
        enableAll();
        currentState = currentState + 1;
    else
        button.String = "Edit Point";
        enableAll();
    end

end