clear all
close all
file = 'Results\23-May-2010results9600H.txt';
fid = fopen(file, 'r');
nlines = 0;
while (fgets(fid) ~= -1),
  nlines = nlines+1;
end
fclose(fid);
fid = fopen(file, 'r');
gpstime = 0;
gpslatitude = 0;
gpslongitude = 0;
rssi = 0;
latitude = 0;
longitude = 0;
i = 0;
data(1,:) = [0 0 0];
latvector(nlines) = 0;
lonvector(nlines) = 0;
timevector(nlines) = 0;
gpstimevector(nlines) = 0;
rssivector = 0;

notbreak = 1;
while (i < nlines)
    
        tline = fgetl(fid);
        if ~ischar(tline),   break,   end
        %disp(tline)
        
        [token, remain] = strtok(tline,',');
        if (strcmp('$RSSI',token))
          [gpstime, remain] = strtok(remain,',');
          [gpslatitude, remain] = strtok(remain,',');
          [gpslongitude, remain] = strtok(remain,',');
          [strrssi,remain] = strtok(remain,'*');
          strrssi(length(strrssi)) = '.'; %Remove '*' Character at end.
        end
        latitude = gps2num(gpslatitude);
        longitude = gps2num(gpslongitude);

        
  
        i = i +1;
        if i == 1
            startlat = latitude;
            startlon = longitude;
        end


        latvector(i) = latitude;


        lonvector(i) = longitude;
        gpstimevector(i) = gps2time(gpstime)-5;
        timevector(i) = str2num(remain(2:length(remain)));


        str = [num2str(i),'/',num2str(nlines)];
        disp(str)


        
        

    
    
    notbreak = 1;



        %latarray(:,i) = latitude;

    
end

fclose(fid);
for i = 1:length(timevector)
    delaytimevector(i) = timevector(i) - gpstimevector(i);
end
for i = 1:length(latvector)
    distancevector(i) = gps2distance(startlat,latvector(i),startlon,lonvector(i));
end
Test5(delaytimevector, distancevector)
