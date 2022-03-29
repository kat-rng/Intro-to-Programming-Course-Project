function simulationRun(buttonSrc, editBtn, axes)
    % Runs the simulation of the model.
    global allPoints;
    global allLines;

    updateAllPoints();
    disableAll(editBtn);
end