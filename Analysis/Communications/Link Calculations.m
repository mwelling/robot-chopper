C = 9600;  %C: Required bps of Channel
B = 5e6;   %B: Channel Bandwidth
Sdbm = -102;  %Sdbm:  Reciever Power, in dbm
%C = B*log2(1+SNR), Shannon's Limit
SNRw = 2^(C/B)-1
SNRdb = 10*log(SNRw)
%SNRdb= (.332 * B )/ C %For S/N >> 1, SNR (db)
%SNRw = 10^(SNRdb/10) %For S/N >> 1, SNR (w)

%SNRw = (C/(1.44*B)) %For SNR << 1, SNR (w)