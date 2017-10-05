%% ELEC 360 --- Assignment 1
% All matlab code and calculations will be verified using matlab
% even though I have the solutions manual lol.
% "Global Variables" --- Used in multiple questions
syms s t w a
format compact
clear all
close all
%% Question 1 (A) -- Laplace Transforms
f1 = t^2
laplace(f1)
f2 = sin(w*t)
laplace(f2)

%% Question 1 (B) -- Inverse Laplace Transforms
F1 = 1 /(s+a)^2
ilaplace(F1)        % i)
F2 = (s+a)/((s+a)^2)+w^2    % prof messed up the question
ilaplace(F2)        % ii)
F3 = (s+3)/(s+1)^3  % iii)
F3 = partfrac(F3)
ilaplace(F3)

%% Question 2 --- Transfer function of electric circuit
syms R1 R2 L C i1 i2 ei eo
ei = R1*i1+L*diff(i1-i2)
laplace(ei)
eo = -1/C*int(i2)
laplace(eo) % ill-suited for matlab, just looked at the solutions manual, 

%% Question 7 B-5-10
% Remember that the ramp response is the integral of the step response. 
% Thus, you can multiply the step response by 1/s and you get the ramp.
figure
s = tf('s');
C = 10;
R = s^2+2*s+10;
step(C/R)   % Step response
print('Images/Q7Step','-dpng','-r300')
%%
% ramp response 
%use help timeoptions 
figure
h = stepplot(C/(R*s));
p = getoptions(h);
p.Title.String =('Unit-Ramp Response');
p.Ylim  = [0 10];
p.Xlim  = [0 10];
setoptions(h,p);
print('Images/Q7Ramp','-dpng','-r300')

%% Ramp response following ogata methodology
t = 0:0.02:10;
num1 = [10];
den1 = [1 2 10 0];
y1 = step(num1,den1,t);
plot(t,t,'--',t,y1)
v = [0 10 0 10]; axis(v);
grid
title('Unit-Ramp Response')
xlabel('t (sec)')
ylabel('Unit-Ramp Input and Output')
text(6.1,5.0,'Unit-Ramp Input')
text(3.5,7.1,'Output')
print('Images/Q7RampOgata','-dpng','-r300')
%%
% impulse response
figure
h = impulseplot(C/R);
p = getoptions(h);
p.Title.String =('Impulse Response');
setoptions(h,p);
print('Images/Q7Impulse','-dpng','-r300')

%% Question 8, using matlab for computation
% ------- This program is to plot the unit-step response curve, as well as to
% find the rise time, peak time, maximum overshoot, and settling time.
% In this program the rise time is calculated as the time required for the
% response to rise from 10% to 90% of its final value. -------
% it seems that the sample time must be less than zeta to get the "right
% answer" I'm sure this makes sense somehow.
% wn = 5, zeta = 1 /6
num = [0 0 36];
den = [1 2 36];
t = 0:0.001:5;
[y,x,t] = step(num,den,t);
plot(t,y); grid;
title('Unit-Step Response')
xlabel('t (sec)')
ylabel('Output y(t)')
print('Images/Q8Step','-dpng','-r300')
%%
% calculate rise time, how long it takes to get to the final value of 1
r1 = 1; while y(r1) < 1.0001, r1 = r1+1; end;  
rise_time = (r1-1)*0.001
[ymax,tp] = max(y);
% The peak time is the time required for the response to reach the first peak of the overshoot.
peak_time = (tp-1)*0.001
% The maximum overshoot is the maximum peak value of the response curve measured from unity. 
max_overshoot = ymax-1
% The settling time is the time required for the response curve to
% reach and stay within a range about the final value of size specified by absolute percentage of the final value
% (usually 2% or 5%)
s = 5001; while y(s) > 0.98 & y(s) < 1.02; s = s-1; end;
settling_time = (s-1)*0.001
%% Question 9
% For a LTI system to be stable, it is sufficient that its transfer 
% function has no poles on the right semi-plane.
% See https://en.wikipedia.org/wiki/Routh%E2%80%93Hurwitz_stability_criterion
syms s 
K = 7
eqn = s^4 + 2*s^3 + (4+K)*s^2+9*s+25;
roots(sym2poly(eqn))
polyVector = sym2poly(eqn)
RouthHurwitz(polyVector)
rHTable =RouthHurwitz(polyVector)
%matrix2latex(rHTable, 'table.tex')
rowLabels = {'$s^4$', '$s^3$','$s^2$','$s^1$', '$s^0$'};
matrix2latex(rHTable, 'RHTable.tex','rowLabels', rowLabels, 'alignment', 'c', 'format', '%-6.2f', 'size', 'large')
%%
% 
syms K
(9*(2*K-1)/2-2*25)/(2*K-1/2)
%% Answer is K =11 , could be a decimal value
for K =4:1:14
    roots(sym2poly(eqn))
    eqn = s^4 + 2*s^3 + (4+K)*s^2+9*s+25;
    polyVector = sym2poly(eqn)
    rHTable =RouthHurwitz(polyVector)
end

