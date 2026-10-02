
function[Lambda_x] = integral_length_scale_by_autocorr(u, del_t)
% This function calculates the streamwise integral length scale from the
% tiem history of streamwise velocity using autocorrelation-based definition
%
% Inputs:
    %  u: time history of streamwise velocity (m/s)
    % del_t: time step in velocity measurements (s)
% Outputs:
    % Lambda_x: Streamwise integral length scale (m)

U_bar = mean(u);    % mean velocity
u_f = detrend(u_f); % remove the linear trend

% for autocorrelation
N = numel(u_f);
tmax = del_t*N;
[dummy, lags] = xcov(u_f,u_f,N,'coef'); % 2-sided, normalized autocorrelation

% Get the 1-sided autocovariance function
R = dummy(N+1:end);
tLag =lags(N+1:end)*del_t;

% find the first zero crossing
indices = find(diff(R >0)~= 0)+1;
ind = indices(1);

% Integral time scale by integrating the area under the curve
T = trapz(tLag(1:ind),R(1:ind));

% Integral length scale
Lambda = T*U_bar;

end