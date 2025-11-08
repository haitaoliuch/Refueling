function [reward]=Rule3(N,P,R)
% Refuel the least required amount of fuel each time
pro = Problem(P); 
for n=1:N
    Price(n,:) = gamrnd(pro.shape(1:pro.T-1),pro.scale(1:pro.T-1));
end
MeanPrice =mean(Price,1); MeanPrice=[MeanPrice,10^6];
%% Evaluation
for i = 1:length(pro.IniInventory)
    parfor r = 1:R
        s_t = [pro.IniInventory(i),gamrnd(pro.shape(1),pro.scale(1))];
        cost=[];
        for t=1:pro.T-1 
            % Determine the best action 
            a_min = max(max(pro.L-s_t(1),pro.D(t,t+1)-s_t(1)),0);
            a_max = pro.C-s_t(1);
            if s_t(2)<=MeanPrice(t+1)
                a=a_max;
            else
                a=a_min;
            end
            cost = [cost, s_t(2)*a + (a>0)*pro.fc(t)]; % price*volume + fixed cost
            s_t = Transition(s_t,a,t,pro); 
        end 
        Obj(r,:)= cost;
    end
    mObj(i,:) = mean(Obj,1);
end

reward.cum =cumsum(mObj,2,'reverse'); 
reward.mean =mean(reward.cum(:,1)); 
end