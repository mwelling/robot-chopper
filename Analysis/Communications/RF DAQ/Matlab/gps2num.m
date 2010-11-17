function[value] = gps2num(str)
%GPS2NUM Summary of this function goes here
%   Detailed explanation goes here
value = 0;
for i = 1:length(str)
if strcmp(str(i),'.')
mark = i;
break;
else
mark = 0;
end
end
MIN = [str((mark-2):(mark+4))];
DEG = [str((1): (mark-3))];
MIN = str2num(MIN)/60;
DEG = str2num(DEG);
value = MIN + DEG;