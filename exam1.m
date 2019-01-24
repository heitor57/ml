data = load("exam1.txt");

X = data(:,1:2);
y = data(:,3);
m = length(y);

%
%plot(X,y)


%hold on;

%xlabel('Score 1')
%xlabel('Score 2')

%legend('Accepted','Negated')
%hold off;

function r = sigmoid(z)
r = zeros(size(z));
r = 1./(1 + exp(-1*z));
end

function [J Grad] = Cost(X,y,theta,lambda)
  m = length(y);
temptheta = theta;
temptheta(1) = 0;
J = 1/m*sum(-log(-y+1+sigmoid(X*theta).*(2*y-1))) + lambda/(2*m)*sum(temptheta.^2);
Grad = 1/m*(X'*(sigmoid(X*theta)-y))+(lambda/m)*temptheta;
end
X = [ones(m,1),X];
theta = zeros(3,1);
lambda = 1;
Cost(X,y,theta,lambda)


options = optimset('GradObj', 'on', 'MaxIter', 400);

[theta, cost] = ...
  fminunc(@(t)(Cost(X, y,t,lambda)), theta, options)

%pause
