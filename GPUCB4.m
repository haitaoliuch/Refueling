function [reward,GP]=GPUCB4(N,P,R)
% Fit a learning model based on inventory, price (current and unvisited ports), 
% Determine refueling decision in the presence of the estimated mean price 
% Determine optimal actions condiering future price
pro = Problem(P); k_max =pro.T+4;
for n=1:N
    tic
    s_t = [rand*pro.C,gamrnd(pro.shape(1),pro.scale(1))]; y_p=[];
    for t=1:pro.T-1              
        [A] = FeAction(s_t(1),pro,t);    % feasible actions 
        % Choose an action
        if n<= k_max+1
            Price(n,t) = s_t(2);
            [a] = A(randi(length(A)));
        else 
            Price(n,t) = s_t(2);
            X = [s_t,mu_0(1,t+1:end)];
            y_p = [y_p,s_t(2)]; y=[];
            for k=1:k_best
                sigma =GMM{k_best}.Sigma(:,:,k); 
                sigma_22 =sigma(1:t,1:t);  sigma_12 =sigma(t+1:end,1:t); 
                y(:,k) = mu_0(t+1:end)'+sigma_12/sigma_22*(y_p-mu_0(1:t))';        
            end
            price_future = y*weight;  X(3:end) = price_future;     
            [a] = UCB([X],A,GP{t},pro,n,t);
        end    
        Cost(n,t) = s_t(2)*a + (a>0)*pro.fc(t); % price*volume + fixed cost
        inv_post = s_t(1)+a-pro.D(t,t+1); 
        Sample{t}(n,1:2) = [inv_post,s_t(2)];
        s_t = Transition1(s_t,a,t,pro);         
    end
    Cost(n,pro.T)=0;
    cr(n,:) =cumsum(Cost(n,:),2,'reverse');
    parfor t=1:pro.T-1 
        % if mod(n,10)==0
        GP{t} = fitrgp([Sample{t},Price(:,t+1:end)],cr(:,t),'FitMethod','exact','PredictMethod','exact','KernelFunction',kfcn); 
        % end
    end
    % estimate price distribution
    if n >=k_max+1
        options = statset('MaxIter',500);
        parfor k = 1 : k_max
            GMM{k} = fitgmdist(Price(1:n,:),k,'Options',options,'RegularizationValue',0.2);
            AIC(k)= GMM{k}.AIC;
        end
        [~,k_best] = min(AIC);
        mu_0 = GMM{k_best}.ComponentProportion*GMM{k_best}.mu;
        weight = GMM{k_best}.ComponentProportion';
    end

    toc
    n
end
%% Evaluation
% est_price = mu_0;
for i = 1:length(pro.IniInventory)
    parfor r = 1:R
        s_t = [pro.IniInventory(i),gamrnd(pro.shape(1),pro.scale(1))];
        cost=[]; y_p=[];
        for t=1:pro.T-1 
            X = [s_t,mu_0(1,t+1:end)];
            [A] = FeAction(X(1),pro,t);    % feasible actions 
            % Determine the best action  
            CurCost=[]; mu=[];
            y_p = [y_p,s_t(2)]; y=[];
            for k=1:k_best
                sigma =GMM{k_best}.Sigma(:,:,k); 
                sigma_22 =sigma(1:t,1:t);  sigma_12 =sigma(t+1:end,1:t); 
                y(:,k) = mu_0(t+1:end)'+sigma_12/sigma_22*(y_p-mu_0(1:t))';        
            end
            price_future = y*weight;  X(3:end) = price_future;
            for j=1:length(A)
                a = A(j);
                CurCost(j) = X(2)*a + (a>0)*pro.fc(t); % price*volume + fixed cost
                x_post =[X(1)+a-pro.D(t,t+1),X(2:end)];
                mu(j) = predict(GP{t},x_post); 
            end
            [~,index] = min(mu+CurCost); a=A(index);
            cost = [cost, s_t(2)*a + (a>0)*pro.fc(t)]; % price*volume + fixed cost
            s_t = Transition1(s_t,a,t,pro); 
        end 
        Obj(r,:)= cost;
    end
    mObj(i,:) = mean(Obj,1);
end

reward.cum =cumsum(mObj,2,'reverse'); 
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

%%GMM prediction
%     for k=1:k_best
%     sigma =GMM{k_best}.Sigma(:,:,k);
%     sigma_FP = repmat(sigma,1,n);
%     sigma_PP = repmat(sigma,n); 
%     num = (n-1)*(pro.T-1)+t;
%     y_P = reshape(Price',[],1);
%     y(k) = sigma_FP(:,1:num)/(sigma_PP(1:num,1:num))*y_P(1:num);
%     w(1,k) = GMM{k_best}.ComponentProportion(k)*mvnpdf(Price(n-1,:),GMM{k_best}.mu,sigma);          
%     end
%     est_price = w/sum(w)*y;