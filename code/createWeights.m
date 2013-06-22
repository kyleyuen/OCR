addpath('functions');

% Load configuration
load('../data/config.mat')

Theta1 = randInitializeWeights(input_layer_size, hidden_layer_size);
Theta2 = randInitializeWeights(hidden_layer_size, num_labels);
save '../data/weights.mat' Theta1 Theta2
