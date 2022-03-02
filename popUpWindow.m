function resultWindow = popUp(typeName)
% Creates a popup window for the Bridge Simulator Program, specifying the
% needed parameters to make the window ideal for the needed component.

    screenInfo = get(0, 'ScreenSize');
    maxWidth = screenInfo(3);
    maxHeight = screenInfo(4);
    appWidth = 0.25 * maxWidth;
    appHeight = 0.25 * maxHeight;
    xCorner = (maxWidth - appWidth)* 0.5;
    yCorner = (maxHeight - appHeight)* 0.5;
    
    titleFontSize = appHeight * 0.025 * 3;
    subTitleFontSize = appHeight * 0.022* 3;
    buttonFontSize = appHeight * 0.019 * 3;

    resultWindow = uifigure("Name", typeName, "Position", [xCorner, yCorner, appWidth, appHeight]);
    winLabel = uilabel("Parent", resultWindow, "Text", typeName, "Position", [0.015 * appWidth, 0.9 * appHeight, 0.3 * appWidth, 0.05 * appHeight], "FontSize", subTitleFontSize);

end