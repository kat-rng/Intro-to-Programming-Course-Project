function stopSimulation(buttonSrc, axes)
    % Runs when the simulation is stopped.

    global allPoints;
    global allPlottedPoints;
    global allLines;
    global allPlottedLines;

    resetAllPoints();
    enableAll();
end