clear all; clc;
cd ../../pressure_measurments/
addpath scripts;

cd files_design; theta=load('theta_middle.txt'); cd ..
runs_array={'fst006_1','fst040_1','fst062_2'};
color_array=[0,0,1; 1,0,0; 0,0,0;];

%% plotting
clf;
set(gcf,'Units','centimeters','Position',[2,2,17,6]);
mk_sz=4;
ax1=subplot(121); 
xlabel('$\theta (^o)$','interpreter','latex'); 
ylabel('$\overline{C}_p$','interpreter','latex');
hold(gca,'all'); Re_star_req=0;
for i=1:3
    run=runs_array{i}; 
    cd 'files_mean cp';nm1=[run,'_cpbar.xls']; a=importdata(nm1); cd ..
    cd 'files_mean coeff'; nm2=[run,'_cdcl.xls']; b=importdata(nm2); cd ..
    b=round(b,2);
    [ind,~]=find(b(:,11)==Re_star_req);
    cpbar_req=a(ind,50:97); cpbar_req(1,end+1)=cpbar_req(1,1);
    cpbar_req=cpbar_req-cpbar_req(1,1)+1;
    plot(theta,cpbar_req,'-','Color',color_array(i,:));
end
tit1=title('(a)','fontweight','normal');
set(tit1,'Units','normalized','Position',[-0.15,0.9,0])

ax2=subplot(122); 
xlabel('$\theta (^o)$','interpreter','latex'); 
hold(gca,'all'); Re_star_req=1;
for i=1:3
    run=runs_array{i}; 
    cd 'files_mean cp';nm1=[run,'_cpbar.xls']; a=importdata(nm1); cd ..
    cd 'files_mean coeff'; nm2=[run,'_cdcl.xls']; b=importdata(nm2); cd ..
    b=round(b,2); 
    [ind,~]=find(b(:,11)==Re_star_req);
    cpbar_req=a(ind,50:97); cpbar_req(:,end+1)=cpbar_req(1,1);
    cpbar_req=cpbar_req-cpbar_req(1,1)+1;
    plot(theta,cpbar_req,'-','Color',color_array(i,:));
end
tit2=title('(b)','fontweight','normal');
set(tit2,'Units','normalized','Position',[-0.15,0.9,0])

set(findobj(gcf,'type','axes'),'xlim',[0 360],'ylim',[-3 1.2],'xtick',[0 90 180 270 360],...
    'xminortick','on','yminortick','on','xgrid','on','ygrid','on','box','on',...
    'fontname','times new roman','fontsize',10,'plotboxaspectratio',[1.4 1 1]);
    leg=legend('$T_u=0.06\%$','$T_u=0.51\%$','$T_u=0.76\%$');
    set(leg,'interpreter','latex','box','off','numcolumns',3,'position',[0.25,0.88,0.5,0.1]);

%% saving
cd ../manuscript_prf/figures/
set(gcf,'renderer','painters');
print(gcf,'cpbar_at_cr_limits','-depsc','-r1200');
cd ../figure_codes/