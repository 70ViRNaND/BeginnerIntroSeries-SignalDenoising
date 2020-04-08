
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 1

%set time and frequency for "continous time" sinusoids
tMax = 1 ;
t = 0 : 0.001 : tMax ;
f1 = 4; 
f2 = 8;
f3 = 16;
%set sampling rate for sampled sinusoid
fs_1 =10;
fs_2 =20;
fs_3 =30;
fs_4 =40;
tSamp_1 = 0 : 1/fs_1 : tMax ;
tSamp_2 = 0 : 1/fs_2 : tMax ;
tSamp_3 = 0 : 1/fs_3 : tMax ;
tSamp_4 = 0 : 1/fs_4 : tMax ;

%create "continous" and sampled signals
xCont = 1*sin(2*pi*f1*t)  + 1*cos(2*pi*f2*t) + 1*sin(2*pi*f3*t) ;
xSamp_1 = 1*sin(2*pi*f1*tSamp_1) + 1*cos(2*pi*f2*tSamp_1) + 1*sin(2*pi*f3*tSamp_1);
xSamp_2 = 1*sin(2*pi*f1*tSamp_2) + 1*cos(2*pi*f2*tSamp_2) + 1*sin(2*pi*f3*tSamp_2);
xSamp_3 = 1*sin(2*pi*f1*tSamp_3) + 1*cos(2*pi*f2*tSamp_3) + 1*sin(2*pi*f3*tSamp_3);
xSamp_4 = 1*sin(2*pi*f1*tSamp_4) + 1*cos(2*pi*f2*tSamp_4) + 1*sin(2*pi*f3*tSamp_4);

subplot(2,2,1);
hold on;
set(gca, 'fontsize', 12, 'fontweight', 'bold') ;
plot(t, xCont, 'b', 'linewidth', 1) ;
plot(tSamp_1, xSamp_1, 'ko', 'linewidth', 1) ; 

%Compute aliased frequency
if fs_1 < 2 * f1 || fs_1 < 2 * f2 || fs_1 < 2 * f3
    
    %determine aliased frequency
    
    keepgoing1 = 1 ;
    m1 = 0;
    while (keepgoing1)
        fAlias1 = abs(f1 - m1 * fs_1) ;
        if fAlias1 <= fs_1 / 2 ;
            keepgoing1 = 0;
        else
            m1 = m1 + 1 ;
        end
    end
    
    keepgoing2 = 1 ;
    m2 = 0;
    while (keepgoing2)
        fAlias2 = abs(f2 - m2 * fs_1) ;
        if fAlias2 <= fs_1 / 2 ;
            keepgoing2 = 0;
        else
            m2 = m2 + 1 ;
        end
    end
    
    keepgoing3 = 1 ;
    m3 = 0;
    while (keepgoing3)
        fAlias3 = abs(f3 - m3 * fs_1) ;
        if fAlias3 <= fs_1 / 2 ;
            keepgoing3 = 0;
        else
            m3 = m3 + 1 ;
        end
    end
    
   ctrl1 = f1 - m1 * fs_1;
   ctrl3 = f3 - m3 * fs_1;
   
   if ctrl1 < 0 && ctrl3 < 0
    %plot aliased sinusoids
    plot(t,  -1*sin(2*pi*fAlias1*t)+ 1*cos(2*pi*fAlias2*t) -1*sin(2*pi*fAlias3*t), 'r', 'linewidth', 2) ;
    title(['Sampling Frequency ' num2str(fs_1) ' Hz ']) ;
     legend('original signal','','sampled signal')
     
   elseif ctrl1 < 0 && ctrl3 >= 0
    %plot aliased sinusoids
    plot(t,  -1*sin(2*pi*fAlias1*t)+ 1*cos(2*pi*fAlias2*t) + 1*sin(2*pi*fAlias3*t), 'r', 'linewidth', 2) ;
    title(['Sampling Frequency ' num2str(fs_1) ' Hz ']) ;
     legend('original signal','','sampled signal')
    
   elseif ctrl1 >= 0 && ctrl3 < 0
    %plot aliased sinusoids
    plot(t,  1*sin(2*pi*fAlias1*t) + 1*cos(2*pi*fAlias2*t) -1*sin(2*pi*fAlias3*t) , 'r', 'linewidth', 2) ;
    title(['Sampling Frequency ' num2str(fs_1) ' Hz ']) ;
     legend('original signal','','sampled signal')
   
     elseif ctrl1 >= 0 && ctrl3 >= 0
    %plot aliased sinusoids
    plot(t,  1*sin(2*pi*fAlias1*t) + 1*cos(2*pi*fAlias2*t) + 1*sin(2*pi*fAlias3*t), 'r', 'linewidth', 2) ;
    title(['Sampling Frequency ' num2str(fs_1) ' Hz ']) ;
     legend('original signal','','sampled signal')
  
   end
else
    legend('original and sampled signal')
    title(['No Aliasing with Sampling Frequency ' num2str(fs_1) ' Hz ']) ;
end
hold off

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 2

%create "continous" and sampled signals
subplot(2,2,2);
hold on;
set(gca, 'fontsize', 12, 'fontweight', 'bold') ;
plot(t, xCont, 'b', 'linewidth', 1) ;
plot(tSamp_2, xSamp_2, 'ko', 'linewidth', 1) ; 

%Compute aliased frequency
if fs_2 < 2 * f1 || fs_2 < 2 * f2 || fs_2 < 2 * f3
    
    %determine aliased frequency
    
    keepgoing1 = 1 ;
    m1 = 0;
    while (keepgoing1)
        fAlias1 = abs(f1 - m1 * fs_2) ;
        if fAlias1 <= fs_2 / 2 ;
            keepgoing1 = 0;
        else
            m1 = m1 + 1 ;
        end
    end
    
    keepgoing2 = 1 ;
    m2 = 0;
    while (keepgoing2)
        fAlias2 = abs(f2 - m2 * fs_2) ;
        if fAlias2 <= fs_2 / 2 ;
            keepgoing2 = 0;
        else
            m2 = m2 + 1 ;
        end
    end
    
    keepgoing3 = 1 ;
    m3 = 0;
    while (keepgoing3)
        fAlias3 = abs(f3 - m3 * fs_2) ;
        if fAlias3 <= fs_2 / 2 ;
            keepgoing3 = 0;
        else
            m3 = m3 + 1 ;
        end
    end
    
   ctrl1 = f1 - m1 * fs_2;
   ctrl3 = f3 - m3 * fs_2;
   
   if ctrl1 < 0 && ctrl3 < 0
    %plot aliased sinusoids
    plot(t,  -1*sin(2*pi*fAlias1*t)+ 1*cos(2*pi*fAlias2*t) -1*sin(2*pi*fAlias3*t), 'r', 'linewidth', 2) ;
    title(['Sampling Frequency ' num2str(fs_2) ' Hz ']) ;
     legend('original signal','','sampled signal')
     
   elseif ctrl1 < 0 && ctrl3 >= 0
    %plot aliased sinusoids
    plot(t,  -1*sin(2*pi*fAlias1*t)+ 1*cos(2*pi*fAlias2*t) + 1*sin(2*pi*fAlias3*t), 'r', 'linewidth', 2) ;
    title(['Sampling Frequency ' num2str(fs_2) ' Hz ']) ;
     legend('original signal','','sampled signal')
    
   elseif ctrl1 >= 0 && ctrl3 < 0
    %plot aliased sinusoids
    plot(t,  1*sin(2*pi*fAlias1*t) + 1*cos(2*pi*fAlias2*t) -1*sin(2*pi*fAlias3*t) , 'r', 'linewidth', 2) ;
    title(['Sampling Frequency ' num2str(fs_2) ' Hz ']) ;
     legend('original signal','','sampled signal')
   
     elseif ctrl1 >= 0 && ctrl3 >= 0
    %plot aliased sinusoids
    plot(t,  1*sin(2*pi*fAlias1*t) + 1*cos(2*pi*fAlias2*t) + 1*sin(2*pi*fAlias3*t), 'r', 'linewidth', 2) ;
    title(['Sampling Frequency ' num2str(fs_2) ' Hz ']) ;
     legend('original signal','','sampled signal')
  
   end
else
    legend('original and sampled signal')
    title(['No Aliasing with Sampling Frequency ' num2str(fs_2) ' Hz ']) ;
end
hold off

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 3
subplot(2,2,3);
hold on;
set(gca, 'fontsize', 12, 'fontweight', 'bold') ;
plot(t, xCont, 'b', 'linewidth', 1) ;
plot(tSamp_3, xSamp_3, 'ko', 'linewidth', 1) ; 

%Compute aliased frequency
if fs_3 < 2 * f1 || fs_3 < 2 * f2 || fs_3 < 2 * f3
    
    %determine aliased frequency
    
    keepgoing1 = 1 ;
    m1 = 0;
    while (keepgoing1)
        fAlias1 = abs(f1 - m1 * fs_3) ;
        if fAlias1 <= fs_3 / 2 ;
            keepgoing1 = 0;
        else
            m1 = m1 + 1 ;
        end
    end
    
    keepgoing2 = 1 ;
    m2 = 0;
    while (keepgoing2)
        fAlias2 = abs(f2 - m2 * fs_3) ;
        if fAlias2 <= fs_3 / 2 ;
            keepgoing2 = 0;
        else
            m2 = m2 + 1 ;
        end
    end
    
    keepgoing3 = 1 ;
    m3 = 0;
    while (keepgoing3)
        fAlias3 = abs(f3 - m3 * fs_3) ;
        if fAlias3 <= fs_3 / 2 ;
            keepgoing3 = 0;
        else
            m3 = m3 + 1 ;
        end
    end
    
   ctrl1 = f1 - m1 * fs_3;
   ctrl3 = f3 - m3 * fs_3;
   
   if ctrl1 < 0 && ctrl3 < 0
    %plot aliased sinusoids
    plot(t,  -1*sin(2*pi*fAlias1*t)+ 1*cos(2*pi*fAlias2*t) -1*sin(2*pi*fAlias3*t), 'r', 'linewidth', 2) ;
    title(['Sampling Frequency ' num2str(fs_3) ' Hz ']) ;
     legend('original signal','','sampled signal')
     
   elseif ctrl1 < 0 && ctrl3 >= 0
    %plot aliased sinusoids
    plot(t,  -1*sin(2*pi*fAlias1*t)+ 1*cos(2*pi*fAlias2*t) + 1*sin(2*pi*fAlias3*t), 'r', 'linewidth', 2) ;
    title(['Sampling Frequency ' num2str(fs_3) ' Hz ']) ;
     legend('original signal','','sampled signal')
    
   elseif ctrl1 >= 0 && ctrl3 < 0
    %plot aliased sinusoids
    plot(t,  1*sin(2*pi*fAlias1*t) + 1*cos(2*pi*fAlias2*t) -1*sin(2*pi*fAlias3*t) , 'r', 'linewidth', 2) ;
    title(['Sampling Frequency ' num2str(fs_3) ' Hz ']) ;
     legend('original signal','','sampled signal')
   
     elseif ctrl1 >= 0 && ctrl3 >= 0
    %plot aliased sinusoids
    plot(t,  1*sin(2*pi*fAlias1*t) + 1*cos(2*pi*fAlias2*t) + 1*sin(2*pi*fAlias3*t), 'r', 'linewidth', 2) ;
    title(['Sampling Frequency ' num2str(fs_3) ' Hz ']) ;
     legend('original signal','','sampled signal')
  
   end
else
    legend('original and sampled signal')
    title(['No Aliasing with Sampling Frequency ' num2str(fs_3) ' Hz ']) ;
end
hold off

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% 4
%set time and frequency for "continous time" sinusoids
subplot(2,2,4);
hold on;
set(gca, 'fontsize', 12, 'fontweight', 'bold') ;
plot(t, xCont, 'b', 'linewidth', 1) ;
plot(tSamp_4, xSamp_4, 'ko', 'linewidth', 1) ; 

%Compute aliased frequency
if fs_4 < 2 * f1 || fs_4 < 2 * f2 || fs_4 < 2 * f3
    
    %determine aliased frequency
    
    keepgoing1 = 1 ;
    m1 = 0;
    while (keepgoing1)
        fAlias1 = abs(f1 - m1 * fs_4) ;
        if fAlias1 <= fs_4 / 2 ;
            keepgoing1 = 0;
        else
            m1 = m1 + 1 ;
        end
    end
    
    keepgoing2 = 1 ;
    m2 = 0;
    while (keepgoing2)
        fAlias2 = abs(f2 - m2 * fs_4) ;
        if fAlias2 <= fs_4 / 2 ;
            keepgoing2 = 0;
        else
            m2 = m2 + 1 ;
        end
    end
    
    keepgoing3 = 1 ;
    m3 = 0;
    while (keepgoing3)
        fAlias3 = abs(f3 - m3 * fs_4) ;
        if fAlias3 <= fs_4 / 2 ;
            keepgoing3 = 0;
        else
            m3 = m3 + 1 ;
        end
    end
    
   ctrl1 = f1 - m1 * fs_4;
   ctrl3 = f3 - m3 * fs_4;
   
   if ctrl1 < 0 && ctrl3 < 0
    %plot aliased sinusoids
    plot(t,  -1*sin(2*pi*fAlias1*t)+ 1*cos(2*pi*fAlias2*t) -1*sin(2*pi*fAlias3*t), 'r', 'linewidth', 2) ;
    title(['Sampling Frequency ' num2str(fs_4) ' Hz ']) ;
     legend('original signal','','sampled signal')
     
   elseif ctrl1 < 0 && ctrl3 >= 0
    %plot aliased sinusoids
    plot(t,  -1*sin(2*pi*fAlias1*t)+ 1*cos(2*pi*fAlias2*t) + 1*sin(2*pi*fAlias3*t), 'r', 'linewidth', 2) ;
    title(['Sampling Frequency ' num2str(fs_4) ' Hz ']) ;
     legend('original signal','','sampled signal')
    
   elseif ctrl1 >= 0 && ctrl3 < 0
    %plot aliased sinusoids
    plot(t,  1*sin(2*pi*fAlias1*t) + 1*cos(2*pi*fAlias2*t) -1*sin(2*pi*fAlias3*t) , 'r', 'linewidth', 2) ;
    title(['Sampling Frequency ' num2str(fs_4) ' Hz ']) ;
     legend('original signal','','sampled signal')
   
     elseif ctrl1 >= 0 && ctrl3 >= 0
    %plot aliased sinusoids
    plot(t,  1*sin(2*pi*fAlias1*t) + 1*cos(2*pi*fAlias2*t) + 1*sin(2*pi*fAlias3*t), 'r', 'linewidth', 2) ;
    title(['Sampling Frequency ' num2str(fs_4) ' Hz ']) ;
     legend('original signal','','sampled signal')
  
   end
else
    legend('original and sampled signal')
    title(['No Aliasing with Sampling Frequency ' num2str(fs_4) ' Hz ']) ;
end
hold off

suptitle('f(t) = sin(2*pi*4*t) + cos(2*pi*8*t) + sin(2*pi*16*t)')