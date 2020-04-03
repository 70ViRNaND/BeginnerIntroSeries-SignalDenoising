%% Main Sinusoid Filtering Procedure

%fs =30;
 % fs  =70;
 %fs =150;
%fs =200;
fs = 360; 
ts = 1/fs; 
dt = 0 : ts : 1 - ts; 

f1 = 40; 
f2 = 80; 
f3 = 160; 

y = 1*sin(2*pi*f1*dt) + 1*cos(2*pi*f2*dt) + 1*sin(2*pi*f3*dt) ; 

nfft = length(y);
nfft2 = 2.^nextpow2(nfft); 

fy = (fftshift(fft(y,nfft2)));
fyfshift = (-nfft2/2:nfft2/2-1)*(fs/nfft2);
fypowershift = abs(fy).^2/1; %nfft2

order = length(y);
cut_off_freq = 150/(fs/2);
alpha = fs/(2*cut_off_freq);
rect = cut_off_freq*sinc(cut_off_freq*(-(order/2):(order/2)));
windowed =  rect ; % Rectangular Window 
%windowed =  gausswin(order+1,alpha)'; % Gaussian Window ('alpha' arguments is tunable)
%windowed =   rect.*gausswin(order+1,alpha/30)'; % Smooth Rectangular Window (Smooth mean Gibbs Phenomenon Eliminated)

h =windowed;

fh = (fftshift(fft(h,nfft2)));
fhfshift = (-nfft2/2:nfft2/2-1)*(fs/nfft2);
fhpowershift = abs(fh).^2/1; 

mul = fypowershift.*fhpowershift; %frequency domain operation
convo = conv(y,h); %time domain operation

fconvo = (fftshift(fft(convo,length(convo))));
fconvofshift = (-length(convo)/2:length(convo)/2-1)*(fs/length(convo));
fconvopowershift = abs(fconvo).^2/1;

invfy = (ifft(ifftshift(fy,length(fyfshift))));
invfh = (ifft(ifftshift(fh,length(fhfshift))));
invconvo = (ifft(ifftshift(fconvo,length(fconvofshift))));

subplot(3,3,1)
plot(dt,y)
hold on 
plot(dt,invfy(1:length(dt)),'red')
title('Time Domain Pre-Filtered Sinusoid')
xlabel('Time Sample')
ylabel('Amplitude')
legend('Original Signal','Sampled Signal')

subplot(3,3,2)
plot(fyfshift,fypowershift)
title('Frequency Domain Pre-Filtered Sinusoid')
xlabel('Frequency')
ylabel('Magnitude')

 subplot(3,3,3)
 plot((1:length(dt)),invfy(1:length(dt)),'red');
title('IDFT of Frequency Domain Pre-Filtered Sinusoid')
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
title('IDFT of Frequency Domain Filter/Window'')
xlabel('Time Sample')
ylabel('Response')

subplot(3,3,7)
plot((convo))
title('Time Domain Post-Filtered Sinusoid') 
xlabel('Time Sample')
ylabel('Amplitude')
    
subplot(3,3,8)
plot(fconvofshift,fconvopowershift)
title('Frequency Domain Post-Filtered Sinusoid') 
xlabel('Frequency')
ylabel('Magnitude')

subplot(3,3,9)
plot(-invconvo,'red')
title('IDFT of Frequency Domain Post-Filtered Sinusoid') 
xlabel('Time Sample')
ylabel('Amplitude')
