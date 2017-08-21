clc; clear; //clears the console and all previously stored variables

function sigma = BS_EuCall_Calibrate (S0, r, T, K, V, sigma0)
    // Calculating Call option value at time t=0 with BS formula (3.23)
    function V0 = BS_EuCall (S0, r, T, K, sigma)
        // Using scilab function to calculate prob. of a std. norm.
        function p = Phi(x)
            p = cdfnor("PQ", x, zeros(x), ones(x));
        endfunction
        // Defining all used formuals in the BS_Call option
        d1 = (log(S0./K) + (r+1/2*sigma^2).*T) ./ (sigma.*sqrt(T));
        d2 = d1 - sigma.*sqrt(T);
        V0 = S0.*Phi(d1)-K.*exp(-r.*T).*Phi(d2);
    endfunction
    // Defining Loss function as in (4.17)
    function e = l (sigma, S0, r, T, K, V)
        e = BS_EuCall(S0, r, T, K, sigma) - V;
    endfunction
    // Minimizing the Loss function with leastsq
    [f, sigma] = leastsq(list(l, S0, r, T, K, V), sigma0);
endfunction

// Data is read, ";" is the separator, "," is the decimal, and [1] tells that
// first row is the header and is ignored
data = csvRead('Dax_CallPrices_Eurex20170601.csv',";",",","",[],[],[],[1]);
// Extracting strike prices from the dataframe
K = data(:,1);
// Extracting time to maturity T from the dataframe
T = data(:,2);
// Extracting the give option prices from the dataframe
V = data(:,3);
// Setting all other values
S0 = 12658; r = 0; sigma0 = 0.3;
// Calling the calibration function to get the optimal sigma
sigma = BS_EuCall_Calibrate (S0, r, T, K, V, sigma0)
disp("Optimal calibrated sigma for given data is: "+string(sigma))
