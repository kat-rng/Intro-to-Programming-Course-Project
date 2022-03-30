function showHelp(button)
    % Shows a popup window when the "Help" button is pressed to give the
    % user information on how to use the program.

    disableAll(button);
    button.Enable = 'off';

    screenInfo = get(0, 'ScreenSize');
    maxWidth = screenInfo(3);
    maxHeight = screenInfo(4);
    appWidth = 0.5 * maxWidth;
    appHeight = 0.5 * maxHeight;
    xCorner = (maxWidth - appWidth)* 0.5;
    yCorner = (maxHeight - appHeight)* 0.5;
    
    titleFontSize = appHeight * 0.025 * 1.25;
    textFontSize = appHeight * 0.0175 * 1.5;
    buttonFontSize = appHeight * 0.019;

    helpFig = figure("Name", "Help", "Position", [xCorner, yCorner, appWidth, appHeight]);
    titleLabel = uicontrol("Parent", helpFig, "Style", "text", "String", "Help: How to use the Bridge Constructor", "Position", [0.25 * appWidth, 0.90 * appHeight, 0.5 * appWidth, 0.075 * appHeight], "FontSize", titleFontSize, "FontWeight", "bold");
    panel1 = uipanel("Parent", helpFig ,"Position", [0.05 * appWidth, 0.2 * appHeight, 0.95 * appWidth, 0.8 * appHeight]);
    closeButton = uicontrol("Parent", helpFig, "Style", "pushbutton", "String", "Close", "Position", [0.35 * appWidth, 0.05 * appHeight, 0.3 * appWidth, 0.075 * appHeight], "BackgroundColor", "#8BA7A9", "FontSize", buttonFontSize);
    closeButton.Callback = @(btn, event) close(helpFig);

    uiwait(helpFig);

    enableAll();

end