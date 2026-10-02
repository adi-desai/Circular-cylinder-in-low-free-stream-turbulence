clear all; clc;
cd ../../pressure_measurments/
addpath scripts\

run_name='fst_006';
cd files_design; theta= load('Theta_middle complete.xls'); cd ..; %theta data for x axis
cd files_raw; cd (run_name); files = dir('*.xls'); %files(31,:)=[];
Fs=500;
file=files(24); a=load(file.name); cd ../..

%% processing
t_array=input('input time interval as [t1 t2] seconds \n \n');
t1=t_array(1,1); t2=t_array(1,2);
i1=Fs*t1; i2=Fs*t2;
if i1==0
    i1=1;
else
end %to avoid the error than can arise due to i1 being zero

p=a(i1:i2,52:99); % fst006- 52:99, higer fst- 51:98
q =a(i1:i2,1); Cp=bsxfun(@rdivide,p,q);

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
prob_0=length(s0)/length(q); prob_1b=length(s1b)/length(q);
prob_1t=length(s1t)/length(q); prob_2=length(s2)/length(q); % probabilities

% plotting
clf; set(gcf,'Units','centimeters','Position',[2,2,8.5,6]);
mk_sz=3;% marker size in line plots
set(gca,'YMinorTick','on','XMinorTick','on','xgrid','on','ygrid','on',...
    'XTick',[0 90 180 270 360],'PlotBoxAspectRatio',[1.4 1 1],...
    'FontSize',10,'FontName','Times New Roman','box','on',...
    'ylim',[-3 1],'xlim',[0 360]);
ylabel('$\overline{C}_p$','interpreter','latex');
xlabel('\theta (^o)'); hold(gca,'all'); 
plot(theta,Cp0,'-go','markersize',mk_sz); plot(theta,Cp1b,'-ro','markersize',mk_sz);
plot(theta,Cp1t,'-bo','markersize',mk_sz); plot(theta,Cp2,'-mo','markersize',mk_sz)
h =legend('$0$','$1b$','$1t$','$2$');
set(h,'Location', 'North','box','off','interpreter','latex','NumColumns',2); 
hold off

%% saving
cd ../manuscript_nov2022/figures/
set(gcf,'Renderer','painters');
nm_str='cond_avg_fst006_re382k'; 
print(gcf,nm_str,'-depsc','-r1200');
cd codes; clipboard('copy',nm_str);
