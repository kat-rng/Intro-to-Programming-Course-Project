function addPoint(button, axes)
    % Toggles the ability to add points to the graph via mouse clicking.
    disableAll(button);
    global currentState;
    global allPoints;
    global allPlottedPoints;
    [~, a] = size(allPoints);

    global ptIDCount;

    xVal = get(axes, 'XLim');
    yVal = get(axes, 'YLim');
    currentState = currentState + 1;
    b = mod(currentState, 2);
    if b == 1
        button.String = "Click to Disable";
        while b == 1
            [x, y] = ginput(1);
            x = round(x);
            y = round(y);
            count = 0;
            for i = 1:a
                if (x == allPoints(i).x) && (y == allPoints(i).y)
                    count = 1;
                    break;
                end
            end
            if (button.String == "Click to Disable") && (xVal(1) < x) && (xVal(2) > x) && (yVal(1) < y) && (yVal(2) > y) && (count == 0)
                allPlottedPoints = [allPlottedPoints, plot(axes, x, y, '.b', "LineWidth", 20)];
                allPoints = [allPoints, point(x, y, 0, 0, ptIDCount)];
                ptIDCount = ptIDCount + 1;
            end
            if button.String == "Add Points"
                break;
            end
        end
    else
        button.String = "Add Points";
        enableAll();
    end

end