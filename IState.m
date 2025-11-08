function [state]=IState(pro)
% Initialize state
state = rand(1)*pro.C;
state = roundn(state,-1);
%% initialize coefficient and sample for value function. there are params.N samples and param.Tn 




