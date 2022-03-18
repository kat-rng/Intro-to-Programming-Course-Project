function addLine(obj, axes)
    % Adds a connecting line and creates a line object based on 2 points.
    global allPoints;
    global allLines;
    global allPlottedLines;

    global lnIDCount;

    [~, a] = size(allPoints);
    if a < 2
        return;
    end
    disableAll(obj);

    defaultMat = "Steel";
    defaultMatStr = 1;

    [point1, ptaIndex] = getPoint(axes);
    colorPt(point1, "red");
    while true
        [point2, ptbIndex] = getPoint(axes);
        if (point2.ptID ~= point1.ptID)
            break;
        end
    end
    colorPt(point1, "blue");
    
    if point2.x < point1.x
        pointTemp = point2;
        point2 = point1;
        point1 = pointTemp;
    end
    xRange = point1.x:0.001:point2.x;
    slope = (point2.y - point1.y)/(point2.x - point1.x);
    y = (slope * (xRange - point1.x)) + point1.y;

    % Add Line
    allLines = [allLines, connectorLine(point1, point2, defaultMat, defaultMatStr, lnIDCount)];
    lnIDCount = lnIDCount + 1;
    allPlottedLines = [allPlottedLines, plot(xRange, y, "-r", "LineWidth", 2)];
    allPoints(ptaIndex).cLines = [allPoints(ptaIndex).cLines, allLines(end)];
    allPoints(ptbIndex).cLines = [allPoints(ptbIndex).cLines, allLines(end)];
    enableAll();
end