clc; clear; close all; warning off;

% 读取数据
data = xlsread('PriceData.xlsx');
data = data(:,2:end);
nan_rows = any(isnan(data), 2);
data = data(~nan_rows, :);
data = data(:, [1,3,5,6]);
autocorr(data(:,1))
% 计算时间相关 & 空间相关
temporal_corr = autocorr(data(:,1), 'NumLags', 20);  % 对第一个城市的自相关
spatial_corr = corr(data);  % 各城市间空间相关

rowLabels = {'Hong Kong','Shanghai','Singapore','Fujairah'};
colLabels = rowLabels;

%% 创建大图窗口
fig = figure('Units','pixels', 'Position', [100, 100, 2000, 600]);

%% 左侧折线图 subplot(用 axes 实现)
ax1 = subplot('Position', [0.05, 0.15, 0.28, 0.75]);  % [left bottom width height]
hold on
plot(data(:,1), 'r-', 'LineWidth', 1.5)
plot(data(:,2), 'g-', 'LineWidth', 1.5)
plot(data(:,3), 'b-', 'LineWidth', 1.5)
plot(data(:,4), 'm-', 'LineWidth', 1.5)
ylabel('Fuel Price', 'FontName', 'Times New Roman')
xlabel('Days', 'FontName', 'Times New Roman')
xLimits = xlim();
yLimits = ylim();


% 在图像区域内部中上方添加标题
text(mean(xLimits), ...
     yLimits(2) - 0.05 * (yLimits(2) - yLimits(1)), ...  % 距离顶部一点
     'Fuel Price Trend', ...
     'HorizontalAlignment', 'center', ...
     'FontName', 'Times New Roman', ...
     'FontSize', 14, ...
     'FontWeight', 'bold');
set(gca, 'FontName', 'Times New Roman', 'FontSize', 14, 'YGrid', 'on');
xlim([1, size(data,1)])
legend(rowLabels, 'Location', 'best')
box on


%% 中间 heatmap（temporal）
panel1 = uipanel(fig, 'Units','normalized', 'Position',[0.36 0.15 0.15 0.75]);
h1 = heatmap(panel1, temporal_corr, ...
    'FontName', 'Times New Roman', ...
    'FontSize', 14, ...
    'Title', 'Temporal Correlation');
ylabel('No. of Lags')
colormap(h1, jet);

%% 右侧 heatmap（spatial）
panel2 = uipanel(fig, 'Units','normalized', 'Position',[0.54 0.15 0.3 0.75]);
h2 = heatmap(panel2, spatial_corr, ...
    'FontName', 'Times New Roman', ...
    'FontSize', 14, ...
    'Title', 'Spatial Correlation');
h2.YDisplayLabels = rowLabels;
h2.XDisplayLabels = colLabels;

colormap(h2, jet);
