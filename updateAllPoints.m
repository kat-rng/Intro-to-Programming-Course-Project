function updateAllPoints()
    % Ensures that the point references on all connecting lines have been
    % updated to see that point values are correct.
    global allPoints;
    global allLines;
    [~, a] = size(allPoints);
    [~, b] = size(allLines);

    for i = 1:b
        for j = 1:a
            if allPoints(j).ptID == allLines(i).point1.ptID
                allPoints(j).cLines = [allPoints(j).cLines, allLines(i)];
                allPoints(j).mass = allPoints(j).mass + (0.5 * allLines(i).mass);
            end
            if allPoints(j).ptID == allLines(i).point2.ptID
                allPoints(j).cLines = [allPoints(j).cLines, allLines(i)];
                allPoints(j).mass = allPoints(j).mass + (0.5 * allLines(i).mass);
            end
        end
    end

    % Reinput points for lines to give updated information on points, being
    % mass and connected lines.
    for j = 1:b
        pt1Index = allLines(j).point1.ptID;
        pt2Index = allLines(j).point2.ptID;
        allLines(j).point1 = allPoints(pt1Index);
        allLines(j).point2 = allPoints(pt2Index);
    end
end