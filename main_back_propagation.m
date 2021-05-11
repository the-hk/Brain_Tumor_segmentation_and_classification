clc;
clear all;
load('A.mat');
load('y.mat');
load('Aval.mat');
load('yval.mat');
y=y';
X=A;
Xval=Aval;
yval=yval';
m = size(X, 1);

% Randomly select 100 data points to display
sel = randperm(size(X, 1));
sel = sel(1:100);
displayData(X(sel, :));

% Load the weights into variables Theta1 and Theta2
% load('ex4weights.mat');

input_layer_size  = 400;  % 20x20 Input Images of Digits
hidden_layer_size = 25;   % 25 hidden units
num_labels = 4;          % 10 labels, from 1 to 10 (note that we have mapped "0" to label 10)



initial_Theta1 = randInitializeWeights(input_layer_size, hidden_layer_size);
initial_Theta2 = randInitializeWeights(hidden_layer_size, num_labels);

% Unroll parameters
initial_nn_params = [initial_Theta1(:) ; initial_Theta2(:)];

%  Check gradients by running checkNNGradients
% lambda = 3;
% checkNNGradients(lambda);

options = optimset('MaxIter', 50);
lambda = 10;

nnCostFunction(initial_nn_params, input_layer_size, hidden_layer_size, num_labels, X, y, lambda)

% Create "short hand" for the cost function to be minimized
costFunction = @(p) nnCostFunction(p, input_layer_size, hidden_layer_size, num_labels, X, y, lambda);

% Now, costFunction is a function that takes in only one argument (the
% neural network parameters)
[nn_params, ~] = fmincg(costFunction, initial_nn_params, options);


Theta1 = reshape(nn_params(1:hidden_layer_size * (input_layer_size + 1)), hidden_layer_size, (input_layer_size + 1));
Theta2 = reshape(nn_params((1 + (hidden_layer_size * (input_layer_size + 1))):end), num_labels, (hidden_layer_size + 1));
 
pred = predict(Theta1, Theta2, X);
fprintf('\nTraining Set Accuracy: %f\n', mean(double(pred == y)) * 100);

%% addding feature
p=3;
% input_layer_size  = 2500*p;  % 20x20 Input Images of Digits
% hidden_layer_size = 25;   % 25 hidden units
% num_labels = 4;
% 
X_poly=polyFeatures(X,p);
[X_poly, mu, sigma] = featureNormalize(X_poly);  % Normalize

lambda=15;
[nnparams,Theta11,Theta22] = trainNeuralReg(X_poly, y, lambda);

pred = predict(Theta11, Theta22, X_poly);
fprintf('\nTraining Set Accuracy: %f\n', mean(double(pred == y)) * 100);

%% validation curve
X_poly_val=polyFeatures(Xval,p);
[X_poly_val, mu, sigma] = featureNormalize(X_poly_val);  % Normalize

% [lambda_vec, error_train, error_val] = validationCurve(X_poly, y, X_poly_val, yval);
load('D:\OneDrive - agu.edu.tr\Documents\MATLAB\BioSd\back_propagation\error_val.mat')
load('D:\OneDrive - agu.edu.tr\Documents\MATLAB\BioSd\back_propagation\lambda_vec.mat')
load('D:\OneDrive - agu.edu.tr\Documents\MATLAB\BioSd\back_propagation\error_train.mat')
plot(lambda_vec, error_train, lambda_vec, error_val);
legend('Train', 'Cross Validation');
xlabel('lambda');
ylabel('Error');


