function resetProgram(obj, ex)
    % Resets the program by removing all points and lines, and reseting all
    % global values
    global allPoints;
    global allPlottedPoints;
    global allLines;
    global allPlottedLines;

    global ptIDCount;
    global lnIdCount;

    [~, a] = size(allPoints);
    [~, b] = size(allLines);

    % Reset changing globals
    ptIDCount = 0;
    lnIdCount = 0;

    % Clear points
    for i = 1:a
        allPoints(1) = [];
        delete(allPlottedPoints(1));
        allPlottedPoints(1) = [];
    end

    % Clear lines
    for j = 1:b
        allLines(1) = [];
        delete(allPlottedLines(1));
        allPlottedLines(1) = [];
    end
end