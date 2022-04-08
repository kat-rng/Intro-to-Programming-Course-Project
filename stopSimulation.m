function stopSimulation(buttonSrc, mainAxes, resultAxes, errorLabel, simulationDisplays)
    % Runs when the simulation is stopped.

    global isStarting;

    % Reset elements to be hidden and switches from result graph to input.
    isStarting = 0;
    resetAllPoints();
    enableAll();
    mainAxes.Visible = "on";
    set([mainAxes.Children], "Visible", "on");
    set(simulationDisplays, "Visible", "off");
    errorLabel.Visible = "off";

    resultAxes.Visible = "off";

end