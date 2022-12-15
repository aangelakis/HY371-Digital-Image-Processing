% Digital Image Processing HY-371
% Alexandros Angelakis csd4334
% Exercise 3
% Image Filtering

% Function that applies a local standard deviation filter on the img.
function new_img = my_stddev_filter(img, pad_type)
    kernel = fspecial('average', 5);
        
    [~, ver_kernel, hor_kernel] = isfilterseparable(kernel);
    
    new_img = my_separable_conv(img.^2, hor_kernel, ver_kernel, pad_type) - (my_separable_conv(img, hor_kernel, ver_kernel, pad_type).^2);

end

