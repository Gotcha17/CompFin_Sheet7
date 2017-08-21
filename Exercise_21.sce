clc; clear; //clears the console and all previously stored variables

function [V0, c1, c2] = EuOption_BS_MC (S0, r, sigma, T, K, M, g)
    // Computing the 95% confidence intervals for the european option price 
    // via the MC approach
    V_(:) = g(S0*exp((r-sigma^2/2)*T+sigma*grand(M, 1, "nor", 0, sqrt(T))))*exp(-r*T);
    V0 = mean(V_);
    var_hat = M/(M-1)*mean(V_^2-V0^2)
    c1=V0-1.96*sqrt(var_hat/M);
    c2=V0+1.96*sqrt(var_hat/M);
endfunction

// Defining the european put function
function y = g(x)
    y = max(K-x, 0)
endfunction

K=100; S0=95; r=0.05; sigma=0.2; T=1; M=100000;

[V0, c1, c2] = EuOption_BS_MC (S0, r, sigma, T, K, M, g)

disp("Value of an european put computed with MC approach is: "+string(V0))
disp("The 95% CI is : ["+string(c1)+" , "+string(c2)+"]")
