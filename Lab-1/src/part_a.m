% ---------------------------------------------------------------------------------
%   Exercise 1, part A
%
%   Authors : Spyridakis Christos
%   Created Date : 26/10/2019
%   Last Updated : 27/10/2019
%
%   Description: 
%               Code created for Exercises of Communication Systems Course
%               in Tecnhical Unoversity of Crete
%
% ---------------------------------------------------------------------------------

clear all
close all
clc

% Just for saving in a separate folder figures as images
DEBUG = true ; part = 'A.' ;dirpath = '../doc/photos' ; ext = '.jpg' ; if ~DEBUG && ~exist(dirpath,'dir') ; mkdir(dirpath); end
% Auxiliary variables for plots, semilogy, etc...
colors = ['r' 'g' 'b' 'c' 'm' 'y' 'k'] ;
lineStyle = ['-' ; ':'  ; '--' ; '-.'];
valueStyles = ['o' 's' '+' '*' 'd' '.' 'x' ];


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 1.1
%
% Init mantatory variable 
stepName = '1 Create SRRC pulses'; extraInfo = '';
T=10^-2 ; over=10 ; Ts=T/over ; A=4 ; a=[0 0.5 1] ; phi_t = [] ; t=[] ; 

% Create srrc pulses and plot them 
f=figure(); p=[];
  for i=1:length(a)
    [phi_tmp t_tmp] = srrc_pulse(T, Ts, A, a(i));
    phi_t = [phi_t; phi_tmp];
    t = t_tmp;
    
    % Plot each srrc with some color and save plot to add extra info later  
    p_tmp = plot(t, phi_t(i,:), colors(i)) ; p=[p ; p_tmp];
    hold on
  end
  hold off

  % Add more info to plots                                           
  % TODO: Check axis on matlab
  axis=([-0.05 0.05 -4 15]) ; legend([p],'a=0', 'a=0.5', 'a=1'); legend('Location','NorthEast'); grid on;
  title(strcat(part,stepName)); ylabel('\phi(t)'); xlabel('T(sec)');  
if ~DEBUG ; saveas(f,strcat(dirpath, '/', part, stepName, extraInfo, ext)) ; end 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 1.2
%
% Init mantatory variable 
stepName = '2 Fourier Transform Φ(F)';
Phi_F1 = [] ; Phi_F2 = []

% Calculate frequency vectors
Fs = 1/Ts ; Nf = [1024 2048] ;              
F_1 = [-Fs/2 : Fs/Nf(1) : Fs/2-Fs/Nf(1)];   % Frequency vector for Nf=1024
F_2 = [-Fs/2 : Fs/Nf(2) : Fs/2-Fs/Nf(2)];   % Frequency vector for Nf=2048

%Fourier Transform and save to vector
for i=1:length(a)
  X1 = fftshift(fft(phi_t(i,:),Nf(1))*Ts) ; Phi_F1 = [Phi_F1 ; X1] ;
  X2 = fftshift(fft(phi_t(i,:),Nf(2))*Ts) ; Phi_F2 = [Phi_F2 ; X2] ; 
end

% Plot them 
f=figure();  extraInfo='-Plots';
  % Nf = 1024
  subplot(1,2,1); 
  p1 = plot(F_1, abs(Phi_F1(1,:)).^2); hold on;
  p2 = plot(F_1, abs(Phi_F1(2,:)).^2); hold on;
  p3 = plot(F_1, abs(Phi_F1(3,:)).^2); hold off;
  legend([p1,p2,p3],'a=0', 'a=0.5', 'a=1'); legend('Location','NorthEast'); grid on;
  title(strcat('Spectral energy density-','Nf=1024')); ylabel('|\Phi(F)|^2'); xlabel('F(Hz)');
  % Nf = 2048
  subplot(1,2,2); 
  p1 = plot(F_2, abs(Phi_F2(1,:)).^2); hold on;
  p2 = plot(F_2, abs(Phi_F2(2,:)).^2); hold on;
  p3 = plot(F_2, abs(Phi_F2(3,:)).^2); hold off;
  legend([p1,p2,p3],'a=0', 'a=0.5', 'a=1'); legend('Location','NorthEast'); grid on;
  title(strcat('Spectral energy density-','Nf=2048')); ylabel('|\Phi(F)|^2'); xlabel('F(Hz)');
  
%  sgtitle(strcat(part, stepName, extraInfo)) ; %  suptitle(strcat(part, stepName, extraInfo));  %TODO
if ~DEBUG ; saveas(f,strcat(dirpath, '/', part, stepName, extraInfo, ext)) ; end


% Semilogy 
f=figure(); extraInfo='-Semilogy';
   % Nf = 1024
  subplot(2,1,1); 
  p1 = semilogy(F_1, abs(Phi_F1(1,:)).^2); hold on;
  p2 = semilogy(F_1, abs(Phi_F1(2,:)).^2); hold on;
  p3 = semilogy(F_1, abs(Phi_F1(3,:)).^2); hold off;
  legend([p1, p2, p3],'a=0', 'a=0.5', 'a=1'); legend('Location','NorthEast'); grid on;
  title(strcat('Spectral energy density (log)-','Nf=1024')); ylabel('|\Phi(F)|^2'); xlabel('F(Hz)');
  % Nf = 2048
  subplot(2,1,2); 
  p1 = semilogy(F_2, abs(Phi_F2(1,:)).^2); hold on;
  p2 = semilogy(F_2, abs(Phi_F2(2,:)).^2); hold on;
  p3 = semilogy(F_2, abs(Phi_F2(3,:)).^2); hold off;
  legend([p1, p2, p3],'a=0', 'a=0.5', 'a=1'); legend('Location','NorthEast'); grid on;
  title(strcat('Spectral energy density (log)-','Nf=2048')); ylabel('|\Phi(F)|^2'); xlabel('F(Hz)');
  
%  sgtitle(strcat(part, stepName, extraInfo)) ; %  suptitle(strcat(part, stepName, extraInfo));  %TODO
if ~DEBUG ; saveas(f,strcat(dirpath, '/', part, stepName, extraInfo, ext)) ; end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 1.3
%
% Init mantatory variable 
stepName = '1.3 Bandwidth'; extraInfo='';

% Theoritical Bandwidth
BW=(1+a)./(2*T)

% Practical Bandwith 
c = [T/(10^3) T/(10^5)];
figure()
  % Nf = 1024
  subplot(2,1,1); 
  p1 = semilogy(F_1, abs(Phi_F1(1,:)).^2); hold on;
  p2 = semilogy(F_1, abs(Phi_F1(2,:)).^2); hold on;
  p3 = semilogy(F_1, abs(Phi_F1(3,:)).^2); hold on;
  p4 = plot(xlim ,[c(1) c(1)]); hold on;
  p5 = plot(xlim ,[c(2) c(2)]); hold off
  legend([p1, p2, p3, p4, p5],'logP(F), a=0', 'logP(F), a=0.5', 'logP(F), a=1' , 'C=T/10^3', 'C=T/10^5'); legend('Location','NorthEast'); grid off;
  title(strcat('Spectral Energy Density Nf=1024')); ylabel('|\Phi(F)|^2'); xlabel('F(Hz)');

  % Nf = 2048
  subplot(2,1,2); 
  p1 = semilogy(F_2, abs(Phi_F2(1,:)).^2); hold on;
  p2 = semilogy(F_2, abs(Phi_F2(2,:)).^2); hold on;
  p3 = semilogy(F_2, abs(Phi_F2(3,:)).^2); hold on;
  p4 = plot(xlim ,[c(1) c(1)]); hold on;
  p5 = plot(xlim ,[c(2) c(2)]); hold off
  legend([p1, p2, p3, p4, p5],'logP(F), a=0', 'logP(F), a=0.5', 'logP(F), a=1' , 'C=T/10^3', 'C=T/10^5'); legend('Location','NorthEast'); grid off;
  title(strcat('Spectral Energy Density  Nf=2048')); ylabel('|\Phi(F)|^2'); xlabel('F(Hz)');
if ~DEBUG ; saveas(f,strcat(dirpath, '/', part, stepName, extraInfo, ext)) ; end

