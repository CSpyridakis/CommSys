% ---------------------------------------------------------------------------------
%   Exercise 1, part C
%
%   Authors : Spyridakis Christos
%   Created Date : 28/10/2019
%   Last Updated : 30/10/2019
%
%   Description: 
%               Code created for Exercises of Communication Systems Course
%               in Tecnhical University of Crete
% ---------------------------------------------------------------------------------

clear all ; close all ; clc ;

% Just for saving in a separate folder figures as images
DEBUG = true ; part = 'C.' ;dirpath = '../doc/photos' ; ext = '.jpg' ; if ~DEBUG && ~exist(dirpath,'dir') ; mkdir(dirpath); end
% Auxiliary variables for plots, semilogy, etc...
colors = ['r' 'g' 'b' 'c' 'm' 'y' 'k'] ;
valueStyles = ['o' 's' '+' '*' 'd' '.' 'x' ];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% C
%
% Init mantatory variables
T = 0.1 ; over = 10 ; a = 0.5 ; A = 5 ; 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% C.1
N = 100;
b=(sign(randn(N, 1)) + 1)/2;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% C.2.a
X = bits_to_2PAM(b);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% C.2.b
stepName = '2.b X_d(t)'; extraInfo = ''; 
%Create signal
Ts=T/over; 
X_delta = 1/Ts * upsample(X, over);
t_delta = [ 0 : Ts : (N*over-1)*Ts ];
%Plot
f=figure();
stem(t_delta, X_delta);
title(strcat(part,stepName)); ylabel('X_d(t)'); xlabel('t(sec)'); 
if ~DEBUG ; saveas(f,strcat(dirpath, '/', part, stepName, extraInfo, ext)) ; end 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% C.2.c
stepName = '2.c '; extraInfo = ' X(t)'; 
%Create SRRC signal 
[phi t_phi] = srrc_pulse(T, Ts, A, a);

% Convolution
t_Xd_conv_phi = [t_delta(1) + t_phi(1) : Ts : t_delta(end) + t_phi(end)];
X_t=conv(X_delta,phi)*Ts;

%Plot Xd(t) ** phi(t)
f=figure();
plot(t_Xd_conv_phi, X_t, 'b') ; grid on;
title(strcat(part,stepName,' X_d(t) conv \phi(t), for a=0.5')); ylabel('X(t)'); xlabel('T(sec)');  
if ~DEBUG ; saveas(f,strcat(dirpath, '/', part, stepName, extraInfo, ext)) ; end 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% C.2.d
stepName = '2.d '; extraInfo = ' Z(t) and Xk'; 
phi_rev = phi(end:-1:1);
t_phi_rev = t_phi;

% Convolution
t_Xd_conv_phi_rev = [t_Xd_conv_phi(1) + t_phi_rev(1) : Ts : t_Xd_conv_phi(end) + t_phi_rev(end)];
Z_t=conv(X_t,phi_rev)*Ts;

%Plot Xd(t) ** phi(-t) and Xk 
f=figure();
p1 = plot(t_Xd_conv_phi_rev, Z_t, 'b') ; hold on;
p2 = stem([0:N-1]*T, X,'r') ; hold off;
legend([p1,p2],'Z(t)', 'X_k'); legend('Location','NorthEast'); grid on;
title(strcat(part,stepName,' X(t) conv \phi(-t), for a=0.5 and X_k')); ylabel('Z(t)'); xlabel('T(sec)');  
if ~DEBUG ; saveas(f,strcat(dirpath, '/', part, stepName, extraInfo, ext)) ; end 
