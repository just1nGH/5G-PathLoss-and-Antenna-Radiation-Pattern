function [] = drawTriSec(numOfRings,centerNodeBPos,ISD)


% This script plot the layout in a hexagonal grid for tri-sector NodeBs,
% given number of rings in the grid, inter-site-distance, and center nodeB
% position

drawSite =  true; % control if to draw NodeB site edge

radius = ISD/sqrt(3); % Hexgonal radius

% number of enodeB
numOfNodeBs = sum(6*(1:numOfRings))+1;

%Initiate NodeB locations
nodeBPos = getNodeBsPos(numOfRings,centerNodeBPos,ISD);

sec2NbAngles = [60,180,300]/360.0 *2*pi;
% plot base station symbols
if drawSite
    for j = 1: numOfNodeBs
            curNodeBPos =  nodeBPos(:,j);
            %viscircles(curNodeBPos.',radius/3,'Color','w','LineWidth',0.5);
            for i =  1:3  
                curAngle = sec2NbAngles(i);
                x = curNodeBPos(1) + [0,cos(curAngle-pi/6),cos(curAngle+pi/6),0]*radius/8;
                y = curNodeBPos(2) + [0,sin(curAngle-pi/6),sin(curAngle+pi/6),0]*radius/8;

                fill(x,y,'k','LineStyle','none');
            end
       
    end

end



end

