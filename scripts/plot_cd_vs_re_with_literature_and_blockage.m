% This script plots two subfigures. first with literature and uncorrected
% Cd and the second with corrected and uncorrected Cd. 
% The corrected Cd used in this script are calculated using Allen and Vincenti method

clearvars; clc;
% cd ../../../
cd C:\Users\flowcon_user\Desktop\docs_aditya\other_projects\cyl_fst_paper;
cd pressure_measurements/

% load data
cd files_literature_data; 
data_1 = load('Cd_Farrel_1983.xls'); 
data_2 = load('Cd_Schewe_1983.xls');
data_3 = load('Desai_et_al 2020_fst006.txt'); cd ..
% data_3 = load('Desai_et_al 2020_fst040.xls'); cd ..
cd 'files_mean coeff';
% without blockage correction
run='fst_006'; nm1=[run,'_CdCl.xls']; data_4 = importdata(nm1); data_4(31,:)=[]; 
run='fst_051'; nm1=[run,'_CdCl.xls']; data_5 = importdata(nm1); 

% corrected for blockage
run='fst_006'; nm1 = [run,'_cdcl_corrected_AnV.txt']; c_1 = readcell(nm1);
data_6 = cell2mat( c_1(2:end,:) );
run='fst_051'; nm2 = [run,'_cdcl_corrected_AnV.txt']; c_2 = readcell(nm2);
data_7 = cell2mat( c_2(2:end,:) );

% set plotting features
mk_sz = 4.5;    % markersize
fs = 10;        % fontsize
%% extraction and plotting

Re1=data_1(:,1); Re2=data_2(:,1); Re3=data_3(:,1); Re4=data_4(:,1); 
cd1=data_1(:,2); cd2=data_2(:,2); cd3=data_3(:,2); cd4=data_4(:,2);
Re5 = data_5(:,1); cd5 = data_5(:,2);

Re6 = data_6(:,1); cd6 = data_6(:,2); Re7 = data_7(:,1); cd7 = data_7(:,2);

clf;
ax1 = subplot(121);

plot(Re1,cd1,'kv','MarkerSize',mk_sz, 'MarkerFaceColor','k'); hold on;
plot(Re2,cd2, 'LineStyle','none', 'color',[.12,.76,.13], 'Marker','^',...
    'MarkerSize',mk_sz, 'MarkerFaceColor',[.12 .76 .13]); 
plot(Re3, cd3, 'md', 'MarkerSize',mk_sz);
% plot(Re3,cd3, 'LineStyle','none', 'color', 'Magenta', 'Marker','hexagram', 'MarkerSize',mk_sz); 
plot(Re4,cd4,'bo','MarkerSize',mk_sz);
plot(Re5,cd5,'rs','MarkerSize',mk_sz); hold off;

leg_1 = legend('Farell and Blessman (1983)','Schewe (1983)', 'Desai et. al. (2020)',...
        'Present study, clean flow', 'Present study, $T_u = 0.51\%$');
set(leg_1,'box','off','NumColumns',1,'location','northeast',...
    'interpreter','latex','Position',[.19, .709, .302, .21]);

ylabel('$\overline{C}_d$','interpreter','latex','FontWeight','bold')
xlabel('$Re$','interpreter','latex','FontWeight','bold');

tit_1 = title('(a)');
set(tit_1, 'Units','normalized', 'Position',[-0.1348 0.9169 0], ...
    'FontWeight','normal');

% subfig (b)

ax2 = subplot(122);
plot(Re4,cd4,'bo','MarkerSize',mk_sz); hold on;
plot(Re4,cd6,'bo','MarkerSize',mk_sz, 'MarkerFaceColor','b');
plot(Re5,cd5,'rs','MarkerSize',mk_sz);
plot(Re5,cd7,'rs','MarkerSize',mk_sz, 'MarkerFaceColor','r'); hold off;

xlabel('$Re$','interpreter','latex','FontWeight','bold');

leg_2 = legend('Clean flow', 'Clean flow: corrected',...
    '$T_u = 0.51\%$', '$T_u = 0.51\%$: corrected');
set(leg_2,'box','off','NumColumns',1,'location','northeast',...
    'interpreter','latex', 'Position',[0.70, 0.751, 0.26, 0.168]);

tit_2 = title('(b)');
set(tit_2, 'Units','normalized', 'Position',[-0.1 0.9169 0], ...
    'FontWeight','normal');

%% figure parameters

set(gcf,'Units','centimeters','Position',[3 3 17 10]);
set(findobj(gcf, 'type','axes'), 'YMinorTick','on', 'YGrid','on','XGrid','on',...
    'box','on','Layer','top','FontSize',fs,'FontName','Times New Roman',...
    'Xlim',[1e5 6e5], 'Ylim',[0 1.5]);
ax2.YTickLabel = [];
ax1.Position = [0.09    0.12    0.4    0.8];
ax2.Position = [0.56    0.12    0.4    0.8];
% manually adjust legend to fit in the right top corner

%% saving
% cd ../manuscript_prf/figures/;
cd C:\Users\flowcon_user\Desktop\docs_aditya\other_projects\cyl_fst_paper\

set(gcf,'renderer','painters');
nm_str='cd_vs_re_with_literature_and_blockage_v3'; 
clipboard('copy',nm_str); 

cd figures; print(gcf, nm_str, '-depsc', '-r1200');
cd ../fig_matlab_format/; saveas(gcf, [nm_str,'.fig'])
cd ..