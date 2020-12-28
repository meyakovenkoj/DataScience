function g = sigmoid(z)
%SIGMOID Compute sigmoid functoon
%   J = SIGMOID(z) computes the sigmoid of z.

% You need to return the following variables correctly 
g = zeros(size(z));

% ====================== YOUR CODE HERE ======================
% Instructions: Compute the sigmoid of each value of z (z can be a matrix,
%               vector or scalar).

% Counting sigmoid for vars that can be matrix, vector or scalar
g = ones(size(z)) ./ (ones(size(z)) + e .^ -z);

% =============================================================

end
