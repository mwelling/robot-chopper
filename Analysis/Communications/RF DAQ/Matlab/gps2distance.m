%This Function calculates the distance between two points on the Earth's
%Surface
%Inputs:  LAT1,LAT2,LONG1,LONG2
%Outputs:  dist
%Author:  DPG 18-Oct-08
function [dist] = gps2distance(LAT1,LAT2,LONG1,LONG2)
LAT1 = LAT1*pi/180;
LAT2 = LAT2*pi/180;
LONG1 = LONG1*pi/180;
LONG2 = LONG2*pi/180;
dLAT = LAT2-LAT1;  dLON = LONG2 - LONG1;
a = (sin(dLAT/2))^2 + cos(LAT1) * cos(LAT2) * (sin(dLON/2))^2;
c = 2 * atan2(a^.5,(1-a).^.5);
dist = 6371000 * 3.28 * c;