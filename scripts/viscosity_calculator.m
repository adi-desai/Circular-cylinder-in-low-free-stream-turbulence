
function [nu, rho] = viscosity_calculator(T_ambient)
% This function calculates Re given U , T and d. It also works if T is not
% specified.
% Inputs: T_ambient (deg C)
% Output: kinematic viscosity (nu and density(rho) in SI units

% Load air table for interpolation
if exist ('C:\Users\flowcon_user\Documents\MATLAB\Projects\ELGPC\data\pinball\Air Table.txt')==0
      temp_data=load('Z:\PinBall_Aditya\pinball_experiments\scripts\matlab_functions\Air Table.txt');
else
      temp_data=load('C:\Users\flowcon_user\Documents\MATLAB\Projects\ELGPC\data\pinball\Air Table.txt');
end

%extract the necessary data
temperature = temp_data(:,1); 
viscosity   = (1e-5)*(temp_data(:,2)); 
density     = temp_data(:,3);

% check if T is provided by the user or not
if nargin == 2
    % temperature not specified. Assign manually.
    lengthscale = T_ambient;    % second input is the lengthscale
    T_ambient = 19.7; % such that rho = 1.20 and nu = 1.5e-5
else end

% interpolate
rho = interp1(temperature,density,(T_ambient+273.15)); % density, kg/m^3
mu  = interp1(temperature,viscosity,(T_ambient+273.15));  % absolute (dynamic) viscosity

% calculate Re
nu  = mu/rho; % kinematic viscosity

end