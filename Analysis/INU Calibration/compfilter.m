close all

acquiredata
Fs = 20; %Assume Sampling Frequency is 20 Hz
resetsize = Fs;
i = 0;
j = 0;

g = 9.8; %m/s^2
%Initialize Gain Constants
kgroll = .5;
kgpitch = .5;
kgyaw = .5;
karoll = .5;
kapitch = .5;
kayaw = .5;


kax = .5;
kay = .5;
kaz = .5;



%Initialize Integral Constants
maxx = 10;
minx = -10;
maxy = 10;
miny = -10;
maxz = 10;
minz = -10;

%Accelerometer constants
acceloffset = 97; %1g
accelmaxres = 128;

%MATLAB Filter Calculation for Gyro
n = 4;  %4th Order filter
fcgyro = 4;  %Cutoff @ 4 Hz
wgyro = fcgyro/Fs;  %Normalize Cutoff Frequency
[b,a] = butter(n,(wgyro/2),'high');


%Gyro Filter Algorithm

L = length(gyroroll);
tempsum = 0;
gyrorollfilt =  zeros(1,L);
gyropitchfilt = zeros(1,L);
gyroyawfilt =   zeros(1,L);
for k = (n+1):L
    tempsum = 0;
    %Input Bias Calculation
    tempsum =  b(1)*gyroroll(k) + b(2)*gyroroll(k-1)+b(3)*gyroroll(k-2)+b(4)*gyroroll(k-3) + b(5)*gyroroll(k-4);
    %Feedback Calculation
    tempsum =  tempsum - (a(2)*gyrorollfilt(k-1) + a(3)*gyrorollfilt(k-2) + a(4)*gyrorollfilt(k-3) + a(5) *gyrorollfilt(k-4));
    gyrorollfilt(k) = tempsum;
end
for k = (n+1):L
    tempsum = 0;
    %Input Bias Calculation
    tempsum =  b(1)*gyropitch(k) + b(2)*gyropitch(k-1)+b(3)*gyropitch(k-2)+b(4)*gyropitch(k-3) + b(5)*gyropitch(k-4);
    %Feedback Calculation
    tempsum =  tempsum - (a(2)*gyropitchfilt(k-1) + a(3)*gyropitchfilt(k-2) + a(4)*gyropitchfilt(k-3) + a(5) *gyropitchfilt(k-4));
    gyrorollfilt(k) = tempsum;
end
for k = (n+1):L
    tempsum = 0;
    %Input Bias Calculation
    tempsum =  b(1)*gyroyaw(k) + b(2)*gyroyaw(k-1)+b(3)*gyroyaw(k-2)+b(4)*gyroyaw(k-3) + b(5)*gyroyaw(k-4);
    %Feedback Calculation
    tempsum =  tempsum - (a(2)*gyroyawfilt(k-1) + a(3)*gyroyawfilt(k-2) + a(4)*gyroyawfilt(k-3) + a(5) *gyroyawfilt(k-4));
    gyroyawfilt(k) = tempsum;
end


%Gyro Integral Calculation

gyrorollint = zeros(1,length(gyrorollfilt));
gyropitchint = zeros(1,length(gyropitchfilt));
gyroyawint = zeros(1,length(gyroyawfilt));
for i = 1:length(gyrorollfilt)
    gyrorollint(i) = integral(gyrorollfilt(i), gyrorollint(i), minx, maxx, 1/Fs);
    gyropitchint(i) = integral(gyropitchfilt(i), gyropitchint(i), miny, maxy, 1/Fs);
    gyroyawint(i) = integral(gyroyawfilt(i), gyroyawint(i), minz, maxz, 1/Fs);
   

end
gyrorollint = kgroll .* gyrorollint; %Scale
gyropitchint = kgpitch .* gyropitchint;
gyroyawing = kgyaw .* gyroyawint;


%MATLAB Filter Calculation for Accelerometer
n = 4;  %4th Order filter
fcacc = 10;  %Cutoff @ 10 Hz
wacc = fcacc/Fs;  %Normalize Cutoff Frequency
[b,a] = butter(n,wacc,'low'); 

accelxfilt = zeros(1,length(accelx));
accelyfilt = zeros(1,length(accely));
accelzfilt = zeros(1,length(accelz));

%Accelerometer Filter Algorithm.  Check this!

for i = n:length(accelx)
    accelxfilt(i) = b(1)*accelx(i) + (1-b(2))*accelx(i-1)+(2-b(3))*accelx(i-2)+(3-b(4))*accelx(i-3);
end
for i = n:length(accelx)
    accelyfilt(i) = b(1)*accely(i) + (1-b(2))*accely(i-1)+(2-b(3))*accely(i-2)+(3-b(4))*accely(i-3);
end
for i = n:length(accelx)
    accelzfilt(i) = b(1)*accelz(i) + (1-b(2))*accelz(i-1)+(2-b(3))*accelz(i-2)+(3-b(4))*accelz(i-3);
end
accelxfilt = kax * accelxfilt;
accelyfilt = kay * accelyfilt;
accelzfilt = kaz * accelzfilt;

%Trig on Accelerometer to convert to angle

accelroll = zeros(1,length(accelxfilt));%Scale
accelpitch = zeros(1,length(accelxfilt));
accelyaw = zeros(1,length(accelxfilt));

for i = 1:length(accelroll)
    accelroll(i) = atan((accelzfilt(i)-1)/accelxfilt(i));
end
for i = 1:length(accelpitch)
    accelpitch(i) = atan((accelzfilt(i)-1)/accelyfilt(i));
end
for i = 1:length(accelyaw)
    accelroll(i) = atan((accelyfilt(i))/accelxfilt(i));
end

%Accelerometer Integral calculations

accelrollint = zeros(1,length(accelroll));
accelpitchint = zeros(1,length(accelpitch));
accelyawint = zeros(1,length(accelyaw));
x = zeros(1,length(accelxfilt));
y = zeros(1,length(accelyfilt));
z = zeros(1,length(accelzfilt));
for i = 1:length(accelroll)
    accelrollint(i) = integral(accelroll(i), integral(accelroll(i),accelrollint(i),-1000,1000,1/Fs), 0, 360, 1/Fs);
end
for i = 1:length(accelroll)
    accelpitchint(i) = integral(accelpitch(i), integral(accelpitch(i),accelpitchint(i),-1000,1000,1/Fs), 0, 360, 1/Fs);
end
for i = 1:length(accelroll)
    accelyawint(i) = integral(accelyaw(i), integral(accelyaw(i),accelyawint(i),-1000,1000,1/Fs), 0, 360, 1/Fs);
end
for i = 1:length(x)
    x(i) = integral(accelxfilt(i), integral(accelxfilt(i),x(i),-1000,1000,1/Fs), -1000, 1000, 1/Fs);
end
for i = 1:length(y)
    y(i) = integral(accelyfilt(i), integral(accelyfilt(i),y(i),-1000,1000,1/Fs), -1000, 1000, 1/Fs);
end
for i = 1:length(z)
    z(i) = integral(accelzfilt(i), integral(accelzfilt(i),z(i),-1000,1000,1/Fs), -1000, 1000, 1/Fs);
end

accelrollint = karoll .* accelrollint;
accelpitchint = kapitch .* accelpitchint;
accelyawint = kayaw .* accelyawint;

pitch = zeros(1,length(accelpitchint));
yaw = zeros(1,length(accelyawint));
roll = zeros(1,length(accelrollint));

for i = 1:length(pitch)
    pitch(i) = gyropitchint(i) + accelpitchint(i);
end
for i = 1:length(roll)
    roll(i) = gyrorollint(i) + accelrollint(i);
end
for i = 1:length(yaw)
    yaw(i) = gyroyawint(i) + accelyawint(i);
end

%Final Outputs:
%Abosolute Position:  x,y,z
%Abosolute Angle:    pitch,yaw,roll


