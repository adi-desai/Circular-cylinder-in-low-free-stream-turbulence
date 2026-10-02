clearvars; clc
cd ../../pressure_measurments;

cd 'files_mean coeff'; a=importdata('fst_006_cdcl.csv');
cd ../files_Re&U; b=importdata('fst_006_Re_U_and_Q.csv'); cd ..
a(31,:)=[]; b(31,:)=[];
Re=a(:,1); Cd=a(:,2);  q=b(:,3); d=Cd.*q;

%% plotting
mk_sz=3;
fs=10;
clf; 
set(gca,'PlotBoxAspectRatio',[1.2 1 1],'XGrid','on','YGrid','on','Layer','top', ...
    'FontSize',fs,'FontName','Times New Roman','xminortick','on','yminortick','on',...
    'box','on','Xlim',[100000 500000]); 
ylim([0 1.2]);
yyaxis left; xlabel('$Re$','interpreter','latex');
ylabel('$\overline{C}_d$','interpreter','latex');
set(gca,'Ycolor','b'); hold(gca,'all');
plot(Re,Cd,':bo','MarkerSize',mk_sz);
yyaxis right; ylim([0 350]); 
ylabel('$\overline{D}$(N)','interpreter','latex');
set(gca,'Ycolor','r'); hold(gca,'all');
plot(Re,d,'rs','MarkerSize',mk_sz); hold off;
set(gcf, 'Units','centimeters', 'Position',[7 5 8.5 8]); 
set(gcf,'renderer','painters');

%% saving
cd ../manuscript_prf/figures/;
set(gcf,'renderer','painters');
print(gcf,'drag_and_cd_vs_re','-depsc','-r1200');
cd ../figure_codes