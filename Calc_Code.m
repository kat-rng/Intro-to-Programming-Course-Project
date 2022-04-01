points = zeros(1,10);
% 1     2       3       4  5  6   7   8   9   10
% PtID, FixedA, FixedP, x, y, vx, vy, xf, yf, mass

lines = zeros(1,8);
% 1     2         3    4    5     6           7          8
% LnID, material, Pt1, Pt2, mass, initLength, initAngle, Area*YoungsMod
% current length and angle will have to be calculated anyway

forces = zeros(1,0);

function points = movePoints(points, timeStep)
    for i = 1:length(points(:,1))
        points(i,4) = points(i,4) + points(i,6)*timeStep;
        points(i,5) = points(i,5) + points(i,7)*timeStep;
    end
end
function points = accelPoints(points, timeStep)
    for i = 1:length(points(:,1))
        points(i,6) = points(i,6) + points(i,8)*timeStep/points(i,10);
        points(i,7) = points(i,7) + points(i,9)*timeStep/points(i,10);
    end
end
    
end