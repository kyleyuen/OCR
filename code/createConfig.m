%% Setup the parameters you will use for this exercise
input_layer_size  = 400;  % 20x20 Input Images of Digits
hidden_layer_size = 100;  % 100 hidden units
num_labels = 62;          % 62 labels, from 1 to 62

lambda = 1;               % learning rate

save '../data/config.mat' input_layer_size hidden_layer_size num_labels lambda;