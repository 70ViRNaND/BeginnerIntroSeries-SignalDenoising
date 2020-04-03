%% Main Non-ECG Filtering Procedure

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
windowed =  rect ; % Jendela Persegi 
%windowed =  gausswin(order+1,alpha)'; % Jendela Gauss
%windowed =   rect.*gausswin(order+1,alpha/30)'; % Jendela Persegi yang diperhalus (eliminasi fenomena Gibbs)

h =windowed;

fh = (fftshift(fft(h,nfft2)));
fhfshift = (-nfft2/2:nfft2/2-1)*(fs/nfft2);
fhpowershift = abs(fh).^2/1; %Update Terbaru

mul = fypowershift.*fhpowershift;
convo = conv(y,h);

fconvo = (fftshift(fft(convo,length(convo))));
fconvofshift = (-length(convo)/2:length(convo)/2-1)*(fs/length(convo));
fconvopowershift = abs(fconvo).^2/1;%length(convo)

invfy = (ifft(ifftshift(fy,length(fyfshift))));
invfh = (ifft(ifftshift(fh,length(fhfshift))));
invconvo = (ifft(ifftshift(fconvo,length(fconvofshift))));

subplot(3,3,1)
plot(dt,y)
hold on 
%plot((1:length(dt)),invfy(1:length(dt)),'red');
plot(dt,invfy(1:length(dt)),'red')
title('Sinyal Domain Waktu Pra Filtrasi')
xlabel('Sampel Waktu')
ylabel('Amplitudo')
legend('original signal','sampled signal')

subplot(3,3,2)
plot(fyfshift,fypowershift)
title('Sinyal Domain Frekuensi Pra Filtrasi')
xlabel('Frekuensi')
ylabel('Magnitudo')

 subplot(3,3,3)
 plot((1:length(dt)),invfy(1:length(dt)),'red');
title('IDFT Sinyal Domain Frekuensi')
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
title('IDFT Simple-Bounded Gaussian Window Domain Frekuensi')
xlabel('Sampel Waktu')
ylabel('Respon')

subplot(3,3,7)
plot((convo))
title('Sinyal Domain Waktu Pasca Filtrasi') 
xlabel('Sampel Waktu')
ylabel('Amplitudo')
    
subplot(3,3,8)
plot(fconvofshift,fconvopowershift)
title('Sinyal Domain Frekuensi Pasca Filtrasi') 
xlabel('Sampel Waktu')
ylabel('Magnitudo')

subplot(3,3,9)
plot(-invconvo,'red')
title('IDFT Sinyal Domain Waktu Pasca Filtrasi') 
xlabel('Sampel Waktu')
ylabel('Amplitudo')