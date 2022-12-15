% Digital Image Processing HY-371
% Alexandros Angelakis csd4334
% Exercise 3
% Image Filtering

% Function that applies a gaussian filter on the img.
function new_img = matlab_gaussian_filter(img, sigma, pad_type)
    new_img = imgaussfilt(img, sigma, 'Padding',pad_type);
end

