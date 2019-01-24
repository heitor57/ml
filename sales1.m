

data = load('sales1.txt');
X = data(:, 1); y = data(:, 2);
m = length(y);

function plotData(x, y)
figure;
plot(x, y, "rx", "MarkerSize", 10);
axis([4 24 -5 25]);
xlabel("Population in 10,000s");
ylabel("Profit in $10,000s");
end
plotData(X,y)



X = [ones(m, 1), X]; % Add a column of ones to x
theta = zeros(2, 1); % initialize fitting parameters
iterations = 1500;
alpha = 0.01;



function J = MycomputeCost(X,y,theta)

	m = length(y);
	J = 0;
	J = 1/(2*m)*sum((X*theta - y).^2);
end
function t = MygradientDescent(X,y,theta,alpha,numIt)
	m = length(y);
	J_History = zeros(numIt,1);
	for iter=1:numIt
		Error = X*theta - y;
		theta(1) = theta(1) -alpha/m*(sum(Error.*X(:,1)));
		theta(2) = theta(2) -alpha/m*(sum(Error.*X(:,2)));
		J_History(iter)= MycomputeCost(X,y,theta);
	end
	t= theta;
end




iterations = 1500;
alpha = 0.01;

% compute and display initial cost
MycomputeCost(X, y, theta)

% run gradient descent
theta = MygradientDescent(X, y, theta, alpha, iterations);

% print theta to screen
fprintf('Theta found by gradient descent: ');
fprintf('%f %f \n', theta(1), theta(2));

% Plot the linear fit
hold on; % keep previous plot visible

plot(X(:,2), X*theta, '-')
legend('Training data', 'Linear regression')
hold off % don't overlay any more plots on this figure

% Predict values for population sizes of 35,000 and 70,000
predict1 = [1, 3.5] *theta;
fprintf('For population = 35,000, we predict a profit of %f\n',...
    predict1*10000);
predict2 = [1, 7] * theta;
fprintf('For population = 70,000, we predict a profit of %f\n',...
    predict2*10000);
	pause;
