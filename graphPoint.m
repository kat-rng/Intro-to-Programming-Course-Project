function pointReturn = graphPoint(axes)
    % Get the x and y coordinates of the mouse cursor location, rounded to
    % the closest integer, and plots the point on the figure's axis.
    % Returns the point of the newly plotted point.

    [x, y] = ginput(1);
    plot(axes, x, y, "Color", "black", "LineWidth", "2");
    pointReturn = point(x, y);
    
end