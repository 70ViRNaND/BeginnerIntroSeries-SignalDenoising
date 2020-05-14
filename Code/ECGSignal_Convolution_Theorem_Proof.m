%%  - RECTANGULAR WINDOW

time = 0:(1/5000):1-(1/5000);
% Signal
 [ECG,txtnoise,rawnoise] = xlsread('Rec2_Day19_Noisy.csv');

x = ECG';
clear ECGclean txtnoise rawnoise

L  = 1/(time(2)-time(1));
fs = L;

cut_off_freq = 480;% Tunable as desired 
cut_off_ratio = cut_off_freq/(fs/2); %fs/2 is called Nyquist Frequency

y = cut_off_ratio*sinc(cut_off_ratio*(-(L/2-1):L/2));

X = fft([x zeros(1,length(x)-1)]);
Y = fft([y zeros(1,length(y)-1)]);

 c1 = conv(x,y,'full');
 c2 = ifft(X.*Y);
 
 rmse1 = sqrt(sum((c1(2501:7500)-c2(2501:7500)).^2))

 figure(1)
 plot(c1(2501:7500))
 
 figure(2)
 plot(c2(2501:7500)) 
 
%%  - GAUSSIAN WINDOW

time = 0:(1/5000):1-(1/5000);
% Signal
 [ECG,txtnoise,rawnoise] = xlsread('Rec2_Day19_Noisy.csv');

x = ECG';
clear ECGclean txtnoise rawnoise

L  = 1/(time(2)-time(1));
fs = L;

%  Change below lines to Gaussian Window!!!
alpha = 500;
order = length(x)-1;
y  =  gausswin(order+1,alpha)'; %matlab definition of gaussian window

X = fft([x zeros(1,length(x)-1)]);
Y = fft([y zeros(1,length(y)-1)]);

 c1 = conv(x,y,'full');
 c2 = ifft(X.*Y);
 
 rmse2 = sqrt(sum((c1(2501:7500)-c2(2501:7500)).^2))

 figure(1)
 plot(c1(2501:7500))
 
 figure(2)
 plot(c2(2501:7500))