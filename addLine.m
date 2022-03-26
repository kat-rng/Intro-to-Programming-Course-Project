function addLine(obj, axes)
    % Adds a connecting line and creates a line object based on 2 points.
    global allPoints;
    global allLines;
    global allPlottedLines;
    [~, a] = size(allPoints);

    global allMaterials;
    defaultMat = allMaterials(1);
    defaultWidth = 1;
    defaultHeight = 1;

    global lnIDCount;
    global currentState;
    currentState = currentState + 1;
    state = mod(currentState, 2);

    if state == 1
        obj.String = "Click to Cancel";
        if a < 2
            currentState = currentState + 1;
            return;
        end
        disableAll(obj);
            
        [point1, ptaIndex] = getPoint(axes);
        
        state = mod(currentState, 2);
        if state == 0
            return;
        end
        
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
        
        % Test if current line exists
        [~, l] = size(allLines);
        for i = 1:l
            if (point1.ptID == allLines(i).point1.ptID) && (point2.ptID == allLines(i).point2.ptID)
                currentState = currentState + 1;
                obj.String = "Add Connecting Line";
                enableAll();
                return;
            end
        end

        % Add Line
        allLines = [allLines, connectorLine(point1, point2, defaultMat, defaultWidth, defaultHeight, lnIDCount)];
        lnIDCount = lnIDCount + 1;
        allPlottedLines = [allPlottedLines, line([point1.x, point2.x],[point1.y, point2.y], 'Color', 'red')];
        allPoints(ptaIndex).cLines = [allPoints(ptaIndex).cLines, allLines(end)];
        allPoints(ptbIndex).cLines = [allPoints(ptbIndex).cLines, allLines(end)];
        
        allPoints(ptaIndex).mass = allPoints(ptaIndex).mass + 0.5 * allLines(end).mass;
        allPoints(ptbIndex).mass = allPoints(ptbIndex).mass + 0.5 * allLines(end).mass;
        enableAll();
        obj.String = "Add Connecting Line";
        currentState = currentState + 1;
    else
        obj.String = "Add Connecting Line";
        enableAll();
        for i = 1:a
            colorPt(allPoints(i), "blue");
        end
    end
end