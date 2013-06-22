%% Initialization
clear ; close all; clc

                          
%% ================ Part 1: Loading and Visualizing Data ============
%  We start by first loading and visualizing the dataset. 

addpath('functions');

% Load Training Data
fprintf('Loading and Visualizing Data ...\n')

% Load configuration
load('../data/config.mat')
% Load train dateset
load('../data/train.mat');

m = size(trainData, 1);

% Randomly select 100 data points to display
sel = randperm(size(trainData, 1));
sel = sel(1:100);

displayData(trainData(sel, :));


%% ================ Part 2: Loading Parameters ======================
% We load some pre-initialized neural network parameters, which
% are random generated.

fprintf('\nLoading Saved Neural Network Parameters ...\n')

% Load the weights into variables Theta1 and Theta2
load('../data/weights.mat');

% Unroll parameters 
nn_params = [Theta1(:) ; Theta2(:)];


%% ================ Part 3: Checking Backpropagation ================
%  Once your cost matches up with ours, you should proceed to implement the
%  backpropagation algorithm for the neural network.

fprintf('\nChecking Backpropagation (w/ Regularization) ... \n')

%  Check gradients by running checkNNGradients
checkNNGradients(lambda);


%% ================ Part 4: Training NN =============================
%  To train your neural network, we will now use "fmincg", which
%  is a function which works similarly to "fminunc". Recall that these
%  advanced optimizers are able to train our cost functions efficiently as
%  long as we provide them with the gradient computations.

fprintf('\nTraining Neural Network... \n')

%  After you have completed the assignment, change the MaxIter to a larger
%  value to see how more training helps.
options = optimset('MaxIter', 100 * 4);

% Create "short hand" for the cost function to be minimized
costFunction = @(p) nnCostFunction(p, ...
                                   input_layer_size, ...
                                   hidden_layer_size, ...
                                   num_labels, trainData, trainLabel, lambda);

% Now, costFunction is a function that takes in only one argument (the
% neural network parameters)
[nn_params, cost] = fmincg(costFunction, nn_params, options);

% Obtain Theta1 and Theta2 back from nn_params
Theta1 = reshape(nn_params(1:hidden_layer_size * (input_layer_size + 1)), ...
                 hidden_layer_size, (input_layer_size + 1));

Theta2 = reshape(nn_params((1 + (hidden_layer_size * (input_layer_size + 1))):end), ...
                 num_labels, (hidden_layer_size + 1));

fprintf('neural network training is finished\n');
% save result
save '../data/weights.mat' Theta1 Theta2


%% ================ Part 5: Prediction ==============================

trainError = nnCostFunction(nn_params, input_layer_size, hidden_layer_size, ...
                   num_labels, trainData, trainLabel, lambda);
fprintf('\nTrain error is %f\n', trainError);
pred = predict(Theta1, Theta2, trainData);
fprintf('\nTrain Set Accuracy: %f\n', mean(double(pred == trainLabel)) * 100);