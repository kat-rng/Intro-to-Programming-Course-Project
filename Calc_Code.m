global isStarting;
global points;
global lines;
testData()
if(isStarting==1)
points = zeros(7,10);
%TODO: add a pointer for what PtID to assign to any given new point
% points(i,4) = x position of index i
% 1     2       3       4  5  6   7   8   9   10
% PtID, FixedA, FixedP, x, y, vx, vy, xf, yf, mass

lines = zeros(11,10);
% 1     2         3    4    5        6          7     8           9           10
% LnID, material, Pt1, Pt2, density, initAngle, Area, initLength, Young'sMod, Shear Modulus
% current length and angle will have to be calculated anyway

forces = zeros(1,0);
testData();

else
    jeb();
end

function p = testData()
    global points;
    global lines;
    
    points = zeros(7,10);
    lines = zeros(11,10);
    p= 1;
    %lower points
    for i = 1:4
        %setting x
        points(i,3) = (i-1)*3;
        
        %setting y
        points(i,4) = 0;
    end
    %upper points
    for i = 5:7
        %setting x
        points(i,3) = (i-5)*3+1.5;
        
        %setting y
        points(i,4) = 2.598076211;
    end
    points(:,1) = 1:7;
    
    lines(:,1) = 1:11;
    %point IDs
    lines(:,3) = [1,2,3,5,6,1,5,2,6,3,7];
    lines(:,4) = [2,3,4,6,7,5,2,6,3,7,4];
    lines(:,2) = 1;
    lines(:,8) = 1;
    % area of a 2x4 in meters^2
    lines(:,7) = 0.00516128;
    %young's modulus of bass wood
    lines(:,9) = 10100*10^6;
    %density of bass wood
    lines(:,5) = 415;
    calcMass();
end
function calcMass()
    global points;
    global lines;
    for i = 1:length(lines)
        %calculate the mass by multiplying the density by the volume of the
        %beam
        m = lines(i,5)*lines(i,7)*lines(i,8);
        
        %get the indecies
        p = findPtIndexes(i);
        
        %add half the mass of each beam to the ends
        points(p(1),10) = points(p(1),10) + m/2;
        points(p(2),10) = points(p(2),10) + m/2;
    end
end
function a = jeb()
    % Jeb is very good at figuring out how to simulate bridges so we hired
    % him. Be sure to thank him because we haven't paid him in months.
    global points;
    a=0;
    
    %May be changeable later but for now it will be hard coded
    timeStep = 0.01;
    
    %Set all the forces to 0
    points(:,8:9)=0;
    
    %apply the current forces
    applyAllForces();
    
    %use the forces to determine the change in velocity
    accelPoints(timeStep);
    
    %use the velocities to determine the change in position
    movePoints(timeStep);
end
function applyAllForces()
    %just iterates applyForces
    global lines
    for i=1:length(lines(:,1))
        applyForces(i);
    end
end
function p = movePoints(timeStep)
    %moves points based off of applying the velocity over a small time
    %step
    global points;
    p = 0;
    for i = 1:length(points(:,1))
        if(points(1) == 0)
            points(i,4) = points(i,4) + points(i,6)*timeStep;
            points(i,5) = points(i,5) + points(i,7)*timeStep;
        end
    end
end
function p = accelPoints(timeStep)
    %changes points velocities via applying newton's second law (a=f/m)
    %over a small time step
    global points;
    p=0;
    for i = 1:length(points(:,1))
        points(i,6) = points(i,6) + points(i,8)*timeStep/points(i,10);
        points(i,7) = points(i,7) + points(i,9)*timeStep/points(i,10)-9.81;
    end
end
function dVector = axialDirVect(ptIndexes)
    %Finds the unit vector that points from point 1 to point 2

    %Finds the distance between 2 points
    dVector = distXY(ptIndexes);
    
    % Divide by magnitude to turn it into a unit vector
    magnitude = (dVector(1)^2 + dVector(2)^2)^0.5;
    dVector(1) = dVector(1) / magnitude;
    dVector(2) = dVector(2) / magnitude;
end
function dxdy = distXY(ptIndexes)
    %finds the xy vector to get to point 2's position from point 1
    global points;
    dxdy = zeros(1,2);
    
    % The formatting here is relevant as the vector must point from 1 to
    % 2 so tension (positive force) forces point1 towards equilibrium
    dxdy(1) = points(ptIndexes(2),4)-points(ptIndexes(1),4);
    dxdy(2) = points(ptIndexes(2),5)-points(ptIndexes(1),5);
end
function clength = currentLength(ptIndexes)
    %finds the current magnitude of the distance between 2 points using
    %their indexes
    %basic magnitude code
    distances = distXY(ptIndexes);
    clength = (distances(1)^2 + distances(2)^2)^0.5;
end
function ptIndexes = findPtIndexes(iL)
    %finds the indexes of the points a line is connected to
    global points;
    global lines;
    ptIDs = lines(iL,3:4);
    ptIndexes= [find(points(:,1)==ptIDs(1)), find(points(:,1)==ptIDs(2))];
end
function ptIndexes = applyForces(iL)
    %Calls all the functions to apply forces to points
    ptIndexes = findPtIndexes(iL);
    
    %Call axial function to apply forces to points
    applyAxial(iL, ptIndexes);
end
function force = applyAxial(iL, ptIndexes)
    %applies an axial force to the connected points according to the
    %formula D=PL/(AE), rearranged to P = D(AE)/L
    global lines;

    %The original length is subtracted such that an increase in length is
    %reflected with a positive value for deflection
    deflection =  currentLength(ptIndexes) - lines(iL,8);
    
    %Calculate forces using the previously mentioned equations
    %Names of forces:   Area       Young'sMod   originalLength
    force = deflection*lines(iL,7)*lines(iL,9)/lines(iL,8);
    
    %Find the unit vector for the points
    unitVector = axialDirVect(ptIndexes);
    
    %Apply those forces using that unit vector (the second point gets a
    %negative value since it's at the opposite end of the beam)
    applyForce(force, unitVector, ptIndexes(1));
    applyForce(force*(-1), unitVector, ptIndexes(2));
end
function p = applyForce(force, unitVector, pointID)
    %Applies forces to a point based on a force and a unit vector
    global points;
    p=0;
    
    %unit vector determines relative magnitudes of the forces
    points(pointID,8) = points(pointID,8) + force*unitVector(1);
    points(pointID,9) = points(pointID,9) + force*unitVector(2);
end