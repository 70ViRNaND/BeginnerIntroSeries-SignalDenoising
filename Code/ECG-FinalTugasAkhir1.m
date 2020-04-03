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
%windowed =  rect ; % Jendela Persegi 
windowed =  gausswin(order+1,50)'; % Jendela Gauss (ternyata alphanya tunable hehe)
%windowed =   rect.*gausswin(order+1,alpha)'; % Jendela Persegi yang diperhalus (eliminasi fenomena Gibbs)

h =windowed;

fh = (fftshift(fft(h,nfft2)));
fhfshift = (-nfft2/2:nfft2/2-1)*(fs/nfft2);
fhpowershift = abs(fh).^2/1; %Update Terbaru

mul = fypowershift'.*fhpowershift;
convo = conv(y,h);

fconvo = (fftshift(fft(convo,length(convo))));
fconvofshift = (-length(convo)/2:length(convo)/2-1)*(fs/length(convo));
fconvopowershift = abs(fconvo).^2/1;

invfy = (ifft(ifftshift(fy,length(fyfshift))));
invfh = (ifft(ifftshift(fh,length(fhfshift))));
invconvo = (ifft(ifftshift(fconvo,length(fconvofshift))));

subplot(3,3,1)
plot(dt,y)
%hold on
%plot((1:length(dt)),invfy(1:length(dt)),'red');
%plot(dt,invfy(1:length(dt)),'red')
title('ECG Domain Waktu Pra Filtrasi')
xlabel('Sampel Waktu')
ylabel('Amplitudo')
%legend('original signal','sampled signal')

subplot(3,3,2)
plot(fyfshift,fypowershift)
title('ECG Domain Frekuensi Pra Filtrasi')
xlabel('Frekuensi')
ylabel('Magnitudo')

 subplot(3,3,3)
 plot(dt,invfy(1:length(dt)),'red');
title('IDFT ECG Domain Frekuensi Pra Filtrasi')
xlabel('Sampel Waktu')
ylabel('Amplitudo')

subplot(3,3,4)
 plot(h)
 title('Filter Domain Waktu') 
 xlabel('Sampel Waktu')
 ylabel('Respon')
 
subplot(3,3,5)
plot(fhfshift,fhpowershift)
title('Filter Domain Frekuensi')
xlabel('Frekuensi')
ylabel('Respon')

subplot(3,3,6)
plot((1:nfft2),abs(invfh(1:nfft2)),'red');
title('IDFT Gaussian Filter Domain Frekuensi')
xlabel('Sampel Waktu')
ylabel('Respon')

subplot(3,3,7)
plot((convo))
title('ECG Domain Waktu Pasca Filtrasi') 
xlabel('Sampel Waktu')
ylabel('Amplitudo')
    
subplot(3,3,8)
plot(fconvofshift,fconvopowershift)
title('ECG Domain Frekuensi Pasca Filtrasi') 
xlabel('Sampel Waktu')
ylabel('Magnitudo')

subplot(3,3,9)
plot(-invconvo,'red')
title('IDFT ECG Domain Waktu Pasca Filtrasi') 
xlabel('Sampel Waktu')
ylabel('Amplitudo')
