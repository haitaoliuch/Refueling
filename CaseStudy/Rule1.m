function [reward]=Rule1(P,R)
% Refuel the least required amount of fuel each time
pro = Problem(P); 
%% Evaluation
for i = 1:length(pro.IniInventory)
    parfor r = 1:R
        s_t = [pro.IniInventory(i),pro.lb(1) + (pro.ub(1)-pro.lb(1))*rand];
        cost=[];
        for t=1:pro.T-1 
            % Determine the best action 
            a = max(max(pro.L-s_t(1),pro.D(t,t+1)-s_t(1)),0);
            cost = [cost, s_t(2)*a + (a>0)*pro.fc(t)]; % price*volume + fixed cost
            s_t = TransitionCS(s_t,a,t,pro); 
        end 
        Obj(r,:)= cost;
    end
    mObj(i,:) = mean(Obj,1);
end

reward.cum =cumsum(mObj,2,'reverse'); 
reward.mean =mean(reward.cum(:,1)); 
end