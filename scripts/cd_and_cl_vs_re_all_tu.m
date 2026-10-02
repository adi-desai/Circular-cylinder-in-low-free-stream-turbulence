clear all; clc;
cd ../../pressure_measurments;
cd 'files_mean coeff';

run='fst_006'; nm1=[run,'_CdCl.xls']; a=importdata(nm1);
run='fst_051'; nm1=[run,'_CdCl.xls']; b=importdata(nm1);
run='fst_076'; nm1=[run,'_CdCl.xls']; c=importdata(nm1); cd ..;

Re1=a(:,1); Re2=b(:,1); Re3=c(:,1);

%% plotting
clf; 
mk_sz=3; %markersize
fs=10; %fontsize
ax1=subplot(121); ax1.Position=[0.1,0.16,0.37,0.65];
zz=2; c1=a(:,zz); c2=b(:,zz); c3=c(:,zz);
ax1.YLim=[0 1.2]; ylabel('$\overline{C}_d$','interpreter','latex')
xlabel('$Re$','interpreter','latex'); hold(gca,'all');
plot(Re1,c1,':bo','MarkerSize',mk_sz); 
plot(Re2,c2,':rs','MarkerSize',mk_sz); 
plot(Re3,c3,':k*','MarkerSize',mk_sz); hold off;
tit1=title('(a)','fontweight','normal'); 
set(tit1,'units','normalized','position',[-0.2,0.95,0]);

ax2=subplot(122); ax2.Position=[0.58,0.16,0.37,0.65];
zz=3; c1=a(:,zz); c2=b(:,zz); c3=c(:,zz);
ax2.YLim=[-1.6 0.2]; ylabel('$\overline{C}_l$','interpreter','latex')
xlabel('$Re$','interpreter','latex'); hold(gca,'all');
plot(Re1,c1,':bo','MarkerSize',mk_sz); 
plot(Re2,c2,':rs','MarkerSize',mk_sz); 
plot(Re3,c3,':k*','MarkerSize',mk_sz); hold off;
tit2=title('(b)','fontweight','normal'); 
set(tit2,'units','normalized','position',[-0.2,0.95,0]);
leg=legend('$T_u=0.06\%$', '$T_u=0.51\%$','$T_u=0.76\%$'); 
set(leg,'box','off','NumColumns',3,'Position',[0.28,0.87,0.48,0.08],...
    'Interpreter','latex');

set(findobj(gcf,'type','axes'),'FontName','times new roman','FontSize',fs,...
    'XMinorTick','on','YMinorTick','on','YGrid','on','XGrid','on','box','on', ...
    'Layer','top','PlotBoxAspectRatio',[1.4 1 1],'xlim',[1e5 6e5]);
set(gcf,'Units','centimeters','Position',[3 4 17 7]);

%% set(gcf,'Units','centimeters','Position',[3 1 15 12]);
cd ../manuscript_prf/figures/
set(gcf,'renderer','painters');
nm_str='cd_and_cl_vs_re_all_tu';
print(gcf,nm_str,'-depsc','-r1200');
cd ../figure_codes; clipboard('copy',nm_str);
