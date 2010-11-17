fid = fopen('TestData.txt', 'r');
accelcounter = 0;
gyrocounter = 0;
linecounter = 0;
gyroroll = 0;
gyropitch = 0;
gyroyaw = 0;
accelx = 0;
accely = 0;
accelz = 0;


sentype = 0;
while 1
    tline = fgetl(fid);
    if ~ischar(tline),   break,   end
    %disp(tline)
    linecounter = linecounter + 1;
    [token, remain] = strtok(tline,',');
    [sentype, remain] = strtok(remain,',');

    if (strcmp('ACC', sentype)) || (strcmp('GYR', sentype)) 
        [val1, remain] = strtok(remain,',');
        [val2, remain] = strtok(remain,',');
        [val3, remain] = strtok(remain,',');
        val3(length(val3)) = '.'; %Remove final * character.
    end

    if strmatch('GYR', sentype)
        gyrocounter = gyrocounter + 1;
        gyroroll(gyrocounter) = str2num(val1);
        gyropitch(gyrocounter) = str2num(val2);
        gyroyaw(gyrocounter) = str2num(val3);

    elseif strmatch('ACC', sentype)
        accelcounter = accelcounter + 1;
        accelx(accelcounter) = str2num(val1);
        accely(accelcounter) = str2num(val2);
        accelz(accelcounter) = str2num(val3);

    end
        
end
fclose(fid);
