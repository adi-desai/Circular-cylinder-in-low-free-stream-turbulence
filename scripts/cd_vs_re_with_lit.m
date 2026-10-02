clearvars; clc;
% cd ../../../
cd C:\Users\flowcon_user\Desktop\docs_aditya\other_projects\cyl_fst_paper;
cd pressure_measurements/

cd files_literature_data; 
data_1 = load('Cd_Farrel_1983.xls'); 
data_2 = load('Cd_Schewe_1983.xls');
data_3 = load('Desai_et_al 2020_fst006.txt'); cd ..
% data_3 = load('Desai_et_al 2020_fst040.xls'); cd ..
cd 'files_mean coeff';

choice = input('Use data corrected for blockage? enter y or n \n');
    if choice == 'y'
        run='fst006_1'; nm1 = [run,'_CdCl.txt']; c_1 = readcell(nm1);
        data_4 = cell2mat( c_1(2:end,:) );
        run='fst040_1'; nm2 = [run,'_CdCl.txt']; c_2 = readcell(nm2);
        data_5 = cell2mat( c_2(2:end,:) );
        else
        run='fst006_1'; nm1=[run,'_CdCl.xls']; data_4 = importdata(nm1);
        run='fst040_1'; nm1=[run,'_CdCl.xls']; data_5 = importdata(nm1); 
    end
 cd ..;

%% extraction and plotting

data_4(31,:)=[]; 
Re1=data_1(:,1); Re2=data_2(:,1); Re3=data_3(:,1); Re4=data_4(:,1); 
cd1=data_1(:,2); cd2=data_2(:,2); cd3=data_3(:,2); cd4=data_4(:,2);
Re5 = data_5(:,1); cd5 = data_5(:,2);

% clf; 
figure()
mk_sz=4; %markersize
fs=10; %fontsize
set(gca,'YMinorTick','on','YGrid','on','XGrid','on','box','on','Layer','top', ...
    'PlotBoxAspectRatio',[1.5 1 1],'FontSize',fs,'FontName','Times New Roman');
xlim([1e5 6e5]); xlabel('$Re$','interpreter','latex','FontWeight','bold');
ylim([0 1.4]); ylabel('$\overline{C}_d$','interpreter','latex','FontWeight','bold')
hold(gca,'all');
plot(Re1,cd1,'-v','MarkerSize',mk_sz); 
plot(Re2,cd2,'-s','MarkerSize',mk_sz); 
plot(Re3,cd3,':^'); 
plot(Re4,cd4,':*','MarkerSize',mk_sz);
plot(Re5,cd5,':d','MarkerSize',mk_sz);

leg=legend('Farell and Blessman(1983)','Schewe (1983)', 'desai (2020)',...
        'Present study, clean flow', 'present study, T_u = 0.51%');
set(leg,'box','off','NumColumns',1,'location','northeast');
set(gcf,'Units','centimeters','Position',[3 3 12 8]);
set(gcf,'renderer','painters');

%% saving
cd ../manuscript_nov2022/figures/
print(gcf,'cd_vs_re_with_lit','-depsc','-r1200');
cd codes;
