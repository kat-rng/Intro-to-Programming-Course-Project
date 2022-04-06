function stopSimulation(buttonSrc, mainAxes, resultAxes)
    % Runs when the simulation is stopped.

    global allPoints;
    global allPlottedPoints;
    global allLines;
    global allPlottedLines;
    global isStarting;

    isStarting = 0;
    resetAllPoints();
    enableAll();
    mainAxes.Visible = "on";
    resultAxes.Visible = "off";

end