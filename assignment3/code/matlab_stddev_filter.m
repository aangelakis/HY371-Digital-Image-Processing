% Digital Image Processing HY-371
% Alexandros Angelakis csd4334
% Exercise 3
% Image Filtering

% Function that applies a local standard deviation filter on the img.
function new_img = matlab_stddev_filter(img, pad_type)
    kernel = fspecial('average', 5);
    
    new_img = imfilter(img.^2, kernel, pad_type) - (imfilter(img, kernel, pad_type).^2);
    
end

