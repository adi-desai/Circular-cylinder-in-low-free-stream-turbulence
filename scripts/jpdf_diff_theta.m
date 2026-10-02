clearvars; close all; clc;
cd ../../pressure_measurments/;
% cd ../../../pressure_measurments/
addpath scripts;

run='fst006_1';
cd files_raw; cd (run); files=dir('*.xls');
a=load('Re391k.xls'); cd ../..
q= a(:,1); Qinf=mean(q); 
i1=59; i2=93; % 59 and 93 for fst006, -1 for fst040 and 062

%% plotting
clf; 
set(gcf,'Units','centimeters', 'Position',[5 5 17 10]);
Xmin=-3.5; Xmax=0; dX=0.05; e1=Xmin:dX:Xmax-dX; % for fst006
pos_array=[0.09,0.47,0.14,0.34; 0.34,0.47,0.14,0.34; 
0.59,0.47,0.14,0.34; 0.84,0.47,0.14,0.34; 
0.09,0.08,0.14,0.34; 0.34,0.08,0.14,0.34;
0.59,0.08,0.14,0.34; 0.84,0.08,0.14,0.34];
th_array=[80; 84; 88; 92; 96; 100; 104; 108;];
title_array={'(a)','(b)','(c)','(d)','(e)','(f)','(g)','(h)'};

for j=1:8
ax=subplot(2,4,j); 
cp1=a(:,i1+j)./a(:,1); cp2=a(:,i2-j)./a(:,1);
n=length(e1); jpdf=zeros(n);
for ii=1:length(cp1)
    x=ceil((cp1(ii,1)-Xmin)/dX);y=ceil((cp2(ii,1)-Xmin)/dX);
    jpdf(x,y)=jpdf(x,y)+1;
end
jpdf=jpdf/length(cp1); [X,Y]=meshgrid(e1,e1);
contourf(X,Y,log10(jpdf)'); %colormap(parula) %colormap(jet);  %colormap(flipud(gray));
shading interp; caxis([-5 -2.2]); pbaspect([1,1,1]);
th1=th_array(j,1); th2=360-th1;
str1=['$C_p(',num2str(th1),'^o)$']; xlabel(str1,'Interpreter','latex');
str2=['$C_p(',num2str(th2),'^o)$']; ylabel(str2,'Interpreter','latex');
ax.Position=pos_array(j,:);
if j==7
    yline(-1.7,':r','linewidth',1.5); xline(-1.7,':r','linewidth',1.5);
else end
tit1=title(title_array{j},'fontweight','normal'); 
set(tit1,'Units','normalized','Position',[-0.4,0.95,0]);
end
h = colorbar; set(h,'FontName','Times New Roman','location','northoutside',...
'position',[0.09,0.84,0.89,0.05]); 
ylabel(h,'log_1_0(JPDF)','FontWeight','bold');
set(findobj(gcf,'type','axes'),'YGrid','on','XGrid','on','box','on',...
    'Layer','top','PlotBoxAspectRatio',[1 1 1],'Xlim',[-3.5 0],'Ylim',[-3.5 0],...
    'fontname','times new roman','fontsize',10);

annotation(gcf,'textbox',[0.69,0.32,0.06,0.06],'EdgeColor','none','String',{'$0$'},...
    'Interpreter','latex','FontSize',8,'FontName','Times New Roman');
annotation(gcf,'textbox',[0.69,0.115,0.06,0.06],'EdgeColor','none','String',{'$1b$'},...
    'Interpreter','latex','FontSize',8,'FontName','Times New Roman');
annotation(gcf,'textbox',[0.59,0.32,0.06,0.06],'EdgeColor','none','String',{'$1t$'},...
    'Interpreter','latex','FontSize',8,'FontName','Times New Roman');
annotation(gcf,'textbox',[0.59,0.115,0.06,0.06],'EdgeColor','none','String',{'$2$'},...
    'Interpreter','latex','FontSize',8,'FontName','Times New Roman');


%% saving
cd ../manuscript_nov2022/figures/
set(gcf,'Renderer','painters');
nm_str='jpdf_diff_theta'; clipboard('copy',nm_str);
print(gcf,nm_str,'-depsc','-r1200');
cd codes