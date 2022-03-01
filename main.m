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

% Generate Figure and Graph Window
mainWindow = uifigure('Name', "Bridge Constructor",'Position', [xCorner,...
    yCorner, appWidth, appHeight]);
mainGrid = uiaxes("Parent", mainWindow ,"XLim", [-10, 210], "YLim", ...
    [-10, 110], "Position", [appWidth * 0.33, appHeight * 0.33, ...
    appWidth * 0.66, appHeight * 0.66], "XGrid", "on", "XMinorGrid", ...
    "on", "YGrid", "on", "YMinorGrid", "on");
disableDefaultInteractivity(mainGrid);

% Point Button Generations
pointAddButton = uibutton(mainWindow, 'Text', "Add Point");
pointRemoveButton = uibutton(mainWindow, 'Text', "Remove Point");
pointEditButton = uibutton(mainWindow, 'Text', "Edit Point");

% Line Button Generations
lineAddButton = uibutton(mainWindow, 'Text', "Add Connecting Line");
lineRemoveButton = uibutton(mainWindow, 'Text', "Remove Connecting Line");
lineEditButton = uibutton(mainWindow, 'Text', "Edit Connecting Line");

% Simulation Buttons
simulateButton = uibutton(mainWindow, 'Text', "Start Simulation");
editButton = uibutton(mainWindow, 'Text', "Stop Simulation and Edit");