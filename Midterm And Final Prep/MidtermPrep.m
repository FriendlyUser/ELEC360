%% Midterm PREP Script
% Chapter 6 --- Stabability Question 1, Nise Textbook
%% 
% s^5 +3s^4+5s^3 + 4s^2+s+3
polyVector = [1 3 5 4 1 3]
RouthHurwitz(polyVector)

%%
% Q2
v2 = [1 0 6 5 8 20]
RouthHurwitz(v2)

%%
syms s
(s+1)*(s+2)*(s+3)*(s+4)
%%
% syms a b c EPS;
syms a b c EPS;
ra=routh([1 a b c],EPS);

%% Question 12
% K(s+2)/s(s-1)(s+3)
syms s K EPS;
ra2 = routh([1 2 K-3 2],EPS)

%% Quesition 20
ra3 = routh([K+1 3 2+K],EPS)

%% Question 21
ra4 = routh([1 5 4+K 6*K],EPS)
% solve(4 - K/5==0)
% solve((6*K*(K - 20))/(5*(K/5 - 4))==0)

%% Question 22
syms a b c EPS;
ra5 = routh([1 K-b -a],EPS

%% Example 7.2 from Nise
syms s
G(s) = 120*(s+2)/((s+3)*(s+4))
CSlashR = simplify(G(s)/(1+G(s)))
polyVector = [1 127 252]
routh([1 127 252],EPS)
limit(G(s),s,0)
limit(s*G(s),s,0)

limit(s^2*G(s),s,0)

%% Example 7.3 from Nise
syms s
G(s) =100*(s+2)*(s+6)/(s*(s+3)*(s+4))
CSlashR = simplify(G(s)/(1+G(s)))
polyVector = [1 107 812 1200]
routh(polyVector, EPS)
%R(s) = 5*1/s
limit(5/(1+G(s)),s,0)
%%

%% Example 7.4 from Nise
G(s) = 10*(s+20)*(s+30)/((s*(s+25)*(s+35)))
CSlashR = simplify(G(s)/(1+G(s)))
polyVector = [1 70 1375 600]
routh(polyVector, EPS)

%%
G(s) = 10*(s+20)*(s+30)/((s^2*(s+25)*(s+35)*(s+50)))
CSlashR = simplify(G(s)/(1+G(s)))
polyVector = [1 110 3875 43760 500 6000]
routh(polyVector, EPS)

%% 
% 
G1(s) = 500*(s+2)*(s+5)/((s+8)*(s+10)*(s+12))
G2(s) = 500*(s+5)*(s+5)*(s+6)/(s*(s+8)*(s+10)*(s+12))
G3(s) = 500*(s+2)*(s+4)*(s+5)*(s+6)*(s+7)/(s^2*(s+8)*(s+10)*(s+12))
Func1 = (simplify(G1(s)/(1+G1(s))))
Func2 = (simplify(G2(s)/(1+G2(s))))
Func3 = (simplify(G3(s)/(1+G3(s))))

%%
%
[n1,d1] = numden(Func1)
routh(sym2poly(d1), EPS)
[n2,d2] = numden(Func2)
routh(sym2poly(d2), EPS)
[n3,d3] = numden(Func3)
routh(sym2poly(d3), EPS)

Kp = limit(G1(s),s,0)
Kv = limit(s*G2(s),s,0)
Ka = limit(s^2*G3(s),s,0)

%%
% Try
numg=1000*[1 8];
deng=poly([-7 -9]);
G=tf(numg,deng);
Kp=dcgain(G)
estep=1/(1+Kp)
T=feedback(G,1);
poles=pole(T)
