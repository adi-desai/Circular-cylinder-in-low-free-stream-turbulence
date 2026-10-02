% clearvars; clc

cd C:\Users\flowcon_user\Desktop\docs_aditya\other_projects\cyl_fst_paper\
cd pressure_measurements/
addpath scripts;

cd 'files_mean coeff'; a=importdata('fst_006_cdcl.xls');
cd ../files_Re&U; 
b=importdata('fst_006_Re_U_and_Q.txt'); 
cd ..

%remove spurious data
a(31,:)=[]; b(31,:)=[];

% select desired arrays
Re=a(:,1); 
%%
Cd=aa(:,3); Cd(31,:) = [];
q=b(:,3); d=Cd.*q;

%% plotting
mk_sz=3;
fs=10;
clf;
xlabel('$Re$','interpreter','latex'); 
ylabel('$\overline{C}_d$','interpreter','latex');
yyaxis left; ylim([0 1.2]); set(gca,'Ycolor','b'); hold(gca,'all');
plot(Re,Cd,':bo','MarkerSize',mk_sz);
yyaxis right; ylim([0 350]); set(gca,'Ycolor','r'); hold(gca,'all');
plot(Re,d,'rs','MarkerSize',mk_sz); hold off;
ylabel('$\overline{D}$(N)','interpreter','latex');
tit1=title('(a)','fontweight','normal');
set(tit1,'Units','normalized','Position',[-0.15,0.9,0]);
set(gcf, 'Units','centimeters', 'Position',[7 5 8.5 7]); 
set(gca,'PlotBoxAspectRatio',[1.2 1 1],'XGrid','on','YGrid','on',...
    'xminortick','on','yminortick','on','box','on','Xlim',[1e5 6e5],'Layer','top',...
    'FontSize',fs,'FontName','Times New Roman');
%% saving
cd ../manuscript_nov2022/figures/
set(gcf,'renderer','painters');
nm_str='drag_n_cd_vs_re_fst006';
print(gcf,nm_str,'-depsc','-r1200');
cd codes; clipboard('copy',nm_str);