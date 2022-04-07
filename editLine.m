function editLine(button, axes)
    % Opens Window to allows user to edit the values of an existing line.
    % Redraws line when done.
    global currentState;
    currentState = currentState + 1;
    state = mod(currentState, 2);
    
    global allLines;
    global allPlottedLines;
    global allMaterials;
    
    % General Values
    global allPoints;
    [~, a] = size(allLines);

    screenInfo = get(0, 'ScreenSize');
    maxWidth = screenInfo(3);
    maxHeight = screenInfo(4);
    appWidth = 0.35 * maxWidth;
    appHeight = 0.35 * maxHeight;
    subTitleFontSize = appHeight * 0.021 * 2;
    buttonFontSize = appHeight * 0.018 * 2;
    
    if state == 1
        % Test to see if function should run.
        if a < 1
            currentState = currentState + 1;
            return;
        end
    
        disableAll(button);
        button.String = "Click to Cancel";

        % Get line
        try
            lineIndex = getLine(axes);
        end
        button.Enable = 'off';

        % Open popup edit window
        editFig = popUpWindow("Edit Line");
        
        % Beam number values
        beamWidthLabel = uicontrol(editFig, "Style", "text", "String", "Line Width: ", "Position", [0.2 * appWidth, 0.8 * appHeight, 0.3 * appWidth, 0.1 * appHeight], "FontSize", subTitleFontSize);
        beamWidthValue = uicontrol(editFig, "Style", "edit", "String", allLines(lineIndex).width, "Position", [0.5 * appWidth, 0.8 * appHeight, 0.3 * appWidth, 0.1 * appHeight]);
        beamHeightLabel = uicontrol(editFig, "Style", "text", "String", "Line Height: ", "Position", [0.2 * appWidth, 0.7 * appHeight, 0.3 * appWidth, 0.1 * appHeight], "FontSize", subTitleFontSize);
        beamHeightValue = uicontrol(editFig, "Style", "edit", "String", allLines(lineIndex).height, "Position", [0.5 * appWidth, 0.7 * appHeight, 0.3 * appWidth, 0.1 * appHeight]);

        % Material Values
        beamMatLabel = uicontrol(editFig, "Style", "text", "String", "Material: ", "Position", [0.2 * appWidth, 0.6 * appHeight, 0.3 * appWidth, 0.1 * appHeight], "FontSize", subTitleFontSize);
        beamMatValue = uicontrol(editFig, "Style", "popupmenu", "Position", [0.5 * appWidth, 0.6 * appHeight, 0.3 * appWidth, 0.1 * appHeight]);
        beamMatValue.String = {allMaterials(1).name, allMaterials(2).name};
        beamMatValue.Value = getMatIndex(allLines(lineIndex).material.name);

        % Buttons
        saveButton = uicontrol(editFig, "Style", "pushbutton", "String", "Save", "Position", [0.1 * appWidth, 0.2 * appHeight, 0.3 * appWidth, 0.1 * appHeight], "BackgroundColor","#8BA7A9", "FontSize", buttonFontSize);
        cancelButton = uicontrol(editFig, "Style", "pushbutton", "String", "Cancel", "Position", [0.6 * appWidth, 0.2 * appHeight, 0.3 * appWidth, 0.1 * appHeight], "BackgroundColor","#8BA7A9", "FontSize", buttonFontSize);
        saveButton.Callback = @(btn, event) saveLine(editFig, lineIndex, str2double(beamWidthValue.String), str2double(beamHeightValue.String), beamMatValue.String(beamMatValue.Value));
        cancelButton.Callback = @(btn, event) close(editFig);
        
        % Wait for figure to close
        uiwait(editFig);

        button.String = "Edit Connecting Line";
        enableAll();
        currentState = currentState + 1;
    else
        button.String = "Edit Connecting Line";
        enableAll();
    end

end