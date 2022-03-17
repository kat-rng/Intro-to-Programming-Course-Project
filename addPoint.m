function addPoint(button, axes)
    % Toggles the ability to add points to the graph via mouse clicking.
    disableAll(button);
    global currentState;
    global allPoints;
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
            if (button.String == "Click to Disable") && (xVal(1) < x) && (xVal(2) > x) && (yVal(1) < y) && (yVal(2) > y)
                plot(axes, x, y, '.b', "LineWidth", 16);
                allPoints = [allPoints, point(x, y, false)];
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