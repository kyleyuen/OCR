function [J, grad] = nnCostFunction(nn_params, ...
                                   input_layer_size, ...
                                   hidden_layer_size, ...
                                   num_labels, ...
                                   X, y, lambda)
%NNCOSTFUNCTION Implements the neural network cost function for a two layer
%neural network which performs classification
%   [J grad] = NNCOSTFUNCTON(nn_params, hidden_layer_size, num_labels, ...
%   X, y, lambda) computes the cost and gradient of the neural network. The
%   parameters for the neural network are "unrolled" into the vector
%   nn_params and need to be converted back into the weight matrices. 
% 
%   The returned parameter grad should be a "unrolled" vector of the
%   partial derivatives of the neural network.
%

% Reshape nn_params back into the parameters Theta1 and Theta2, the weight matrices
% for our 2 layer neural network
Theta1 = reshape(nn_params(1:hidden_layer_size * (input_layer_size + 1)), ...
                 hidden_layer_size, (input_layer_size + 1));

Theta2 = reshape(nn_params((1 + (hidden_layer_size * (input_layer_size + 1))):end), ...
                 num_labels, (hidden_layer_size + 1));

% Setup some useful variables
m = size(X, 1);
         
% You need to return the following variables correctly 
Theta1_grad = zeros(size(Theta1));
Theta2_grad = zeros(size(Theta2));

% ====================== YOUR CODE HERE ======================

% Part 1: 
% Feedforward the neural network and return the cost in the variable J.

%compute h
a = X;
a = [ones(m, 1) a];
z = a * Theta1';
a = sigmoid(z);

a = [ones(m, 1) a];
z = a * Theta2';
a = sigmoid(z);
h = a;

%compute J without regularized
result = zeros(m, 1);
for i = 1:m
    temp = zeros(num_labels, 1);
    temp(y(i)) = 1;
    for k = 1:num_labels
        result(i) = result(i) - (temp(k) * log(h(i, k)) + (1 - temp(k)) * log(1 - h(i, k)));
    end
end
J = sum(result) / m;

%compute regularized J
result = 0;
[row, column] = size(Theta1);
for i = 1:row
    for j = 2:column
        result = result + Theta1(i, j) ^ 2;
    end
end

[row, column] = size(Theta2);
for i = 1:row
    for j = 2:column
        result = result + Theta2(i, j) ^ 2;
    end
end

result = result * lambda / m / 2;
J = J + result;


% Part 2: 
% Implement the backpropagation algorithm to compute the gradients
% Theta1_grad and Theta2_grad.

for i = 1:m
    example = X(i, :);
    a1 = [1 example];	
    z2 = a1 * Theta1';
    a2 = sigmoid(z2);

    a2 = [1 a2];	
    z3 = a2 * Theta2';
    a3 = sigmoid(z3);

    temp = zeros(num_labels, 1);
    temp(y(i), 1) = 1;
    delta3 = a3' - temp;
    delta2 = Theta2' * delta3;
    delta2 = delta2(2:end) .* sigmoidGradient(z2)';

    Theta1_grad = Theta1_grad + delta2 * a1;
    Theta2_grad = Theta2_grad + delta3 * a2;
end

Theta1_grad = Theta1_grad / m;
Theta2_grad = Theta2_grad / m;


% Part 3:
% Obtain the (unregularized) gradient for the neural network cost function 
% by dividing the accumulated gradients by 1/m
Theta1_grad(:, 2:end) = Theta1_grad(:, 2:end) + Theta1(:, 2:end) * lambda / m;
Theta2_grad(:, 2:end) = Theta2_grad(:, 2:end) + Theta2(:, 2:end) * lambda / m;

% =========================================================================

% Unroll gradients
grad = [Theta1_grad(:) ; Theta2_grad(:)];


end
