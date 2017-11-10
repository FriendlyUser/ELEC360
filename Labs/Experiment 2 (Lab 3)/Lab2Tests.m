
ki = [5,10,15,20]
zeta = 0.5
K = 19.9


for i=1:4
    num = [K*ki(i)]
    den = [0.093 1 K*ki(i)]
    figure
    step(num,den)
end