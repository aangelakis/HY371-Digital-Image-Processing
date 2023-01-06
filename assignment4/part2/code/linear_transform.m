% Digital Image Processing HY-371
% Alexandros Angelakis csd4334
% Exercise 4 part2
%  Discrete Fourier Transform & Image Compression

% Function that calculates the new transformed image by using the altered 
% image Y and the original image X.
function Z = linear_transform(X,Y)
    Z = max(max(X)) .* ((Y - min(min(Y))) ./ (max(max(Y)) - min(min(Y)))) + min(min(X));
end

