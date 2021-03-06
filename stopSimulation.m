function stopSimulation(buttonSrc, mainAxes, resultAxes, simulationDisplays)
    % Runs when the simulation is stopped.

    global isStarting;
    global points;
    points = zeros(1,1);
    global lines;
    lines = zeros(1,1);

    % Reset elements to be hidden and switches from result graph to input.
    isStarting = 0;
    resetAllPoints();
    enableAll();
    mainAxes.Visible = "on";
    set([mainAxes.Children], "Visible", "on");
    set(simulationDisplays, "Visible", "off");

    resultAxes.Visible = "off";

end