clc; clear; //clears the console and all previously stored variables

// Defining function Sample_Beta_AR with one output and three inputs
function X = Sample_Beta_AR (alpha1, alpha2, N)
    // For-loop for 1 to N iterations with default stepsize 1.
    for i=1:N
        // Generating two independent uniformly distributed variables
        U1 = rand(1,1);
        U2 = rand(1,1);
        // Generating U1 and U2 r.v. as long as the equality holds (rejection)
        // Setting x = 1/2 since it maximizes the beta distribution
        // Accepting U1 r.v. as beta distrubuted r.v. when equality does not
        // hold anymore (acceptance)
        while U2 > (0.5^(alpha1+alpha2-2))^(-1)*(U1^(alpha1-1)*(1-U1)^(alpha2-1)) 
            U1 = rand(1,1);
            U2 = rand(1,1);
        end
        // vector of N beta distributed random variables
        X(1,i) = U1;
    end
endfunction

// Setting predefined values
alpha1=2; alpha2=3; N=2000;
// Calling Sample_Beta_AR function with predefined values
X = Sample_Beta_AR (alpha1, alpha2, N)
//Selecting figure one
scf(0)
// Clearing selected figure
clf()
// Plotting X vector with N beta distributed r.v. in a histogram with 50 bars
histplot(50, X)
