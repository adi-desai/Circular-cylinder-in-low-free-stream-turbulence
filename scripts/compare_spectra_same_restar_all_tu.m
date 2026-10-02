clearvars; clc;

% set parameters
re_star = 0;

cd C:\Users\flowcon_user\Desktop\docs_aditya\other_projects\cyl_fst_paper;
cd pressure_measurements\'files_Re&U';

% load files containing re_star and re for each Tu
temp_1 = readcell('fst_006_Re&U.txt'); data_1 = cell2mat(temp_1(2:end,:));
temp_1 = readcell('fst_051_Re&U.txt'); data_2 = cell2mat(temp_1(2:end,:));
temp_1 = readcell('fst_076_Re&U.txt'); data_3 = cell2mat(temp_1(2:end,:));

% find indices of files corresponding to re_star = 0 for each Tu
ind_fst006 = find(data_1(:,4)== re_star);
ind_fst051 = find(data_2(:,4)== re_star);
ind_fst076 = find(data_3(:,4)== re_star);

% extract U_inf for each case
U_bar_fst006 = data_1(ind_fst006, 2);
U_bar_fst051 = data_2(ind_fst051, 2);
U_bar_fst076 = data_3(ind_fst076, 2);

%%
cd ../files_coeff_series/

cd fst_006; 
temp_2 = dir('*.txt');  % list of all files
temp_3 = temp_2(ind_fst006); % file at the desired index
temp_4 = importdata(temp_3.name); % load the file
cd_fst006 = temp_4(:, 2); 
cl_fst006 = temp_4(:, 3); 
cd ..

cd fst_051; 
temp_2 = dir('*.txt');  % list of all files
temp_3 = temp_2(ind_fst051); % file at the desired index
temp_4 = importdata(temp_3.name); % load the file
cd_fst051 = temp_4(:,2);
cl_fst051 = temp_4(:,3);
cd ..

cd fst_076; 
temp_2 = dir('*.txt');  % list of all files
temp_3 = temp_2(ind_fst076); % file at the desired index
temp_4 = importdata(temp_3.name); % load the file
cd_fst076 = temp_4(:, 2);
cl_fst076 = temp_4(:, 3);
cd ..

cd ..\..
%% pwelch and plot

f_sampling = 500;
n_window = 2^(nextpow2(10*f_sampling));
n_overlap = n_window/2;
SPECTRUMTYPE = 'power';

clf;
% subplot 1: spectra of C_d
ax_1 = subplot(121);

[pxx1,f1] = pwelch(detrend(cd_fst006), n_window, n_overlap, [], f_sampling, SPECTRUMTYPE); 
[pxx2,f2] = pwelch(detrend(cd_fst051), n_window, n_overlap, [], f_sampling, SPECTRUMTYPE); 
[pxx3,f3] = pwelch(detrend(cd_fst076), n_window, n_overlap, [], f_sampling, SPECTRUMTYPE);

semilogy(f1*.25/U_bar_fst006, pxx1, 'b'); hold on;
semilogy(f2*.25/U_bar_fst051, pxx2, 'r');
semilogy(f3*.25/U_bar_fst076, pxx3, 'color',3*[0.1, 0.1, 0.1]); hold off;
ylabel('Power $(dB)$', 'Interpreter', 'latex');
% xlabel('$f(Hz)$', 'Interpreter', 'latex');
xlabel('$St$', 'Interpreter', 'latex');  

leg1 = legend('$T_u = 0.06\%$', '$T_u = 0.51\%$', '$T_u = 0.76\%$');
set(leg1, 'box', 'off', 'Interpreter','latex', 'Location','southwest');

tit_1 = title('(a)');
set(tit_1, 'Fontweight','normal', 'Units','normalized',...
    'Position',[-0.12 0.95 0]);

% subplot 1: spectra of C_l
ax_2 = subplot(122);

[pxx4,f1] = pwelch(detrend(cl_fst006), n_window, n_overlap, [], f_sampling, SPECTRUMTYPE); 
[pxx5,f2] = pwelch(detrend(cl_fst051), n_window, n_overlap, [], f_sampling, SPECTRUMTYPE); 
[pxx6,f3] = pwelch(detrend(cl_fst051), n_window, n_overlap, [], f_sampling, SPECTRUMTYPE);

semilogy(f1*.25/U_bar_fst006, pxx4, 'b'); hold on;
semilogy(f2*.25/U_bar_fst051, pxx5, 'r');
semilogy(f3*.25/U_bar_fst076, pxx6, 'color',3*[0.1, 0.1, 0.1]); hold off;
% xlabel('$f(Hz)$', 'Interpreter', 'latex');
xlabel('$St$', 'Interpreter', 'latex'); 

tit_2 = title('(b)');
set(tit_2, 'Fontweight','normal', 'Units','normalized',...
    'Position',[-0.1 0.95 0]);

%% set figure parameters

set(findobj(gcf, 'type','axes'), 'fontname','times new roman', 'fontsize',10,...
    'box','on', 'Xgrid','on', 'Ygrid','on', 'Xminortick','on',...
    'Yminortick','on', 'Xlim',[0 3], 'Ylim',[1e-9 1e-1], 'Xscale','log');
set(gcf,'Units','centimeters','position',[2 4 17 8]);

ax_2.YTickLabel = [];
ax_1.Position = [0.13, 0.15, 0.38, 0.78];
ax_2.Position = [0.58, 0.15, 0.38, 0.78];

%% saving
% cd ../manuscript_prf/figures/;
cd C:\Users\flowcon_user\Desktop\docs_aditya\other_projects\cyl_fst_paper\

set(gcf,'renderer','painters');
nm_str='coeff_spectra_at_restar_zero_all_tu'; 
clipboard('copy',nm_str); 

cd figures; print(gcf, nm_str, '-depsc', '-r1200');
cd ../fig_matlab_format/; saveas(gcf, [nm_str,'.fig'])
cd ..

