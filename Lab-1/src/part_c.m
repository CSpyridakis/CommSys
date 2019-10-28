% ---------------------------------------------------------------------------------
%   Exercise 1, part C
%
%   Authors : Spyridakis Christos
%   Created Date : 28/10/2019
%   Last Updated : 28/10/2019
%
%   Description: 
%               Code created for Exercises of Communication Systems Course
%               in Tecnhical Unoversity of Crete
%
% ---------------------------------------------------------------------------------

clear all ; close all ; clc ;

% Just for saving in a separate folder figures as images
DEBUG = false ; part = 'C.' ;dirpath = '../doc/photos' ; ext = '.jpg' ; if ~DEBUG && ~exist(dirpath,'dir') ; mkdir(dirpath); end
% Auxiliary variables for plots, semilogy, etc...
colors = ['r' 'g' 'b' 'c' 'm' 'y' 'k'] ;
valueStyles = ['o' 's' '+' '*' 'd' '.' 'x' ];


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
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
Ts=T/over ; 
X_delta = 1/Ts * upsample(X, over);
t = [ 0 : Ts : (N*over-1)*Ts ];
stepName = '2.b X_δ(t)'; extraInfo = ''; 
f=figure();
stem(t, X_delta);
title(strcat(part,stepName)); ylabel('X_δ(t)'); xlabel('t(sec)'); 
if ~DEBUG ; saveas(f,strcat(dirpath, '/', part, stepName, extraInfo, ext)) ; end 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% C.2.c









