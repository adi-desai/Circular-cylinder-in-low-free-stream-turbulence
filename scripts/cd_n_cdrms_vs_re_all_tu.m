clearvars; clc
cd ../../pressure_measurments/
addpath scripts;

cd 'files_mean coeff';
data1=importdata('fst006_1_cdcl.xls');
data1(31,:)=[];
Re1=data1(:,1); Cd1=data1(:,2);  Cdrms1=data1(:,4);

data2=importdata('fst040_1_cdcl.xls');
Re2=data2(:,1); Cd2=data2(:,2);  Cdrms2=data2(:,4);
Cdrms2(1,1)=0.0925; Cdrms2(4,1)=0.0732; Cdrms2(57,1)=0.0350; Cdrms2(58,1)=0.0346;

data3=importdata('fst062_2_cdcl.xls'); cd ..
Re3=data3(:,1); Cd3=data3(:,2);  Cdrms3=data3(:,4);
Cdrms3(38:43,1)=[.0319;.0318;.0317;.0316;.0315;.0314];

%% plotting
mk_sz=3; fs=10; col=[.93 .69 .13];

clf;
ax1=subplot(311); ax1.Position=[0.21,0.70,0.6,0.28];
ylabel('$\overline{C}_d$','interpreter','latex');
yyaxis left; ylim([0 1.2]); set(gca,'Ycolor','b'); hold(gca,'all');
patch([3.68e5 4.32e5 4.32e5 3.68e5],[0 0 1.2 1.2],col,'FaceAlpha',0.3,'EdgeColor','none');
plot(Re1,Cd1,':bo','MarkerSize',mk_sz);
yyaxis right; ylim([0 0.12]); set(gca,'Ycolor','k'); hold(gca,'all');
plot(Re1,Cdrms1,'ks','MarkerSize',mk_sz); 
ylabel('$C_d''$','interpreter','latex');
tit1=title('(a)','fontweight','normal'); 
set(tit1,'Units','normalized','Position',[-0.19,0.9,0]);

ax2=subplot(312); ax2.Position=[0.21,0.38,0.6,0.28];
ylabel('$\overline{C}_d$','interpreter','latex');
yyaxis left; ylim([0 1.2]); set(gca,'Ycolor','b'); hold(gca,'all');
patch([2.36e5 3.80e5 3.80e5 2.36e5],[0 0 1.2 1.2],col,'FaceAlpha',0.3,'EdgeColor','none');
plot(Re2,Cd2,':bo','MarkerSize',mk_sz);
yyaxis right; ylim([0 0.12]); set(gca,'Ycolor','k'); hold(gca,'all');
plot(Re2,Cdrms2,'ks','MarkerSize',mk_sz); 
ylabel('$C_d''$','interpreter','latex');
tit1=title('(b)','fontweight','normal');
set(tit1,'Units','normalized','Position',[-0.19,0.9,0]);

ax3=subplot(313); ax3.Position=[0.21,0.06,0.6,0.28];
xlabel('$Re$','interpreter','latex'); 
ylabel('$\overline{C}_d$','interpreter','latex');
yyaxis left; ylim([0 1.2]); set(gca,'Ycolor','b'); hold(gca,'all');
patch([1.71e5 3.13e5 3.13e5 1.71e5],[0 0 1.2 1.2],col,'FaceAlpha',0.3,'EdgeColor','none');
plot(Re3,Cd3,':bo','MarkerSize',mk_sz);
yyaxis right; ylim([0 0.12]); set(gca,'Ycolor','k'); hold(gca,'all');
plot(Re3,Cdrms3,'ks','MarkerSize',mk_sz); 
ylabel('$C_d''$','interpreter','latex');
tit1=title('(c)','fontweight','normal');
set(tit1,'Units','normalized','Position',[-0.19,0.9,0]);

set(gcf, 'Units','centimeters', 'Position',[2 2 8.5 16]); 
set(findobj(gcf,'type','axes'),'XGrid','on','YGrid','on','xminortick','on','yminortick','on',...
    'box','on','layer','top','FontSize',fs,'FontName','Times New Roman','xlim',[1e5 6e5]);
ax1.XTickLabel=[]; ax2.XTickLabel=[];
%% saving
% cd ../manuscript_nov2022/figures/
cd ../manuscript_prf/figures/;
set(gcf,'renderer','painters');
nm_str='cd_n_cdrms_vs_re_all_tu';
print(gcf,nm_str,'-depsc','-r1200');
cd ../figure_codes; clipboard('copy',nm_str);