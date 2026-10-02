clear all; clc;
% cd ../../pressure_measurments/
addpath scripts\

run_name='fst006_1';
cd files_design; theta= load('Theta_middle complete.xls'); cd ..; %theta data for x axis
cd files_raw; cd (run_name); files = dir('*.xls'); %files(31,:)=[];
Fs=500;
file=files(24); a=load(file.name); cd ../..

%% processing & plotting the time series

clearvars t_array t1 t2 j1 j2 p q Cp;

t_array=[90 95];%input('input time interval as [t1 t2] seconds \n \n');
t1=t_array(1,1); t2=t_array(1,2);
j1=Fs*t1; j2=Fs*t2;
p=a(j1:j2,52:99); % fst006- 52:99, higer fst- 51:98
q =a(j1:j2,1); Cp=bsxfun(@rdivide,p,q); Cp(:,end+1)=Cp(:,1);

clf; 
set(gcf,'Units','centimeters','Position',[2,2,17,6]);

% No VS-LSB: conditional averaging and plotting

clearvars t_array t1 t2 j1 j2 p q Cp ;
mk_sz=3;% marker size in line plots

t_array=[91.668 92.320];%input('input time interval as [t1 t2] seconds \n \n');
t1=t_array(1,1); t2=t_array(1,2);
j1=Fs*t1; j2=Fs*t2;
p=a(j1:j2,52:99); % fst006- 52:99, higer fst- 51:98
q =a(j1:j2,1); Cp=bsxfun(@rdivide,p,q); Cp(:,end+1)=Cp(:,1);

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
for j=1:48
    Cp0(1,j)=mean(s0(:,j)); Cp1b(1,j)=mean(s1b(:,j));
    Cp1t(1,j)=mean(s1t(:,j)); Cp2(1,j)=mean(s2(:,j));
end %mean cp distribution for each state
Cp0(1,49)=Cp0(1,1); Cp1b(1,49)=Cp1b(1,1); Cp1t(1,49)=Cp1t(1,1);
Cp2(1,49)=Cp2(1,1); %cp(360^o)= cp(0^o)
prob_0=size(s0,1)/length(q); prob_1b=size(s1b,1)/length(q);
prob_1t=size(s1t,1)/length(q); prob_2=size(s2,1)/length(q); % probabilities

ax1=subplot(121); tit1=title('(a)','FontWeight','normal');
hold(gca,'all'); 
plot(theta,Cp0,'-k','markersize',mk_sz); % 'color',[.25, .69, .25]
plot(theta,Cp1b,'-r','markersize',mk_sz);
plot(theta,Cp1t,'-b','markersize',mk_sz); 
plot(theta,Cp2,'-','color','[.2 .8 .2]','markersize',mk_sz)
h =legend('$0$','$1b$','$1t$','$2$');
hold off;
ylabel('$\overline{C}_p$','interpreter','latex'); xlabel('\theta (^o)'); 

% VS-LSB: conditional averaging and plotting

clearvars t_array t1 t2 j1 j2 p q Cp ;
t_array=[94 94.296];%input('input time interval as [t1 t2] seconds \n \n');
t1=t_array(1,1); t2=t_array(1,2);
j1=Fs*t1; j2=Fs*t2;
p=a(j1:j2,52:99); % fst006- 52:99, higer fst- 51:98
q =a(j1:j2,1); Cp=bsxfun(@rdivide,p,q); Cp(:,end+1)=Cp(:,1);

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
for j=1:48
    Cp0(1,j)=mean(s0(:,j)); Cp1b(1,j)=mean(s1b(:,j));
    Cp1t(1,j)=mean(s1t(:,j)); Cp2(1,j)=mean(s2(:,j));
end %mean cp distribution for each state
Cp0(1,49)=Cp0(1,1); Cp1b(1,49)=Cp1b(1,1); Cp1t(1,49)=Cp1t(1,1);
Cp2(1,49)=Cp2(1,1); %cp(360^o)= cp(0^o)
prob_0=size(s0,1)/length(q); prob_1b=size(s1b,1)/length(q);
prob_1t=size(s1t,1)/length(q); prob_2=size(s2,1)/length(q); % probabilities

ax2=subplot(122); tit2=title('(b)','FontWeight','normal');
hold(gca,'all'); 
% plot(theta,Cp0,'-k','markersize',mk_sz); 
plot(theta,Cp1b,'-r','markersize',mk_sz);
plot(theta,Cp1t,'-b','markersize',mk_sz); 
plot(theta,Cp2,'-','color','[.2 .8 .2]','markersize',mk_sz)
hold off;
xlabel('\theta (^o)'); 

% set common parameters for the subplots
set(findobj(gcf,'type','axes'), 'YMinorTick','on', 'XMinorTick','on',...
    'xgrid','on', 'ygrid','on', 'box','on','layer','top', 'XTick',[0 90 180 270 360],...
        'ylim',[-3 1], 'xlim',[0 360], 'FontSize',9, 'FontName','Times New Roman');

%%
set(h,'Location', 'Northoutside','box','off','interpreter','latex','NumColumns',4,...
    'Position',[ 0.21, 0.9, 0.59, 0.07]); 
ax1.Position=[0.12,0.17,0.36,0.65];
ax2.YTickLabel=[];
ax2.Position=[0.55,0.17,0.36,0.65]; 
set(tit1,'Units','normalized','Position',[-0.1,0.9]);
set(tit2,'Units','normalized','Position',[-0.1,0.9]);


%% saving
% cd ../manuscript_prf/figures/
cd ..
set(gcf,'Renderer','painters');
nm_str='cond_avg_fst006_re382k_updated_v3'; 
print(gcf,nm_str,'-depsc','-r1200');
% cd ../figure_codes; clipboard('copy',nm_str);
