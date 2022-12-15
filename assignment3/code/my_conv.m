% Digital Image Processing HY-371
% Alexandros Angelakis csd4334
% Exercise 3
% Image Filtering

% Function that performs a valid convolution in an image.
function [valid_conv, kern] = my_conv(img, kernel)

% Dimensions of img
x = size(img,1);
y = size(img,2);

% Dimensions of kernel
kx = size(kernel,1);
ky = size(kernel,2);

% Our stride is of size one so the size of a valid convolution will be
% n - f + 1
valid_conv = zeros(x - kx + 1, y - ky + 1);

% Dimensions of convoluted image
convx = size(valid_conv,1);
convy = size(valid_conv,2);

% Flip the kernel vertically and horizontally
flip_kernel = rot90(kernel,2); % Same with flipud(fliplr) but faster

% Using im2col to help us with the convolution
i2c = im2col(img, [kx,ky]);
kern = (im2col(flip_kernel, [1 1]));

% Do the convolution
for j = 1:size(i2c, 2)
    tmp = 0;
    for i = 1:size(i2c,1)
        tmp = tmp + i2c(i,j) * kern(i);
    end
    valid_conv(j) = tmp;
end

% Reshape from a row vector to a matrix with size [convx,convy]
valid_conv = reshape(valid_conv, [convx, convy]);



% This implements the convolution without using the function im2col

% stepx = 0;
% 
% for convi = 1:size(valid_conv, 1)
%     stepy = 0;
%     for convj = 1:size(valid_conv, 2)
%         tmp = 0;
%         for ki = convi:(kx + convi - 1)
%             for kj = convj:(ky + convj - 1)
%                 tmp = tmp + img(ki, kj) * flip_kernel(ki - stepx, kj - stepy);
%             end
%         end
%         valid_conv(convi, convj) = tmp;
%         stepy = stepy + 1;
%     end
%     stepx = stepx + 1;
% end

end

