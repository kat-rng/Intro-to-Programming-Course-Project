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
global allMaterials;
global points;
global lines;

global ptIDCount;
global lnIDCount;
global editPresent;

% Basic Variable Setup
currentState = 0;
allPoints = [];
allLines = [];
allPlottedPoints = [];
allPlottedLines = [];

ptIDCount = 0;
lnIDCount = 0;
editPresent = 0;

%% Generate Materials
%name, density, maxShear, maxAxial, youngs, shearMod, id
wood = bridgeMaterial("Wood", 1500, 1, 1, (10^6), 6.2, 1);
test = bridgeMaterial("Test", 2000, 2, 2, (10^7), 7, 2);
allMaterials = [wood, test];

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
resultGrid = uiaxes("Parent", mainWindow, "XLim", [-1, 21], "YLim", [-1, 11], "Position", [appWidth * 0.33, appHeight * 0.33, appWidth * 0.66, appHeight * 0.66], "XGrid", "on", "XMinorGrid", "on", "YGrid", "on", "YMinorGrid", "on");
mainGrid = uiaxes("Parent", mainWindow ,"XLim", [-1, 21], "YLim", [-1, 11], "Position", [appWidth * 0.33, appHeight * 0.33, appWidth * 0.66, appHeight * 0.66], "XGrid", "on", "XMinorGrid", "on", "YGrid", "on", "YMinorGrid", "on");

% Should be .015, is currently 0.01
generalLabel = uicontrol("Parent", mainWindow, "Style", "text", "String", "Bridge Constructor", "Position", [0.01 * appWidth, 0.95 * appHeight, 0.3 * appWidth, 0.05 * appHeight], "FontSize", titleFontSize, "FontWeight", "bold");

disableDefaultInteractivity(mainGrid);
hold(mainGrid, "on");

% Point Button Generations
pointLabel = uicontrol(mainWindow, "Style", "text", "String", "Point Functions", "Position", [0.015 * appWidth, 0.89 * appHeight, 0.3 * appWidth, 0.05 * appHeight], "FontSize", subTitleFontSize);
pointAddButton = uicontrol(mainWindow, "Style", "pushbutton", "String", "Add Points", "Position", [0.04 * appWidth, 0.85 * appHeight, 0.25 * appWidth, 0.05 * appHeight], "FontSize", buttonFontSize, "BackgroundColor","#8BA7A9");
pointRemoveButton = uicontrol(mainWindow, "Style", "pushbutton", 'String', "Remove Point", "Position", [0.04 * appWidth, 0.8 * appHeight, 0.25 * appWidth, 0.05 * appHeight], "FontSize", buttonFontSize, "BackgroundColor","#8BA7A9");
pointEditButton = uicontrol(mainWindow, "Style", "pushbutton", 'String', "Edit Point", "Position", [0.04 * appWidth, 0.75 * appHeight, 0.25 * appWidth, 0.05 * appHeight], "FontSize", buttonFontSize, "BackgroundColor","#8BA7A9");

% Line Button Generations
lineLabel = uicontrol(mainWindow, "Style", "text", "String", "Connecting Line Functions", "Position", [0.015 * appWidth, 0.69 * appHeight, 0.3 * appWidth, 0.05 * appHeight], "FontSize", subTitleFontSize);
lineAddButton = uicontrol(mainWindow, "Style", "pushbutton", 'String', "Add Connecting Line", "Position", [0.04 * appWidth, 0.65 * appHeight, 0.25 * appWidth, 0.05* appHeight], "FontSize", buttonFontSize, "BackgroundColor","#8BA7A9");
lineRemoveButton = uicontrol(mainWindow, "Style", "pushbutton", 'String', "Remove Connecting Line", "Position", [0.04 * appWidth, 0.6 * appHeight, 0.25 * appWidth, 0.05 * appHeight], "FontSize", buttonFontSize, "BackgroundColor","#8BA7A9");
lineEditButton = uicontrol(mainWindow, "Style", "pushbutton", 'String', "Edit Connecting Line", "Position", [0.04 * appWidth, 0.55 * appHeight, 0.25 * appWidth, 0.05 * appHeight], "FontSize", buttonFontSize, "BackgroundColor","#8BA7A9");

% Simulation Buttons
simulateLabel = uicontrol(mainWindow, "Style", "text", "String", "Simulation Control", "Position", [0.015 * appWidth, 0.49 * appHeight, 0.3 * appWidth, 0.05 * appHeight], "FontSize", subTitleFontSize);
simulateButton = uicontrol(mainWindow, "Style", "pushbutton", 'String', "Start Simulation", "Position", [0.04 * appWidth, 0.45 * appHeight, 0.25 * appWidth, 0.05 * appHeight], "FontSize", buttonFontSize, "BackgroundColor", "green");
editButton = uicontrol(mainWindow, "Style", "pushbutton", 'String', "Stop Simulation and Edit", "Position", [0.04 * appWidth, 0.4 * appHeight, 0.25 * appWidth, 0.05 * appHeight], "FontSize", buttonFontSize, "BackgroundColor", "red");

% Simulation Displays - To be shown during simulation for stresses, bream
% breaks, and appropiate labels
tensionLabel = uicontrol(mainWindow, "Style", "text", "String", "Tension Forces", "Position", [0.52 * appWidth, 0.17 * appHeight, 0.15 * appWidth, 0.05 * appHeight], "FontSize", buttonFontSize, "Visible", "off");
neutralLabel = uicontrol(mainWindow, "Style", "text", "String", "Neutral", "Position", [0.355 * appWidth, 0.17 * appHeight, 0.10 * appWidth, 0.05 * appHeight], "FontSize", buttonFontSize, "Visible", "off");
compressionLabel = uicontrol(mainWindow, "Style", "text", "String", "Compression Forces", "Position", [0.1875 * appWidth, 0.17 * appHeight, 0.14 * appWidth, 0.05 * appHeight], "FontSize", buttonFontSize, "Visible", "off");
colorPlot = uiaxes("Parent", mainWindow, "XLim", [0,21], "YLim", [0,1], "Position", [appWidth * 0.15, appHeight * 0.2, appWidth * 0.5, appHeight * 0.075], "Visible", "off");
colorGradient = zeros(1, 21);
for i = 1:11
    colorGradient(1, i+10) = rectangle("Parent", colorPlot, "FaceColor", [1 - (i/11), 0, 1], "Position", [i+10,0,1,1], "Visible", "off");
end
for j = 1:10
    colorGradient(1, j) = rectangle("Parent", colorPlot, "FaceColor", [1, 0, (j/10)], "Position", [j,0,1,1], "Visible", "off");
end
colorPlot.Visible = "off";
simulationDisplays = [tensionLabel, compressionLabel, neutralLabel, colorGradient];

% Clear Button
clearButton = uicontrol(mainWindow, "Style", "pushbutton", 'String', "Reset Program", "Position", [0.825 * appWidth, 0.22 * appHeight, 0.15 * appWidth, 0.05 * appHeight], "FontSize", buttonFontSize, "BackgroundColor","#8BA7A9");

% Help Button
helpButton = uicontrol(mainWindow, "Style", "pushbutton", "String", "Help", "Position", [0.825 * appWidth, 0.15 * appHeight, 0.15 * appWidth, 0.05 * appHeight], "FontSize", buttonFontSize, "BackgroundColor", "#8BA7A9");

% Close Button
closeButton = uicontrol(mainWindow, "Style", "pushbutton", "String", "Close", "Position", [0.825 * appWidth, 0.08 * appHeight, 0.15 * appWidth, 0.05 * appHeight], "FontSize", buttonFontSize, "BackgroundColor", "#8BA7A9");

% All Button Array - For Disabling in Functions
allButtons = [pointAddButton, pointRemoveButton, pointEditButton, lineAddButton, lineRemoveButton, lineEditButton, simulateButton, editButton, clearButton, helpButton, closeButton];

% Establish Commands
pointAddButton.Callback = @(btn, event) addPoint(event.Source, mainGrid);
pointRemoveButton.Callback = @(btn, event) removePoint(event.Source, mainGrid);
pointEditButton.Callback = @(btn, event) editPoint(event.Source, mainGrid);
lineAddButton.Callback = @(btn, event) addLine(event.Source, mainGrid);
lineRemoveButton.Callback = @(btn, event) removeLine(event.Source, mainGrid);
lineEditButton.Callback = @(btn, event) editLine(event.Source, mainGrid);
clearButton.Callback = @resetProgram;
helpButton.Callback = @(btn, event) showHelp(event.Source);
simulateButton.Callback = @(btn, event) simulationRun(event.Source, editButton, mainGrid, resultGrid, simulationDisplays);
editButton.Callback = @(btn, event) stopSimulation(event.Source, mainGrid, resultGrid, simulationDisplays);
closeButton.Callback = @(btn, event) close(mainWindow);