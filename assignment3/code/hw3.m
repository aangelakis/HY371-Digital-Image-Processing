% Digital Image Processing HY-371
% Alexandros Angelakis csd4334
% Exercise 3
% Image Filtering

clear; close all;

I = imread('bsds86016.png');

img = im2double(I);

threshold = graythresh(img);
BW = im2bw(img, threshold);

figure;
imshow(BW); title('Binarized Original Image');

%% 1(a)
kernel = [0 -1 0;
          -1 5 -1;
          0 -1 0;];
      
[conved_I_a, peos] = my_conv(img, kernel);

figure;
subplot(1,2,1); imshow(conved_I_a); title('Filtered Image');
subplot(1,2,2); imhist(conved_I_a); title('Filtered Image Histogram');

%% 1(b)
ver_kernel = [0; 1; 0;];
hor_kernel = [0 1 0];

conved_I_b = my_separable_conv(img, hor_kernel, ver_kernel, 2);

figure;
subplot(2, 1, 1); imshow(img); title('Original Image');
subplot(2, 1, 2); imshow(conved_I_b); title('Convoluted Image');

figure;
subplot(2, 1, 1); imhist(img); title('imhist of original');
subplot(2, 1, 2); imhist(conved_I_b); title('imhist of conved');

%% 2.1

for sigma = 3:2:7;
    
    matlab_gaussian = matlab_gaussian_filter(img, sigma, 'replicate');
    
    my_gaussian = my_gaussian_filter(img, sigma, 2);
    
    threshold1 = graythresh(matlab_gaussian);
    threshold2 = graythresh(my_gaussian);
    
    binarized_matlab_gaussian = im2bw(matlab_gaussian, threshold1);
    
    binarized_my_gaussian = im2bw(my_gaussian, threshold2);
    
    figure;
    subplot(1, 2, 1); imshow(binarized_matlab_gaussian); title(['MATLAB binarized image with sigma = ', num2str(sigma)]);
    subplot(1, 2, 2); imshow(binarized_my_gaussian); title(['My binarized image with sigma = ', num2str(sigma)]);
end

%% 2.2

I = imread('facade.png');

img = im2double(I);

threshold = graythresh(img);
BW = im2bw(img, threshold);

figure;
imshow(BW); title('Original Image');

matlab_stddev = matlab_stddev_filter(img, 0);

my_stddev = my_stddev_filter(img, 1);

threshold1 = graythresh(matlab_stddev);
threshold2 = graythresh(my_stddev);

binarized_matlab_stddev = im2bw(matlab_stddev, threshold1);

binarized_my_stddev = im2bw(my_stddev, threshold2);

figure; imshow(binarized_matlab_stddev); title('MATLAB binarized image');
figure; imshow(binarized_my_stddev); title('My binarized image');

%% 2.3

I = imread('plate_usa.png');

img = mat2gray(I);

threshold = graythresh(img);
BW = im2bw(img, threshold);

figure;
imshow(BW); title('Binarized Original Image');

sigma2 = 2 * sqrt(2);

sigma1 = 1.28 * sigma2;

matlab_log = matlab_log_filter(img, sigma1, sigma2, 'replicate');

my_log = my_log_filter(img, sigma1, sigma2, 2);

threshold1 = graythresh(matlab_log);
threshold2 = graythresh(my_log);

binarized_matlab_log = im2bw(matlab_log, threshold1);

binarized_my_log = im2bw(my_log, threshold2);

figure;
subplot(1, 2, 1); imshow(binarized_matlab_log); title('MATLAB binarized image');
subplot(1, 2, 2); imshow(binarized_my_log); title('My binarized image');