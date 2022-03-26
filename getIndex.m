function index = getIndex(id)
    % Returns the index value in the array of allPoints based on the
    % id value given as an input.
    
    global allPoints;
    [~, a] = size(allPoints);

    for i = 1:a
        if allPoints(i).ptID == id
            index = i;
            break
        end
    end

end