function savePoint(fig, changedPtIndex, newX, newY, newFixedPos, newFixedRot, axes)
    % Applies changes to the point that was made, in turn changing and
    % redrawing both the point and all connected lines.

    global allPoints;
    global allPlottedPoints;
    global allLines;
    global allPlottedLines;
    [~, a] = size(allLines);

    close(fig);

    % Replots changed point.
    allPoints(changedPtIndex) = point(newX, newY, newFixedPos - 1, newFixedRot - 1, allPoints(changedPtIndex).ptID);
    delete(allPlottedPoints(changedPtIndex));
    allPlottedPoints(changedPtIndex) = plot(axes, newX, newY, '.b', "LineWidth", 20);

    % Replots line positions affected by changed point.
    for i = 1:a
        if getIndex(allLines(i).point1.ptID) == changedPtIndex
            delete(allPlottedLines(i));
            if allLines(i).point2.x >= allPoints(changedPtIndex).x
                allLines(i) = connectorLine(allPoints(changedPtIndex).ptID, allLines(i).point2.ptID, allLines(i).material, allLines(i).width, allLines(i).height, allLines(i).lnID);
            else
                allLines(i) = connectorLine(allLines(i).point1.ptID, allPoints(changedPtIndex).ptID, allLines(i).material, allLines(i).width, allLines(i).height, allLines(i).lnID);
            end
            allPlottedLines(i) = line([allLines(i).point1.x, allLines(i).point2.x],[allLines(i).point1.y, allLines(i).point2.y], 'Color', 'blue', 'LineWidth', (0.1 * allLines(i).height), "Parent", axes);
        end
        if getIndex(allLines(i).point2.ptID) == changedPtIndex
            delete(allPlottedLines(i));
            if allLines(i).point1.x >= allPoints(changedPtIndex).x
                allLines(i) = connectorLine(allPoints(changedPtIndex).ptID, allLines(i).point1.ptID, allLines(i).material, allLines(i).width, allLines(i).height, allLines(i).lnID);
            else
                allLines(i) = connectorLine(allLines(i).point1.ptID, allPoints(changedPtIndex).ptID, allLines(i).material, allLines(i).width, allLines(i).height, allLines(i).lnID);
            end
            allPlottedLines(i) = line([allLines(i).point1.x, allLines(i).point2.x],[allLines(i).point1.y, allLines(i).point2.y], 'Color', 'blue', 'LineWidth', (0.1 * allLines(i).height), "Parent", axes);
        end
    end
end