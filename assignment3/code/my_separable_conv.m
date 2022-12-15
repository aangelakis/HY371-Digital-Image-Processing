% Digital Image Processing HY-371
% Alexandros Angelakis csd4334
% Exercise 3
% Image Filtering

% Function that performs a convolution with separable kernel in an image.
% pad_type = 1 for zero-padding, pad_type = 2 for replication.
function conv = my_separable_conv(img, hor_kernel, ver_kernel, pad_type)

% Dimensions of img
x = size(img,1);
y = size(img,2);

% Dimensions of kernels
kx = size(hor_kernel, 2);
ky = size(ver_kernel, 1);

conv = zeros(x,y);

% Padding size
padsize = floor(kx/2);

% Zero-padding
if pad_type == 1
    padded_img = padarray(img, [padsize padsize], 0, 'both');
    img_conved = my_conv(padded_img, ver_kernel);
    conv = my_conv(img_conved, hor_kernel);
    
% Pixel Boundary Value Replication
elseif pad_type == 2
    padded_img = padarray(img, [padsize padsize], 'replicate', 'both');
    img_conved = my_conv(padded_img, ver_kernel);
    conv = my_conv(img_conved, hor_kernel);
    
else
    disp('Wrong padding type');
end
end