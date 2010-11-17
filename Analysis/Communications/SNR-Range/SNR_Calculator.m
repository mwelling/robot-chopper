clear all;
close all;
clc;
%Ground Station Constants
GTxPower = 20 %dBm, xbee is 0, xbee pro is 18
GAntenntaGain = 2.1 %3 standard dipole
GFreq1 = 900 %In Megahurtz
GFreq2 = 2400 %In Megahurtz
%Vehicle Constants
ASensitivity = -100 %dBm
AAntennaGain = 2.1 %3 standard dipole

%Environment Constants
NoiseFloor = -92 %-100 is unusual, assume -92
LossExponent = 2 %2 is free space path loss
MinimumSNR = 5 %dB
MinimumSNRvector = 0;

startDistance = 1;  %Starting Distance, m
finalDistance = 16000;  %Final Distance, m
PathLossdB = 0;  %Friis Pathloss Equation
SignalStrength = 0;
SNR = 0;
maxdistance = 0;
i = 0;
figure(1)
subplot(2,1,1)
hold on
for i = 1:(finalDistance-startDistance)
    
    PathLossdB = (20*log10(GFreq1) + (10*LossExponent)*log10(i+startDistance))-28;
    SignalStrength = ((GTxPower+GAntenntaGain)+AAntennaGain)-PathLossdB;
    SNR(i) = -1*NoiseFloor + SignalStrength;
    MinimumSNRvector(i) = MinimumSNR;
    if ((SNR(i) < MinimumSNR) & (maxdistance == 0))
        maxdistance = i+startDistance;
        disp('Maximum Distance @ 900 MHz is (m):')
        disp(maxdistance)
        plot(maxdistance,SNR(i));
    end
        
end

x1 = plot(SNR,'b');
x2 = plot(MinimumSNRvector,'r');
xlabel({'Distance (m)'});
ylabel({'SNR'});
title({'SNR Model for XBee Pro @ 900 MHz'});
legend([x1,x2],'SNR Model','Minimum SNR');
SNR = 0;
maxdistance = 0;
MinimumSNRvector = 0;
hold off
subplot(2,1,2)
hold on
for i = 1:(finalDistance-startDistance)
    
    PathLossdB = (20*log10(GFreq2) + (10*LossExponent)*log10(i+startDistance))-28;
    SignalStrength = ((GTxPower+GAntenntaGain)+AAntennaGain)-PathLossdB;
    SNR(i) = -1*NoiseFloor + SignalStrength;
    MinimumSNRvector(i) = MinimumSNR;
    if ((SNR(i) < MinimumSNR) & (maxdistance == 0))
        maxdistance = i+startDistance;
        disp('Maximum Distance @ 2.4 GHz is (m):')
        disp(maxdistance)
        plot(maxdistance,SNR(i));
    end
        
end

x1 = plot(SNR,'b');
x2 = plot(MinimumSNRvector,'r');
xlabel({'Distance (m)'});
ylabel({'SNR'});
title({'SNR Model for XBee Pro @ 2.4 GHz'});
legend([x1,x2],'SNR Model','Minimum SNR');
hold off

