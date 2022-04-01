global points;
points = zeros(2,10);
%TODO: add a pointer for what PtID to assign to any given new point
points(1,:) = 1:10;
% 1     2       3       4  5  6   7   8   9   10
% PtID, FixedA, FixedP, x, y, vx, vy, xf, yf, mass
global lines;
lines = zeros(1,10);
% 1     2         3    4    5     6          7     8           9           10
% LnID, material, Pt1, Pt2, mass, initAngle, Area, initLength, Young'sMod, Shear Modulus
% current length and angle will have to be calculated anyway

forces = zeros(1,0);

function points = movePoints(timeStep)
    %moves points based off of applying the velocity over a small time
    %step
    for i = 1:length(points(:,1))
        points(i,4) = points(i,4) + points(i,6)*timeStep;
        points(i,5) = points(i,5) + points(i,7)*timeStep;
    end
end
function points = accelPoints(timeStep)
    %changes points velocities via applying newton's second law (a=f/m)
    %over a small time step
    for i = 1:length(points(:,1))
        points(i,6) = points(i,6) + points(i,8)*timeStep/points(i,10);
        points(i,7) = points(i,7) + points(i,9)*timeStep/points(i,10);
    end
end
function dVector = axialFDirVect(points, p1i, p2i)
    % Produces a force wo
    
    dVector = zeros(1,2);
    
    % Vector points from point 1 to point 2, as this would result in
    % tension (positive force) forcing the point towards equilibrium
    dVector(1) = points(p2i,4)-points(p1i,4);
    dVector(2) = points(p2i,5)-points(p1i,5);
    
    % Divide by magnitude to turn it into a unit vector
    magnitude = (dVector(1)^2 + dVector(2)^2)^0.5;
    dVector(1) = dVector(1) / magnitude;
    dVector(2) = dVector(2) / magnitude;
end
