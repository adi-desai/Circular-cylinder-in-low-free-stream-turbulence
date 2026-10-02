clearvars; clc; close all;
cd ../../../pressure_measurments/
addpath scripts;

cd 'files_mean coeff';
data1=importdata('fst_006_cdcl.xls');
data1(31,:)=[];
Re1=data1(:,1); Clrms1=data1(:,5);  Cdrms1=data1(:,4);

data2=importdata('fst_051_cdcl.xls');
Re2=data2(:,1); Clrms2=data2(:,5);  Cdrms2=data2(:,4);

data3=importdata('fst_076_cdcl.xls'); cd ..
Re3=data3(:,1); Clrms3=data3(:,5);  Cdrms3=data3(:,4);

%% plotting
mk_sz=3; fs=10; col=[.93 .69 .13];

clf;
ax1=subplot(311); %ax1.Position=[0.06,0.2,0.3,0.7];
% xlabel('$Re$','interpreter','latex'); 
ylabel('$C_l''$','interpreter','latex');
yyaxis left; ylim([0 0.4]); set(gca,'Ycolor','b'); hold(gca,'all');
patch([3.68e5 4.32e5 4.32e5 3.68e5],[0 0 1.2 1.2],col,'FaceAlpha',0.3,'EdgeColor','none');
plot(Re1,Clrms1,':bo','MarkerSize',mk_sz);
yyaxis right; ylim([0 0.12]); set(gca,'Ycolor','r'); hold(gca,'all');
plot(Re1,Cdrms1,'rs','MarkerSize',mk_sz); 
ylabel('$C_d''$','interpreter','latex');
tit1=title('(a)','fontweight','normal'); 
set(tit1,'Units','normalized','Position',[-0.2,0.9,0]);

ax2=subplot(312); %ax2.Position=[0.37,0.2,0.3,0.7];
% xlabel('$Re$','interpreter','latex'); 
ylabel('$C_l''$','interpreter','latex');
yyaxis left; ylim([0 0.4]); set(gca,'Ycolor','b'); hold(gca,'all');
patch([2.36e5 3.80e5 3.80e5 2.36e5],[0 0 1.2 1.2],col,'FaceAlpha',0.3,'EdgeColor','none');
plot(Re2,Clrms2,':bo','MarkerSize',mk_sz);
yyaxis right; ylim([0 0.12]); set(gca,'Ycolor','r'); hold(gca,'all');
plot(Re2,Cdrms2,'rs','MarkerSize',mk_sz); 
ylabel('$C_d''$','interpreter','latex');
tit1=title('(b)','fontweight','normal');
set(tit1,'Units','normalized','Position',[-0.2,0.9,0]);

ax3=subplot(313); %ax3.Position=[0.68,0.2,0.3,0.7];
xlabel('$Re$','interpreter','latex'); 
ylabel('$C_l''$','interpreter','latex');
yyaxis left; ylim([0 0.4]); set(gca,'Ycolor','b'); hold(gca,'all');
patch([1.71e5 3.13e5 3.13e5 1.71e5],[0 0 1.2 1.2],col,'FaceAlpha',0.3,'EdgeColor','none');
plot(Re3,Clrms3,':bo','MarkerSize',mk_sz);
yyaxis right; ylim([0 0.12]); set(gca,'Ycolor','r'); hold(gca,'all');
plot(Re3,Cdrms3,'rs','MarkerSize',mk_sz); 
ylabel('$C_d''$','interpreter','latex');
tit1=title('(c)','fontweight','normal');
set(tit1,'Units','normalized','Position',[-0.2,0.9,0]);

set(gcf, 'Units','centimeters', 'Position',[2 2 10 16]); 
set(findobj(gcf,'type','axes'),'XGrid','on','YGrid','on','xminortick','on','yminortick','on',...
    'box','on','layer','top','FontSize',fs,'FontName','Times New Roman','xlim',[1e5 5e5],...
    'plotboxaspectratio',[2 1 1],'Ytick',[0 0.03 0.06 0.09 0.12]);
ax1.XTickLabel=[]; ax2.XTickLabel=[];
%% saving
cd ../manuscript_prf/revision_sep23/figures_ref1/
set(gcf,'renderer','painters');
nm_str='cdrms_and_clrms_vs_re_all_tu';
print(gcf,nm_str,'-depsc','-r1200');
cd ../figure_codes; clipboard('copy',nm_str);