function s =TransitionSeasonal(s,a,t,pro)
    s(1) =s(1)+a-pro.D(t,t+1);
    % cor= pro.shape(t+1)*pro.scale(t+1)/(pro.shape(t)*pro.scale(t));
   % s(2) =s(2)*cor+max(normrnd(0,2),0); 
%  T = 40; % 时间长度（对应60个港口）
% dt = 1; % 时间步长
seasonal_period = pro.seasonal_period; % 季节性周期（假设每20个港口有一个季节性周期）
sigma = 3; % 随机波动幅度
% mu = 70; % 平均油价
trend = 0.05; % 长期趋势（每时间步长）

% % 初始化油价
% oil_price = zeros(1, T);
% oil_price(1) = mu; % 初始油价

% 模拟油价随时间变化
% for t = 2:T
    % 随机波动（布朗运动部分）
    random_shock = sigma * randn();
    
    % 季节性成分（正弦波）
    seasonal_component = 5 * sin(2 * pi * t / seasonal_period);
    
    % 长期趋势 + 随机波动 + 季节性成分
    s(2) = s(2) + trend + seasonal_component + random_shock;
end