function vertices = getHexagonVertices(center,radius,angle)
% This fucntion computes the postioon of a hexagon given the center
% positon, redius and angle of a vetex;
% @inputs
% - center: a vector of length 2.  represents x-coordinate and
% y-coordinate respectively of the Hexagon center.
% - radius
% - angle: a value between 0: 2*pi (the angle between a vetex and x axis)
% @outputs
% - verteices:  a matrix of 2-by-7; rows represent x or y coordinates and
% columns represents vertices

angles = (0:1:6)*pi/3 + angle;

vertices =  zeros(2,7);
% x coordinates
vertices(1,:) = center(1) + radius*cos(angles);
% y coirdinated
vertices(2,:) = center(2) + radius*sin(angles);

end

