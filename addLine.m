function addLine(obj, axes)
    % Adds a connecting line and creates a line object based on 2 points.
    global allPoints;
    global allLines;
    global allPlottedLines;
    [~, a] = size(allPoints);

    % General Material Values - Default for line creation
    global allMaterials;
    defaultMat = allMaterials(1);
    defaultWidth = 2;
    defaultHeight = 4;

    global lnIDCount;
    global currentState;
    currentState = currentState + 1;
    state = mod(currentState, 2);

    if state == 1
        while state == 1
            % Test if function should run
            if a < 2
                currentState = currentState + 1;
                return;
            end
    
            disableAll(obj);
            obj.String = "Click to Disable";
            
            % Get first point
            try
                [point1, ~] = getPoint(axes);
            end
            if mod(currentState, 2) == 0
                return;
            end
            colorPt(point1, "red");
    
            % Get second point, different from first
            while true
                try
                    [point2, ~] = getPoint(axes);
                end
                if mod(currentState, 2) == 0
                    return;
                end
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
            countOverlap = 0;
            [~, l] = size(allLines);
            for i = 1:l
                if ((point1.ptID == allLines(i).point1.ptID) && (point2.ptID == allLines(i).point2.ptID))
                    countOverlap = 1;;
                end
            end
    
            % Add Line
            if countOverlap == 0
                allLines = [allLines, connectorLine(point1.ptID, point2.ptID, defaultMat, defaultWidth, defaultHeight, lnIDCount)];
                lnIDCount = lnIDCount + 1;
                allPlottedLines = [allPlottedLines, line([point1.x, point2.x],[point1.y, point2.y], 'Color', 'blue', 'LineWidth', 0.1 * defaultHeight, "Parent", axes)];
            end
        end
    else
        obj.String = "Add Beam";
        enableAll();
        for i = 1:a
            colorPt(allPoints(i), "blue");
        end
    end

end