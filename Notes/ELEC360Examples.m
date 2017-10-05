%% ELEC 360 -- Examples for Control Systems Theory and such
% 

syms t s
f = 2*exp(-t)-exp(-2*t)
laplace(f)
F = (s+3)/((s+1)*(s+2))
ilaplace(F)

F1 = (s^3+5*s^2+9*s+7)/((s+1)*(s+2))
ilaplace(F1)

% use help residue for partial fraction decomposition
num = [2 5 3 6]; % descending powers, highest to lowest
den = [1 6 11 6];
[r,p,k] = residue(num,den)

%% Creating control systems
sys = drss(3,2,2) % random
sys = dss(1,2,3,4,5,0.1,'inputname','voltage') % specific

num = {1 , [1 0.3]}
den = {[1 1 2] ,[5 2]}

% H has two functions multipicated together
H = filt(num,den,'inputname',{'channel1' 'channel2'})

% SISO FRD Model
freq = logspace(1,2);
resp = .05*(freq).*exp(i*2*freq);
sys = frd(resp,freq)

%Now we define an FRD model and its data is returned.
freq = logspace(1,2,2);
resp = .05*(freq).*exp(i*2*freq);
sys = frd(resp,freq);
[resp,freq] = frdata(sys,'v')

% The following example creates a 2-output/1-input transfer function:
num = {[1 1] ; 1}
den = {[1 2 2] ; [1 0]}
H = tf(num,den)

% The following example computes the transfer function for the following state-space model:
sys = ss([-2 -1;1 -2],[1 1;2 -1],[1 0],[0 1])
tf(sys)

% describe discrete time transfer functions
g = tf([1 1],[1 2 3],0.1)
h = tf([1 1],[1 2 3],0.1,'variable','z^-1')

%% Zeroes (z), Poles (p), Gain(k)
% Zero-Pole-Gain Model
z = {[] ; -0.5} % Zeroes
p = {0.3 ; [0.1+i 0.1-i]} % Poles 
k = [1 ; 2] % Gains
H = zpk(z,p,k,-1)

h = tf([-10 20 0],[1 7 20 28 19 5])
zpk(h)

%% Transfer functions
H = tf([1 -1],[1 4 5],'inputdelay',0.35)
Hd = c2d(H,0.1,'foh')
step(H,'-',Hd,'--')
pade(0.1,3) 

% System response
sys = zpk([-10 -20.01],[-5 -9.9 -20.1],1)
[sysb,g] = balreal(sys)
sysr = modred(sysb,[2 3],'del')
bode(sys,'-',sysr,'x')

a = [1 1e4 1e2; 0 1e2 1e5; 10 1 0];
b = [1; 1; 1];
c = [0.1 10 1e2];
sys = ss (a, b, c, 0)

% More transfer functions
H = tf([2 5 1],[1 2 3])
damp(H)
H = [1 tf([1 -1],[1 1 3]) ; tf(1,[1 1]) tf([1 2],[1 -3])]
dcgain(H)

% Another transfer function
H = tf([1 -2.841 2.875 -1.004],[1 -2.417 2.003 -0.5488],0.1)
norm(H)

[ninf,fpeak] = norm(H,inf)
bode (H)

%% Lotus Plots
h = tf([2 5 1],[1 2 3]);
rlocus (h)

rlocus(H)
zgrid
axis([-1 1 -1 1])
%% Matrix related formula

A = [1 1 2;3 4 0;1 2 5];
inv(A)

%% Control Systems Commands

sys1 = tf(1,[1 0])
sys2 = ss(1,2,3,4)
sys = append(sys1,10,sys2)

G = tf([2 5 1],[1 2 3],'inputname','torque',...)
'outputname','velocity');
H = zpk(-2,-10,5)
Cloop = feedback(G,H)	% Feedback loop

%% Square wave
[u,t] = gensig('square',5,30,0.1);
plot(t,u)
axis([0 30-1 2])

a = [-0.5572 -0.7814;0.7814 0];
c = [1.9691 6.4493];
x0 = [1 ; 0]
sys = ss(a,[],c,[]);
initial (sys, x0)

a = [-0.5572 -0.7814;0.7814 0];
b = [1 -1;0 2];
c = [1.9691 6.4493];
sys = ss(a,b,c,0);
step(sys)

g = tf([1 0.1 7.5],[1 0.12 9 0 0]);
bode (g)

H = tf([1 -1],[1 1 1],-1)
z = 1+j
evalfr(H,z)

%% Nichols chart, with grid
H = tf([-4 48 -18 250 600],[1 30 282 525 60])
nichols(H)
ngrid

a = [-3 2;1 1]; b = [0 ; 1]; c = [1 -1]; r = 3;
[x,l,g] = care(a,b,c'*c,r)

% Matrix Tools 
I = [eye(5,4) zeros(5,4) ones(5,4)]
% format rat  -- is useful