
 [ECG,txtnoise,rawnoise] = xlsread('Rec2_Day19_Noisy.csv');
 

ecg_V1 = ECG;
clear ECGclean txtnoise rawnoise

fs = 360;

fs_samp_1 = 100;
fs_samp_2 = 200;
fs_samp_3 = 300;
fs_samp_4 = 360;

ts = 1/fs;

ts_samp_1 = 1/fs_samp_1;
ts_samp_2 = 1/fs_samp_2;
ts_samp_3 = 1/fs_samp_3;
ts_samp_4 = 1/fs_samp_4;

dt = 0 : ts : 10-ts;

dt_samp_1 = 0 : ts_samp_1 : 10-ts_samp_1;
dt_samp_2 = 0 : ts_samp_2 : 10-ts_samp_2;
dt_samp_3 = 0 : ts_samp_3 : 10-ts_samp_3;
dt_samp_4 = 0 : ts_samp_4 : 10-ts_samp_4;

y = ecg_V1(1: length(dt));

y_samp_1 = ecg_V1(1: length(dt_samp_1));
y_samp_2 = ecg_V1(1: length(dt_samp_2));
y_samp_3 = ecg_V1(1: length(dt_samp_3));
y_samp_4 = ecg_V1(1: length(dt_samp_4));

subplot(2,2,1)
plot(dt,y,'b','linewidth',1)
hold on
plot(dt_samp_1,y_samp_1,'r','linewidth',1)
title(['Sampling Frequency ' num2str(fs_samp_1) ' Hz'])
xlabel('Time')
ylabel('Amplitude')
legend('original signal','sampled signal')

subplot(2,2,2)
plot(dt,y,'b','linewidth',1)
hold on
plot(dt_samp_2,y_samp_2,'r','linewidth',1)
title(['Sampling Frequency ' num2str(fs_samp_2) ' Hz'])
xlabel('Time','FontWeight','bold')
ylabel('Amplitude','FontWeight','bold')
legend('original signal','sampled signal')

subplot(2,2,3)
plot(dt,y,'b','linewidth',1)
hold on
plot(dt_samp_3,y_samp_3,'r','linewidth',1)
title(['Sampling Frequency ' num2str(fs_samp_3) ' Hz'])
xlabel('Time','FontWeight','bold')
ylabel('Amplitude','FontWeight','bold')
legend('original signal','sampled signal')

subplot(2,2,4)
plot(dt,y,'b','linewidth',1)
hold on
plot(dt_samp_4,y_samp_4,'b','linewidth',1)
title(['No Aliasing with Sampling Frequency ' num2str(fs_samp_4) ' Hz'])
xlabel('Time','FontWeight','bold')
ylabel('Amplitude','FontWeight','bold')
legend('original signal','sampled signal')

suptitle('ECG Signal of Person02_Rec19')
