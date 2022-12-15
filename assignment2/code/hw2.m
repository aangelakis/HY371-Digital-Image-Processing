% Digital Image Processing HY-371
% Alexandros Angelakis csd4334
% Exercise 2
% Point-wise Intensity Transformations

clear; close all;

% Getting the directory with the images
myDir = uigetdir;
myFiles = dir(fullfile(myDir, '*.png'));

% for k = 1:(length(myFiles))
    baseFileName = 'A0S9V9.png';%myFiles(k).name;
    fullFileName = fullfile(myDir, baseFileName);
    
    % Reading and storing the image
    img = imread(fullFileName);
    
    [p,f,e] = fileparts(fullFileName);
    fullFileName = fullfile(p,f);
    
    % Scaling the image in range [0,1]
    norm_img = mat2gray(img);
    
    L = 256;
    
    % My histogram
    h = histogram(img);
    
    % MATLAB's histogram
    hist = imhist(img);
    
    % my PDF
    p = h/numel(img);
    
    % MATLAB's pdf
    p_mat = imhist(img)/numel(img);
    
    % Comparison between my PDF and the MATLAB's
    RMSE = sqrt(mean((p_mat - p).^2));
    
    figure; plot(h); title('My histogram');
    figure; plot(hist); title('MATLAB histogram');
    
    % Computation of the CDF
    q = cdf(p);
    
    % Loading the exponential, Gaussian, Rice distributions
    load('p_e.mat', 'p_e');
    load('p_G.mat', 'p_G');
    load('p_R.mat', 'p_R');
    
    % ð0 parameter
    pi0 = p(1)/p_e(1);
    
    % our models
    p1 = pi0 * p_e + (1 - pi0) * p_G;
    p2 = pi0 * p_e + (1 - pi0) * p_R;
    
    % Computation of the CDFs for the two given models
    q1 = cdf(p1);
    q2 = cdf(p2);
    
    % Finding the intensity transformation for the two models
    T1 = T1_f(q1, q);
    T2 = T2_f(q2, q);
    
    % Histogram Equalization
    T = (L-1)*q;
     
    % Applying the transformation to the image
    Y1 = cast(T1(img + 1) - 1, 'uint8');
    Y2 = cast(T2(img + 1) - 1, 'uint8');
    Y = cast(T(img + 1) - 1, 'uint8');
    
    % Find the histogram for each new image
    h1 = imhist(Y1);
    h2 = imhist(Y2);
    h3 = imhist(Y);
    
    % Finding pdf of Y
    p3 = h3/numel(Y);
    
    % Finding the CDF of Y
    q3 = cdf(p3);  
    
    % Plots 
    x = 1:256;
    
%     figure; title(baseFileName);
%     subplot(3,3,[1,2,3]), imshow(img); title('Original');
%     subplot(3,3,4), imshow(Y1); title('Gaussian');
%     subplot(3,3,5), imshow(Y2); title('Rice');
%     subplot(3,3,6), imshow(Y); title('Equalized');
%     subplot(3,3,7), plot(x, T, x, T1, x, T2); title('Transformations'); legend('T', 'T1', 'T2');
%     subplot(3,3,8), plot(x, h, x, h1, x, h2, x, h3); title('Histograms'); legend('Original', 'Gaussian', 'Rice', 'Equalized');
%     subplot(3,3,9), plot(x, q, x, q1, x, q2, x, q3); title('CDFs'); legend('Original', 'Gaussian', 'Rice', 'Equalized');
    
%     saveas(gcf, baseFileName);
% end