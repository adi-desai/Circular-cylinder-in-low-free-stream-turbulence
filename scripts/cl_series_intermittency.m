clearvars; close all; clc;
cd ../../../pressure_measurments/
addpath scripts;

cd 'files_coeff_series'
cd fst006_1; dat1=load('Re377487.txt'); cd ..;
cd fst040_1; dat2=load('Re243778.txt'); cd ..
cd fst062_2; dat3=load('Re173489.txt'); cd ../..

%% plotting
t1=(24.22/0.248)*dat1(:,1); cl1=dat1(:,3); 
t2=(16.05/0.248)*dat2(:,1); cl2=dat2(:,3); 
t3=(11.22/0.248)*dat3(:,1); cl3=dat3(:,3);

clf;
ax1=subplot(311); plot(t1,cl1,'b'); ylabel('$C_l$','interpreter','latex'); ylim([-1 1]);
tit1=title('(a)','fontweight','normal'); set(tit1,'Units','normalized','Position',[-0.15,0.9,0])
ax2=subplot(312); plot(t2,cl2,'r'); ylabel('$C_l$','interpreter','latex'); ylim([-1 1]);
tit2=title('(b)','fontweight','normal'); set(tit2,'Units','normalized','Position',[-0.15,0.9,0])
ax3=subplot(313); plot(t3,cl3,'k'); ylabel('$C_l$','interpreter','latex'); ylim([-2 2]);
xlabel('$tU/D$','interpreter','latex');
tit3=title('(c)','fontweight','normal'); set(tit3,'Units','normalized','Position',[-0.15,0.9,0])

set(gcf,'Units','centimeters','Position',[3,3,9,7])
set(findobj(gcf,'type','axes'),'xgrid','on','ygrid','on','box','on',...
    'xminorgrid','on','yminorgrid','on','layer','top',...
    'fontname','times new roman','fontsize',10);

ax1.XTickLabel=[]; ax2.XTickLabel=[];
ax1.Position=[0.15,0.72,0.79,0.22]; ax1.XLim=[7300 7800];
ax2.Position=[0.15,0.45,0.79,0.22]; ax2.XLim=[2500 3000];
ax3.Position=[0.15,0.18,0.79,0.22]; ax3.XLim=[500 1000];

%% saving
cd ../manuscript_nov2022/figures/
set(gcf,'Renderer','painters');
nm_str='cl_series_intermittency';
print(gcf,nm_str,'-depsc','-r1200');
cd codes; clipboard('copy',nm_str);