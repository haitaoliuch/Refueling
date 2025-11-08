function s =TransitionCS(s,a,t,pro)
    s(1) =s(1)+a-pro.D(t,t+1);
    s(2) =pro.lb(1) + (pro.ub(t)-pro.lb(t))*rand;     % 
 end 


