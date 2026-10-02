clearvars; clc

cd C:\Users\flowcon_user\Desktop\docs_aditya\other_projects\cyl_fst_paper\;
cd pressure_measurements;

cd files_literature_data; 
a = importdata('Drag_schewe_1983.txt');
b = load('Cd_Schewe_1983.xls'); 
cd ..

Re_1 = a(:,1); D_1 = a(:,2); % Re and drag force
Re_2 = b(:,1); Cd_2 = b(:,2); % Re and Cd

%% plotting
mk_sz = 3;
fs = 10;

clf; 
set(gca, 'Position',[0.13 0.14 0.78 0.71], 'Xlim',[1e5 5e5]);

yyaxis left; 
set(gca, 'Ylim', [0 1.2], 'YTick',[0 0.3 0.6 0.9 1.2]);
xlabel('$Re$', 'interpreter','latex');
ylabel('$\overline{C}_d$', 'interpreter','latex');
set(gca, 'Ycolor','b'); 
hold(gca, 'all');
plot(Re_2, Cd_2, 'bs', 'MarkerSize',mk_sz, 'MarkerFaceColor','b');

yyaxis right; 
ylim([0 20]); %yticks = 16*[0 0.25 0.5 0.75 1.0 1.25];
ylabel('$\overline{D}$(N)', 'interpreter','latex');
set(gca, 'Ycolor','k'); 
hold(gca, 'all');
plot(Re_1, D_1, '-ko', 'MarkerSize',mk_sz, 'MarkerFaceColor','k'); 
hold off;

l_1 = xline(288200); set(l_1, 'LineStyle', '--', 'LineWidth',1.5, 'Color',3*[0.1, 0.1, 0.1]);
l_2 = xline(356800); set(l_2, 'LineStyle', '--', 'LineWidth',1.5, 'Color',3*[0.1, 0.1, 0.1]);

%% add annotations

% set common axes attributes
set(gcf, 'Units','centimeters', 'Position',[2 7 14 8]); 
set(gca, 'XGrid','on', 'YGrid','on', 'Box','on', 'Layer','top', ...
    'FontSize',fs, 'FontName','Times New Roman', 'Position',[0.13 0.14 0.78 0.71],...
    'xminortick','on','yminortick','on', 'Xlim',[1e5 5e5]);

re1 = 1e5;      % leftmost Re
re2 = 2.882e5;  % end of first regime
re3 = 3.568e5;  % end of second regime
re4 = 5e5;      % end of last regime

x0=0.13; width=0.78; % figure(axes) parameters

x1 = x0; 
x2 = (re2-re1)*width /4e5 +x0; 
x3 = (re3-re1)*width /4e5 +x0;
x4 = (re4-re1)*width /4e5 +x0;
hd_l = 6;  % arrowhead length
hd_w = 4;    % arrowhead width
annotation(gcf,'doublearrow',[x1+.001 x2-.001],[0.9 0.9],...
    'Head2Style','plain','Head2Length',hd_l,'Head2Width',hd_w,...
    'Head1Style','plain','Head1Length',hd_l,'Head1Width',hd_w);
annotation(gcf,'doublearrow',[x2+.001 x3-.001],[0.9 0.9],...
    'Head2Style','plain','Head2Length',hd_l,'Head2Width',hd_w,...
    'Head1Style','plain','Head1Length',hd_l,'Head1Width',hd_w);
annotation(gcf,'doublearrow',[x3+.001 x4-.001],[0.9 0.9],...
    'Head2Style','plain','Head2Length',hd_l,'Head2Width',hd_w,...
    'Head1Style','plain','Head1Length',hd_l,'Head1Width',hd_w);
% text annotations
annotation(gcf,'textbox',[x1,0.92,x2-x1,0.03],'EdgeColor','none',...
    'VerticalAlignment','middle','String','Subcritical',...
    'HorizontalAlignment','center','FontName','Times New Roman','FontSize',fs,...
    'FitBoxToText','off','Interpreter','latex');
annotation(gcf,'textbox',[x2,0.92,x3-x2,0.03],'EdgeColor','none',...
    'VerticalAlignment','middle','String','Critical',...
    'HorizontalAlignment','center','FontName','Times New Roman','FontSize',fs,...
    'FitBoxToText','off','Interpreter','latex');
annotation(gcf,'textbox',[x3,0.92,x4-x3,0.03],'EdgeColor','none',...
    'VerticalAlignment','middle','String','Supercritical',...
    'HorizontalAlignment','center','FontName','Times New Roman','FontSize',fs,...
    'FitBoxToText','off','Interpreter','latex');

% arrow indicating the first transition
annotation(gcf, 'arrow',[0.5448 0.5338], [0.6721 0.5235], 'color','r');
% arrow indicating the second transition
annotation(gcf, 'arrow',[0.5911 0.6302], [0.5310 0.3739],'Color','r');

%% saving
% cd ../manuscript_prf/figures/;
cd C:\Users\flowcon_user\Desktop\docs_aditya\other_projects\cyl_fst_paper\

set(gcf,'renderer','painters');
nm_str='flow_regimes_schewe_1983'; 
clipboard('copy',nm_str); 

cd figures; print(gcf, nm_str, '-depsc', '-r1200');
cd ../fig_matlab_format/; saveas(gcf, [nm_str,'.fig'])
cd ..
