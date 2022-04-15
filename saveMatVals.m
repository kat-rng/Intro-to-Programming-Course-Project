function saveMatVals(matID, matFig)
    % Set all lines to have the material based on the index/id provided.

    global allMaterials;
    global allLines;
    [~, a] = size(allLines);

    for i = 1:a
        allLines(i) = connectorLine(allLines(i).point1.ptID, allLines(i).point2.ptID, allMaterials(matID), allLines(i).width, allLines(i).height, allLines(i).lnID);
    end

    close(matFig);
end