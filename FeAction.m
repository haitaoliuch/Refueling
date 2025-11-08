function [A] = FeAction(inventory,pro,t)
     sz = 0.5;
     A = [max(max(pro.L-inventory,pro.D(t,t+1)-inventory),0):sz:pro.C-inventory]';
end