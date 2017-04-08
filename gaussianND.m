function [ res ] = gaussianND(X, mu, Sigma, class_num)
%GAUSSIANND 
%      X - Matrix of data points, one per row.
%     mu - Row vector for the mean.
%  Sigma - Covariance matrix.

% Get the vector length.
n = size(X, 2);
% Subtract the mean from every data point.

% Calculate the multivariate gaussian.
% pdf = 1 / sqrt((2*pi)^n * det(Sigma)) * exp(-1/2 * sum((meanDiff * inv(Sigma) .* meanDiff), 2));
res = 0;
for i=1:class_num
	meanDiff = bsxfun(@minus, X, mu(i,:));
	res = res + 1 / sqrt((2*pi)^n * det(Sigma(:,:,i))) * exp(-1/2 * (meanDiff * inv(Sigma(:,:,i)) * meanDiff'));
end

end

