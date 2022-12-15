% Digital Image Processing HY-371
% Alexandros Angelakis csd4334
% Exercise 4 part1
%  Discrete Space Fourier Transform & Image Segmentation

%% Discrete Space Fourier Transform

close all; clear;

% Our 1D signals in the time domain
m = -5:5;
h = [0.009, 0.027, 0.065, 0.122, 0.177, 0.2, 0.177, 0.122, 0.065, 0.027, 0.009];
g = [0.013, 0.028, 0.048, 0.056, 0.039, 0, 0.039, 0.056, 0.048, 0.028, 0.013];
f = -1/2:0.001:1/2;

% Compute the DSFT of the two signals
F_h = DSFT_1D(h, m, f);
F_g = DSFT_1D(g, m, f);

% Plots of the signals in the time domain
figure;
plot(m,h); hold on;
plot(m,g); hold off;
legend('h(m)', 'g(m)');
title('Signals in time domain');

% Plots of the signals in the frequency domain
figure;
plot(f, abs(F_h)); hold on;
plot(f, abs(F_g)); hold off;
legend('F_h(u)', 'F_g(u)', 'Interpreter', 'none');
title('Signals in frequency domain');

% Our 2D filter in the Fourier domain
% Since convolution becomes multiplication in frequency domain
Fhg = F_h .* F_g;

% Our 2D filter in the time domain using conv()
hg1 = conv(h,g, 'same');

% Our 2D filter in the time domain, using the inverse Fourier Transform
hg2 = real(inverse_DSFT_1D(Fhg, f ,m))/size(Fhg,2);

%  Plots of the convolution of the two signals in the time domain
% and the same process expressed as multiplication in the frequency domain
figure;
subplot(3,1,1); plot(m, hg1); title('Signal hg using conv', 'Interpreter', 'none');
subplot(3,1,2); plot(m, hg2); title('Signal hg using inverse Fourier Transform', 'Interpreter', 'none');
subplot(3,1,3); plot(f, abs(Fhg)); title('Magnitude of signal F_hg', 'Interpreter', 'none');

%% Image Segmentation

close all; clear;

% Our 1D signals in the time domain
h = [0.009, 0.027, 0.065, 0.122, 0.177, 0.2, 0.177, 0.122, 0.065, 0.027, 0.009];
g = [0.013, 0.028, 0.048, 0.056, 0.039, 0, 0.039, 0.056, 0.048, 0.028, 0.013];

% Reading and storing our image
I = imread('build_neoclassic.png');
img = im2double(I);
figure; imshow(img); title('Original Image');

% Compute the two filters
h1 = h .* g';
h2 = g .* h';

% Computing each filter response by filtering rows and columns separately
y1 = imfilter(imfilter(img, h), g');
y2 = imfilter(imfilter(img, g), h');

% Plotting
figure; imshow(y1); title('Image filtered with h1');
figure; imshow(y2); title('Image filtered with h2');

% Calculating the square magnitude
A = y1.^2 + y2.^2;

% Calculating the unsigned direction of the vector (y1, y2)
theta = abs(atan(y2./y1));

% The mean value of A
mu = mean(mean(A));

% The cluster centers
theta_k = [0, 0.15*pi, 0.35*pi, 0.5*pi]; 

% All the theta values in a column vector
data = reshape(theta, size(theta,1)*size(theta,2), 1);

% Clustering the image based on the thetas
C = kmeans(data, size(theta_k,2), 'Distance', 'cityblock', 'Start', theta_k');

% The clustered image with labels
L = reshape(C, 590, 959);

% Because MATLAB is bad and arrays don't start from 0 :D
for m = 1:size(A, 1)
    for n = 1:size(A, 2)
        if A(m, n) <= mu
            L(m, n) = 0;
        end
        L(m, n) = L(m, n) + 1;
    end
end

cmap = [0 0 0;  % Black
        1 1 0;  % Yellow
        1 0 0;  % Red
        0 1 0;  % Green
        0 0 1;];% Blue
    
% From labels to RGB image
RGB = label2rgb(L, cmap);

% Plotting the RGB image
figure;
imshow(RGB); title('The clustered RGB image');