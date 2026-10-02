% updating spectral plots with:
    % kolmogorov filering to remove high f noise
    % directly from data_u
    % normalized spectra, according to Romblad_EiF_2022

clearvars; clc

% change to data directory
cd C:\Users\flowcon_user\Desktop\docs_aditya\other_projects\cyl_fst_paper;
cd turbulence_measurements\cta_nov_2023\files_raw

% measurement parameters
f_sampling = 30e3;  % sampling frequency
del_t = 1/f_sampling;   % time step

% PSD parameters
% n_window = 2^(nextpow2(10*f_sampling)-3);
n_window = 2^(nextpow2(2*f_sampling));
n_overlap = n_window/2;
SPECTRUMTYPE = 'power';

%% FST 076

file_no = 3;                % U ~ 10 m/s
run1 = 'x1396mm_g1_off0';   % FST 076
cd (run1);

% load the the file containing the ambient temperatures
data_2 = load('u_Eoff_Ta.txt');
T_ambient = data_2(file_no, 3);      % Mean ambient temperature during the measurement

% load voltage and convert
cd data_u; 
files_array_1= dir('*.txt');
file_1 = files_array_1(file_no); 
data_3 = importdata(file_1.name);
cd ../..

u1_m = data_3(:,2);
U1_bar = mean(u1_m);    % mean of u_x
u1_rms = std(u1_m); % rms of u_x

% From mean ambient temperature, calculate kinematic viscosity
nu = viscosity_calculator(T_ambient);   % Kinematic viscosity

% receursive digital filtering to calculate the appropriate f_c and
% low-pass filter below it
[~, u1_filt] = kolmogorov_filter(f_sampling, u1_m, nu, 1e-5);

% calculate power spectral density for the normalized signal
[pxx_076,f1] = pwelch(detrend(u1_filt)/U1_bar, n_window, n_overlap, [], f_sampling, SPECTRUMTYPE);
Exx_076 = pxx_076/f_sampling;

%% FST 051

run2='x2576mm_g1_off0';    % FST 051
cd (run2);

% load the the file containing the ambient temperatures
data_2 = load('u_Eoff_Ta.txt');
T_ambient = data_2(file_no, 3);      % Mean ambient temperature during the measurement

% load voltage and convert
cd data_u; 
files_array_1= dir('*.txt');
file_1 = files_array_1(file_no); 
data_3 = importdata(file_1.name);

% get velocity signal and process further
u2_m = data_3(:,2);
U2_bar = mean(u2_m);    % mean of u_x
u2_rms = std(u2_m); % rms of u_x

% read mean ambient temperature and calculate kinematic viscosity
T_ambient = data_2(file_no, 3);      % Mean ambient temperature during the measurement
nu = viscosity_calculator(T_ambient);   % Kinematic viscosity

% receursive digital filtering to calculate the appropriate f_c and
% low-pass filter below it
[~, u2_filt] = kolmogorov_filter(f_sampling, u2_m, nu, 1e-5);

% calculate power spectral density
[pxx_051,f2] = pwelch(detrend(u2_filt)/U2_bar, n_window, n_overlap, [], f_sampling, SPECTRUMTYPE);
Exx_051 = pxx_051/f_sampling;

%% plotting

lambda_x_1 = 0.06;
lambda_x_2 = 0.09;

% line segment with slope -5/3
% dum1 = 200:1:2000; dum2 = .003*dum1.^(-5/3);
dum1 = 2:1:20; dum2 = (1e-6)*dum1.^(-5/3);

clf;
loglog(f1* lambda_x_1/U1_bar, (U1_bar/(u1_rms^2* lambda_x_1)) *Exx_051); hold on
loglog(f2* lambda_x_2/U2_bar, (U2_bar/(u2_rms^2* lambda_x_2)) *Exx_076);
loglog(dum1,dum2,'color',[0.47, 0.67, 0.19],'LineStyle',':','LineWidth',1.5); 
hold off;
xlabel('$f \Lambda_x /U_{\infty}$ ', 'interpreter','latex'); 
ylabel('$(E_{uu} \overline{U}_{\infty})/(\overline{u''^2} \Lambda_x) $', 'interpreter','latex');
% set(gca,'PlotBoxAspectRatio', [1 1 1]);

set(gca,'FontName','Times New Roman','fontsize',10,...
    'XGrid','on','YGrid','on','box','on','Layer','Top',...
    'Ylim',[1e-13 1e-5],'Xlim',[0 200])%,'XTick',[1e0 1e1 1e2 1e3 1e4]); 
set(gca, 'Position',[.145 .145 .77 .78]);
set(gcf,'Units','centimeters','Position',[3 3 12 8]);
leg1 = legend('$T_u = 0.51\%$', '$T_u = 0.76\%$');
set(leg1,'box','off', 'interpreter','latex');

%%
cd C:\Users\flowcon_user\Desktop\docs_aditya\other_projects\cyl_fst_paper;

set(gcf,'renderer','painters');
print(gcf,'u_spectra_diff_Tu_v3','-depsc','-r1200');
