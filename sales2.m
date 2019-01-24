
data = load("sales2.txt");
X = data(:,1:2);
y = data(:,3);
m = length(y);

function [X_norm, mu, sigma] = featureNormalize(X)
X_norm = X;
mu = mean(X);
sigma = std(X);
X = (X - mu)./sigma;
X_norm = X;
end
fprintf('First 10 examples from the dataset: \n');
fprintf(' x = [%.0f %.0f], y = %.0f \n', [X(1:10,:) y(1:10,:)]');

[X mu sigma] = featureNormalize(X);

X = [ones(m,1),X];



function theta =  gradientDescentMulti(X,y,theta,alpha,num_i)
m = length(y);
for i=1:num_i
		Error = X*theta - y;
		part2 = sum(Error.*X);
		theta = theta - alpha/m*(part2');
	end
end
% Choose some alpha value
alpha = 0.01;
num_iters = 400;

% Init Theta and Run Gradient Descent 
theta = zeros(3, 1);
theta= gradientDescentMulti(X, y, theta, alpha, num_iters)


