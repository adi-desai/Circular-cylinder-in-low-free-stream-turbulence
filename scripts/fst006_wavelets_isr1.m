clearvars; close all; clc;
cd ..\..\pressure_measurments\
% cd ../../../pressure_measurments/
addpath scripts;

run='fst_006';
cd files_coeff_series; cd(run);files=dir('*.txt');

i1=19; i2=24; i3=30;
file1=files(i1); dat1=load(file1.name); 
file2=files(i2); dat2=load(file2.name); 
file3=files(i3); dat3=load(file3.name); cd ../..;
cd files_Re&U; nm1=[run,'_Re&U.xls']; dat4=importdata(nm1); cd ..

% get the required data
Fs=500; D=0.248;
t1=dat1(:,1); cl1=dat1(:,3); 
t2=dat2(:,1); cl2=dat2(:,3);
t3=dat3(:,1); cl3=dat3(:,3);
U1=dat4(i1,2); re_star1=dat4(i1,4);
U2=dat4(i2,2); re_star2=dat4(i2,4);
U3=dat4(i3,2); re_star3=dat4(i3,4);
[cfs1,frq1] = cwt(cl1,'amor',Fs); st1=frq1*(D/U1);
[cfs2,frq2] = cwt(cl2,'amor',Fs); st2=frq2*(D/U2);
[cfs3,frq3] = cwt(cl3,'amor',Fs); st3=frq3*(D/U3);

%% plotting

ylim_odd=[-1 1]; ylim_even=[0 .6];
ylab_odd=('$C_l$'); ylab_even=('$St$'); xlab=('$t(s)$');
xlim1=[18 22]; xlim2=[36 40]; xlim3=[43 47];

clf;
set(gcf,'Units','centimeters','Position',[3,5,17,12]);

ax1=subplot(321); ax1.Position=[.07,.74,.36,.18];
plot(t1,cl1); xlim(xlim1); xlabel(xlab,'Interpreter','latex');
ylabel(ylab_odd,'Interpreter','latex'); ylim(ylim_odd);
tit1=title('(a)','fontweight','normal'); 
set(tit1,'Units','normalized','Position',[-0.15,0.95,0]);
ax2=subplot(322); ax2.Position=[.53,.73,.36,.18];
surface(t1,st1,abs(cfs1)); colormap parula; 
axis tight; caxis([0 .5]); 
shading interp; xlim(xlim1); xlabel(xlab,'Interpreter','latex');
ylabel(ylab_even,'Interpreter','latex'); ylim(ylim_even); 

ax3=subplot(323); ax3.Position=[.07,.44,.36,.18];
plot(t2,cl2); xlim(xlim2); xlabel(xlab,'Interpreter','latex');
ylabel(ylab_odd,'Interpreter','latex'); ylim(ylim_odd);
tit3=title('(b)','fontweight','normal'); 
set(tit3,'Units','normalized','Position',[-0.15,0.95,0]);
ax4=subplot(324); ax4.Position=[.53,.44,.36,.18];
surface(t2,st2,abs(cfs2)); colormap parula; axis tight; caxis([0 .5]); 
shading interp; xlim(xlim2); xlabel(xlab,'Interpreter','latex');
ylabel(ylab_even,'Interpreter','latex'); ylim(ylim_even); 

ax5=subplot(325); ax5.Position=[.07,.14,.36,.18];
plot(t3,cl3); xlim(xlim3); xlabel(xlab,'Interpreter','latex');
ylabel(ylab_odd,'Interpreter','latex'); ylim(ylim_odd);
tit5=title('(c)','fontweight','normal'); 
set(tit5,'Units','normalized','Position',[-0.15,0.95,0]);
ax6=subplot(326); ax6.Position=[.53,.14,.36,.18];
surface(t3,st3,abs(cfs3)); colormap parula; axis tight; caxis([0 .5]); 
shading interp; xlim(xlim3); xlabel(xlab,'Interpreter','latex');
ylabel(ylab_even,'Interpreter','latex'); ylim(ylim_even); 
h=colorbar; set(h,'Position',[0.915,0.13,0.04,0.78]);
set(findobj(gcf,'type','axes'),'Xminortick','on','Yminortick','on',...
    'Layer','top','FontName','Times New Roman','fontsize',10);

%% saving
cd ../manuscript_nov2022/figures/
% set(gcf,'Renderer','painters');
nm_str='fst006_wavelets_isr1'; clipboard('copy',nm_str);
print(gcf,nm_str,'-depsc','-r1200');
cd codes