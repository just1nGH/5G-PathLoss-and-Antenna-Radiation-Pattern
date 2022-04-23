function nodeBPos = getNodeBsPos(numOfRings,centerNodeBPos,ISD)
%%------------------------------------------------------------------------
% This fucntion cauclate nodeB loctions in a hexgonal gris given the center
% nodeB postion and number of rings and inter-site distance
% Author Dr J Mao juquan.justin.mao@gmail.com
%-------------------------------------------------------------------------
% number of enodeBs
numOfNodeBs = sum(6*(1:numOfRings))+1;
radius = ISD/sqrt(3); % Hexgonal radius

nodeBPos = zeros(2,numOfNodeBs);

nodebIdx = 1;
% loop each eNodeB from left bottom corner, column first.
for rowIdx =  -numOfRings:numOfRings % for each row
    % get the number of eNodeBs on the current row
    numOfCols =   2*numOfRings +1 - abs(rowIdx);
    % compute the y-coordinate for the row
    
    y = rowIdx * 3/2 * radius ;
    
    for colIdx = 0: numOfCols -1 % for each column
        
        % compute x-coordinate of the current eNodeb specified by (rowIdx, colIdx)
        x = - (numOfCols-1)*ISD/2 + colIdx*ISD;
        
        % reference center based on pi/6 angle hexagon layout
        curNodeBPos = centerNodeBPos + [x;y];
  
        % rotate Center to the angles of interest
        nodeBPos(:,nodebIdx) = curNodeBPos;
        nodebIdx = nodebIdx+1;
    end
 
end



end

