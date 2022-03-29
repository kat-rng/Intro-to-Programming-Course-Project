function resetAllPoints()
    % Runs when the simulation is stopped. Deletes all connected lines and
    % resets all masses on points.

    global allPoints;
    global allLines;
    [~, a] = size(allPoints);
    [~, b] = size(allLines);

    for i = 1:a
        allPoints(i).mass = 0;
        allPoints(i).cLines = [];
    end
    for j = 1:b
        for i = 1:a
            if allLines(j).point1.ptID == allPoints(i).ptID
                allLines(j).point1 = allPoints(i);
            end
            if allLines(j).point2.ptID == allPoints(i).ptID
                allLines(j).point2 = allPoints(i);
            end
        end
    end
end