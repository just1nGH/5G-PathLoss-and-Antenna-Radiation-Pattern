function angle = toAzimathAngle(angle)
% regulate angle value between [-180,180]

% ensure it is in [-360,360]
angle = mod(angle+180,360);

% ensure it is in [0,360]
if angle < 0
    angle= angle + 360;
end

angle = angle -180;

end

