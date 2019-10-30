% ---------------------------------------------------------------------------------
%   Exercise 1, part B
%
%   Authors : Spyridakis Christos
%   Created Date : 27/10/2019
%   Last Updated : 30/10/2019
%
%   Description: 
%               Code created for Exercises of Communication Systems Course
%               in Tecnhical University of Crete
% ---------------------------------------------------------------------------------

clear all; close all; clc;

% Just for saving in a separate folder figures as images
DEBUG = true ; part = 'B.' ;dirpath = '../doc/photos' ; ext = '.jpg' ; if ~DEBUG && ~exist(dirpath,'dir') ; mkdir(dirpath); end
% Auxiliary variables for plots, semilogy, etc...
colors = ['r' 'g' 'b' 'c' 'm' 'y' 'k'] ;
valueStyles = ['o' 's' '+' '*' 'd' '.' 'x' ];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% B
%
% Init mantatory variable 
T=10^-2 ; over=10 ; Ts=T/over ; A=5 ; a=[0 0.5 1] ; phi_t = [] ; t=[] ; 

% Create srrc pulses 
for i=1:length(a)
  [phi_tmp t_tmp] = srrc_pulse(T, Ts, A, a(i));
  phi_t = [phi_t; phi_tmp];
  t = t_tmp;
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% B.1.1
stepName='1.1 Plot \phi(t) and \phi(t-kT)'; 
% for a = 0, 0.5, 1 and k=0,1,2,4 plot phi(t) and phi(t-kT)
f=figure(); extraInfo=' Plot phi_t and phi_t_kT';
  for i=1:length(a)             % for a = 0, 0.5, 1
    subplot(3,1,i) ; col=2;
    for k=[0 1 2 4]             % for k=0,1,2,4
      %Create signals
      t_s=[-A*T:Ts:(A+k)*T];                         % time vector with needed extra time added for shifting
      phi_t_za=[phi_t(i,:) zeros(1,k*over)];         % phi(t) (with zeros added)
      phi_kt_za=[zeros(1,k*over) phi_t(i,:)];        % phi(t-kT) (with zeros added)
      
      % Plot once initial signal then plot others
      if k==0 
        plot(t_s, phi_t_za, strcat(colors(1),'-'), 'DisplayName','\phi(t)') ; hold on ; 
        plot(t_s, phi_kt_za, strcat(colors(col),valueStyles(col)), 'DisplayName','\phi(t-kT), k=0') ; hold on ; col=col+1; 
      else
        plot(t_s, phi_kt_za, strcat(colors(col),'-',valueStyles(col)), 'DisplayName',strcat('\phi(t-kT), k=',num2str(k))) ; hold on ; col=col+1; 
      end
    end
    hold off; legend('Location','NorthEast'); grid on;
    title(strcat(part,stepName, ' for a = ',num2str(a(i)))); ylabel(''); xlabel('T(sec)'); 
  end
if ~DEBUG ; saveas(f,strcat(dirpath, '/', part, '1.1', extraInfo, ext)) ; end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% B.1.2
stepName='1.2 Products'; extraInfo='';
% for a = 0, 0.5, 1 and k=0,1,2,4 plot phi(t)*phi(t-kT)
f=figure(); p_num=1;
  for i=1:length(a)             % for a = 0, 0.5, 1
    for k=[0 1 2 4]             % for k = 0,1,2,4
      subplot(3,4,p_num) ; p_num=p_num+1 ; col=2;
      %Create signals
      t_s=[-A*T:Ts:(A+k)*T];                         % time vector with needed extra time added for shifting
      phi_t_za=[phi_t(i,:) zeros(1,k*over)];         % phi(t) (with zeros added)
      phi_kt_za=[zeros(1,k*over) phi_t(i,:)];        % phi(t-kT) (with zeros added)
      
      plot(t_s, phi_t_za, 'r-', 'DisplayName','\phi(t)') ; hold on ;                        % phi(t) 
      plot(t_s, phi_kt_za, 'b-.', 'DisplayName', '\phi(t-kT)') ; hold on                    % phi(t-kT)
      plot(t_s, phi_t_za.*phi_kt_za,'g', 'DisplayName','\phi(t)*\phi(t-kT)') ; hold off;    % phi(t)*phi(t-kT) 
      
      legend('Location','NorthEast'); grid on;
      title(strcat(' a=',num2str(a(i)), ', k=', num2str(k))); ylabel(''); xlabel('T(sec)'); 
    end
  end
if ~DEBUG ; saveas(f,strcat(dirpath, '/', part, stepName, extraInfo, ext)) ; end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% B.1.3
stepName='3'; integrals=[] ;
for i=1:length(a)
  for k=[0 2 4]
    %Create signals
    phi_t_za=[phi_t(i,:) zeros(1,k*over)];         % phi(t) (with zeros added)
    phi_kt_za=[zeros(1,k*over) phi_t(i,:)];        % phi(t-kT) (with zeros added)
  
    integrals=[integrals sprintf('a=%.1f, k=%d, integral=%f\n',a(i),k,sum(phi_t_za.*phi_kt_za)*Ts)];
  end
end
disp('Integrals') ; disp(integrals)
