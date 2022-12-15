% Digital Image Processing HY-371
% Alexandros Angelakis csd4334
% Exercise 3
% Image Filtering

% Function that applies a gaussian filter on the img.
function new_img = my_gaussian_filter(img, sigma, pad_type)
    
    size = 2 * ceil(2*sigma) + 1;

    kernel = fspecial('gaussian', size, sigma);
    
    [~, ver_kernel, hor_kernel] = isfilterseparable(kernel);
             
    new_img = my_separable_conv(img, hor_kernel, ver_kernel, pad_type);
end

