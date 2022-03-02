%% Bridge Constructor
% George D. Crochiere and Kate LaChance
% HP 103

%% Reset
clc; clear; close all;

%% Screen Generation
% Default Screen Info
screenInfo = get(0, 'ScreenSize');
maxWidth = screenInfo(3);
maxHeight = screenInfo(4);
appWidth = 0.75 * maxWidth;
appHeight = 0.75 * maxHeight;
xCorner = (maxWidth - appWidth)* 0.5;
yCorner = (maxHeight - appHeight)* 0.5;

titleFontSize = appHeight * 0.025;
subTitleFontSize = appHeight * 0.022;
buttonFontSize = appHeight * 0.019;

% Generate Figure and Graph Window
mainWindow = uifigure('Name', "Bridge Constructor",'Position', [xCorner, yCorner, appWidth, appHeight]);
mainGrid = uiaxes("Parent", mainWindow ,"XLim", [-10, 210], "YLim", [-10, 110], "Position", [appWidth * 0.33, appHeight * 0.33, appWidth * 0.66, appHeight * 0.66], "XGrid", "on", "XMinorGrid", "on", "YGrid", "on", "YMinorGrid", "on");
disableDefaultInteractivity(mainGrid);
generalLabel = uilabel(mainWindow, "Text", "Bridge Constructor", "Position", [0.01 * appWidth, 0.95 * appHeight, 0.3 * appWidth, 0.05 * appHeight], "FontSize", titleFontSize, "FontWeight", "bold");

% Point Button Generations
pointLabel = uilabel(mainWindow, "Text", "Point Functions", "Position", [0.015 * appWidth, 0.9 * appHeight, 0.3 * appWidth, 0.05 * appHeight], "FontSize", subTitleFontSize);
pointAddButton = uibutton(mainWindow, 'Text', "Add Point", "Position", [0.02 * appWidth, 0.85 * appHeight, 0.25 * appWidth, 0.05 * appHeight], "FontSize", buttonFontSize);
pointRemoveButton = uibutton(mainWindow, 'Text', "Remove Point", "Position", [0.02 * appWidth, 0.8 * appHeight, 0.25 * appWidth, 0.05 * appHeight], "FontSize", buttonFontSize);
pointEditButton = uibutton(mainWindow, 'Text', "Edit Point", "Position", [0.02 * appWidth, 0.75 * appHeight, 0.25 * appWidth, 0.05 * appHeight], "FontSize", buttonFontSize);

% Line Button Generations
lineLabel = uilabel(mainWindow, "Text", "Connecting Line Functions", "Position", [0.015 * appWidth, 0.7 * appHeight, 0.3 * appWidth, 0.05 * appHeight], "FontSize", subTitleFontSize);
lineAddButton = uibutton(mainWindow, 'Text', "Add Connecting Line", "Position", [0.02 * appWidth, 0.65 * appHeight, 0.25 * appWidth, 0.05* appHeight], "FontSize", buttonFontSize);
lineRemoveButton = uibutton(mainWindow, 'Text', "Remove Connecting Line", "Position", [0.02 * appWidth, 0.6 * appHeight, 0.25 * appWidth, 0.05 * appHeight], "FontSize", buttonFontSize);
lineEditButton = uibutton(mainWindow, 'Text', "Edit Connecting Line", "Position", [0.02 * appWidth, 0.55 * appHeight, 0.25 * appWidth, 0.05 * appHeight], "FontSize", buttonFontSize);

% Simulation Buttons
simulateLabel = uilabel(mainWindow, "Text", "Simulation Control", "Position", [0.015 * appWidth, 0.5 * appHeight, 0.3 * appWidth, 0.05 * appHeight], "FontSize", subTitleFontSize);
simulateButton = uibutton(mainWindow, 'Text', "Start Simulation", "Position", [0.02 * appWidth, 0.45 * appHeight, 0.25 * appWidth, 0.05 * appHeight], "FontSize", buttonFontSize, "BackgroundColor", "green");
editButton = uibutton(mainWindow, 'Text', "Stop Simulation and Edit", "Position", [0.02 * appWidth, 0.4 * appHeight, 0.25 * appWidth, 0.05 * appHeight], "FontSize", buttonFontSize, "BackgroundColor", "red");

% Results Display
resultLabel = uilabel(mainWindow, "Text", "Results:", "Position", [0.015 * appWidth, 0.3 * appHeight, 0.3 * appWidth, 0.05 * appHeight], "FontSize", subTitleFontSize);