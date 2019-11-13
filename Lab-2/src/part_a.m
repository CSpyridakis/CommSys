% ---------------------------------------------------------------------------------
%   Exercise 2, part A
%
%   Authors : Spyridakis Christos
%   Created Date : 12/11/2019
%   Last Updated : 13/11/2019
%
%   Description: 
%               Code created for Exercises of Communication Systems Course
%               in Tecnhical University of Crete
% ---------------------------------------------------------------------------------

clear all ; close all ; clc ;

% Just for saving in a separate folder figures as images
DEBUG = true ; part = 'A.' ;dirpath = '../doc/photos' ; ext = '.jpg' ; if ~DEBUG && ~exist(dirpath,'dir') ; mkdir(dirpath); end
% Auxiliary variables for plots, semilogy, etc...
colors = ['r' 'g' 'b' 'c' 'm' 'y' 'k'] ;
valueStyles = ['o' 's' '+' '*' 'd' '.' 'x' ];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% A.1
%
% Init mantatory variables
stepName = '1 Spectral energy density Nf=2048'; extraInfo='';
T=10^-3 ; over=10 ; Ts=T/over ; A=4 ; a=0.5 ; Nf = 2048 ; Fs = 1/Ts ; 

f=figure(); 
    [phi_t, t_phi] = srrc_pulse(T, Ts, A, a);       % Create SRRC pulse              
    F_Phi = [-Fs/2 : Fs/Nf : Fs/2-Fs/Nf];           % Frequency vector
    Phi_F = fftshift(fft(phi_t,Nf)*Ts) ;            % Fourier Transform of phi(t)
    
    semilogy(F_Phi, abs(Phi_F).^2); grid on;        % Display Spectral energy density of phi(t)
    title(strcat(part, stepName)); ylabel('|\Phi(F)|^2 in log'); xlabel('F(Hz)');
if ~DEBUG ; saveas(f,strcat(dirpath, '/', part, stepName, extraInfo, ext)) ; end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% A.2
%
% Init mantatory variables
stepName = '2 '; extraInfo='';
N=100 ; 

f=figure();
    b=(sign(randn(N, 1)) + 1)/2;                        % Create bit stream
    Xn = bits_to_2PAM(b);                               % Bits to symbols

    % Calculate upsampled signal Xd
    X_delta = 1/Ts * upsample(Xn, over);                
    t_delta = [ 0 : Ts : (N*over-1)*Ts ];
    
    % Calculate X_t, which is the convolution of phi(t) and X_delta
    t_Xt = [t_delta(1) + t_phi(1) : Ts : t_delta(end) + t_phi(end)];
    Xt = conv(X_delta, phi_t)*Ts;
    
    % Display signal
    plot(t_Xt, Xt, 'b') ; grid on;
    title(strcat(part,stepName)); ylabel('X(t)'); xlabel('T(sec)');  
if ~DEBUG ; saveas(f,strcat(dirpath, '/', part, stepName, extraInfo, ext)) ; end 


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% A.3
%
% Init mantatory variables




































