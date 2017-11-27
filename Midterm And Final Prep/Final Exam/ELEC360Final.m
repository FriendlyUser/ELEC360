%% ELEC 360 Final Exam Prep
% Will focus on the latter half of the course and the Nise textbook
% examples I haven't gone through yet.
%% Numbered List of sections to study
% 
% # Bode Plot, Frequency Domain Plots, Root Locus
% # Designing a control system with resistances and capactiance values
% # Compute Phase And Gain Margin
%% Notes
%  [Gm,Pm,Wcg,Wcp] = margin(SYS) computes the gain margin Gm, the phase 
%  margin Pm, and the associated frequencies Wcg and Wcp, for the SISO 
% open-loop model SYS (continuous or discrete). 
clear all
close all
addpath('MatlabFiles/')  
%% Examples from Schaum's Outline of Feedback and Control Systems
%
% $\frac{1}{s+1}$
G = tf([1],[1,1])
% Using data cursor is quite helpful
nyquist(G)
%%
% $\frac{1}{s^3(s+1)}$
G2 = tf([1],[1,1,0,0,0])
nyquist(G2)
%% Bode Plots
% $$\frac{100(1+j\omega/10)}{1+j\omega}$$
G3 = tf([1],[1,1])
bode(G3)
G4 = tf([10,100],[1,1])
bode(G4)
BodePlotGui(G4)
figure
% Another plot
G5 = tf([100,0],[1/10,1])
bode(G5)
%% Examples from Nise
% 
G6 = tf([1],[1,6,8])
bode(G6)
BodePlotGui(G6)
figure
%
nyquist(G6)
G7 = tf([1,3],[1 3 2 0])
bode(G7)
BodePlotGui(G7)
figure
%% 
% Example 10.3 Nise
syms s 
P5 = (s+2)*(s^2+2*s+25)
poly = sym2poly(P5)
G8 = tf([1 3],poly)
bode(G8)
%% 
% example 10.5 Nise
clear all
close all
G1 = tf([1,2],[1,0,0])
nyquist(G1)

%%
% example 10.5 solved using Nise textbook, with range of omega
numg=[1 2]; % Define numerator of G(s).
deng=[1 0 0]; % Define denominator of G(s).
G111=tf (numg, deng) % Create and display G(s).
nyquist(G111) % Make a Nyquist diagram.
w=0:0.5:10; % Let 0 <w< 10 in steps of 0.5.
[re,im]=nyquist(G111,w); % Get Nyquist diagram points for a
% range of w.
points=[re(:,:)', im(:,:)',w']
%%
% TryIt 10.2
G=zpk([-3, -5],...
    [2,4],1)
nyquist(G)

% Skill-Assessment Exercise 10.3
G1=zpk([],...
    [-2,-4],1)
nyquist(G1)
%%
% More Nyquist examples
% Example 10.6
G2 = zpk([],...
    [0,-3,-5],1)
P = nyquistoptions;
P.ShowFullContour = 'on';
P.Xlim = [-0.1,0.1];
P.Ylim = [-1,1];
h = nyquistplot(G2,[],P);
%axis([-0.2 5],[-2,2])
% Example 10.7
G3 = zpk([], ...
    [-1+j,-1-j,-2],1)
nyquist(G3)

%%
% Self-assignment Excerise 10.4
G4 = zpk([],...
    [-2,-4,-6],1)
nyquist(G4)
% see https://www.wolframalpha.com/input/?i=(iw-2)*(iw-4)*(iw-6)%3D0
% Skill-Assessment Excerise 10.5, computing phase margin and gain margin 
margin(G4) 
%%
% # Right-click in the graph area.
% # Select Characteristics.
% # Select All Stability Margins.
% # Let the mouse rest on the margin points to read the gain and phase margins.
%%
% answer is $$ K < 480, \quad w = \sqrt(44) $$
%%
% Example 10.8
numg=6; % Define numerator of G(s).
deng=conv ([1 2],[1 2 2]); % Define denominator of G (s).
G=tf (numg, deng) % Create and display G (s).
nyquist(G) % Make a Nyquist diagram.
grid on % Turn on grid for the Nyquist
% diagram.
title ('Open-Loop Frequency Response')
% Add a title to the Nyquist
% diagram.
[Gm,Pm,Wcg,Wcp]=margin(G); % Find margins and margin % frequencies. 'Gm(dB); Pm(deg.); 180 deg. freq.(r/s); 0 dB freq. (r/s)’
% Display label.
margins=[20*log10(Gm),Pm,Wcg,Wcp]
% Display margin data.
bode(G)