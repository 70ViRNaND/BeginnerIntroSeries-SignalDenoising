%% - RECTANGULAR WINDOW

fs = 2000; %sampling frequency to generate time domain signal
ts = 1/fs;%1/fs; %increment of time
tmeasure = 1; %measured of time
L = tmeasure/ts; %length of signal vector
time = 0 : ts : tmeasure-ts; %time vector

% Signal
y = 20*sin(2.*pi.*4.*time) + 8*cos(2.*pi.*8.*time)+ sin(2.*pi.*16.*time);

%Window
cut_off_freq = 9;% Tunable as desired 
cut_off_ratio = cut_off_freq/(fs/2); %fs/2 is called Nyquist Frequency
w =  100*cut_off_ratio*sinc(cut_off_ratio*(-(L/2 - 1):L/2)); %exact definition of rectangular window
filtered = 10*conv(y,w)/L;  %linear convolution cuz it's real vector
subset_filtered = filtered(920:2919); %make sure length of filtered signal equals to length of original signal

% Plot 1
figure(1)

subplot(3,1,1)
plot(time,y) %plot original signal
xlabel('time')
ylabel('amplitude')
title('sin(2\pi4t) + cos(2\pi8t)+ sin(2\pi16t)')

subplot(3,1,2)
plot(w) %plot rectangular window
xlabel('time sample')
ylabel('amplitude')
title('rectangular window - cutoff 9 Hz')

subplot(3,1,3)
plot(time,subset_filtered) %plot filtered signal
xlabel('time')
ylabel('amplitude')

suptitle('Signal Denoising by Convolution in Time Domain')

%compute fft for original signal
Fs = fs;
L = length(y);
signal_fft = fft(y,L)/L;
amplitude_signal = 2*abs(signal_fft(1:(L/2+1)));
frequency_signal = Fs/2*linspace(0,1,L/2+1);

% compute fft for rectangular window
Fs = fs;
L = length(y);
window_fft = fft(subset_filtered,L)/L;
amplitude_window = 2*abs(window_fft(1:(L/2+1)));
frequency_window = Fs/2*linspace(0,1,L/2+1);

% compute Hadamard multiplication (element-wise product) between fft's
filtered_fft = signal_fft.*window_fft;
amplitude_filtered_fft =  4*abs(filtered_fft(1:(L/2+1)));
frequency_filtered_fft = Fs/2*linspace(0,1,L/2+1);

%Plot 2
figure(2)

subplot (3,1,1)
plot(frequency_signal,amplitude_signal)

subplot (3,1,2)
stem(frequency_window,amplitude_window)

subplot (3,1,3)
plot(frequency_filtered_fft,amplitude_filtered_fft)

suptitle('Signal Denoising by Element-Wise Product in Frequency Domain')

%% - GAUSSIAN WINDOW  

fs = 2000; %sampling frequency to generate time domain signal
ts = 1/fs;%1/fs; %increment of time
tmeasure = 1; %measured of time
L = tmeasure/ts; %length of signal vector
time = 0 : ts : tmeasure-ts; %time vector

% Signal
y = 20*sin(2.*pi.*4.*time) + 8*cos(2.*pi.*8.*time)+ sin(2.*pi.*16.*time);

%Window
alpha = 10;
order = 2000;
w =  gausswin(order+1,alpha)'; %matlab definition of gaussian window
filtered = conv(y,w)/L;  %linear convolution cuz it's real vector 
subset_filtered = filtered(1000:2999); %make sure length of filtered signal equals to length of original signal

% Plot 1
figure(1)

subplot(3,1,1)
plot(time,y) %plot original signal
xlabel('time')
ylabel('amplitude')
title('sin(2\pi4t) + cos(2\pi8t)+ sin(2\pi16t)')

subplot(3,1,2)
plot(w) %plot rectangular window
xlabel('time sample')
ylabel('amplitude')
title('gaussian window - alpha 10')

subplot(3,1,3)
plot(time,10*subset_filtered) %plot filtered signal
xlabel('time')
ylabel('amplitude')

suptitle('Signal Denoising by Convolution in Time Domain')

%compute fft for original signal
Fs = fs;
L = length(y);
signal_fft = fft(y,L)/L;
amplitude_signal = 2*abs(signal_fft(1:(L/2+1)));
frequency_signal = Fs/2*linspace(0,1,L/2+1);

% compute fft for rectangular window
Fs = fs;
L = length(y);
window_fft = fft(subset_filtered,L)/L;
amplitude_window = 2*abs(window_fft(1:(L/2+1)));
frequency_window = Fs/2*linspace(0,1,L/2+1);

% compute Hadamard multiplication (element-wise product) between fft's
filtered_fft = signal_fft.*window_fft;
amplitude_filtered_fft =  4*abs(filtered_fft(1:(L/2+1)));
frequency_filtered_fft = Fs/2*linspace(0,1,L/2+1);

%Plot 2
figure(2)

subplot (3,1,1)
plot(frequency_signal,amplitude_signal)

subplot (3,1,2)
stem(frequency_window,amplitude_window)

subplot (3,1,3)
plot(frequency_filtered_fft,amplitude_filtered_fft)

suptitle('Signal Denoising by Element-Wise Product in Frequency Domain')
