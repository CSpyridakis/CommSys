% ---------------------------------------------------------------------------------
%   Exercise 2, part A
%
%   Authors : Spyridakis Christos
%   Created Date : 12/11/2019
%   Last Updated : 14/11/2019
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
stepName = '1 Spectral energy density'; extraInfo='';
T=10^-3 ; over=10 ; Ts=T/over ; A=4 ; a=0.5 ; Nf = 4096 ; Fs = 1/Ts ; 

f=figure(); 
    [phi_t, t_phi] = srrc_pulse(T, Ts, A, a);       % Create SRRC pulse              
    F_Phi = [-Fs/2 : Fs/Nf : Fs/2-Fs/Nf];           % Frequency vector
    Phi_F = fftshift(fft(phi_t,Nf)*Ts) ;            % Fourier Transform of phi(t)
    
    semilogy(F_Phi, abs(Phi_F).^2); grid on;        % Display Spectral energy density of phi(t)
    title(strcat(part, stepName, ' Nf=2048 (Semilogy)')); ylabel('|\Phi(F)|^2'); xlabel('F(Hz)');
if ~DEBUG ; saveas(f,strcat(dirpath, '/', part, stepName, extraInfo, ext)) ; end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% A.2
%
% Init mantatory variables
stepName = '2'; extraInfo='';
N=100 ; 

f=figure();
    b=(sign(randn(N, 1)) + 1)/2;                        % Create bit stream
    Xn = bits_to_2PAM(b);                               % Bits to symbols

    % Calculate upsampled signal X_delta
    X_delta = 1/Ts * upsample(Xn, over);                
    t_delta = [ 0 : Ts : (N*over-1)*Ts ];
    
    % Calculate X_t, which is the convolution of phi(t) and X_delta
    Xt = conv(X_delta, phi_t).*Ts;
    t_Xt = [t_delta(1) + t_phi(1) : Ts : t_delta(end) + t_phi(end)];
    
    % Display signal
    plot(t_Xt, Xt, 'b') ; grid on;
    title([strcat(part, stepName, ' X(t) = $\sum_{n=0}^{N-1}X_n\phi(t-nT)$')],'Interpreter','latex'); ylabel('X(t)'); xlabel('T(sec)');  
if ~DEBUG ; saveas(f,strcat(dirpath, '/', part, stepName, extraInfo, ext)) ; end 

Sx_F = (var(Xt)/T).*(abs(Phi_F).^2);                      % Theoretical Power Spectrum

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% A.3.a
%
% Init mantatory variables
stepName = '3.a Periodogram'; extraInfo='_Plot_and_Semilogy';
 
f=figure();
    Ttotal = length(t_Xt)*Ts;                             % Ttotal is total time of X(t) in sec
    Px_F = (abs(fftshift(fft(Xt,Nf)*Ts)).^2)./Ttotal;     % Px(F) = (|F[X(t)]|^2)/(Ttotal)
    F_Px = [-Fs/2 : Fs/Nf : Fs/2-Fs/Nf];                  % Frequency vector
    
    % Display signal
    subplot(2,1,1);    % Plot
    plot(F_Px, Px_F, 'b') ; grid on;
    title(strcat(part,stepName, ' - Plot')); ylabel('P_x(F)'); xlabel('F(Hz)'); 
    subplot(2,1,2);     % Semilogy
    semilogy(F_Px, Px_F, 'b') ; grid on;
    title(strcat(part,stepName, ' - Semilogy')); ylabel('P_x(F)'); xlabel('F(Hz)'); 
if ~DEBUG ; saveas(f,strcat(dirpath, '/', part, stepName, extraInfo, ext)) ; end 


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% A.3.b
%
% Init mantatory variables
K = 1000 ;   
stepName = '3.b '; extraInfo='';
 
f=figure();
    
    % Calculate experimental 
    for i = 1:K                                            
        % Create again bits, create symbols etc...  \see A.2 for more info
        b = (sign(randn(N, 1)) + 1)/2;                   
        Xn = bits_to_2PAM(b);                      
        X_delta = 1/Ts * upsample(Xn, over);                
        Xt = conv(X_delta, phi_t).*Ts;
        Px_experiments(i,:) = (abs(fftshift(fft(Xt,Nf).*Ts)).^2)./Ttotal;
    end
    
    Px_F_experimental = mean(Px_experiments);            % Experimental
    Px_F_theoritical = Sx_F;                        	 % Theoritical
    
    p1 = semilogy(F_Px, Px_F_experimental, 'b') ; hold on;
    p2 = semilogy(F_Px, Px_F_theoritical, 'r') ; hold off;
    legend([p1, p2],'Experimental', 'Theoritical'); legend('Location','NorthEast'); grid on;
    title(strcat(part,stepName)); ylabel('P_x(F)'); xlabel('F(Hz)');
if ~DEBUG ; saveas(f,strcat(dirpath, '/', part, stepName, extraInfo, ext)) ; end 


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% A.4.a
%
% Init mantatory variables
stepName = '4'; extraInfo='';

f=figure();
    b=(sign(randn(N, 1)) + 1)/2;                        % Create bit stream
    Xn = bits_to_4PAM(b);                               % Bits to symbols

    % Calculate upsampled signal X_delta
     X_delta = 1/Ts * upsample(Xn, over);                
     t_delta = [ 0 : Ts : ((N/2)*over-1)*Ts ];
     
     % Calculate X_t, which is the convolution of phi(t) and X_delta
     t_Xt = [t_delta(1) + t_phi(1) : Ts : t_delta(end) + t_phi(end)];
     Xt = conv(X_delta, phi_t).*Ts;
     
     % Display signal
%     plot(t_Xt, Xt, 'b') ; grid on;
%     title([strcat(part, stepName, ' X(t) = $\sum_{n=0}^{N-1}X_n\phi(t-nT)$')],'Interpreter','latex'); ylabel('X(t)'); xlabel('T(sec)');  
if ~DEBUG ; saveas(f,strcat(dirpath, '/', part, stepName, extraInfo, ext)) ; end 


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% A.4.b
%
% Init mantatory variables

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% A.5
%
% Init mantatory variables


































