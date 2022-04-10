function convertToCalc()
    % Converts the data from the objects used in graphing to the data
    % matricies used in code calculations.

    global allPoints;
    global allLines;
    global points;
    global lines;

    % Get total number of points and lines on input for calcs. Refer to
    % Calc_Code for what is to be stored in each value.
    p = length(allPoints);
    l = length(allLines);

    points = zeros(p, 10);
    lines = zeros(l, 10);

    % Transfer values for points
    for i = 1:p
        points(i, :) = [allPoints(i).ptID, allPoints(i).fxdA, allPoints(i).fxdPt, allPoints(i).x, allPoints(i).y, 0, 0, 0, 0, allPoints(i).mass];
    end

    % Transfer values for lines
    for j = 1:l
        lines(j, :) = [allLines(j).lnID, allLines(j).material.matID, allLines(j).point1.ptID, allLines(j).point2.ptID, allLines(j).material.density, allLines(j).angleInit, allLines(j).area, allLines(j).lengthInit, allLines(j).material.youngsModulus, allLines(j).material.shearModulus, llLines(j).material.maxAxial, 0];
    end
end