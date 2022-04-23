% Author Juquan Mao
% 2022 March
addpath('./Source Files/');


% set network size 
numOfRings = 1; % 7 sites
ISD = 200; % inter site distance

% obtain site positions
nodeBPos = getNodeBsPos(numOfRings,[0;0],ISD);
numOfSites = size(nodeBPos,2);

% specify region of interest
ROI.width = (2*numOfRings+1)*ISD + ISD/3;
ROI.height = ROI.width ;%(3*numOfRings+2)*ISD/sqrt(3);

ROI.leftbottom = [-ROI.width/2;-ROI.height/2];
ROI.topRight = [ROI.width/2 ;ROI.height/2];
ROI.pos = [ROI.leftbottom;ROI.topRight];

% sectors of each sites and the azimath angels
numOfSecs = 3;
Azimaths = [60,180,300];


% map resolutions 
mapResol = 3;
numOfPixelsX = floor(ROI.width/mapResol);
numOfPixelsY = floor(ROI.height/mapResol);

% initiate path loss and antenna pattern
pathLossMap = zeros(numOfSites,numOfSecs,numOfPixelsX,numOfPixelsY);
antPattern = zeros(numOfSites,numOfSecs,numOfPixelsX,numOfPixelsY);

utHeight = 1.5;
AntHeight = 35;
minCoupLoss = 70;


for iSite = 1: numOfSites
    for iSec = 1: numOfSecs
        for iPixelX = 1:numOfPixelsX
            pixelXpos = iPixelX*mapResol ;
            for iPixelY = 1: numOfPixelsY
                pixelYpos = iPixelY *mapResol;
                pixelPos = [pixelXpos;pixelYpos] + ROI.leftbottom ;
                    
                    sitePos= nodeBPos(:,iSite); 
                    dist2D = vecnorm(sitePos- pixelPos,2,1);
                    
                    angleH = rad2deg(angle(complex(pixelPos(1)-sitePos(1),pixelPos(2)-sitePos(2))));
                    angleV = rad2deg(atan(dist2D/(AntHeight-utHeight)));
                    
                    theta = angleV; 
                    phi = toAzimathAngle(angleH-toAzimathAngle(Azimaths(iSec)));
                    
                    % compute antenna pattern
                    antPattern(iSite,iSec,iPixelX,iPixelY) = computeAntPattern(0,phi);
                    
                    % compute path loss
                    pathLossMap(iSite,iSec,iPixelX,iPixelY) = -max(20*log10(4*pi/299792458*sqrt(dist2D.^2+(AntHeight-utHeight).^2)*20e9),0.00000)...
                                                                + antPattern(iSite,iSec,iPixelX,iPixelY);
                                                            
                    pathLossMap(iSite,iSec,iPixelX,iPixelY) = min( pathLossMap(iSite,iSec,iPixelX,iPixelY),-minCoupLoss);
 
            end
        end
        
    end
end

% select the max power for  each pixel location
pathLossMap = squeeze(max(pathLossMap,[],1));
pathLossMap = squeeze(max(pathLossMap,[],1));

figure('position',[100,100,500,500*ROI.height/ROI.width]);
C = pathLossMap;
imagesc('XData',(1:numOfPixelsX)*mapResol+ROI.leftbottom(1),'YData',(1:numOfPixelsX)*mapResol+ROI.leftbottom(2),'CData',C.');
hold on;
axis(1.1*[ROI.pos(1),ROI.pos(3),ROI.pos(2),ROI.pos(4)]);

drawTriSec(numOfRings,[0;0],ISD);
