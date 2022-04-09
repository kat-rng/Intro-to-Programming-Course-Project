function simulationRun(buttonSrc, editBtn, mainAxes, resultAxes, simulationDisplays)
    % Runs the simulation of the model.
    global isStarting;

    global allPoints;
    global allLines;
    global points;
    global lines;
    [p, ~] = size(points);
    [l, ~] = size(lines);

    resultPlottedPoints = [];
    resultPlottedLines = [];
    
    % Set GUI Properties
    updateAllPoints();
    disableAll(editBtn);
    resultAxes.Visible = "on";
    mainAxes.Visible = "off";
    set([mainAxes.Children], "Visible", "off");
    set(simulationDisplays, "Visible", "on");
    isStarting = 1;
    hold(resultAxes, "on");
    count = 0;
    skipFrames = 5;

    % Plot all vals on result plot
    while isStarting > 0
        run("Calc_Code.m");
        
        % Display every 5 frames
        if mod(count, skipFrames) == 0
            % Plot Points 
            for i = 1:p
                try
                    delete(resultPlottedPoints(i));
                end
                resultPlottedPoints(i) = plot(resultAxes, points(i, 4), points(i, 5), '.g', "LineWidth", 20);
            end
    
            % Plot Lines
            for j = 1:l
                try
                    delete(resultPlottedLines(j));
                end
                pt1 = zeros(1,2);
                pt2 = zeros(1,2);
                for n = 1:p
                    if (lines(j, 3) == points(n, 1))
                        pt1 = [points(n, 4), points(n, 5)];
                    end
                    if (lines(j, 4) == points(n, 1))
                        pt2 = [points(n, 4), points(n, 5)];
                    end
                end
                distance = sqrt(((pt1(1)-pt2(1))^2) + ((pt1(2)-pt2(2))^2));
                color = "magenta";
                if distance > lines(j, 8)
                    color = "blue";
                elseif distance < lines(j, 8)
                    color = "red";
                end
                resultPlottedLines(j) = line([pt1(1), pt2(1)], [pt1(2), pt2(2)], "Color", color, "LineWidth", 1, "Parent", resultAxes);
            end
            pause(0.1);
    
            % Check if simulation should continue
            if isStarting == 0
                for k = 1:p
                    delete(resultPlottedPoints(1));
                    resultPlottedPoints(1) = [];
                end
                for m = 1:l
                    delete(resultPlottedLines(1));
                    resultPlottedLines(1) = [];
                end
                break;
            elseif isStarting == 1
                isStarting = 2;
            end
        end
        count = count + 1;
    end
end