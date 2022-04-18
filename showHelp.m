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
    
    % Help Text
    titles = ["Note: "; "Timestep: "; "Add Points:"; "Remove Points: "; "Edit Point: "; "Add Beams: "; "Remove Beams: "; "Edit Beam: "; "Set Global Material: "; "Start Simulation: "; "Stop Simulation and Edit: "; "Reset Program: ";];
    content = [
        "Construct your own bridge and test it out by adding points and beams to the grid, editing specific values and parts of the bridge, removing unneeded values, and running the simulation. You can stop the simulation after seeing it’s results and reset the plotted values to easily change scenarios. Points must be used to define all corners and intersections on the bridge, with beams being added to connect two points together. Scroll down for more information on how to use the program.";
        "When canceling or toggling an option, a crosshair may appear on the screen. If you had pressed cancel just beforehand, the crosshair will not give any input into the system. During this, think of it as just a cursor.";
        "Present at the bottom of the screen is a slider labeled (Timestep). Use this slider to determine the accuracy of the simulation. Lower values will provide a more accurate reporesntation of the model, but will be much more computationally intensive, with higher values having the inverse effect. This cannot be changed during the simulation.";
        "Click on the (Add Points) button to toggle the ability to add points to the plot. When activated, click anywhere on the graph to place a point. The point will be rounded initially but can be edited later. Click again to disable.";
        "Click on this button to enable the ability to delete points on the graph. This will delete all beams that are connected to the point upon deletion. Click the button again to cancel/stop the operation.";
        "This function will only operate if at least one point exists. Click on this option to enable the ability to edit an already existing point on the graph. After selecting the button, click on a point to open a GUI with its properties. You can edit the position values and fixed property values while in this window. Click on the (Save) button to save and apply your changes. This will also adjust any connected beams. Click on (Cancel) at any time to cancel the operation.";
        "Click on this function to add default-property beams to the graph. Click (Cancel) at any time to stop the operation. After clicking on the button, click on the first of the two points that will determine the beam’s location. You will know if this is successful if the point turns red. Click on the second point the beam will be connected to, and the new beam will be added.";
        "Click on the button to remove beams from the graph. Click again to cancel the operation. After clicking on the button to remove a beam, click on any existing beam in the graph. This will delete the beam from the input.";
        "This function will only operate if any beams already exist. Click on the button to enable the ability to edit one of the existing lines on the graph. Click again to cancel. After clicking the button to edit the values of an existing line, click on any line that exists. You can then edit the material, width, and height of the beam. Click on (Save) to save and apply the values. Click on (Cancel) to cancel.";
        "This function will only operate if any beams already exist. Click on this button to set the material for all beams present on the graph. Note that the fake materials will deflect far more than their real counterparts, but will not spaz out at high timesteps. This will overwrite any individual materials that have already been preset. This will not set the material of any future beams that are added. Once in the window, select the desired material. Click the (Save) option to apply this material. Click on (Cancel) to cancel.";
        "Click on this button to start a simulation with the program. This will take what has been plotted on the graph and run a simulation, modeling what would happen to the bridge. You cannot edit the bridge while the simulation is running. You’ll be able to see what beams are in tension or compression based on a scale that will display along the bottom of the screen.";
        "Click on this button to stop any simulation that is running. This will show the originally plotted values and allow you to edit the graph.";
        "Click on this button to remove all existing plotted values, including points and beams.";
        ];

    % Format text for display
    windowText = [content(1,1), newline];
    for i = 1:11
        windowText = [windowText, titles(i, 1), content(i+1, 1), newline];
    end

    % Create Window and show text in box that can be scrolled
    titleFontSize = appHeight * 0.025 * 1.25;
    textFontSize = appHeight * 0.0175 * 1.5;
    buttonFontSize = appHeight * 0.019;

    helpFig = figure("Name", "Help", "Position", [xCorner, yCorner, appWidth, appHeight]);
    titleLabel = uicontrol("Parent", helpFig, "Style", "text", "String", "Help: How to use the Bridge Constructor", "Position", [0.25 * appWidth, 0.90 * appHeight, 0.5 * appWidth, 0.075 * appHeight], "FontSize", titleFontSize, "FontWeight", "bold");
    panelScreen = uipanel("Parent", helpFig, "Units", "pixels", "Position", [0.025 * appWidth, 0.15 * appHeight, 0.95 * appWidth, 0.75 * appHeight], "HighlightColor", "k");
    helpText = uicontrol("Style", "edit" ,"Parent", panelScreen, "Units", "normalized", "Position", [0, 0, 1, 1], "Max", 4, "Enable", "off", "String", windowText, "FontSize", appWidth * 0.02, "HorizontalAlignment", "left");
    closeButton = uicontrol("Parent", helpFig, "Style", "pushbutton", "String", "Close", "Position", [0.35 * appWidth, 0.05 * appHeight, 0.3 * appWidth, 0.075 * appHeight], "BackgroundColor", "#8BA7A9", "FontSize", buttonFontSize);
    closeButton.Callback = @(btn, event) close(helpFig);

    % Wait for help window to close before enabling actions on program
    uiwait(helpFig);

    enableAll();

end