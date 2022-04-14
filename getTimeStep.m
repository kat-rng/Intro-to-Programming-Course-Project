function getTimeStep(slider, label)
    % Updates the label and global timestep values when timestep slider is
    % updated.

    global timeStep;

    timeStep = slider.Value;
    label.String = "Timestep: " + num2str(slider.Value);
end