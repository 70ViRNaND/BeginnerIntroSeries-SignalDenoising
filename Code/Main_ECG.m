%% Main ECG Filtering Procedure
[ecg,txt,raw] = xlsread('214m.csv');

ecg_ML2 = ecg(:,1);
ecg_V1 = ecg(:,2);
clear ecg txt raw

fs = 360;
ts = 1/fs;
dt = 0:ts:10-ts;
y = ecg_V1;

nfft = length(y);
nfft2 = 2.^nextpow2(nfft); 

fy = (fftshift(fft(y,nfft2)));
fyfshift = (-nfft2/2:nfft2/2-1)*(fs/nfft2);
fypowershift = abs(fy).^2/1;

order = length(y);
cut_off_freq = 3/(fs/2);
alpha = fs/(2*cut_off_freq);
rect = cut_off_freq*sinc(cut_off_freq*(-(order/2):(order/2)));
%windowed =  rect ; % Rectangular Window
windowed =  gausswin(order+1,50)'; % Gaussian Window (second argument is tunable)
%windowed =   rect.*gausswin(order+1,alpha)'; % Smooth Rectangular Window (Smooth means Gibbs Phenomenon Eliminated)

h =windowed;

fh = (fftshift(fft(h,nfft2)));
fhfshift = (-nfft2/2:nfft2/2-1)*(fs/nfft2);
fhpowershift = abs(fh).^2/1; %Update Terbaru

mul = fypowershift'.*fhpowershift; %frequency domain operation
convo = conv(y,h); %time domain operation 

fconvo = (fftshift(fft(convo,length(convo))));
fconvofshift = (-length(convo)/2:length(convo)/2-1)*(fs/length(convo));
fconvopowershift = abs(fconvo).^2/1;

invfy = (ifft(ifftshift(fy,length(fyfshift))));
invfh = (ifft(ifftshift(fh,length(fhfshift))));
invconvo = (ifft(ifftshift(fconvo,length(fconvofshift))));

subplot(3,3,1)
plot(dt,y)
title('Time Domain Pre-Filtered ECG')
xlabel('Time Sample')
ylabel('Amplitude')

subplot(3,3,2)
plot(fyfshift,fypowershift)
title('Frequency Domain Pre-Filtered ECG')
xlabel('Frequency')
ylabel('Magnitude')

 subplot(3,3,3)
 plot(dt,invfy(1:length(dt)),'red');
title('IDFT of Frequency Domain Pre-Filtered ECG')
xlabel('Time Sample')
ylabel('Amplitude')

subplot(3,3,4)
 plot(h)
 title('Time Domain Filter/Window') 
 xlabel('Time Sample')
 ylabel('Response')
 
subplot(3,3,5)
plot(fhfshift,fhpowershift)
title('Frequency Domain Filter/Window')
xlabel('Frequency')
ylabel('Response')

subplot(3,3,6)
plot((1:nfft2),abs(invfh(1:nfft2)),'red');
title('IDFT of Frequency Domain Filter/Window')
xlabel('Time Sample')
ylabel('Response')

subplot(3,3,7)
plot((convo))
title('Time Domain Post-Filtered ECG') 
xlabel('Time Sample')
ylabel('Amplitude')
    
subplot(3,3,8)
plot(fconvofshift,fconvopowershift)
title('Frequency Domain Post-Filtered ECG') 
xlabel('Frequency')
ylabel('Magnitude')

subplot(3,3,9)
plot(-invconvo,'red')
title('IDFT of Frequency Domain Post-Filtered ECG') 
xlabel('Time Sample')
ylabel('Amplitude')
