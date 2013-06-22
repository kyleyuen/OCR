function [lambda_vec, error_train, error_val] = ...
    validationCurve(trainData, trainLabel, crossValidationData, crossValidationLabel, ...
                    input_layer_size, hidden_layer_size, num_labels, nn_params)
%VALIDATIONCURVE Generate the train and validation errors needed to
%plot a validation curve that we can use to select lambda


% Selected values of lambda (you should not change this)
lambda_vec = [0.01 0.03 0.1 0.3 1 3]';

% You need to return these variables correctly.
error_train = zeros(length(lambda_vec), 1);
error_val = zeros(length(lambda_vec), 1);


options = optimset('MaxIter', 50);
for i = 1:length(lambda_vec)
    % Create "short hand" for the cost function to be minimized
    costFunction = @(p) nnCostFunction(p, ...
                                   input_layer_size, ...
                                   hidden_layer_size, ...
                                   num_labels, trainData, trainLabel, lambda_vec(i));
    [temp, ~] = fmincg(costFunction, nn_params, options);
                 
	error_train(i) = nnCostFunction(temp, input_layer_size, hidden_layer_size, ...
                   num_labels, trainData, trainLabel, lambda_vec(i));
    error_val(i) = nnCostFunction(temp, input_layer_size, hidden_layer_size, ...
                   num_labels, crossValidationData, crossValidationLabel, lambda_vec(i));
end

end
