clearvars; close all; clc;
% cd ../../../
cd C:\Users\flowcon_user\Desktop\docs_aditya\other_projects\cyl_fst_paper;
cd pressure_measurements/
addpath scripts;

run='fst006_1';
cd 'files_mean cp'; 
a = readtable('fst006_1_cpbar.txt'); a = table2array(a); cd ..;
cd files_design; theta=load('Theta_middle.txt'); cd ..;

%% plotting
i1=42; i2=55; %fst006
cpbar1=a(i1,50:97); cpbar1(1,49)=cpbar1(1,1); 
Re1=a(i1,1); Re_star_1=Re_to_Restar_converter(run,Re1);
cpbar2=a(i2,50:97); cpbar2(1,49)=cpbar2(1,1);
Re2=a(i2,1); Re_star_2=Re_to_Restar_converter(run,Re2);

% % strings for legend
% str1=['$Re^*=',num2str(Re_star_1,3),'$'];
% str2=['$Re^*=',num2str(Re_star_2,3),'$'];
str1=['$\beta=',num2str(Re_star_1,3),'$'];
str2=['$\beta=',num2str(Re_star_2,3),'$'];

clf;
mk_sz=3;
set(gcf,'Units','centimeters','Position',[5 2 17 5.5]);

% subfig 1
ax1=subplot(121); ax1.Position=[0.09,0.18,0.37,0.68];
ct=ones(1,49);
plot(theta,cpbar1.*ct,'-','markersize',mk_sz); hold on; 
plot(theta,cpbar2.*ct,'-','markersize',mk_sz); hold off;
ylim([-3.5 1]); ylabel('$\overline{C}_p$','interpreter','latex');
xlabel('$\theta (^o)$','interpreter','latex'); 
tit1=title('(a)','fontweight','normal');
set(tit1,'Units','normalized','Position',[-0.15,0.9,0])

% subfig 2
ax2=subplot(122);  ax2.Position=[0.57,0.18,0.37,0.68];
ct=cosd(theta'); 
plot(theta,cpbar1.*ct,'-','markersize',mk_sz); hold on; 
plot(theta,cpbar2.*ct,'-','markersize',mk_sz); hold off;
ylim([-1 1]); ylabel('$\overline{C}_p cos \theta$','interpreter','latex');
xlabel('$\theta (^o)$','interpreter','latex'); 
tit2=title('(b)','fontweight','normal');
set(tit2,'Units','normalized','Position',[-0.15,0.9,0])

leg=legend(str1,str2); 
set(leg,'box','off','NumColumns',2,'Position',[0.38,0.9,0.28,0.1],...
    'interpreter','latex');

% set figure attributes
set(findobj(gcf,'type','axes'),'xlim',[0 360],'XTick',[0 90 180 270 360],...
    'xgrid','on',    'ygrid','on','xminortick','on','yminortick','on',...
    'layer','top', 'FontName','times new roman','FontSize',10);

%% saving

% cd ../manuscript_nov2022/figures/
cd C:\Users\flowcon_user\Desktop\docs_aditya\other_projects\cyl_fst_paper\

set(gcf, 'Renderer','painters');
nm_str = 'supercritical_lsb_vanish_v2'; 
clipboard('copy', nm_str);

cd figures; print(gcf, nm_str, '-depsc', '-r1200');
cd ../fig_matlab_format/; saveas(gcf, [nm_str,'.fig'])
cd ..
% cd codes;
