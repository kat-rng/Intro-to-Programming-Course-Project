function stopSimulation(buttonSrc, mainAxes, resultAxes)
    % Runs when the simulation is stopped.

    global isStarting;

    isStarting = 0;
    resetAllPoints();
    enableAll();
    mainAxes.Visible = "on";
    set([mainAxes.Children], "Visible", "on");
    resultAxes.Visible = "off";

end