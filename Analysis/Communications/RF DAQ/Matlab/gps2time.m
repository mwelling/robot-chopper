function[value] = gps2time(str)
%GPS2TIME Summary of this function goes here
%   Detailed explanation goes here
value = 0;


HR = str(1:2);
MIN = str(3:4);
SEC = str(5:length(str));

HR = str2num(HR);
MIN = str2num(MIN)/60;
SEC = str2num(SEC)/3600;

value = HR + MIN + SEC;
