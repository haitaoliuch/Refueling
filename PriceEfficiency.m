clc, clear, close all, warning off
% 数据输入
periods = [6, 9, 12, 18, 36]; % 周期
data = [375240, 378030, 370514, 374330, 378859, 375870, 372316, 369088, 378242, 373103;  % 6个月的周期
        389527, 385369, 383079, 383881, 385582, 380286, 386295, 378215, 376060, 370604;  % 9个月的周期
        394621, 394873, 396058, 386612, 399542, 389436, 393881, 396045, 390393, 386681;  % 12个月的周期
        419952, 420494, 402284, 405810, 409244, 414663, 404841, 402245, 403730, 403869;  % 18个月的周期
        469117, 471072, 478446, 474889, 469834, 462902, 468767, 463376, 468245, 462835]; % 36个月的周期

% 计算均值
means = mean(data, 2); % 每组数据计算均值

% 绘制箱型图
figure;
boxplot(data', 'Labels', string(periods)); % 转置数据以符合箱型图格式
xlabel('Seasonality Intervals'); % 设置x轴标签
ylabel('ARC'); % 设置y轴标签
grid on; % 显示网格线
hold on; % 保持当前图像，便于叠加新的图形

% 添加均值折线
plot(1:length(periods), means, '-o', 'Color', 'r', 'LineWidth', 1.5, 'MarkerSize', 8, 'MarkerFaceColor', 'r'); 
% 使用红色线连接均值，带圆形标记
set(gca,'FontName', 'Times New Roman', 'FontSize', 14);
% 图例
legend('Mean', 'Location', 'best','FontName', 'Times New Roman'); % 添加图例，标注均值线

% 数据准备
% parameters = {'(16,2)', '(16,4)', '(16,6)', '(16,8)'};
% RPL = [47600, 48200, 56300, 52500];        % GPAOAP3/RPL - 红色
% GPUCB = [80350, 72100, 70000, 103000];     % GPUCB - 绿色
% Rule1 = [143000, 143000, 143000, 143000];  % Rule1 - 蓝色
% Rule2 = [185000, 193000, 201000, 208000];  % Rule2 - 品红
% 
% % 创建矩阵用于柱状图
% data = [RPL; GPUCB; Rule1; Rule2]';
% 
% % 创建图形
% figure('Position', [100, 100, 900, 600], 'Color', 'w'); 
% 
% % 绘制分组柱状图
% h = bar(data, 'grouped', 'BarWidth', 0.8);
% set(gca, 'FontSize', 12,  'LineWidth', 1.5);
% grid on
% 
% % 使用论文中的颜色方案
% colors = [1 0 0;   % 红色 - RPL (GPAOAP3)
%           0 1 0;   % 绿色 - GPUCB
%           0 0 1;   % 蓝色 - Rule1
%           1 0 1];  % 品红 - Rule2
% 
% % 应用颜色
% for k = 1:4
%     h(k).FaceColor = colors(k, :);
%     h(k).EdgeColor = 'k';
%     h(k).LineWidth = 1.2;
%     h(k).FaceAlpha = 0.85; % 透明度
% end
% 
% % 添加标题和标签
% xlabel('Shape and Scale Parameters', 'FontSize', 14);
% ylabel('ARC', 'FontSize', 14);
% 
% % 设置x轴刻度
% set(gca, 'XTickLabel', parameters, 'XTick', 1:length(parameters));
% 
% % 将图例放置在图表内部右上角
% legend({'RPL', 'GPUCB', 'Rule 1', 'Rule 2'}, ...
%        'Location', 'northeast', ...  % 东北角（右上角）
%        'FontSize', 12, ...
%        'Box', 'off', ...            % 无边框
%        'Color', [0.95 0.95 0.95]);  % 浅灰色背景提高可读性
% 
% % 设置y轴范围
% ylim([0 220000]);
% 
% % 添加网格
% set(gca, 'YGrid', 'on', 'GridLineStyle', '--', 'GridAlpha', 0.1,'FontName', 'Times New Roman');
% 
% % 优化布局
% set(gcf, 'Color', 'w'); % 白色背景
% box on

    

clc, clear, close all, warning off
% load('..\GPUCB\Result\PerComSI\GPAOAP3_SI3_N1000.mat')
% x1=cumsum(reward.tc,2,'reverse'); 
% load('..\GPUCB\Result\PerComSI\GPUCB_SI3_N1000.mat')
% x2=cumsum(reward.tc,2,'reverse'); 
% load('..\GPUCB\Result\PerComSI\Rule1_SI3_N1000.mat')
% x3=cumsum(reward.tc,2,'reverse'); 
% load('..\GPUCB\Result\PerComSI\Rule2_SI3_N1000.mat')
% x4=cumsum(reward.tc,2,'reverse'); 
% boxplot([x1(:,1),x2(:,1),x3(:,1),x4(:,1)],{'RPL','GPUCB','Rule 1','Rule 2'})
% set(gca,'YColor', 'k','FontName', 'Times New Roman','FontSize',14)
%  box on; % grid on
%  a=[x1(:,1),x2(:,1),x3(:,1),x4(:,1)];
%  ylabel('ARC','FontName', 'Times New Roman')
%  legend()
% print('-painters','-depsc','T16ind')


% clc,clear, close all, warning off
% % x=400:200:2500;
% load('..\GPUCB\Result\PerComCor2M\GPAOAP3_S4_N1000.mat')
% x(1)=reward.mean;
% load('..\GPUCB\Result\PerComCor2M\GPUCB_S4_N1000.mat')
% x(2)=reward.mean;
% load('..\GPUCB\Result\PerComCor2M\Rule1_S4_N1000.mat')
% x(3)=reward.mean;
% load('..\GPUCB\Result\PerComCor2M\Rule2_S4_N1000.mat')
% x(4)=reward.mean; hold on
% 
% % boxplot([x1,x2,x3],'Labels',{'GPBPL','Rule1','Rule2'}); 
% plot(x,x1(x),'r--s','LineWidth',1.2,'MarkerSize',10)
% plot(x,x2,'g--o','LineWidth',1.2,'MarkerSize',10)
% plot(x,x3,'b--*','LineWidth',1.2,'MarkerSize',10)
% plot(x,x4,'m--p','LineWidth',1.2,'MarkerSize',10)
% set(gca,'YColor', 'k','FontName', 'Times New Roman','FontSize',14); xlim([min(x) max(x)])
%  box on; % grid on
%  ylabel('ARC','FontName', 'Times New Roman')
%  legend('RPL','GPUCB','Rule 1','Rule 2')
% print('-painters','-depsc','T16ind')


% clc,clear, close all, warning off
% x=0:10:90;
% load('..\GPUCB\Result\PerComInd\GPAOAP3_P1_N1000.mat')
% x1=reward.cum(:,1);
% load('..\GPUCB\Result\PerComInd\GPUCB_P1_N1000.mat')
% x2=reward.cum(:,1);
% 
% load('..\GPUCB\Result\PerComInd\Rule1_P1_N1000.mat')
% x3=reward.cum(:,1);
% load('..\GPUCB\Result\PerComInd\Rule2_P1_N1000.mat')
% x4=reward.cum(:,1); hold on
% % boxplot([x1,x2,x3],'Labels',{'GPBPL','Rule1','Rule2'}); 
% plot(x,x1,'r--s','LineWidth',1.2,'MarkerSize',10)
% plot(x,x2,'g--o','LineWidth',1.2,'MarkerSize',10)
% plot(x,x3,'b--*','LineWidth',1.2,'MarkerSize',10)
% plot(x,x4,'m--p','LineWidth',1.2,'MarkerSize',10)
% set(gca,'YColor', 'k','FontName', 'Times New Roman','FontSize',14); xlim([min(x) max(x)])
%  box on; % grid on
%  ylabel('ARC','FontName', 'Times New Roman')
%  legend('RPL','GPUCB','Rule 1','Rule 2')
% print('-painters','-depsc','T16ind')


%% case study
% clc,clear, close all, warning off
% x=0:10:90;
% load('..\GPUCB\Result\CaseStudy\GPAOAP3_CS_N1000.mat')
% x1=reward.cum(:,1);
% load('..\GPUCB\Result\CaseStudy\GPUCB_CS_N1000.mat')
% x2=reward.cum(:,1);
% 
% load('..\GPUCB\Result\CaseStudy\Rule1_CS_N1000.mat')
% x3=reward.cum(:,1);
% load('..\GPUCB\Result\CaseStudy\Rule2_CS_N1000.mat')
% x4=reward.cum(:,1); hold on
% % boxplot([x1,x2,x3],'Labels',{'GPBPL','Rule1','Rule2'}); 
% plot(x,x1,'r--s','LineWidth',1.2,'MarkerSize',10)
% plot(x,x2,'g--o','LineWidth',1.2,'MarkerSize',10)
% plot(x,x3,'b--*','LineWidth',1.2,'MarkerSize',10)
% plot(x,x4,'m--p','LineWidth',1.2,'MarkerSize',10)
% set(gca,'YColor', 'k','FontName', 'Times New Roman','FontSize',14); xlim([min(x) max(x)])
%  box on; % grid on
%  ylabel('ARC','FontName', 'Times New Roman')
%  legend('RPL','GPUCB','Rule 1','Rule 2')
% print('-painters','-depsc','CS_Uniform')



clc,clear, close all, warning off
mu=0.0;      % drift
sigma=0.05;   % std dev over total inverval
T = 46; W=0;
dt = sigma/sqrt(T-1);   % local volatility
N=2000; P='P4'; 
pro = Problem(P); 

for n=1:N
   % initial inventory 
    Price(n,1) = gamrnd(pro.shape(1),pro.scale(1));
    for t=1:T-1          
        cor= pro.shape(t+1)*pro.scale(t+1)/(pro.shape(t)*pro.scale(t));
        Price(n,t+1) =Price(n,t)*cor+ normrnd(0,2);       
    end
end
correlation =corrcoef(Price);
figure(2)
pcolor(correlation);
colorbar;
sigma=0.05;   % std dev over total inverval
T = 36; W=0;
dt = sigma/sqrt(T-1);   % local volatility
N=2000; P='P4'; 
pro = Problem(P); 
T = 36; % 时间长度（对应T个港口）
% dt = 1; % 时间步长
seasonal_period = 4; % 季节性周期（假设每20个港口有一个季节性周期）
sigma = 3; % 随机波动幅度
mu = 100; % 平均油价
trend = 0.05; % 长期趋势（每时间步长）
for n=1:N
   % initial inventory 
    Price(n,1) = gamrnd(pro.shape(1),pro.scale(1));
    for t=1:45          
        cor= pro.shape(t+1)*pro.scale(t+1)/(pro.shape(t)*pro.scale(t));
                random_shock = sigma * randn(); 
        % 季节性成分（正弦波）
        seasonal_component =  5 * sin(2 * pi * t / seasonal_period);
        Price(n,t+1) =Price(n,t)*cor+ trend + seasonal_component + random_shock;
        % Price(n,t+1) =Price(n,t)*cor+ max(normrnd(0,2),0);         
    end
end
correlation =corrcoef(Price); A=triu(correlation,1); mean(A(A>0))
figure(3)
pcolor(correlation);
colorbar;
% ylabel('PCS','FontName', 'Times New Roman')
% xlabel('Budget' , 'Interpreter','LaTex')
set(gca,'YColor', 'k','FontName', 'Times New Roman','FontSize',14);% xlim([min(x) max(x)])
%legend({'{ADP}','ADPd','OCBAm','{OCBAm+}','{EA}'},'Location','best')
% box on; grid on
print('-painters','-depsc','Cor2P16')



