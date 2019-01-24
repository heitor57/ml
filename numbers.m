load('numbers.mat');
input_layer_size = 400;
global m = size(X,1);
K = 10;
rand_indices = randperm(m);
sel = X(rand_indices(1:100),:);

function r = sigmoid(z)
	r = 1./(1+exp(-z));
end

function [cost grad] = LrCost(X,y,theta,lambda)
	sigmoidr= sigmoid(X*theta);
	temptheta = theta;
	global m;
	temptheta(1) = 0;
	cost = 1/m*sum(-log(-y+1+sigmoidr.*(2*y-1)))+(lambda/(2*m))*sum(temptheta.^2);
	grad = 1/m*(X'*(sigmoidr-y)) + lambda/m*temptheta;
end

function [all_theta] = OneVsAll(X,y,K,lambda)
options = optimset('GradObj', 'on', 'MaxIter', 50);

global m;
n = size(X,2);
X = [ones(m,1),X];
initial_theta= zeros(n+1,1);

all_theta = zeros(K, n + 1);
for i = 1:K
	theta = fmincg (@(t)(LrCost(X, (y == i),t , lambda)), initial_theta, options);
	all_theta(i,:) = theta';
end

end

function p = predictOneVsAll(Ltheta, X)
global m;
p = zeros(m, 1);
X = [ones(m,1),X];
[probability indices] = max(sigmoid(Ltheta * X'));
p = indices';
end


lambda = 0.1;
theta = zeros(size(X,2),1);
Ltheta=OneVsAll(X,y,K,lambda)
p = predictOneVsAll(Ltheta,X)

fprintf('\nTraining Set Accuracy: %f\n', mean(double(p == y)) * 100);
