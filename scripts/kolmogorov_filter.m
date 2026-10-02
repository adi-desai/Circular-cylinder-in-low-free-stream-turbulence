
function [f_c, u1_filt] = kolmogorov_filter(f_sampling, u1_m, nu, tol)
% This function performs receursive digital filtering to calculate the
% appropriate low-pass cutoff frequency for filtering a velocity signal
% while preserving the small-scale information, based on the given parameters 
% 
% inputs:
    % % f_c: initial cutoff frequency (Hz), may be changed to being requested as user input in execution
    % f_sampling: sampling frequemcy used in measurement (Hz)
    % u1_m: time history of u velocity
    % nu: Kinemtic viscosity in SI units
    % tol: tolerance for the frequency ratio (<= 1e-3)
% outputs:
    % f_c: cutoff frequency derived after iterating
    % u_filt: velocity time history, low pass filtered below f_c


% initialize the loop
i = 1;  %iteration counter
delta = 1; % tolerance, initial value to execute the while loop

while delta > tol
 
% assign cutoff frequency for the current iteration
    if i == 1
         f_c = 10e3;    % initialization value
    else f_c = f_K;     % kolmogorov frequency from the last itearion
    end

% create low-pass fliter 
f_n = f_sampling/2;
[b, a] = butter(2, f_c/f_n, 'low');

% filter the u signal and also calculate mean
u1_filt= filter(b, a, u1_m);
U1 = mean(u1_m);    % mean of u_x

% calculate time rate of change of velocity
del_t = 1/f_sampling;   % time step
del_u1_del_t = diff(u1_filt)/del_t;

% dissipation rate, epsilon
epsilon = 15* nu* (U1^-2)* mean((del_u1_del_t).^2);

% kolmogorov scale, eta
eta = ((nu^3)/epsilon)^(1/4);

% kolmogorov frequency, f_K
f_K = U1/(2* pi* eta);

delta = (f_c - f_K)/f_K;

mat1(i, :) = [i, epsilon, eta, f_K, delta];

i = i+1;
end

f_c = f_K;              % iterated value

% create low-pass fliter 
f_n = f_sampling/2;
[b, a] = butter(2, f_c/f_n, 'low');

% filter the u signal
u1_filt= filter(b, a, u1_m);

end