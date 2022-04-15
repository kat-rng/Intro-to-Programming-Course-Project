function resultWindow = popUpWindow(typeName)
% Creates a popup window for the Bridge Simulator Program, specifying the
% needed parameters to make the window ideal for the needed component.

    screenInfo = get(0, 'ScreenSize');
    maxWidth = screenInfo(3);
    maxHeight = screenInfo(4);
    appWidth = 0.35 * maxWidth;
    appHeight = 0.35 * maxHeight;
    xCorner = (maxWidth - appWidth)* 0.5;
    yCorner = (maxHeight - appHeight)* 0.5;
    
    titleFontSize = appHeight * 0.024 * 2;

    % Returns window with header to be used.
    resultWindow = figure("Name", typeName, "Position", [xCorner, yCorner, appWidth, appHeight]);
    winLabel = uicontrol(resultWindow, "Style", "text", "String", typeName + ": ", "Position", [0.35 * appWidth, 0.90 * appHeight, 0.3 * appWidth, 0.1 * appHeight], "FontSize", titleFontSize);

end