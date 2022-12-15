% Digital Image Processing HY-371
% Alexandros Angelakis csd4334
% Exercise 4 part2
%  Discrete Fourier Transform & Image Compression

%% Discrete Fourier Transform Part 1

close all; clear;

% Getting the directory with the images
myDir = uigetdir;
myFiles = dir(fullfile(myDir, '*.png'));

for k = 1:(length(myFiles))
    
    baseFileName = myFiles(k).name;
    fullFileName = fullfile(myDir, baseFileName);
    
    % Reading and storing the image
    I = imread(fullFileName);
    img = im2double(I);
    
    [p,f,e] = fileparts(fullFileName);
    fullFileName = fullfile(p,f);
    
    % Plotting it
    figure;
    imshow(img); title('Original image');
    
    % Computing the Discrete Fourier Transform
    dft = fft2(img);
    
    % The DFT expressed in the polar coordinate system
    polar_dft = abs(dft) .* exp(1i * angle(dft));
    
    % Size of the image
    M = size(img, 1);
    N = size(img, 2);
    
    % variables for the sinusoidals
    m = 0:M-1;
    n = 0:N-1;
    u = m/M;
    v = n/N;
    
    alpha = [0.45, 0.49, 0.495];
    
    for i=1 : size(alpha,2)
        % Altering the magnitude
        A = 1 ./ (1 - alpha(i) * (cos(2*pi*u) + cos(2*pi*v')));
        
        % The new DFT with altered magnitude
        new_polar_dft = A .* exp(1i * angle(dft));
        
        % Computing the inverse DFT of the altered magnitude
        Y = ifft2(new_polar_dft, 'symmetric');
        
        % Linearnly transforming the inverse DFT for the magnitude case alpha
        Z = linear_transform(img,Y);
        
        % The histogram of the original image
        hist = imhist(img);
        
        % Histogram equalization between the image Z an1d the histogram of the
        % original one
        new_Z = histeq(Z, hist);
        
        % Computing the mean absolute error between the resulting image and the
        % original one
        MAE = sum(sum(abs(new_Z - img)))./(M*N);
        
        % Plotting
        figure;
        subplot(121); imhist(img); title('Histogram of the original image');
        subplot(122); imhist(new_Z); title('Histogram of the new altered image');
        
%         saveas(gcf, [fullFileName, '_hist', num2str(alpha(i)), '.png'])
        
        figure; imshow(new_Z); title(['The new altered image with alpha = ', num2str(alpha(i))], 'Interpreter', 'none');
        
%         saveas(gcf, [fullFileName, '_new', num2str(alpha(i)),'.png'])
    end
end

%% Discrete Fourier Transform Part 2






