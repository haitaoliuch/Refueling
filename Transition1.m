 function s =Transition1(s,a,t,pro)
    s(1) =s(1)+a-pro.D(t,t+1);
    mu=0;      % drift
sigma=0.05;   % std dev over total inverval
T = pro.T-1; W=0;
dt = sigma/sqrt(T);   % local volatility
    cor= pro.shape(t+1)*pro.scale(t+1)/(pro.shape(t)*pro.scale(t));
            eps=randn; 
        dW = sigma*eps*sqrt(dt);
        W = W + dW; % W(t)
    s(2) =s(2)*cor*exp((mu*t-0.5*sigma*sigma*t) + W); % cor+max(normrnd(0,2),0); %      ;
 end 


