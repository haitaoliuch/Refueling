function [s,price] =TransitionCor(s,a,t,pro)
    s(1) =s(1)+a-pro.D(t,t+1);
    for i=1:pro.T
        if i==1
            price(1) = gamrnd(pro.shape(1),pro.scale(1));
        else
            cor= pro.shape(i)*pro.scale(i)/(pro.shape(i-1)*pro.scale(i-1));
            price(i) =s(2)*cor+max(normrnd(0,2),0); 
        end

    end
    s(2)=price(t+1);
    
 end 
