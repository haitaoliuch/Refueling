function GP=GPgreedy(N)
theta = ones(4,1);    % hyperparameter: signal standard deviation; length scale; noise
pro = Problem(); 
for n=1:N
    [s] = IState(pro);       % initial state
    for t=1:pro.T-1 
        [A] = FeAction(s,pro,t);    % feasible actions        
        % Choose an action
        if n<=10
            [a] = A(randi(length(A)));
        else
            [a] = Greedy(A,s,GP{t},n);
        end
        Sample{t}(n,1:2) = [s,a];
        s_post = s+a;
        [s]= Transition(s_post,t,pro);      
        R(t) = normrnd(pro.mu(t),pro.sig(t))*a + (a>0)*pro.fc(t); % price*volume + fixed cost
    end
    cr =cumsum(R,'reverse');
    parfor t=1:pro.T-1 
        Sample{t}(n,3) = cr(t);
        if mod(n,10)==0
        GP{t} = fitrgp(Sample{t}(:,1:end-1),Sample{t}(:,end),'FitMethod','exact',...
                   'PredictMethod','exact','KernelFunction','ardsquaredexponential', 'KernelParameters',theta(1:3)','Sigma',theta(4));
        end
    end      
end
end

function action = Greedy(A,s,gp)
    L =length(A);  
    for i=1:L
        a = A(i); CurCost(i) = s(2)*a + (a>0)*pro.fc(t); % price*volume + fixed cost
        [mu(i),~] = predict(gp,[s,A(i)]) ;
        v(i) = mu(i) + CurCost(i); 
    end
    [~,i]=min(v);
    action = A(i);
end