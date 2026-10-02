clear all; clc;
cd ../../pressure_measurments/
addpath scripts;

run='fst_006'; i1=42;
cd files_coeff_series; cd(run);files=dir('*.txt');
file1=files(i1); dat1=load(file1.name); cd ../..;
cd files_Re&U; nm1=[run,'_Re&U.xls']; dat4=importdata(nm1); cd ..
cd 'files_mean cp';nm1=[run,'_cpbar.xls']; a=importdata(nm1); cd ..
cd files_design; theta=load('theta_middle.txt'); cd ..

% get the required data
Fs=500; D=0.248;
t1=dat1(:,1); cl1=dat1(:,3); 
U1=dat4(i1,2); re_star1=dat4(i1,4);
[cfs1,frq1] = cwt(cl1,'amor',Fs); st1=frq1*(D/U1);
cpbar_1=a(i1,50:97); cpbar_1(1,end+1)=cpbar_1(1,1);
%% plotting
clf;
set(gcf,'Units','centimeters','Position',[2,2,17,6]);
ax1=subplot(221); ax1.Position=[0.08,0.59,0.36,0.32];
plot(t1,cl1); ylabel('$C_l$','Interpreter','latex'); 
xlim([35 39]); ylim([-1 1]); ax1.XTickLabel=[];
tit1=title('(a)','fontweight','normal'); 
set(tit1,'Units','normalized','Position',[-0.15,0.95,0]);
ax2=subplot(223); ax2.Position=[0.08,0.16,0.36,0.32];
surface(t1,st1,abs(cfs1)); colormap jet; axis tight; caxis([0 .1]); 
shading interp; xlim([35 39]); xlabel('$t(s)$','Interpreter','latex');
ylabel('$St$','Interpreter','latex'); ylim([0 0.6]); 
h=colorbar; set(h,'Position',[0.46,0.16,0.03,0.32]);
tit2=title('(b)','fontweight','normal'); 
set(tit2,'Units','normalized','Position',[-0.15,0.95,0]);
ax3=subplot(2,2,[2 4]); mk_sz=3; ax3.Position=[0.6,0.16,0.34,0.76];
plot(theta,cpbar_1,'-mo','markersize',mk_sz);
xlabel('$\theta (^o)$','interpreter','latex'); 
ylabel('$\overline{C}_p$','interpreter','latex');
set(gca,'xlim',[0 360],'ylim',[-3 1.1],'xtick',[0 90 180 270 360],...
    'xgrid','on','ygrid','on','box','on','Layer','top');
tit3=title('(c)','fontweight','normal'); 
set(tit3,'Units','normalized','Position',[-0.15,0.95,0]);
leg1=legend('$2$'); set(leg1,'location','north','Box','off','Interpreter','latex');

set(findobj(gcf,'type','axes'),'fontname','times new roman','fontsize',10,...
    'xminortick','on','yminortick','on');
%% saving
cd ../manuscript_prf/figures/
% set(gcf,'renderer','painters');
nm_str='fst006_restar1_wavelets_cpbar'; clipboard('copy',nm_str);
print(gcf,nm_str,'-depsc','-r300');
cd ../figure_codes
