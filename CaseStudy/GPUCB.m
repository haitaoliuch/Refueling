function [reward,est_price,GP]=GPUCB(N,P,R)
% Fit a learning model based on inventory, price (current and unvisited ports), 
% Determine refueling decision in the presence of the estimated mean price 
% estimate fuel price using GMR model
% change based on GPAOAP2,
pro = Problem(P); k_max =pro.T+4;
for n=1:N
    s_t = [rand*pro.C,pro.lb(1) + (pro.ub(1)-pro.lb(1))*rand]; 
    for t=1:pro.T-1              
        [A] = FeAction(s_t(1),pro,t);    % feasible actions 
        % Choose an action
        if n<=  k_max+1
            Price(n,t) = s_t(2);
            [a] = A(randi(length(A)));
        else 
            Price(n,t) = s_t(2);
            options = statset('MaxIter',500);
            parfor k = 1 : k_max
                GMM{k} = fitgmdist(Price(1:n-1,:),k,'Options',options,'RegularizationValue',0.1);
                AIC(k)= GMM{k}.AIC;
            end
            [~,k_best] = min(AIC);
            [est_price] = GMR(GMM{k_best}, Price(n,1:t)', [1:t], [t+1:pro.T-1 ]);       
            [a] = UCB([s_t,est_price],A,GP{t},pro,n,t);
        end    
        Cost(n,t) = s_t(2)*a + (a>0)*pro.fc(t); % price*volume + fixed cost
        inv_post = s_t(1)+a-pro.D(t,t+1); 
        Sample{t}(n,1:2) = [inv_post,s_t(2)];
        s_t = TransitionCS(s_t,a,t,pro);         
    end
    Cost(n,pro.T)=0;
    cr(n,:) =cumsum(Cost(n,:),2,'reverse');
    parfor t=1:pro.T-1 
        % if mod(n,10)==0
        GP{t} = fitrgp([Sample{t},Price(:,t+1:end)],cr(:,t),'FitMethod','exact','PredictMethod','exact','KernelFunction','squaredexponential'); 
        % end
    end
end
%% Evaluation
est_price = GMM{k_best}.ComponentProportion*GMM{k_best}.mu;
for i = 1:length(pro.IniInventory)
    parfor r = 1:R
        s_t = [pro.IniInventory(i),pro.lb(1) + (pro.ub(1)-pro.lb(1))*rand];
        cost=[];
        for t=1:pro.T-1 
            X = [s_t,est_price(1,t+1:end)];
            [A] = FeAction(X(1),pro,t);    % feasible actions 
            % Determine the best action  
            CurCost=[]; mu=[];
            for j=1:length(A)
                a = A(j);
                CurCost(j) = X(2)*a + (a>0)*pro.fc(t); % price*volume + fixed cost
                x_post =[X(1)+a-pro.D(t,t+1),X(2:end)];
                mu(j) = predict(GP{t},x_post); 
            end
            [~,index] = min(mu+CurCost); a=A(index);
            cost = [cost, s_t(2)*a + (a>0)*pro.fc(t)]; % price*volume + fixed cost
            s_t = TransitionCS(s_t,a,t,pro); 
        end 
        Obj(r,:)= cost;
    end
    mObj(i,:) = mean(Obj,1);
end

reward.cum =cumsum(mObj,2,'reverse'); reward.cum =reward.cum(:,1);
reward.mean =mean(reward.cum(:,1)); 
end



function action = UCB(s,A,gp,pro,n,t)

L =length(A);  D=L; delta =0.1;
beta_n = 2*log(D*(n*pi)^2/(6*delta));
parfor i=1:L
    a = A(i);
    CurCost(i) = s(2)*a + (a>0)*pro.fc(t); % price*volume + fixed cost
    s_post =[s(1)+a-pro.D(t,t+1),s(2:end)]; 
    [mu(i),ysd(i)] = predict(gp,s_post); 
end
ucb = (mu+ CurCost)+sqrt(beta_n)*ysd;
[~,i]=min(ucb);
action = A(i);
end
