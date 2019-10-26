% ---------------------------------------------------------------------------------
%   Exercise 1, part B
%
%   Authors : Spyridakis Christos
%   Created Date : 27/10/2019
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
DEBUG = true ; part = 'B.' ;dirpath = '../doc/photos' ; ext = '.jpg' ; if ~DEBUG && ~exist(dirpath,'dir') ; mkdir(dirpath); end
% Auxiliary variables for plots, semilogy, etc...
colors = ['r' 'g' 'b' 'c' 'm' 'y' 'k'] ;
lineStyle = ['-' ; ':'  ; '--' ; '-.'];
valueStyles = ['o' 's' '+' '*' 'd' '.' 'x' ];


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 1
%
% Init mantatory variable 
T=10^-2 ; over=10 ; Ts=T/over ; A=4 ; a=[0 0.5 1] ; phi_t = [] ; t=[] ; 

% Create srrc pulses 
for i=1:length(a)
  [phi_tmp t_tmp] = srrc_pulse(T, Ts, A, a(i));
  phi_t = [phi_t; phi_tmp];
  t = t_tmp;
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% 1.1 
stepName='Shifting \phi'; %TODO
% for a = 0, 0.5, 1 and k=0,1,2,4 plot phi(t) and phi(t-kT)
f=figure(); p=[];
for i=1:length(a)
  subplot(3,1,i) ; col=2;
  for k=[0 1 2 4]
    t_s=[-A*T:Ts:(A+k)*T];                         % time vector with needed extra time added for shifting
    phi_t_za=[phi_t(i,:) zeros(1,k*over)];         % φ(t) (with zeros added)
    phi_kt_za=[zeros(1,k*over) phi_t(i,:)];        % φ(t-kT) (with zeros added)
    
    % Plot once initial signal then plot others
    if k==0 
      p_tmp = plot(t_s, phi_t_za, strcat(colors(1),'r-')) ; p=[p ; p_tmp]; hold on ; 
      p_tmp = plot(t_s, phi_kt_za, strcat(colors(col),valueStyles(col))) ; p=[p ; p_tmp]; col=col+1; hold on;
    else
      p_tmp = plot(t_s, phi_kt_za, strcat(colors(col),'-',valueStyles(col))) ; p=[p ; p_tmp]; col=col+1; hold on;
    end
        
  end
  hold off;
  legend([p],'\phi(t)','\phi(t-kT), k=0', '\phi(t-kT), k=1', '\phi(t-kT), k=2', '\phi(t-kT), k=4'); legend('Location','NorthEast'); grid on;
  title(strcat(part,stepName, 'a=',num2str(a(i)))); ylabel('\phi(t)'); xlabel('T(sec)'); 
end








