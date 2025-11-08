seasonality = [6, 9, 12, 18, 36];
% 后续行是不同横坐标(0,10,...,90)对应的百分比值
data = [
    6.83, 10.09, 11.36, 30.97, 13.61;  % 0
    11.57, 9.21, 8.86, 25.99, 17.19;   % 10
    5.97, 6.69, 2.93, 19.38, 13.95;    % 20
    4.63, 9.94, 5.40, 20.99, 12.54;    % 30
    6.04, 8.20, 12.70, 21.51, 14.79;   % 40
    1.33, 7.10, 5.67, 18.77, 12.83;    % 50
    10.20, 8.05, 8.42, 21.08, 12.84;   % 60
    7.78, 2.01, 11.68, 22.13, 10.70;   % 70
    13.43, 8.58, 2.27, 22.50, 15.79;   % 80
    7.90, 6.37, 7.43, 20.61, 12.73;    % 90
];

% 横坐标
x = 0:10:90;

% 创建图形
figure('Units', 'inches', 'Position', [1, 1, 8, 6], 'Color', 'w');
hold on;

% 设置线条样式和颜色
line_styles = {'-', '--', '-.', ':', '-'};
markers = {'o', 's', '^', 'd', 'p'};
colors = lines(5);  % 生成5种不同的颜色

% 绘制每条折线
for i = 1:length(seasonality)
    plot(x, data(:, i), ...
         'LineStyle', line_styles{i}, ...
         'Marker', markers{i}, ...
         'Color', colors(i, :), ...
         'LineWidth', 1.5, ...
         'MarkerSize', 6, ...
         'MarkerFaceColor', colors(i, :));
end

% 图形美化
set(gca, ...
    'FontName', 'Times New Roman', ...
    'FontSize', 12, ...
    'XTick', x, ...  % 设置横坐标刻度
    'XGrid', 'on', ...
    'YGrid', 'on', ...
    'GridLineStyle', ':', ...
    'Box', 'on');

% 添加标签和标题
xlabel('Initial Fuel Inventory Levels', 'FontName', 'Times New Roman', 'FontSize', 14);
ylabel('Improvement Ratios (%)', 'FontName', 'Times New Roman', 'FontSize', 14);
% 添加图例
legend(cellstr(num2str(seasonality', 'Seasonality Interval: %d')), ...
       'Location', 'best', ...
       'FontName', 'Times New Roman', ...
       'FontSize', 14);

% 调整纵坐标范围，更好地展示数据
ylim([0, max(data(:)) * 1.05]);
print('-painters','-depsc','full')


clc,clear, close all, warning off
N=2000; P='P1'; R =20;
T = 16; 
pro = Problem(P); mu_true = pro.shape(1:T).*pro.scale(1:T);
for r=1:30
    Price=[];
    for n=1:N
        Price(n,1) = gamrnd(pro.shape(1),pro.scale(1));
        for t =1:T-1
            Price(n,t+1) = Price(n,t)*pro.shape(t+1)*pro.scale(t+1)/(pro.shape(t)*pro.scale(t));
        end
        mu_sa = mean(Price);
        d_sa(n,r)  = norm(mu_sa-mu_true',2);
    end

    k_max =pro.T+4;  
    for n=1:N 
        if n> k_max  
            if mod(n,10)==0
                options = statset('MaxIter',500);
                parfor k = 1 : k_max
                    GMM{k} = fitgmdist((Price(1:n,:)),k,'Options',options,'RegularizationValue',0.1);
                    AIC(k)= GMM{k}.AIC;
                end
                [~,k_best] = min(AIC);
                mu_n = GMM{k_best}.ComponentProportion*GMM{k_best}.mu;
                KC(n,r)=norm(mu_n-mu_true',2);
            end
        end  
    end
end
d_sam = mean(d_sa,2); KC_m = mean(KC,2);
x=100:100:N;avg=mean(KC_m);
plot(x,avg(x),'m--o','LineWidth',1,'MarkerSize',10)
set(gca,'YColor', 'k','FontName', 'Times New Roman','FontSize',10);
ylabel('No. of components','FontName', 'Times New Roman')