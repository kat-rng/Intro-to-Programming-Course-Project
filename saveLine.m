function saveLine(fig, lineIndex, newWidth, newHeight, newMat, axes)
    % Applies chances to the selected line and recalculated needed values.

    global allLines;
    global allPlottedLines;
    global allMaterials;
    
    close(fig);

    % Replots line and saves data.
    inputMat = getMatIndex(newMat);
    delete(allPlottedLines(lineIndex));
    allLines(lineIndex) = connectorLine(allLines(lineIndex).point1.ptID, allLines(lineIndex).point2.ptID, allMaterials(inputMat), newWidth, newHeight, allLines(lineIndex).lnID);
    allPlottedLines(lineIndex) = line([allLines(lineIndex).point1.x, allLines(lineIndex).point2.x],[allLines(lineIndex).point1.y, allLines(lineIndex).point2.y], 'Color', 'blue', 'LineWidth', (0.1 * newHeight), "Parent", axes);
end