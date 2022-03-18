%% Bridge Constructor
% George D. Crochiere and Kate LaChance
% HP 103

%% Reset
clc; clear; close all;

%% Variables
% Establish Globals - Used due to compatibility with variables in between
% functions and lack of return capability.
global currentState;
global allPoints;
global allLines;
global allButtons;
global allPlottedPoints;
global allPlottedLines;

global ptIDCount;
global lnIdCount;

% Basic Variable Setup
currentState = 0;
allPoints = [];
allLines = [];
allPlottedPoints = [];
allPlottedLines = [];

ptIDCount = 0;
lnIdCount = 0;

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
mainWindow = figure("Name", "Bridge Contructor", "Position", [xCorner, yCorner, appWidth, appHeight]);
mainGrid = uiaxes("Parent", mainWindow ,"XLim", [-10, 210], "YLim", [-10, 110], "Position", [appWidth * 0.33, appHeight * 0.33, appWidth * 0.66, appHeight * 0.66], "XGrid", "on", "XMinorGrid", "on", "YGrid", "on", "YMinorGrid", "on");
generalLabel = uicontrol("Parent", mainWindow, "Style", "text", "String", "Bridge Constructor", "Position", [0.01 * appWidth, 0.95 * appHeight, 0.3 * appWidth, 0.05 * appHeight], "FontSize", titleFontSize, "FontWeight", "bold");

disableDefaultInteractivity(mainGrid);
hold on;

% Point Button Generations
pointLabel = uicontrol(mainWindow, "Style", "text", "String", "Point Functions", "Position", [0.015 * appWidth, 0.9 * appHeight, 0.3 * appWidth, 0.05 * appHeight], "FontSize", subTitleFontSize);
pointAddButton = uicontrol(mainWindow, "Style", "pushbutton", "String", "Add Points", "Position", [0.02 * appWidth, 0.85 * appHeight, 0.25 * appWidth, 0.05 * appHeight], "FontSize", buttonFontSize);
pointRemoveButton = uicontrol(mainWindow, "Style", "pushbutton", 'String', "Remove Points", "Position", [0.02 * appWidth, 0.8 * appHeight, 0.25 * appWidth, 0.05 * appHeight], "FontSize", buttonFontSize);
pointEditButton = uicontrol(mainWindow, "Style", "pushbutton", 'String', "Edit Point", "Position", [0.02 * appWidth, 0.75 * appHeight, 0.25 * appWidth, 0.05 * appHeight], "FontSize", buttonFontSize);

% Line Button Generations
lineLabel = uicontrol(mainWindow, "Style", "text", "String", "Connecting Line Functions", "Position", [0.015 * appWidth, 0.7 * appHeight, 0.3 * appWidth, 0.05 * appHeight], "FontSize", subTitleFontSize);
lineAddButton = uicontrol(mainWindow, "Style", "pushbutton", 'String', "Add Connecting Lines", "Position", [0.02 * appWidth, 0.65 * appHeight, 0.25 * appWidth, 0.05* appHeight], "FontSize", buttonFontSize);
lineRemoveButton = uicontrol(mainWindow, "Style", "pushbutton", 'String', "Remove Connecting Lines", "Position", [0.02 * appWidth, 0.6 * appHeight, 0.25 * appWidth, 0.05 * appHeight], "FontSize", buttonFontSize);
lineEditButton = uicontrol(mainWindow, "Style", "pushbutton", 'String', "Edit Connecting Line", "Position", [0.02 * appWidth, 0.55 * appHeight, 0.25 * appWidth, 0.05 * appHeight], "FontSize", buttonFontSize);

% Simulation Buttons
simulateLabel = uicontrol(mainWindow, "Style", "text", "String", "Simulation Control", "Position", [0.015 * appWidth, 0.5 * appHeight, 0.3 * appWidth, 0.05 * appHeight], "FontSize", subTitleFontSize);
simulateButton = uicontrol(mainWindow, "Style", "pushbutton", 'String', "Start Simulation", "Position", [0.02 * appWidth, 0.45 * appHeight, 0.25 * appWidth, 0.05 * appHeight], "FontSize", buttonFontSize, "BackgroundColor", "green");
editButton = uicontrol(mainWindow, "Style", "pushbutton", 'String', "Stop Simulation and Edit", "Position", [0.02 * appWidth, 0.4 * appHeight, 0.25 * appWidth, 0.05 * appHeight], "FontSize", buttonFontSize, "BackgroundColor", "red");

% Results Display
resultLabel = uicontrol(mainWindow, "Style", "text", "String", "Results:", "Position", [0.015 * appWidth, 0.3 * appHeight, 0.3 * appWidth, 0.05 * appHeight], "FontSize", subTitleFontSize);

% All Button Array - For Disabling in Functions
allButtons = [pointAddButton, pointRemoveButton, pointEditButton, lineAddButton, lineRemoveButton, lineEditButton, simulateButton, editButton];

% Establish Commands
pointAddButton.Callback = @(btn, event) addPoint(event.Source, mainGrid);
pointRemoveButton.Callback = @(btn, event) removePoint(event.Source, mainGrid);
lineAddButton.Callback = @(btn, event) addLine(event.Source, mainGrid);
lineRemoveButton.Callback = @(btn, event) removeLine(event.Source, mainGrid);
