% Digital Image Processing HY-371
% Alexandros Angelakis csd4334
% Exercise 4 part2
%  Discrete Fourier Transform & Image Compression

%% Discrete Fourier Transform part1

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
        
        % Computing the mean absolute error between the resul   ting image and the
        % original one
        MAE = sum(sum(abs(new_Z - img)))./(M*N);
        
        % Plotting
        figure; imshow(new_Z); title(['The new image with alpha = ', num2str(alpha(i)), ' and MAE = ', num2str(MAE)], 'Interpreter', 'none');
%         saveas(gcf, [fullFileName, '_new', num2str(alpha(i)),'.png'])
    end
end

%% Discrete Fourier Transform part2

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
    
    phase = angle(dft);
    
    % Size of the image
    M = size(img, 1);
    N = size(img, 2);
    
    % variables for the sinusoidals
    m = 0:M-1;
    n = 0:N-1;
    u = m/M;
    v = n/N;
    
    alpha = 0.495;
    
    % The set of intervals we want to uniformly quantize with
    K = [5, 9, 17, 33, 65];
    
    % Altering the magnitude
    A = 1 ./ (1 - alpha * (cos(2*pi*u) + cos(2*pi*v')));
    
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
    
    % Computing the Discrete Fourier Transform
    dft_Z = fft2(new_Z);
    
    for i=1:size(K,2)
        
        % Find the uniformed vector for the specific set of interval of fft's phase
        thresh = linspace(min(phase(:)), max(phase(:)), K(i));
        
        % Quantize the phase with thresh levels and [0, thresh] values
        quantized_phase = imquantize(phase, thresh, [0, thresh]);
        
        % Polar form of fft with regular magnitude
        quantized_polar = abs(dft) .* exp(1i*quantized_phase);
        
        % Polar form of fft with altered magnitude
        quantized_altered_polar = abs(dft_Z) .* exp(1i*quantized_phase);
        
        % Taking the inverse fft with regular magnitude
        quantized_img = abs(ifft2(quantized_polar, 'symmetric'));
        
        % Taking the inverse fft with altered magnitude
        quantized_altered_img = abs(ifft2(quantized_altered_polar, 'symmetric'));
        
        % Computing the mean absolute error between the normal image and the
        % original one
        MAE = sum(sum(abs(quantized_img - img)))./(M*N);
        
        % Computing the mean absolute error between the altered image and the
        % original one
        MAE_altered = sum(sum(abs(quantized_altered_img - img))) / (M*N);
        
        % Plotting
        figure;
        subplot(211); imshow(quantized_img); title(['quantized image', ' with ', num2str(K(i)), ' intervals and MAE = ', num2str(MAE)], 'Interpreter', 'none');
        subplot(212); imshow(quantized_altered_img); title(['quantized altered image', ' with ', num2str(K(i)), ' intervals and MAE = ', num2str(MAE_altered)], 'Interpreter', 'none');
%         saveas(gcf, [fullFileName, '_new', num2str(K(i)),'.png'])
    end
end

%% Image Compression

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
    
    % percentage of retaining the spatial frequencies
    p = [2.5, 5, 7.5];
    
    for k = 1:size(p,2)
        max_p = p(k) / 100;
        
        % Calculating the DFT of the image
        dft = fft2(img);
        
        % Calculating the magnitude of the DFT
        A = abs(dft);
        
        % Directions of A
        M = size(A,1);
        N = size(A,2);
        
        A_new = zeros(M,N);
        
        % Reshaping the matrix into a vector
        A_vector = reshape(A, 1, M * N);
        
        % Sorting the A_vector in descending order
        A_sorted = sort(A_vector, 'descend');
        
        % How many frequencies we should consider
        max_frequencies = ceil(M * N * max_p);
        
        % Finding the positions of the frequencies that are below p%
        [x,y] = find(A >= A_sorted(max_frequencies));
        
        % Finding the frequencies that are below p%
        values = A(A >= A_sorted(max_frequencies));
        
        % Error checking
        if size(values,1) > max_frequencies
            values(max_frequencies+1:end) = [];
            x(max_frequencies+1:end) = [];
            y(max_frequencies+1:end) = [];
        end
        
        % Creating the new compressed magnitude of the image
        for i = 1:size(values,1)
            A_new(x(i), y(i)) = values(i);
        end
        
        % Polar form of DFT
        dft_new = A_new .* exp(1i*angle(dft));
        
        % Calculating the inverse DFT
        img_new = ifft2(dft_new, 'symmetric');
        
        % Calculating the Mean Absolute Error
        MAE = sum(sum(abs(img_new - img))) / (M*N);
        
        % Plotting
        figure; imshow(img_new); title([num2str(p(k)), ' % of the spatial frequencies and MAE = ', num2str(MAE)]);
        
%         saveas(gcf, [fullFileName, '_compressed', num2str(p(k)), '.png'])
    end
end