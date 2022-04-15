function setGlobalMat(btn)
    % Sets the material for all lines present on the plot to save time for
    % setting the material for a large structure (QoL)

    global allLines;
    global allMaterials;
    [~, c] = size(allMaterials);
    materialString = string.empty;
    for i = 1:c
        materialString(i) = allMaterials(i).name;
    end

    % General Values
    screenInfo = get(0, 'ScreenSize');
    maxWidth = screenInfo(3);
    maxHeight = screenInfo(4);
    appWidth = 0.35 * maxWidth;
    appHeight = 0.35 * maxHeight;
    subTitleFontSize = appHeight * 0.021 * 2;
    buttonFontSize = appHeight * 0.018 * 2;
    
    % Test if beams exist
    [~, a] = size(allLines);
    if a > 0
        % Prevent interaction
        disableAll(btn);
        btn.Enable = "off";
    
        % Create Figure
        matFig = popUpWindow("Set Global Material");

        % Material Values
        matLabel = uicontrol(matFig, "Style", "text", "String", "Material: ", "Position", [0.2 * appWidth, 0.6 * appHeight, 0.3 * appWidth, 0.1 * appHeight], "FontSize", subTitleFontSize);
        matValue = uicontrol(matFig, "Style", "popupmenu", "Position", [0.5 * appWidth, 0.6 * appHeight, 0.3 * appWidth, 0.1 * appHeight]);
        matValue.String = materialString;
        
        % Buttons
        saveButton = uicontrol(matFig, "Style", "pushbutton", "String", "Save", "Position", [0.1 * appWidth, 0.2 * appHeight, 0.3 * appWidth, 0.1 * appHeight], "BackgroundColor","#8BA7A9", "FontSize", buttonFontSize);
        cancelButton = uicontrol(matFig, "Style", "pushbutton", "String", "Cancel", "Position", [0.6 * appWidth, 0.2 * appHeight, 0.3 * appWidth, 0.1 * appHeight], "BackgroundColor","#8BA7A9", "FontSize", buttonFontSize);
        saveButton.Callback = @(btn, event) saveMatVals(matValue.Value, matFig);
        cancelButton.Callback = @(btn, event) close(matFig);
        
        % Wait for figure to close
        uiwait(matFig);
    
        enableAll();
    end

end