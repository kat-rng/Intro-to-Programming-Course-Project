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
global timeStep;

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
wood = bridgeMaterial("Wood", 1500, 1, (2.4*10^6), 1010000, 1, 1);
fakeWood = bridgeMaterial("Steel", 1500, 1, (2.4*10^7), 1010000*2, 1, 2);
test = bridgeMaterial("Bedrock", 1500, 1, (2.4*10^10), 1010000*3, 1, 3);
allMaterials = [wood, fakeWood, test];

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
lineLabel = uicontrol(mainWindow, "Style", "text", "String", "Beam Functions", "Position", [0.015 * appWidth, 0.69 * appHeight, 0.3 * appWidth, 0.05 * appHeight], "FontSize", subTitleFontSize);
lineAddButton = uicontrol(mainWindow, "Style", "pushbutton", 'String', "Add Beam", "Position", [0.04 * appWidth, 0.65 * appHeight, 0.25 * appWidth, 0.05* appHeight], "FontSize", buttonFontSize, "BackgroundColor","#8BA7A9");
lineRemoveButton = uicontrol(mainWindow, "Style", "pushbutton", 'String', "Remove Beam", "Position", [0.04 * appWidth, 0.6 * appHeight, 0.25 * appWidth, 0.05 * appHeight], "FontSize", buttonFontSize, "BackgroundColor","#8BA7A9");
lineEditButton = uicontrol(mainWindow, "Style", "pushbutton", 'String', "Edit Beam", "Position", [0.04 * appWidth, 0.55 * appHeight, 0.25 * appWidth, 0.05 * appHeight], "FontSize", buttonFontSize, "BackgroundColor","#8BA7A9");

% Simulation Buttons
simulateLabel = uicontrol(mainWindow, "Style", "text", "String", "Simulation Control", "Position", [0.015 * appWidth, 0.49 * appHeight, 0.3 * appWidth, 0.05 * appHeight], "FontSize", subTitleFontSize);
simulateButton = uicontrol(mainWindow, "Style", "pushbutton", 'String', "Start Simulation", "Position", [0.04 * appWidth, 0.45 * appHeight, 0.25 * appWidth, 0.05 * appHeight], "FontSize", buttonFontSize, "BackgroundColor", "green");
editButton = uicontrol(mainWindow, "Style", "pushbutton", 'String', "Stop Simulation and Edit", "Position", [0.04 * appWidth, 0.4 * appHeight, 0.25 * appWidth, 0.05 * appHeight], "FontSize", buttonFontSize, "BackgroundColor", "red");

% Simulation Displays - To be shown during simulation for stresses, bream
% breaks, and appropiate labels

% Labels for force comparisons
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

% Label for broken beams
breakColor = uiaxes("Parent", mainWindow, "XLim", [0,1], "YLim", [0,1], "Position", [appWidth * 0.37, appHeight * 0.07, appWidth * 0.22, appHeight * 0.075], "Visible", "off");
breakRectangleColor = rectangle("Parent", breakColor, "FaceColor", [1,1,0], "Position", [0,0,1,1], "Visible", "off");
breakLabel = uicontrol(mainWindow, "Style", "text", "String", "Broken Beams:", "Position", [0.25 * appWidth, 0.085 * appHeight, 0.12 * appWidth, 0.05 * appHeight], "FontSize", buttonFontSize, "Visible", "off");

simulationDisplays = [tensionLabel, compressionLabel, neutralLabel, colorGradient, breakRectangleColor, breakLabel];

% Clear Button
clearButton = uicontrol(mainWindow, "Style", "pushbutton", 'String', "Reset Program", "Position", [0.825 * appWidth, 0.22 * appHeight, 0.15 * appWidth, 0.05 * appHeight], "FontSize", buttonFontSize, "BackgroundColor","#8BA7A9");

% Help Button
helpButton = uicontrol(mainWindow, "Style", "pushbutton", "String", "Help", "Position", [0.825 * appWidth, 0.15 * appHeight, 0.15 * appWidth, 0.05 * appHeight], "FontSize", buttonFontSize, "BackgroundColor", "#8BA7A9");

% Close Button
closeButton = uicontrol(mainWindow, "Style", "pushbutton", "String", "Close", "Position", [0.825 * appWidth, 0.08 * appHeight, 0.15 * appWidth, 0.05 * appHeight], "FontSize", buttonFontSize, "BackgroundColor", "#8BA7A9");

% Time Step Slider
timeSlider = uicontrol("Parent", mainWindow, "Style", "slider", "Position", [0.15 * appWidth, 0.03 * appHeight, 0.5 * appWidth, 0.025 * appHeight], "Value", 0.001, "Max", 0.05, "Min", 0.001, "BackgroundColor", "#8BA7A9");
timeDisp = uicontrol("Parent", mainWindow, "Style", "text", "Position", [0.32 * appWidth, 0.055 * appHeight, 0.16 * appWidth, 0.025 * appHeight], "String", "Timestep: " + num2str(timeSlider.Value));
timeStep = timeSlider.Value;
addlistener(timeSlider, "Value", "PostSet", @(~, ~) getTimeStep(timeSlider, timeDisp));

% All Button Array - For Disabling in Functions
allButtons = [pointAddButton, pointRemoveButton, pointEditButton, lineAddButton, lineRemoveButton, lineEditButton, simulateButton, editButton, clearButton, helpButton, closeButton, timeSlider];

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

% Show help on startup
showHelp(helpButton);