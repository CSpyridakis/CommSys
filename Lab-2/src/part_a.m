% ---------------------------------------------------------------------------------
%   Exercise 2, part A
%
%   Authors : Spyridakis Christos
%   Created Date : 12/11/2019
%   Last Updated : 18/11/2019
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

[phi_t, t_phi] = srrc_pulse(T, Ts, A, a);           % Create SRRC pulse  
[Phi_F, F_Phi] = fourier_transform(phi_t, Ts, Nf);

% Display Spectral energy density of phi(t)
f=figure();
semilogy(F_Phi, abs(Phi_F).^2); grid on;       
title(strcat(part, stepName, ' Nf= ',num2str(Nf),' (Semilogy)')); ylabel('|\Phi(F)|^2'); xlabel('F(Hz)');
if ~DEBUG ; saveas(f,strcat(dirpath, '/', part, stepName, extraInfo, ext)) ; end


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% A.2
%
% Init mantatory variables
stepName = '2'; extraInfo='';
N=100 ; 
    
% Calculate X_t
[Xt, t_Xt, Sx_F] = create_xt('A.2', N, 2, phi_t, t_phi, Phi_F, Ts, T, over, 'T');  
    
% Display signal
f=figure();
plot(t_Xt, Xt, 'b') ; grid on;
title([strcat(part, stepName, ' X(t) = $\sum_{n=0}^{N-1}X_n\phi(t-nT)$')],'Interpreter','latex'); ylabel('X(t)'); xlabel('T(sec)');  
if ~DEBUG ; saveas(f,strcat(dirpath, '/', part, stepName, extraInfo, ext)) ; end 


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% A.3.a and A.3.b
%
% Init mantatory variables
stepName = '3.a Periodogram'; extraInfo='_Plot_and_Semilogy';
K=100;
display_periodogram_PSD_theoretical_experimental('A.3.a', 'A.3.b', 2, T, Ts, A, a, Nf, N, K, over)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% A.3.c
%
% for Ni = [5 10 30 50 100] 
%     for Ki = [5 10 30 50 100]
%         display_periodogram_PSD_theoretical_experimental('', 'A.3.c', 2, T, Ts, A, a, Nf, Ni, Ki, over)
%     end
% end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% A.4.a
%
stepName = '4'; extraInfo='';

display_periodogram_PSD_theoretical_experimental('A.4.a', 'A.4.a', 4, T, Ts, A, a, Nf, N, K, over)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% A.5.a -> A.3.a + A.3.b 
%
display_periodogram_PSD_theoretical_experimental('A.5.a', 'A.5.a', 2, 2*T, Ts, A, a, Nf, N, K, 2*over)

%%%%%%%%%
% A.5.a -> A.3.c
%
% for Ni = [5 10 30 50 100] 
%     for Ki = [5 10 30 50 100]
%         display_periodogram_PSD_theoretical_experimental('', 'A.5.c', 2, 2*T, Ts, A, a, Nf, Ni, Ki, 2*over)
%     end
% end
