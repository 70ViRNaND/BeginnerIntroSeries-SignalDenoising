%%  - RECTANGULAR WINDOW

time = linspace(0,1,200);
x = sin(2.*pi.*4.*time) + cos(2.*pi.*8.*time)+ sin(2.*pi.*16.*time);

L  = 1/(time(2)-time(1));
fs = L;

cut_off_freq = 9;% Tunable as desired 
cut_off_ratio = cut_off_freq/(fs/2); %fs/2 is called Nyquist Frequency

y = cut_off_ratio*sinc(cut_off_ratio*(-(L/2):L/2));

X = fft([x zeros(1,length(y)-1)]);
Y = fft([y zeros(1,length(x)-1)]);

 c1 = conv(x,y,'full');
 c2 = ifft(X.*Y);
 
 rmse1 = sqrt(sum((c1(100:299)-c2(100:299)).^2))

 figure(1)
 plot(c1(100:299))
 
 figure(2)
 plot(c2(100:299)) 
 
%%  - GAUSSIAN WINDOW

time = linspace(0,1,200);
x = sin(2.*pi.*4.*time) + cos(2.*pi.*8.*time)+ sin(2.*pi.*16.*time);

L  = 1/(time(2)-time(1));
fs = L;

%  Change below lines to Gaussian Window!!!
alpha = 10;
order = length(x)-1;
y  =  gausswin(order+1,alpha)'; %matlab definition of gaussian window

X = fft([x zeros(1,length(y)-1)]);
Y = fft([y zeros(1,length(x)-1)]);

 c1 = conv(x,y,'full');
 c2 = ifft(X.*Y);
 
 rmse2 = sqrt(sum((c1(100:299)-c2(100:299)).^2))

 figure(1)
 plot(c1(100:299))
 
 figure(2)
 plot(c2(100:299))
