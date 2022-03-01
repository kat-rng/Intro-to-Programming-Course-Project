%% Bridge Constructor
% George D. Crochiere and Kate LaChance
% HP 103

screenInfo = get(0, 'ScreenSize');
maxWidth = screenInfo(3);
maxHeight = screenInfo(4);
appWidth = 0.5 * maxWidth;
appHeight = 0.5 * maxHeight;
xCorner = (maxWidth - appWidth)* 0.5;
yCorner = (maxHeight - appHeight)* 0.5;

mainWindow = figure('Name', "Bridge Constructor",'Position', [xCorner, yCorner, appWidth, appHeight]);
