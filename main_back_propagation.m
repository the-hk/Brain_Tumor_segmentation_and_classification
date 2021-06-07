clc;
clear all;
% load('trainBM.mat');
% load('yBM.mat');
% load('Aval.mat');
% load('yval.mat');
load('crossVal.mat');

% load('trainTumorGM.mat');
% load('yTumorGM.mat');
y=double(y)';
Xval=Aval;
yval=yval';
% y(y==1)=2;
% y(y==0)=1;


X=double(train);
% Xval=double(Aval);
% yval=double(yval)';
m = size(X, 1);


% Load the weights into variables Theta1 and Theta2
% load('ex4weights.mat');

input_layer_size  = 64;  % 20x20 Input Images of Digits
hidden_layer_size = 25;   % 25 hidden units
num_labels = 4;          % 10 labels, from 1 to 10 (note that we have mapped "0" to label 10)



initial_Theta1 = randInitializeWeights(input_layer_size, hidden_layer_size);
initial_Theta2 = randInitializeWeights(hidden_layer_size, num_labels);

% Unroll parameters
initial_nn_params = [initial_Theta1(:) ; initial_Theta2(:)];

%  Check gradients by running checkNNGradients
% lambda = 3;
% checkNNGradients(lambda);

options = optimset('MaxIter', 100);
lambda = 5;

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
p=5;
% input_layer_size  = 2500*p;  % 20x20 Input Images of Digits
% hidden_layer_size = 25;   % 25 hidden units
% num_labels = 4;
% 
X_poly1=polyFeatures(X,p);
[X_poly, mu, sigma] = featureNormalize(X_poly1);  % Normalize
% X_poly=normalize(X_poly);
lambda=0.01;

[nnparams,Theta11,Theta22] = trainNeuralReg(X_poly, y, lambda);

pred = predict(Theta11, Theta22, X_poly);
fprintf('\nTraining Set Accuracy: %f\n', mean(double(pred == y)) * 100);
%% confusion matrix
% figure(1);
% C = confusionmat(y,pred);
% confusionchart(C);
%% test data prediction and confusion Matrix
X_poly2=polyFeatures(Xval,p);
[X_poly12, mu, sigma] = featureNormalize(X_poly2);
pred12 = predict(Theta11, Theta22, X_poly12);
fprintf('\nTest Set Accuracy: %f\n', mean(double(pred12 == yval)) * 100);
% figure(2);
% C = confusionmat(yval,pred12);
% confusionchart(C);

%% validation curve
% 
% X_poly_val=polyFeatures(Xval,p);
% [X_poly_val, mu, sigma] = featureNormalize(X_poly_val);  % Normalize
% 
% [lambda_vec, error_train, error_val] = validationCurve(X_poly, y, X_poly_val, yval,p);
% % % load('D:\OneDrive - agu.edu.tr\Documents\MATLAB\BioSd\back_propagation\error_val.mat')
% % % load('D:\OneDrive - agu.edu.tr\Documents\MATLAB\BioSd\back_propagation\lambda_vec.mat')
% % % load('D:\OneDrive - agu.edu.tr\Documents\MATLAB\BioSd\back_propagation\error_train.mat')
% plot(lambda_vec, error_train, lambda_vec, error_val);
% title("changing lambda")
% legend('Train', 'Cross Validation');
% xlabel('lambda');
% ylabel('Error');
%% plotting errors
% [row,col]=size(y);
% [error_train, error_val] = learningCurve(X, y, Xval, yval, lambda);
% plot(1:row,error_train, 1:row,error_val);
% title("learning curve")
% legend('error_train', 'error_val');
% xlabel('sample size');
% ylabel('Error');
% 
% 
% poly_vec = 1:1:15;
% % 
% % % You need to return these variables correctly.
% % error_train_poly = zeros(length(poly_vec), 1);
% % error_val_poly = zeros(length(poly_vec), 1);
% % 
% for i = 1:length(poly_vec)
%     
%     polyy = poly_vec(i);
%     X_poly=polyFeatures(X,polyy);
%     [X_poly, mu, sigma] = featureNormalize(X_poly);
%      X_poly_val=polyFeatures(Xval,polyy);
%     [X_poly_val, mu1, sigma1] = featureNormalize(X_poly_val);
%     
%     nnparams=trainNeuralReg(X_poly, y, lambda,polyy);
%     error_train_poly(i) = nnCostFunction(nnparams, 64*polyy, 25, 4, X_poly, y, 0);
%     error_val_poly(i) = nnCostFunction(nnparams, 64*polyy, 25, 4, X_poly_val, yval, 0);
% end
% plot(poly_vec,error_train_poly, poly_vec,error_val_poly);
% title("polynomial curve")
% legend('error_train_poly', 'error_val_poly');
% xlabel('poliynomal degree');
% ylabel('Error');
