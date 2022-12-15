% Digital Image Processing HY-371
% Alexandros Angelakis csd4334
% Exercise 4 part2
%  Discrete Fourier Transform & Image Compression

%% Discrete Fourier Transform

close all; clear;

I = imread('einstein.png');
img = im2double(I);

figure;
imshow(img);

dft = fft2(img);

M = size(img, 1);
N = size(img, 2);

m = 0:M-1;
n = 0:N-1;

u = m/M;
v = n/N;

a = 0.45;

new_abs = 1 ./ (1 - a * (cos(2*pi*u) + cos(2*pi*v')));

polar_dft = new_abs .* exp(1i * angle(dft));

idft = ifft2(polar_dft, 'symmetric');

Z = linear_transform(img,idft);

hist = imhist(img);

new_Z = histeq(Z, hist);

MAE = sum(sum(abs(new_Z - img)))/(M*N);

figure;
imhist(img);

figure;
imhist(new_Z);

figure;
imshow(new_Z);