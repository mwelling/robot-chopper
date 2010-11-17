close all
fid = fopen('testdata.txt', 'r');
index = 0;
ax = 0;
ay = 0;
az = 0;
A = 0;
i = 0;
Fs = 1000;  %From Sample Data Specifications
tempsum = 0;


while 1
    if i > 800, break, end
    
    i = i + 1;
    tline = fgetl(fid);
    if ~ischar(tline),   break,   end
    %disp(tline)
    [cur, remain] = strtok(tline);
    index(i) = str2num(cur);
    [cur, remain] = strtok(remain);
    az(i) = (str2num(cur)*6)/(2^16)-3;
    [cur, remain] = strtok(remain);
    ay(i) = (str2num(cur)*6)/(2^16)-3;
    [cur, remain] = strtok(remain);
    ax(i) = (str2num(cur)*6)/(2^16)-3;
    A(i) = sqrt(ax(i)^2+ay(i)^2+az(i))^2;
      
end
fclose(fid);

L = length(index);

%Low Pass Filter Algorithm

n = 4;  %4th Order filter
fcacc = 20; %Cutoff at 20 Hz
wacc = fcacc/Fs;
[b,a] = butter(n,(wacc/2),'low')

% a1 = .01;
% axfilt(2) = 0;
% for k = 2:L
%     axfilt(k) = a1*ax(k)+(1-a1)*ax(k-1);
% end
L = length(ax);
axfilt = zeros(1,L);
vxfilt = zeros(1,L);
sxfilt = zeros(1,L);
SXfilt = zeros(1,L);

tempint = 0;
for k = (n+1):L
    tempint = 0;


    %Input Bias Calculation
    tempsum =  b(1)*ax(k) + b(2)*ax(k-1)+b(3)*ax(k-2)+b(4)*ax(k-3) + b(5)*ax(k-4);
    %Feedback Calculation
    tempsum =  tempsum - (a(2)*axfilt(k-1) + a(3)*axfilt(k-2) + a(4)*axfilt(k-3) + a(5) *axfilt(k-4));
    axfilt(k) = tempsum;
    vxfilt(k) = axfilt(k) * 1/Fs;
    sxfilt(k) = (vxfilt(k)*1/Fs) + .5 * (axfilt(k) * (1/Fs)^2); 
    SXfilt(k) = sxfilt(k) + SXfilt(k-1);

end

NFFT = 2^nextpow2(L);
Y = fft(ax,NFFT)/L;
Yfilt = fft(axfilt,NFFT)/L;
f = Fs/2*linspace(0,1,NFFT/2);


% subplot(3,1,1)
% hold on
% plot(index,ax,'r')
% title('Original Test Data:  X-Axis')

% title('Original Test Data: Y-Axis')
% plot(index,ay,'b')
% title('Original Test Data: Y-Axis')
% subplot(3,1,3)
% plot(index,az,'g')


% 
% subplot(3,1,2)
% hold on
% %plot(index,ax,'b')
% plot(index,axfilt,'r')
% title('X-Axis Filtered')
% xlabel('Frequency (Hz)')
% ylabel('|Y(f)|')

figure(1)
subplot(2,1,1)
loglog(f,2*abs(Y(1:NFFT/2)),'b')
title('Single-Sided Amplitude Spectrum of X-Axis Accelerometer, Before Low Pass Filter')
xlabel('Frequency (Hz)')
ylabel('|Y(f)|')
subplot(2,1,2)
loglog(f,2*abs(Yfilt(1:NFFT/2)),'r')
title('Single-Sided Amplitude Spectrum of X-Axis Accelerometer, After Low Pass Filter')
xlabel('Frequency (Hz)')
ylabel('|Y(f)|')