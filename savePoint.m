function savePoint(fig, changedPtIndex, newX, newY, newFixedPos, newFixedRot, axes)
    % Applies changes to the point that was made, in turn changing and
    % redrawing both the point and all connected lines.

    global allPoints;
    global allPlottedPoints;
    global allLines;
    global allPlottedLines;
    [~, a] = size(allLines);

    allPoints(changedPtIndex) = point(newX, newY, newFixedPos, newFixedRot,allPoints(changedPtIndex).ptID);
    delete(allPlottedPoints(changedPtIndex));
    allPlottedPoints(changedPtIndex) = plot(axes, newX, newY, '.b', "LineWidth", 20);

    for i = 1:a
        if getIndex(allLines(i).point1.ptID) == changedPtIndex
            allLines(i) = connectorLine(changedPtIndex, allLines(i).point2.ptID, allLines(i).material, allLines(i).width, allLines(i).height, allLines(i).lnID);
            delete(allPlottedLines(i));
            allPlottedLines(i) = line([newX, allLines(i).point2.x],[newY, allLines(i).point2.y], 'Color', 'blue', 'LineWidth', (0.1 * allLines(i).height));
        end
        if getIndex(allLines(i).point2.ptID) == changedPtIndex
            allLines(i) = connectorLine(allLines(i).point1.ptID, changedPtIndex, allLines(i).material, allLines(i).width, allLines(i).height, allLines(i).lnID);
            delete(allPlottedLines(i));
            allPlottedLines(i) = line([allLines(i).point1.x, newX],[allLines(i).point1.y, newY], 'Color', 'blue', 'LineWidth', (0.1 * allLines(i).height));
        end
    end
    close(fig);
end