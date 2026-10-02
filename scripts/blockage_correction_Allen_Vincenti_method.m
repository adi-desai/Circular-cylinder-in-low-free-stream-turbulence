% This script is to correct the measured drag force for effects of high
% bloackage for the 250mm cylinder.
% It uses the method from Allen and Vincenti (1944)

clearvars; clc
T_u = input('FST value? 006/ 051/ 076 \n \n');

if T_u == 006
        run_name = 'fst_006';
else if T_u == 051
        run_name = 'fst_051';
    else if T_u == 076
            run_name = 'fst_076';
        end
    end
end

% model and tunnel parameters
S = 0.248* 2.25;           % projected surface area
C = 3.00* 2.25;            % test section area
BR = S/C;                  % blockage ratio
AR = 2.25/0.248;           % aspect ratio

%% load and process data

cd C:\Users\flowcon_user\Desktop\docs_aditya\other_projects\cyl_fst_paper\
cd pressure_measurements;

cd 'files_mean coeff'
file_nm_1 = [run_name,'_cdcl.xls'];
data_1 = importdata(file_nm_1);

cd ../files_Re&U/
file_nm_2 = [run_name,'_Re&U.txt'];
data_2 = importdata(file_nm_2);


disp('Using: Allen and Vincenti''s method (1944)');

if T_u == 006
    data_1(31,:)=[]; data_2(31,:)=[]; % very small time sample
else end

for i = 1:size(data_1,1)
    Re_u    = data_1(i,1);
    C_d_u    = data_1(i,2);
    q_u     = data_2(i,3);
    
   C_d_c = C_d_u* (1- 2.4674*(BR^2) -0.5*C_d_u* BR);
   data_2(i,4) = C_d_c;
   data_2(i,5) = 100*abs(C_d_c/C_d_u -1); % percentage error
    
    q_c = q_u*C_d_u/C_d_c;
    Re_c = Re_u*sqrt(q_c/q_u);
    
   mat_out_2(i,:) = [Re_c, C_d_c];
end

%% plotting

clf;
plot(data_1(:,1), data_1(:,2), '-b.'); hold on
plot(mat_out_2(:,1), mat_out_2(:,2), '-r.'); hold off

ylabel('$\overline{C}_d$','Interpreter','latex');
xlabel('$Re$','Interpreter','latex');
leg1 = legend('measured', 'corrected for blockage');
set(leg1, 'box', 'off');

set(gca,'fontname','times new roman', 'fontsize',10, 'box','on',...
    'Xgrid','on', 'Ygrid','on', 'Xminortick','on', 'Yminortick','on',...
    'layer','top', 'PlotboxAspectratio',[1.4 1 1],...
    'Xlim',[1e5 6e5], 'Ylim',[0 1.2]);
set(gcf,'Units','centimeters','position',[2 4 12 8]);

%% save plot?

% cd ../..
% set(gcf,'renderer','painters');
% nm_str=[run_name(1:end-1), 'Cd_vs_re_blockage_correction'];
% print(gcf,nm_str,'-depsc','-r1200');
% print(gcf,nm_str,'-dpng','-r1200');

%% save the corrected data

% array with corrected Re and Cd
data_out = mat_out_2;
% create headers
headers ={'% Re', 'Cd_corrected'} ;
% combine into cells
output_1 = [headers; num2cell(data_out)];

% creat file name and write
file_out_1 = [file_nm_1(1:end-4),'_corrected_AnV.txt'];
writecell(output_1, file_out_1,'Delimiter','tab');

% read these files using readcell and then cell2mat functions