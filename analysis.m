clc,clear, close all, warning off

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

% 初始化油价

Price(:,1) = gamrnd(16,10,N,1); % 初始油价

% 模拟油价随时间变化
for n=1:N
    for t = 2:T
        % 随机波动（布朗运动部分）
        random_shock = sigma * randn(); 
        % 季节性成分（正弦波）
        seasonal_component =  5 * sin(2 * pi * t / seasonal_period);
        % 长期趋势 + 随机波动 + 季节性成分
        Price(n,t) = Price(n,t-1) + trend + seasonal_component + random_shock;
    end
end

correlation =corrcoef(Price); 
A_masked = correlation;                       % 复制原矩阵
A_masked(triu(true(size(A_masked)), 1)) = NaN; % 屏蔽上三角部分（不包括对角线）

% 可视化矩阵
figure(1)
pcolor(A_masked);                % 绘制伪彩色图
shading flat;                    % 去除网格线，使图更美观
colorbar;                        % 添加颜色条

% 设置颜色映射，使 NaN 显示为白色
colormap(jet);                   % 使用 jet 颜色映射
caxis([min(correlation(:)), max(correlation(:))]); % 设置颜色范围
set(gca, 'Color', [1, 1, 1]);    % 将背景颜色设置为白色

% 设置图形属性
set(gca, 'YColor', 'k', 'FontName', 'Times New Roman', 'FontSize', 14);
xlabel('Port Index', 'FontSize', 14);
ylabel('Port Index', 'FontSize', 14);