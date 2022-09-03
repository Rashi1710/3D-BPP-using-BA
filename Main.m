%% Information 
% The 1-D Bin Packing Problem Optimisation using Bees Algorithm
% If you use this code for your work, please cite:
% XXXX et al., 2022. The 1-D Bin Packing Problem Optimisation using Bees
% Algorithm ......., Journal .....(will adds information after publication) 

%% Abbreviation 
% BA = Bees Algorithm
% BPP = Bin Packing Problem

%% How to run experiment 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% click Run
% to use other BPP model, see the BPPModel.m
% Result will be saved as *.mat file with name: 
% Result{number of max iteration]nScoutBee{number of scout bees]
% Inside the mat file: Best(Position, Cost, Sol), ave_time, totaltime
% ave_time is average of time (in seconds)
% totaltime is total run time
% Number of bins in the current best known solution (BKS) is in the BPPModel, you
% can use this information to simulate the best parameter setting to find
% the minimum difference from BKS.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% 
clc;
clear;
close all;

%% Problem Definition 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%                 Don't change this                            
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Create the model
n=50;
classtype=7;
[bin,boxes]=generator(n,classtype);
% calculate minimal dimension and volume
mindim=intmax;
minvol=intmax;
for i=1:length(boxes)
    mindim=min([mindim,boxes(i).mindim]);
    minvol=min([minvol,boxes(i).vol]); 
end

%% Run times
% The run time can be changed 
% In the paper, we use 10 runs 

runtimes = 1; %10                          
                                                                       
%% Parameters setting 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% The parameters can be changed.                                          
% Stopping Criteria. In the paper we use 3000 iteration.
% Recommendation for BA: n = 40, m = 20, e = 8, nsp = 10, and nep = 40          
% Constrain to change the parameter: (e) must be lower than (m)     
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

MaxIt=3;                             % stopping criteria

% Bees Algorithm parameter
nScoutBee = 40;                         % Number of Scout Bees (n)
nBestSite= 20;                          % Number of Best Sites (m)
nEliteSite= 8;                          % Number of Elite Sites(e) 
nBestSiteBee = 10;                      % Number of Recruited Bees for Best Sites (nsp)
nEliteSiteBee= 40;                      % Number of Recruited Bees for Elite Sites (nep)

%% Bees Algorithm
BA;