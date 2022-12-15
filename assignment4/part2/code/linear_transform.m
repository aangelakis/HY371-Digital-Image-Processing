function Z = linear_transform(X,Y)
    Z = max(max(X)) .* ((Y - min(min(Y))) ./ (max(max(Y)) - min(min(Y)))) + min(min(X));
end

