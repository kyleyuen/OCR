function [error_train, error_val] = ...
    learningCurve(trainData, trainLabel, ...
                  crossValidationData, crossValidationLabel, ...
                  input_layer_size, hidden_layer_size, num_labels, ...
                  nn_params, lambda)
%LEARNINGCURVE Generates the train and cross validation set errors needed 
%to plot a learning curve

% Number of cross validation dataset
m = size(crossValidationData, 1);
% You need to return these values correctly
error_train = zeros(m, 1);
error_val   = zeros(m, 1);

fprintf('# Training Examples\tTrain Error\tCross Validation Error\n');
for i = 1:m
    error_train(i) = nnCostFunction(nn_params, input_layer_size, hidden_layer_size, ...
                   num_labels, trainData(1:i, :), trainLabel(1:i, :), lambda);
    error_val(i) = nnCostFunction(nn_params, input_layer_size, hidden_layer_size, ...
                   num_labels, crossValidationData(1:i, :), crossValidationLabel(1:i, :), lambda);
    
    fprintf('  \t%d\t\t%f\t%f\n', i, error_train(i), error_val(i));
end
