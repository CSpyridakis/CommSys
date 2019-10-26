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
DEBUG = false; dirpath = '../doc/photos'; ext = '.jpg' ; if ~DEBUG && ~exist(dirpath,'dir') ; mkdir(dirpath); end



x = 0:pi/100:2*pi;
y11 = sin(x);
y12 = sin(-x);

t2=[-1:0.5:4]
x12=exp(-x)
x22=exp(x);


figure();
subplot(1,2,1);
plot(x,y11, 'r');
hold on;
plot(x,y12, 'b');

plot()



