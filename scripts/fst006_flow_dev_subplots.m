clearvars; close all; clc;

cd C:\Users\flowcon_user\Desktop\docs_aditya\other_projects\cyl_fst_paper\
cd pressure_measurements
% addpath scripts;

run_nm='fst_006';
cd files_condprob; nm1=[run_nm,'_condprob.txt']; dat1=load(nm1); cd ..
cd 'files_mean coeff'; nm2=[run_nm,'_cdcl.xls']; dat2=importdata(nm2); cd ..
cd files_spectra; cd (run_nm); dat3=load('lift_coeff.txt'); cd ../..
cd 'files_mean cp'; nm4=[run_nm,'_cpbar.txt']; dat4=importdata(nm4); cd ..
dat1(31,:)=[]; dat2(31,:)=[]; dat4(31,:)=[]; % eliminate Re397k data: insufficient samples in time

% data for first subplot
Re_star=dat2(:,end); s0=dat1(:,2); s1b=dat1(:,3); s1t=dat1(:,4); s2=dat1(:,5);
% data for second plot
cd1=dat2(:,2); cdrms=dat2(:,4); cpb=dat4(:,74);
% data for third plot
U_all=dat2(:,end-1); spectra_cl=dat3;

%% clear figure and set plotting parameters
clf;
set(gcf,'Units','centimeters','Position',[2,2,10.1,18]);
mk_sz=3; fs=10; 
% data for patches of subregimes
re1=0; re2=0.388; re3=0.608; re4=.761; re5=1;
col1=[1 .84 .1]; col2=[.72 .27 1]; col3=[.8 .6 .6]; col4=[.72 .72 .92];

%% subplot 1
ax1=subplot(311);
yyaxis left; ylabel('$\overline{C}_d$, $-\overline{C}_{p,b}$','interpreter','latex'); 
xlim([0 1]); ylim([0 1.2]);
set(gca, 'XMinorTick','on', 'YMinorTick','on', 'YGrid','on', 'XGrid','on',...
    'Ycolor',[0 0 1], 'box','on', 'YTick',[0 0.3 0.6 0.9 1.2]); 
hold(gca,'all');
plot(Re_star,cd1,'bo','markersize',mk_sz,'MarkerFaceColor','w'); 
plot(Re_star,-cpb,'bs','markersize',mk_sz,'MarkerFaceColor','b');
yyaxis right; plot(Re_star,cdrms,'k*','markersize',mk_sz); 
set(gca, 'Ycolor','k', 'YLim',[0 .12], 'YTick',[0 0.03 0.06 0.09 0.12]); 
ylabel('$C_{d} \prime$','interpreter','latex'); 
tit1=title('(a)','fontweight','normal'); 
set(tit1,'Units','normalized','Position',[-0.15,0.95,0]);
% patches and arrows
yy=[0 0 .16 .16];
p1=patch([re1 re2 re2 re1],yy,col1); p2=patch([re2 re3 re3 re2],yy,col2);
p3=patch([re3 re4 re4 re3],yy,col3); p4=patch([re4 re5 re5 re4],yy,col4);
p1.EdgeColor='none'; p1.FaceAlpha=0.3; p2.EdgeColor='none'; p2.FaceAlpha=0.3;
p3.EdgeColor='none'; p3.FaceAlpha=0.3; p4.EdgeColor='none'; p4.FaceAlpha=0.3;
ax1.XTickLabel=[];
leg=legend('$\overline{C}_d$','$-\overline{C}_{p,b}$','$C_{d} \prime$');
set(leg,'interpreter','latex','box','off','NumColumns',1,'Position',[0.62,0.8,0.2,0.07]);

%% subplot 2
ax2=subplot(312);
set(gca,'YMinorTick','on','YGrid','on','XGrid','on','box','on',...
    'Layer','top','YScale','log','YLim',[1e-4 1.5]);
ylabel('Probability','interpreter','latex'); hold(gca,'all');
plot(Re_star,s0,'ko','markersize',mk_sz); 
plot(Re_star,s1b,'rv','MarkerFaceColor','r','markersize',mk_sz);
plot(Re_star,s1t,'b^','MarkerFaceColor','b','markersize',mk_sz);
plot(Re_star,s2,'color','[.2 .8 .2]','MarkerFaceColor','[0.2 .8 .2]',...
    'Marker','d','Linestyle','none','markersize',mk_sz); hold off; 
h =legend('$0$','$1b$','$1t$','$2$'); 
set(h,'box','off','Position',[0.78,0.46,0.2,0.09],'Interpreter','latex');
set(gca,'xlim',[0 1]);
tit1=title('(b)','fontweight','normal'); 
set(tit1,'Units','normalized','Position',[-0.15,0.95,0]);
yy=[1e-4 1e-4 1.5 1.5];
p1=patch([re1 re2 re2 re1],yy,col1); p2=patch([re2 re3 re3 re2],yy,col2);
p3=patch([re3 re4 re4 re3],yy,col3); p4=patch([re4 re5 re5 re4],yy,col4);
p1.EdgeColor='none'; p1.FaceAlpha=0.3; p2.EdgeColor='none'; p2.FaceAlpha=0.3;
p3.EdgeColor='none'; p3.FaceAlpha=0.3; p4.EdgeColor='none'; p4.FaceAlpha=0.3;
h.String=h.String(1:4); % remove patch entries from legend
ax2.XTickLabel=[];

%% subplot 3
f=(0:1:4096-1)*250/4095;

X=repmat(Re_star',4096,1);
Y=zeros(size(f,2),size(U_all,1));
for i=1:size(f,2)
    freq=f(1,i);
    for j= 1:size(U_all,1)
        u_inf=U_all(j,1);
        St=freq*0.248/u_inf;
        Y(i,j)=St;
    end
end

ax3=subplot(313);
pcolor(X,Y,log10(spectra_cl')); shading interp; hold on;
caxis([-5 -2]); h=colorbar; h.Location='eastoutside';
h.Label.String=('$log(power)$'); h.Label.Interpreter='latex'; h.Label.FontSize=fs;
tit1=title('(c)','fontweight','normal'); 
set(tit1,'Units','normalized','Position',[-0.15,0.95,0]);

%lines indicating different Strouhl numbers
lw=1.2; 
st20=0.2*(ones(58,1));
ind0=find(Re_star==re1); ind1=find(Re_star==re2);
plot(Re_star(ind0:ind1),st20(ind0:ind1),'-r','LineWidth',lw); 
st12=0.12*(ones(58,1));
plot(Re_star(ind0:ind1),st12(ind0:ind1),'--r','LineWidth',lw); 
st33=0.33*(ones(58,1));
ind2=find(Re_star==0.726); 
plot(Re_star(ind1:ind2),st33(ind1:ind2),':r','LineWidth',lw); 
st48=0.48*(ones(58,1)); ind3=find(Re_star==1);
plot(Re_star(ind2:ind3),st48(ind2:ind3),'-.r','LineWidth',lw);
ylabel('$St$','interpreter','latex'); 
ylim([0 0.8]); xlim([0 1]);
% xlabel('$Re^*$','interpreter','latex');
xlabel('$\beta$','interpreter','latex');

%% set common parameters
set(findobj(gcf,'type','axes'),'fontname','times new roman','fontsize',fs);
ax1.Position=[0.14,0.63,0.7,0.25];
ax2.Position=[0.14,0.36,0.7,0.25];
ax3.Position=[0.14,0.09,0.7,0.25]; 
h.Position=[0.87,0.09,0.05,0.25];
%% add regime titles(annotations)and arrows
x0=0.14; width=0.7;
x1=x0; x2=(re2-re1)*width+x0; x3=(re3-re1)*width+x0;
x4=(re4-re1)*width+x0; x5=(re5-re1)*width+x0;
hd_l=3; hd_w=2;
annotation(gcf,'doublearrow',[x1+.001 x2-.001],[0.9 0.9],...
    'Head2Style','plain','Head2Length',hd_l,'Head2Width',hd_w,...
    'Head1Style','plain','Head1Length',hd_l,'Head1Width',hd_w);
annotation(gcf,'doublearrow',[x2+.001 x3-.001],[0.9 0.9],...
    'Head2Style','plain','Head2Length',hd_l,'Head2Width',hd_w,...
    'Head1Style','plain','Head1Length',hd_l,'Head1Width',hd_w);
annotation(gcf,'doublearrow',[x3+.001 x4-.001],[0.9 0.9],...
    'Head2Style','plain','Head2Length',hd_l,'Head2Width',hd_w,...
    'Head1Style','plain','Head1Length',hd_l,'Head1Width',hd_w);
annotation(gcf,'doublearrow',[x4+.001 x5-.001],[0.9 0.9],...
    'Head2Style','plain','Head2Length',hd_l,'Head2Width',hd_w,...
    'Head1Style','plain','Head1Length',hd_l,'Head1Width',hd_w);
% text annotations
annotation(gcf,'textbox',[x1,0.92,x2-x1,0.03],'EdgeColor','none','BackgroundColor',col1,...
    'facealpha',0.3,'VerticalAlignment','middle','String','$I_{0,1b^{vs},1t^{vs},2^{vs}}$',...
    'HorizontalAlignment','center','FontName','Times New Roman','FontSize',fs,...
    'FitBoxToText','off','Interpreter','latex');
annotation(gcf,'textbox',[x2,0.92,x3-x2,0.03],'EdgeColor','none','BackgroundColor',col2,...
    'facealpha',0.3,'VerticalAlignment','middle','String','$S_{1b^+}$',...
    'HorizontalAlignment','center','FontName','Times New Roman','FontSize',fs,...
    'FitBoxToText','off','Interpreter','latex');
annotation(gcf,'textbox',[x3,0.92,x4-x3,0.03],'EdgeColor','none','BackgroundColor',col3,...
    'facealpha',0.3,'VerticalAlignment','middle','String','$I_{1b^+,2^-}$',...
    'HorizontalAlignment','center','FontName','Times New Roman','FontSize',fs,...
    'FitBoxToText','off','Interpreter','latex');
annotation(gcf,'textbox',[x4,0.92,x5-x4,0.03],'EdgeColor','none','BackgroundColor',col4,...
    'facealpha',0.3,'VerticalAlignment','middle','String','$S_{2}$',...
    'HorizontalAlignment','center','FontName','Times New Roman','FontSize',fs,...
    'FitBoxToText','off','Interpreter','latex');

%% saving
% cd ..
cd C:\Users\flowcon_user\Desktop\docs_aditya\other_projects\cyl_fst_paper\

nm_str='fst006_flow_dev_subplots'; 
clipboard('copy',nm_str); 

cd figures; print(gcf, nm_str, '-depsc', '-r1200');
cd ../fig_matlab_format/; saveas(gcf, [nm_str,'.fig'])
cd ..

% cd codes
