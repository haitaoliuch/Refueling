function [reward]=Rule2(P,R)
% Refuel the largest amount of fuel each time
pro = Problem(P); 
%% Evaluation
for i = 1:length(pro.IniInventory)
    parfor r = 1:R
        s_t = [pro.IniInventory(i),gamrnd(pro.shape(1),pro.scale(1))];
        cost=[];
        for t=1:pro.T-1 
            % Determine the best action 
            a = pro.C-s_t(1);
            cost = [cost, s_t(2)*a + (a>0)*pro.fc(t)]; % price*volume + fixed cost
            s_t = TransitionCor(s_t,a,t,pro); 
        end 
        Obj(r,:)= cost;
    end
    mObj(i,:) = mean(Obj,1);
end

reward.cum =cumsum(mObj,2,'reverse'); 
reward.mean =mean(reward.cum(:,1)); 
reward.tc = Obj;
end