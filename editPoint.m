function editPoint(button, axes)
    % Opens Window to allows user to edit the values of an existing point.
    % Redraws point when done.
    global currentState;
    currentState = currentState + 1;
    state = mod(currentState, 2);

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
        if a < 1
            currentState = currentState + 1;
            return;
        end

        disableAll(button);
        button.String = "Click to Cancel";

        try
            [editPoint, editPtIndex] = getPoint(axes);
        end

        if mod(currentState, 2) == 0
            return;
        end
        button.Enable = 'off';

        fig = popUpWindow("Edit Point");
    
        xValueLabel = uicontrol(fig, "Style", "text", "String", "X Value: ", "Position", [0.2 * appWidth, 0.8 * appHeight, 0.3 * appWidth, 0.1 * appHeight], "FontSize", subTitleFontSize);
        xValueEdit = uicontrol(fig, "Style", "edit", "String", editPoint.x, "Position", [0.5 * appWidth, 0.8 * appHeight, 0.3 * appWidth, 0.1 * appHeight]);
        yValueLabel = uicontrol(fig, "Style", "text", "String", "Y Value: ", "Position", [0.2 * appWidth, 0.7 * appHeight, 0.3 * appWidth, 0.1 * appHeight], "FontSize", subTitleFontSize);
        yValueEdit = uicontrol(fig, "Style", "edit", "String", editPoint.y, "Position", [0.5 * appWidth, 0.7 * appHeight, 0.3 * appWidth, 0.1 * appHeight]);

        ptFixedLabel = uicontrol(fig, "Style", "text", "String", "Fixed?: ", "Position", [0.2 * appWidth, 0.6 * appHeight, 0.3 * appWidth, 0.1 * appHeight], "FontSize", subTitleFontSize);
        ptFixedValue = uicontrol(fig, "Style", "popupmenu", "Position", [0.5 * appWidth, 0.6 * appHeight, 0.3 * appWidth, 0.1 * appHeight]);
        ptFixedValue.String = {"False", "True"};

        saveButton = uicontrol(fig, "Style", "pushbutton", "String", "Save", "Position", [0.1 * appWidth, 0.2 * appHeight, 0.3 * appWidth, 0.1 * appHeight], "BackgroundColor","#8BA7A9", "FontSize", buttonFontSize);
        cancelButton = uicontrol(fig, "Style", "pushbutton", "String", "Cancel", "Position", [0.6 * appWidth, 0.2 * appHeight, 0.3 * appWidth, 0.1 * appHeight], "BackgroundColor","#8BA7A9", "FontSize", buttonFontSize);
        saveButton.Callback = @(btn, event) savePoint(editPtIndex, xValueEdit.Value, yValueEdit.Value, ptFixedValue.Value);
        cancelButton.Callback = @(btn, event) close(fig);
        
        % Wait for figure to close
        uiwait(fig);

        button.String = "Edit Point";
        enableAll();
        currentState = currentState + 1;
    else
        button.String = "Edit Point";
        enableAll();
    end

end