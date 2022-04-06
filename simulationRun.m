function simulationRun(buttonSrc, editBtn, mainAxes, resultAxes)
    % Runs the simulation of the model.
    global isStarting;

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
    isStarting = 1;
    hold(resultAxes, "on");

    % Plot all vals on result plot
    while isStarting > 0
        run("Calc_Code.m");
        
        % Plot Points 
        for i = 1:p
            try
                delete(resultPlottedPoints(i));
            end
            resultPlottedPoints(i) = plot(resultAxes, points(i, 4), points(i, 5), '.r', "LineWidth", 20);
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
            
            resultPlottedLines(j) = line([pt1(1), pt2(1)], [pt1(2), pt2(2)], "Color", "red", "LineWidth", 1, "Parent", resultAxes);
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
end