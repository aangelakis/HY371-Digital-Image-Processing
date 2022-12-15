% Digital Image Processing HY-371
% Alexandros Angelakis csd4334
% Exercise 3
% Image Filtering

% Function that applies a laplcian of gaussian filter on the img.
function new_img = matlab_log_filter(img, sigma1, sigma2, pad_type)
    G1 = matlab_gaussian_filter(img, sigma1, pad_type);
    
    G2  = matlab_gaussian_filter(img, sigma2, pad_type);

    new_img = G1 - G2;
end


