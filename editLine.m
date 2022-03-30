function editLine(button, axes)
    % Opens Window to allows user to edit the values of an existing line.
    % Redraws line when done.
    global currentState;
    currentState = currentState + 1;
    state = mod(currentState, 2);
    
    global allLines;
    global allPlottedLines;
    global allMaterials;
    
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
        if a < 1
            currentState = currentState + 1;
            return;
        end
    
        disableAll(button);
        button.String = "Click to Cancel";

        try
            lineIndex = getLine(axes);
        end
        button.Enable = 'off';

        EditFig = popUpWindow("Edit Line");
        
        beamWidthLabel = uicontrol(EditFig, "Style", "text", "String", "Line Width: ", "Position", [0.2 * appWidth, 0.8 * appHeight, 0.3 * appWidth, 0.1 * appHeight], "FontSize", subTitleFontSize);
        beamWidthValue = uicontrol(EditFig, "Style", "edit", "String", allLines(lineIndex).width, "Position", [0.5 * appWidth, 0.8 * appHeight, 0.3 * appWidth, 0.1 * appHeight]);
        beamHeightLabel = uicontrol(EditFig, "Style", "text", "String", "Line Height: ", "Position", [0.2 * appWidth, 0.7 * appHeight, 0.3 * appWidth, 0.1 * appHeight], "FontSize", subTitleFontSize);
        beamHeightValue = uicontrol(EditFig, "Style", "edit", "String", allLines(lineIndex).height, "Position", [0.5 * appWidth, 0.7 * appHeight, 0.3 * appWidth, 0.1 * appHeight]);

        beamMatLabel = uicontrol(EditFig, "Style", "text", "String", "Material: ", "Position", [0.2 * appWidth, 0.6 * appHeight, 0.3 * appWidth, 0.1 * appHeight], "FontSize", subTitleFontSize);
        beamMatValue = uicontrol(EditFig, "Style", "popupmenu", "Position", [0.5 * appWidth, 0.6 * appHeight, 0.3 * appWidth, 0.1 * appHeight]);
        beamMatValue.String = {allMaterials(1).name, allMaterials(2).name};

        saveButton = uicontrol(EditFig, "Style", "pushbutton", "String", "Save", "Position", [0.1 * appWidth, 0.2 * appHeight, 0.3 * appWidth, 0.1 * appHeight], "BackgroundColor","#8BA7A9", "FontSize", buttonFontSize);
        cancelButton = uicontrol(EditFig, "Style", "pushbutton", "String", "Cancel", "Position", [0.6 * appWidth, 0.2 * appHeight, 0.3 * appWidth, 0.1 * appHeight], "BackgroundColor","#8BA7A9", "FontSize", buttonFontSize);
        saveButton.Callback = @(btn, event) saveLine(editFig, lineIndex, str2double(beamWidthValue.String), str2double(beamHeightValue.String), beamMatValue.String);
        cancelButton.Callback = @(btn, event) close(EditFig);
        
        % Wait for figure to close
        uiwait(EditFig);

        button.String = "Edit Connecting Line";
        enableAll();
        currentState = currentState + 1;
    else
        button.String = "Edit Connecting Line";
        enableAll();
    end

end