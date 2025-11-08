function [reward,est_price,GP]=GPUCB0(N,P,R)
% Fit a learning model based on inventory, price at the current  port,  do
% not consider the prices of unvisited ports
% Determine refueling decision without the estimated mean price 
pro = Problem(P); 
for n=1:N
   % initial inventory 
    s_t = [rand*pro.C,gamrnd(pro.shape(1),pro.scale(1))];
    for t=1:pro.T-1              
        [A] = FeAction(s_t(1),pro,t);    % feasible actions 
        % Choose an action
        if n<=10
            [a] = A(randi(length(A)));
        else    
            [a] = UCB(s_t,A,GP{t},pro,n,t);
        end    
        Cost(n,t) = s_t(2)*a + (a>0)*pro.fc(t); % price*volume + fixed cost
        inv_post = s_t(1)+a-pro.D(t,t+1); % post-decision inventory
        Sample{t}(n,1:2) = [inv_post,s_t(2)];  % post-decision inventory, price at current port
        Price(n,t) = s_t(2);
        s_t = TransitionCor(s_t,a,t,pro);         
    end
    Cost(n,pro.T)=0;
    est_price = mean(Price,1);
    cr(n,:) =cumsum(Cost(n,:),2,'reverse');
    parfor t=1:pro.T-1 
        GP{t} = fitrgp([Sample{t}],cr(:,t)); %'KernelFunction','ardsquaredexponential'
    end
end
%% Evaluation
for i = 1:length(pro.IniInventory)
    parfor r = 1:R
        s_t = [pro.IniInventory(i),gamrnd(pro.shape(1),pro.scale(1))];
        cost=[];
        for t=1:pro.T-1 
            X = [s_t];
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
            s_t = TransitionCor(s_t,a,t,pro); 
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