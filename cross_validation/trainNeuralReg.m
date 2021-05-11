function [nn_params,Theta1,Theta2] = trainNeuralReg(X, y, lambda)
%TRAINLINEARREG Trains linear regression given a dataset (X, y) and a
%regularization parameter lambda
%   [theta] = TRAINLINEARREG (X, y, lambda) trains linear regression using
%   the dataset (X, y) and regularization parameter lambda. Returns the
%   trained parameters theta.
%
% 
% % Initialize Theta
% initial_theta = zeros(size(X, 2), 1); 
% 
% % Create "short hand" for the cost function to be minimized
% costFunction = @(t) linearRegCostFunction(X, y, t, lambda);
% 
% % Now, costFunction is a function that takes in only one argument
% options = optimset('MaxIter', 200, 'GradObj', 'on');
% 
% % Minimize using fmincg
% theta = fmincg(costFunction, initial_theta, options);
p=3;
input_layer_size  = 400*p;  % 20x20 Input Images of Digits
hidden_layer_size = 25;   % 25 hidden units
num_labels = 4;

initial_Theta1 = randInitializeWeights(input_layer_size, hidden_layer_size);
initial_Theta2 = randInitializeWeights(hidden_layer_size, num_labels);

% Unroll parameters
initial_nn_params = [initial_Theta1(:) ; initial_Theta2(:)];

%  Check gradients by running checkNNGradients
% lambda = 3;
% checkNNGradients(lambda);


options = optimset('MaxIter', 50);

% Create "short hand" for the cost function to be minimized
costFunction = @(p) nnCostFunction(p, input_layer_size, hidden_layer_size, num_labels, X, y, lambda);

% Now, costFunction is a function that takes in only one argument (the
% neural network parameters)
[nn_params, ~] = fmincg(costFunction, initial_nn_params, options);


Theta1 = reshape(nn_params(1:hidden_layer_size * (input_layer_size + 1)), hidden_layer_size, (input_layer_size + 1));
Theta2 = reshape(nn_params((1 + (hidden_layer_size * (input_layer_size + 1))):end), num_labels, (hidden_layer_size + 1));

end
