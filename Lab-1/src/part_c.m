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
% C.1
%
% Init mantatory variables