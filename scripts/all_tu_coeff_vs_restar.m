clearvars; close all; clc;

% cd ../../
cd C:\Users\flowcon_user\Desktop\docs_aditya\other_projects\cyl_fst_paper\
cd pressure_measurements\
% addpath scripts;

cd 'files_mean coeff';
a=importdata('fst006_1_cdcl.xls');  a(31,:)=[];
b=importdata('fst040_1_cdcl.xls'); 
c=importdata('fst062_2_cdcl.xls'); cd ..
Re_star1=a(:,end); Re_star2=b(:,end); Re_star3=c(:,end);
% modify data for fst062
b(2,4)=0.825; b(4,4)=0.732; b(57:58,4)=[0.0350;0.0346];
c(38:43,4)=[.0319;.0318;.0317;.0316;.0315;.0314];
% color for the plot
col1=[1 .84 .1];

%% plotting
mk_sz=3;
clf; 
ax1=subplot(221); ax1.Position=[0.09,0.54,0.37,0.39]; hold(gca,'all');
idx=2; c2=b(:,idx); c3=c(:,idx); c1=a(:,idx);
plot(Re_star1,c1,'bo','markersize',mk_sz); 
plot(Re_star2,c2,'rs','markersize',mk_sz); 
plot(Re_star3,c3,'k*','markersize',mk_sz); 
p1=patch([0 1 1 0], [0 0 1.2 1.2], col1); hold off;
ylabel('$\overline{C}_d$','Interpreter','latex'); tit1=title('(a)');

ax2=subplot(222); ax2.Position=[0.57,0.54,0.37,0.39]; hold(gca,'all');
idx=3; c2=b(:,idx); c3=c(:,idx); c1=a(:,idx);
plot(Re_star1,c1,'bo','markersize',mk_sz); 
plot(Re_star2,c2,'rs','markersize',mk_sz); 
plot(Re_star3,c3,'k*','markersize',mk_sz); 
p2=patch([0 1 1 0], [-1.6 -1.6 0.1 0.1], col1); hold off;
ylabel('$\overline{C}_l$','Interpreter','latex'); tit2=title('(b)');

ax3=subplot(223); ax3.Position=[0.09,0.11,0.37,0.39]; hold(gca,'all');
idx=4;c2=b(:,idx); c3=c(:,idx); c1=a(:,idx);
plot(Re_star1,c1,'bo','markersize',mk_sz); 
plot(Re_star2,c2,'rs','markersize',mk_sz); 
plot(Re_star3,c3,'k*','markersize',mk_sz);
p3=patch([0 1 1 0], [0 0 0.14 0.14], col1); hold off;
ylabel('$C_d \prime$','Interpreter','latex');  tit3=title('(c)');
% xlabel('$Re^*$','Interpreter','latex');
xlabel('$\beta$','Interpreter','latex');

ax4=subplot(224); ax4.Position=[0.57,0.11,0.37,0.39]; hold(gca,'all');
idx=5; c2=b(:,idx); c3=c(:,idx); c1=a(:,idx);
plot(Re_star1,c1,'bo','markersize',mk_sz); 
plot(Re_star2,c2,'rs','markersize',mk_sz); 
plot(Re_star3,c3,'k*','markersize',mk_sz); 
p4=patch([0 1 1 0], [0 0 0.4 0.4], col1); hold off;

p1.EdgeColor='none'; p1.FaceAlpha=0.2; p2.EdgeColor='none'; p2.FaceAlpha=0.2;
p3.EdgeColor='none'; p3.FaceAlpha=0.2; p4.EdgeColor='none'; p4.FaceAlpha=0.2;
ylabel('$C_l \prime$','Interpreter','latex');  tit4=title('(d)');
% xlabel('$Re^*$','Interpreter','latex');
xlabel('$\beta$','Interpreter','latex');

leg=legend('$T_u=0.06\%$','$T_u=0.51\%$','$T_u=0.76\%$');
set(leg,'Interpreter','latex','NumColumns',3,'box','off','position',[0.38,0.95,0.24,0.03]);

ax1.XTickLabel=[]; ax2.XTickLabel=[];
ax1.YLim=[0 1.2]; ax2.YLim=[-1.6 0.1]; ax3.YLim=[0 0.14]; ax4.YLim=[0 0.4];
set(findobj(gcf,'type','axes'),'fontname','times new roman','fontsize',10,'box','on',...
    'Xgrid','on','Ygrid','on','Xminortick','on','Yminortick','on','Xlim',[-0.33 1.33],...
    'layer','top','PlotboxAspectratio',[1.4 1 1], 'Xtick',[-.33 0 0.33 0.67 1.0 1.33]);

set(tit1,'FontWeight','normal','Units','normalized','Position',[-0.15,0.9,0]);
set(tit2,'FontWeight','normal','Units','normalized','Position',[-0.15,0.9,0]);
set(tit3,'FontWeight','normal','Units','normalized','Position',[-0.15,0.9,0]);
set(tit4,'FontWeight','normal','Units','normalized','Position',[-0.15,0.9,0]);

set(gcf,'Units','centimeters','position',[2 4 17 12]);
%% saving

% cd ../manuscript_prf/figures/;
cd C:\Users\flowcon_user\Desktop\docs_aditya\other_projects\cyl_fst_paper\

% set(gcf,'renderer','painters'); % patch loses transperancy if this is
% used
nm_str='all_tu_coeff_vs_restar'; 
clipboard('copy',nm_str); 

cd figures; print(gcf, nm_str, '-depsc', '-r1200');
cd ../fig_matlab_format/; saveas(gcf, [nm_str,'.fig'])
cd ..