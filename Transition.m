 function s =Transition(s,a,t,pro)
    s(1) =s(1)+a-pro.D(t,t+1);
    s(2) = gamrnd(pro.shape(t),pro.scale(t));
 end 

% s(2) =s(2)*rand*5;

