function pro = Problem(options)
%% Notice that all the problem parameters can be changed.
load('para1.mat') 
switch options
    case 'P1'
    pro.T =16;  % number of stage
    pro.C =300; % bunker capacity
    pro.L  =0;  % safe bunker volume for the container ship
    pro.fc =ones(pro.T,1)*20; % fixed cost of bunker repleshiment at each stage
    pro.D  = d(1:pro.T,1:pro.T); % bunker consumption matrix
    pro.shape = shape(1:pro.T) ; % Mean of Price
    pro.scale = scale(1:pro.T); % Variance of Price
    pro.IniInventory = [0:10:90];
    case 'P2'
    pro.T =26;  % number of stage
    pro.C =300; % bunker capacity
    pro.L  =0;  % safe bunker volume for the container ship
    pro.fc =ones(pro.T,1)*20; % fixed cost of bunker repleshiment at each stage
    pro.D  = d(1:pro.T,1:pro.T); % bunker consumption matrix
    pro.shape = shape(1:pro.T) ; % Mean of Price
    pro.scale = scale(1:pro.T); % Variance of Price
    pro.IniInventory = [0:10:90];
    case 'P3'
    pro.T =36;  % number of stage
    pro.C =300; % bunker capacity
    pro.L  =0;  % safe bunker volume for the container ship
    pro.fc =ones(pro.T,1)*20; % fixed cost of bunker repleshiment at each stage
    pro.D  = d(1:pro.T,1:pro.T); % bunker consumption matrix
    pro.shape = shape(1:pro.T) ; % Mean of Price
    pro.scale = scale(1:pro.T); % Variance of Price
    pro.IniInventory = [0:10:90];
    case 'P4'
    pro.T =46;  % number of stage
    pro.C =300; % bunker capacity
    pro.L  =0;  % safe bunker volume for the container ship
    pro.fc =ones(pro.T,1)*20; % fixed cost of bunker repleshiment at each stage
    pro.D  = d(1:pro.T,1:pro.T); % bunker consumption matrix
    pro.shape = shape(1:pro.T) ; % Mean of Price
    pro.scale = scale(1:pro.T); % Variance of Price
    pro.IniInventory = [0:10:90];
    case 'CS'
    pro.T =17;  % number of stage
    pro.C =2000; % bunker capacity
    pro.L  =0;  % safe bunker volume for the container ship
    pro.fc =ones(pro.T,1)*5000; % fixed cost of bunker repleshiment at each stage
    com =[0 140.49	60.85	180.49	120.4	21.76	485.95	1855.94	295.66	20.66	76.69	116.61	391.83	229.1	526.91	480.3	388.72];
    pro.D  = zeros(pro.T,pro.T); % bunker consumption matrix
    for i =1:pro.T-1
        pro.D(i,i+1)=com(i+1);
    end
    pro.lb = [303	316.75	296.5	355	308.75	336	322.25	320.5	314.25	349.75	336.75	343	326.25	355	340.75	325.75	356.5];  % lower bound  of Price
    pro.ub = [742.75	743.00	748.25	839.00	837.75	739.00	914.50	1092.75	1192.25	1029.50	1065.00	1062.25	1015.50	934.75	868.00	875.25	921.75]; % Variance of Price
    pro.IniInventory = 0:10:90;
end