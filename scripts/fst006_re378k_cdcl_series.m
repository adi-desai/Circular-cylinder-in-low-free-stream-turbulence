clearvars; close all; clc;
cd ../../pressure_measurments/
addpath scripts;

cd files_coeff_series; cd fst006_1\
a=importdata('Re377487.txt'); cd ../..
t1=a(:,1); cd1=a(:,2); cl1=a(:,3);

%% plotting
clf;
set(gcf,'units','centimeters','Position',[3,5 8.5,5]);
ax1=subplot(211); ax1.Position=[0.15,0.6,0.81,0.35];
plot(t1,cd1,'-b'); ylabel('$C_d$','interpreter','latex'); ylim([.5 1]);
tit1=title('(a)','fontweight','normal');
set(tit1,'Units','normalized','Position',[-0.12,0.9,0]);
ax2=subplot(212); ax2.Position=[0.15,0.21,0.81,0.35];
plot(t1,cl1,'-r'); ylabel('$C_l$','interpreter','latex');
xlabel('$t(s)$','interpreter','latex'); ylim([-1 1]);
tit2=title('(b)','fontweight','normal');
set(tit2,'Units','normalized','Position',[-0.12,0.9,0]);

set(findobj(gcf,'type','axes'),'xlim',[70 80],'xgrid','on','ygrid','on',...
'xminortick','on','yminortick','on','box','on','layer','top', ...
'fontname','times new roman','fontsize',10);
ax1.XTickLabel=[];

%% saving
cd ../manuscript_prf/figures/;
set(gcf,'Renderer','painters');
print(gcf,'fst006_re378k_cdcl_series','-depsc','-r1200');
cd ../figure_codes