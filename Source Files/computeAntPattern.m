function  antGaindB = computeAntPattern(theta,phi)

%TR38901 Table 7.3.1 Radiation power pattern of a single antenna element
AthetadB = -min(12*((theta-90)/65).^2,30);
AphidB = -min(12*(phi/65)^2,30);

antGaindB = 8 - min(-(AphidB + AthetadB),30);

end

