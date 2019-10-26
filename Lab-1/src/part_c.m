% ---------------------------------------------------------------------------------
%   Exercise 1, part 2
%
%   Authors : Spyridakis Christos
%   Created Date : 19/10/2019
%   Last Updated : 22/10/2019
%
%   Description: 
%               Code created for labs of Digital Signal Processing Course
%               in Technical University of Crete
%
% ---------------------------------------------------------------------------------

clear all
close all
clc

% Just for saving in a separate folder figures as images
DEBUG = false; dirpath = 'photos'; ext = '.jpg' ; if ~DEBUG && ~exist(dirpath,'dir') ; mkdir(dirpath); end

% -------------------------------
%
%           Exercise 2
%
% -------------------------------

% ---------------------------------------------------------------------------------
% 2.1
% Initial signal 
tmin = 0 ; tmax = 0.5 ;
dt = 0.001;                             % dt = 1ms
t = [ tmin + dt : dt : tmax - dt ];     % 0 < t < 500ms
x = 5*cos(24*pi*t)-2*sin(1.5*pi*t);     % x(t) = 5cos(24πt)-2sin(1.5πt)
% Plot Initial signal
stepName = '2.1 Initial signal';
f = figure();
p1 = plot(t,x,'b'); 
legend([p1],'x(t)'); legend('Location','NorthEast');
title(stepName); ylabel('x(t)'); xlabel('t(sec)');
if ~DEBUG ; saveas(f,strcat(dirpath, '/', stepName, ext)) ; end

% --------------------------------------------------------------------------------
% 2.2
% Fourier Tranform
stepName = '2.2 Fourier Transform';
Fs = 100 ;   % Sampling Frequency
DT = 1/Fs ;  % Sampling Period
NFFT = 2^nextpow2(length(x));           % NFFT = biggest power of 2, fft works best for power of 2 number of elements (e.g. 256, 512, etc..)
X = fftshift(fft(x,NFFT)*DT);
F = [-Fs/2 : Fs/NFFT : Fs/2-Fs/NFFT];   %Frequency vector
% Plot Signal
f = figure();
p1 = plot(F,abs(X),'b'); 
legend([p1],'Amplitude Spectrum of x(t)'); legend('Location','NorthEast');
title(stepName); ylabel('|X(F)|'); xlabel('frequency');
if ~DEBUG ; saveas(f,strcat(dirpath, '/', stepName, ext)) ; end


% --------------------------------------------------------------------------------
% 2.3
% Sampling
Ts = [1/48 1/24 1/12];
Ts_str = ['48';'24';'12'];

stepName = '2.3.';
for i=1:length(Ts)
    
    % Sampling
    nmin = ceil(tmin/Ts(i)); nmax = floor(tmax/Ts(i)); n = nmin:nmax;
    x_sampled = 5*cos(24*pi*n*Ts(i))-2*sin(1.5*pi*n*Ts(i));
    
    % Plot Signals
    f = figure();     
    
    % Sampled signal
    subplot(2,1,1)
    p1 = plot(t,x,'b'); 
    hold on;
    p2 = plot(n*Ts(i),x_sampled,'r.');
    legend([p1,p2],'x(t)','Sampled'); legend('Location','NorthEast');
    title(strcat(stepName, num2str(i), ' Sampled - Ts=1/', Ts_str(i,:))); xlabel('t(sec)');
    
    % Reconstructed signal
    subplot(2,1,2)
    p1 = plot(t,x,'b'); 
    hold on;
    p2 = plot(n*Ts(i),x_sampled,'r');
    legend([p1,p2],'x(t)','Reconstructed'); legend('Location','NorthEast');
    title(strcat(stepName, num2str(i), ' Reconstructed - Ts=1/', Ts_str(i,:))); xlabel('t(sec)');
    
    if ~DEBUG ; saveas(f,strcat(dirpath, '/', stepName, num2str(i), ' Sampling with Ts 1_', Ts_str(i,:), ext)) ; end 
end