clear all; clc;
cd ../../pressure_measurments/
addpath scripts;

run='fst_006'; i1=38;
cd files_design; theta=load('theta_middle.txt'); cd ..
cd files_coeff_series; cd(run);files=dir('*.txt');
file1=files(i1); dat1=load(file1.name); cd ../..;
cd files_Re&U; nm1=[run,'_Re&U.xls']; dat2=importdata(nm1); cd ..
cd files_raw; cd (run); files = dir('*.xls'); %files(31,:)=[];
file=files(i1); a=load(file.name); cd ../..
%% processing and extracting the required data
Fs=500; D=0.248;
t1=dat1(:,1); cl1=dat1(:,3); 
U1=dat2(i1,2); re_star1=dat2(i1,4);
[cfs1,frq1] = cwt(cl1,'amor',Fs); st1=frq1*(D/U1);

%% conditional averaging for third subplot
disp(file.name); 
p=a(:,52:99); % fst006
q =a(:,1); T= a(:,2); Cp=bsxfun(@rdivide,p,q);
s0=zeros(1,48); s1b=zeros(1,48); s1t=zeros(1,48); s2=zeros(1,48);
%separating the four states
cp_thres= -1.7;  %threshold cp for lsb & no-lsb distinction
theta1=104; % angular location at which this Cp is to be found
i1=find(theta==theta1); i2=find(theta==(360-theta1));
s0=Cp(find(((Cp(:,i1)>cp_thres)&(Cp(:,i2)>cp_thres))),:);
s1b=Cp(find(((Cp(:,i1)>cp_thres)&(Cp(:,i2)<=cp_thres))),:);
s1t=Cp(find(((Cp(:,i1)<=cp_thres)&(Cp(:,i2)>cp_thres))),:);
s2=Cp(find(((Cp(:,i1)<=cp_thres)&(Cp(:,i2)<=cp_thres))),:);

Cp0=zeros(1,48);Cp1b=zeros(1,48);Cp1t=zeros(1,48);Cp2=zeros(1,48);
for t=1:48
    Cp0(1,t)=mean(s0(:,t)); Cp1b(1,t)=mean(s1b(:,t));
    Cp1t(1,t)=mean(s1t(:,t)); Cp2(1,t)=mean(s2(:,t));
end %mean cp distribution for each state
Cp0(1,49)=Cp0(1,1); Cp1b(1,49)=Cp1b(1,1); Cp1t(1,49)=Cp1t(1,1);
Cp2(1,49)=Cp2(1,1); %cp(360^o)= cp(0^o)

%% plotting
clf;
set(gcf,'Units','centimeters','Position',[2,2,17,6]);
ax1=subplot(221); ax1.Position=[0.08,0.59,0.36,0.32];
plot(t1,cl1); ylabel('$C_l$','Interpreter','latex'); 
xlim([10 14]); ylim([-2 0]); ax1.XTickLabel=[];
tit1=title('(a)','fontweight','normal'); 
set(tit1,'Units','normalized','Position',[-0.15,0.95,0]);
ax2=subplot(223); ax2.Position=[0.08,0.16,0.36,0.32];
surface(t1,st1,abs(cfs1)); colormap jet; axis tight; caxis([0 .15]); 
shading interp; xlim([10 14]); xlabel('$t(s)$','Interpreter','latex');
ylabel('$St$','Interpreter','latex'); ylim([0 0.6]); 
h=colorbar; set(h,'Position',[0.46,0.16,0.03,0.32]);
tit2=title('(b)','fontweight','normal'); 
set(tit2,'Units','normalized','Position',[-0.15,0.95,0]);
ax3=subplot(2,2,[2 4]); mk_sz=3; ax3.Position=[0.6,0.16,0.34,0.76];
plot(theta,Cp1b,'-ro','MarkerSize',mk_sz); hold on;
plot(theta,Cp2,':mo','MarkerSize',mk_sz); hold off;
xlabel('$\theta (^o)$','interpreter','latex'); 
ylabel('$\overline{C}_p$','interpreter','latex');
leg=legend('$1b^+$','$2^-$');
set(leg,'box','off','Location','north','Interpreter','latex');
set(gca,'xlim',[0 360],'ylim',[-3.5 1.1],'xtick',[0 90 180 270 360],...
    'xgrid','on','ygrid','on','box','on','Layer','top');
tit3=title('(c)','fontweight','normal'); 
set(tit3,'Units','normalized','Position',[-0.15,0.95,0]);

set(findobj(gcf,'type','axes'),'fontname','times new roman','fontsize',10,...
    'xminortick','on','yminortick','on');
%% saving
cd ../manuscript_prf/figures/;
% set(gcf,'renderer','painters');
nm_str='fst006_restar076_wavelets_cpbar'; clipboard('copy',nm_str);
print(gcf,nm_str,'-depsc','-r300');
cd ../figure_codes
