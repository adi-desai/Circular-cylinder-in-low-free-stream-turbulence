clear all; clc;
% cd ../../pressure_measurments/
cd pressure_measurements\
addpath scripts\

run_name='fst_006';
cd files_design; theta= load('Theta_middle complete.xls'); cd ..; %theta data for x axis
cd files_raw; cd (run_name); files = dir('*.xls'); %files(31,:)=[];
file=files(24); a=load(file.name); cd ../..
cd files_coeff_series; cd (run_name); files = dir('*.txt'); 
file=files(24); b=load(file.name); cd ../..

%% processing & plotting the time series

clf; set(gcf,'Units','centimeters','Position',[2,2,17,9]);

clearvars t_array t_i t_f j_i j_f p q Cp;
clearvars t1 t2 t3 t4 j1 j2 j3 j4;
Fs = 500;

t_array = [90 95];
t_i = t_array(1,1);               t_f = t_array(1,2);
j_i = Fs*t_i;                     j_f = Fs*t_f;

t1 = 91.37;                     t2 = 91.74;
j1 = Fs*t1;                     j2 = Fs*t2;
t3 = 92.59;                     t4 = 94.16;
j3 = Fs*t3;                     j4 = Fs*t4;

t = t_i:(1/Fs):t_f;%-(1/Fs);
p = a(j_i:j_f,52:99); % fst006- 52:99, higer fst- 51:98
q = a(j_i:j_f,1); Cp=bsxfun(@rdivide,p,q); Cp(:,end+1)=Cp(:,1);

cl = b(j_i:j_f,3);
cl1 = b(j1,3); cl2 = b(j2,3); cl3 = b(j3,3); cl4 = b(j4,3);

ax1=subplot(2,3,[1 2]); [X,Y]=meshgrid(t,theta);
pcolor(X,Y,Cp'); 
shading interp; caxis([-3 1]); colormap(jet);
ylabel('$\theta(^o)$','Interpreter','latex'); tit1=title('(a)','FontWeight','normal');
h = colorbar; set(h,'FontName','Times New Roman','location','northoutside');
ylabel(h,'$C_p$','Interpreter','latex');

mk_sz1 = 9;
ax2=subplot(2,3,[4 5]); tit2=title('(b)','FontWeight','normal');
set(gca,'xgrid','on','ygrid','on','Ylim',[-1 1]); 
ylabel('$C_l$','Interpreter','latex'); 
xlabel('$t(s)$','Interpreter','latex');
hold(gca,'all'); plot(t,cl,'-b'); 
plot(t1, cl1, 'k.','markersize',mk_sz1); tx1 = text(t1-.1, cl1+.2,'$i$','interpreter','latex');
plot(t2, cl2, 'k.','markersize',mk_sz1); tx2 = text(t2, cl2-.2,'$ii$','interpreter','latex'); 
plot(t3, cl3, 'k.','markersize',mk_sz1); tx3 = text(t3+.1, cl3+.2,'$iii$','interpreter','latex'); 
plot(t4, cl4, 'k.','markersize',mk_sz1); tx4 = text(t4+.1, cl4-.1,'$iv$','interpreter','latex');
hold off;

yy=[-1 -1 1 1];
col1=[1 .84 .1]; col2=[.72 .27 1]; 
p1=patch([91.668 92.320 92.320 91.668],yy,col1); p1.EdgeColor='none'; p1.FaceAlpha=0.3; 
p2=patch([94 94.296 94.296 94],yy,col2); p2.EdgeColor='none'; p2.FaceAlpha=0.3;

% No VS-LSB: plotting Cpbar for instances of + and - cl
clearvars p1 p2 q1 q2 Cp1 Cp2;
mk_sz=3;% marker size in line plots

p1 = a(j1,52:99);              p2 = a(j2,52:99); % fst006- 52:99, higer fst- 51:98
q1 = a(j1,1);                  q2 = a(j2,1);
Cp1 = bsxfun(@rdivide,p1,q1);  Cp2 = bsxfun(@rdivide,p2,q2); 
Cp1(:,end+1) = Cp1(:,1);       Cp2(:,end+1) = Cp2(:,1);

ax3=subplot(2,3,3); tit3=title('(c)','FontWeight','normal');
set(gca,'xgrid','on','ygrid','on','XTick',[0 90 180 270 360],... 
        'ylim',[-3 1],'xlim',[0 360]);
ylabel('$C_p$','interpreter','latex'); 
hold(gca,'all'); 
plot(theta,Cp1,'-', 'markersize',mk_sz, 'color',[0.0660 0.4430 0.7450]); 
plot(theta,Cp2,'-', 'markersize',mk_sz, 'color',[0.8660 0.3290 0.0000]);
leg1 =legend('$i$','$ii$');
set(leg1,'Location', 'South','box','off','interpreter','latex','NumColumns',2); 
hold off;

% VS-LSB: plotting Cpbar for instances of + and - cl
clearvars p3 p4 q3 q4 Cp3 Cp4;
mk_sz=3;% marker size in line plots

p3 = a(j3,52:99);               p4 = a(j4,52:99); % fst006- 52:99, higer fst- 51:98
q3 = a(j3,1);                   q4 = a(j4,1);
Cp3 = bsxfun(@rdivide,p3,q3);   Cp4 = bsxfun(@rdivide,p4,q4); 
Cp3(:,end+1) = Cp3(:,1);        Cp4(:,end+1) = Cp4(:,1);

ax4=subplot(2,3,6); tit4=title('(d)','FontWeight','normal');
set(gca,'xgrid','on','ygrid','on','XTick',[0 90 180 270 360],... 
        'ylim',[-3 1],'xlim',[0 360]);
ylabel('$C_p$','interpreter','latex'); 
xlabel('\theta (^o)'); hold(gca,'all'); 
plot(theta,Cp3,'-', 'markersize',mk_sz, 'color',[0.2310 0.6660 0.1960]); 
plot(theta,Cp4,'-', 'markersize',mk_sz, 'color',[0.5210 0.0860 0.8190]);
leg2 =legend('$iii$','$iv$');
set(leg2,'Location', 'North', 'box','off','interpreter','latex','NumColumns',2); 
hold off;

% set common attributes for the subplots

set(findobj(gcf,'type','axes'),'YMinorTick','on','XMinorTick','on',...
    'box','on', 'layer','top', 'FontSize',9,'FontName','Times New Roman');

ax1.XTickLabel=[]; ax1.YTick=[0 180 360]; %ax1.XLim=[t1 t2];
ax1.Position=[0.09,0.5,0.49,0.34]; h.Position = [0.09, 0.858, 0.49, 0.05];
ax2.Position=[0.09,0.11,0.49,0.34]; %ax2.XLim=[t1 t2];
ax3.XTickLabel=[];
ax3.Position=[0.69,0.5,0.25,0.35];
ax4.Position=[0.69,0.11,0.25,0.35];
set(tit1,'Units','normalized','Position',[-0.14,0.9]);
set(tit2,'Units','normalized','Position',[-0.14,0.9]);
set(tit3,'Units','normalized','Position',[-0.2,0.9]);
set(tit4,'Units','normalized','Position',[-0.2,0.9]);
tx1.FontName = 'Times New Roman'; tx1.FontSize = 9;
tx2.FontName = 'Times New Roman'; tx2.FontSize = 9;
tx3.FontName = 'Times New Roman'; tx3.FontSize = 9;
tx4.FontName = 'Times New Roman'; tx4.FontSize = 9;

%% saving
% cd ../manuscript_prf/figures/
cd ..
set(gcf,'Renderer','opengl');
nm_str='cp_series_n_inst_fst006_re382k'; 
print(gcf,nm_str,'-depsc','-r1200');
% cd ../figure_codes; clipboard('copy',nm_str);
