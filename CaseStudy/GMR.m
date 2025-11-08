function [y] = GMR(GMM, x, in, out)
%
% Gaussian Mixture Regression.
% This source code is the implementation of the algorithms described in 
% Section 2.4, p.38 of the book "Robot Programming by Demonstration: A 
% Probabilistic Approach".
%
% Author:	Sylvain Calinon, 2009
%			http://programming-by-demonstration.org
%
% This function performs Gaussian Mixture Regression (GMR), using the 
% parameters of a Gaussian Mixture Model (GMM). Given partial input data, 
% the algorithm computes the expected distribution for the resulting 
% dimensions. By providing temporal values as inputs, it thus outputs a 
% smooth generalized version of the data encoded in GMM, and associated 
% constraints expressed by covariance matrices.
%
% Inputs -----------------------------------------------------------------
%   o Priors:  1 x K array representing the prior probabilities of the K GMM 
%              components.
%   o Mu:      D x K array representing the centers of the K GMM components.
%   o Sigma:   D x D x K array representing the covariance matrices of the 
%              K GMM components.
%   o x:       P x N array representing N datapoints of P dimensions.
%   o in:      1 x P array representing the dimensions to consider as
%              inputs.
%   o out:     1 x Q array representing the dimensions to consider as
%              outputs (D=P+Q).
% Outputs ----------------------------------------------------------------
%   o y:       Q x N array representing the retrieved N datapoints of 
%              Q dimensions, i.e. expected means.
%   o Sigma_y: Q x Q x N array representing the N expected covariance 
%              matrices retrieved. 
%
% This source code is given for free! However, I would be grateful if you refer 
% to the book (or corresponding article) in any academic publication that uses 
% this code or part of it. Here are the corresponding BibTex references: 

Priors = GMM.ComponentProportion;
Mu = GMM.mu'; Sigma = GMM.Sigma;
nbData = length(x);
nbVar = size(Mu,1);
nbStates = size(Sigma,3);
%% Fast matrix computation (see the commented code for a version involving 
%% one-by-one computation, which is easier to understand).
%%
%% Compute the influence of each GMM component, given input x
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for i=1:nbStates
  Pxi(:,i) = Priors(i).*gaussPDF(x, Mu(in,i), Sigma(in,in,i));
end
beta = Pxi./repmat(sum(Pxi,2)+realmin,1,nbStates);
%% Compute expected means y, given input x
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
for j=1:nbStates
  y_tmp(:,j) = Mu(out,j) + Sigma(out,in,j)*inv(Sigma(in,in,j)) * (x-Mu(in,j));
end
% beta_tmp = reshape(beta,[1 size(beta)]);
y = beta* y_tmp';
% y = sum(y_tmp2,3);
%% Compute expected covariance matrices Sigma_y, given input x
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% for j=1:nbStates
%   Sigma_y_tmp(:,:,1,j) = Sigma(out,out,j) - (Sigma(out,in,j)*inv(Sigma(in,in,j))*Sigma(in,out,j));
% end
% beta_tmp = reshape(beta,[1 1 size(beta)]);
% Sigma_y_tmp2 = repmat(beta_tmp.*beta_tmp, [length(out) length(out) 1 1]) .* repmat(Sigma_y_tmp,[1 1 nbData 1]);
% Sigma_y = sum(Sigma_y_tmp2,4);
