% Digital Image Processing HY-371
% Alexandros Angelakis csd4334
% Exercise 1_c
% Sub-sampling using the Nearest Neighbour method with Anti-aliasing and up-sampling using the Nearest Neighbour

clear; close all;

% Getting the directory with the images
myDir = uigetdir;
myFiles = dir(fullfile(myDir, '*.gif'));

% scaling factor
a = 1/8;

% Some initializations
E_imresize = zeros(1, length(myFiles));
E_imresize_AA = zeros(1, length(myFiles));
G_original = zeros(1, length(myFiles));
G_imresize = zeros(1, length(myFiles));
G_imresize_AA = zeros(1, length(myFiles));

% Upsample and sub-sample every image
for k = 1:(length(myFiles))

  baseFileName = myFiles(k).name;
  fullFileName = fullfile(myDir, baseFileName);

  % Reading and storing the image
  img = imread(fullFileName);

  [p,f,e] = fileparts(fullFileName);
  fullFileName = fullfile(p,f);

  % Scaling the image in range [0,1]
  norm_img = mat2gray(img);

  % Plotting the original image
  figure;
  subplot(2,2,[1,2]), imshow(norm_img);
  title(['Image: ', baseFileName], 'Interpreter', 'none');

  % Sub-sampling the image using the imresize function with anti-aliasing and plotting it
  sub_sampled_img_imresize_AA = imresize(norm_img, a, method = "nearest", 'Antialiasing', true);
  %figure; imshow(sub_sampled_img_imresize_AA); title(['Sub-sampled Image with AA: ', baseFileName], 'Interpreter', 'none');

  % Sub-sampling the image using the imresize function with anti-aliasing and plotting it
  sub_sampled_img_imresize = imresize(norm_img, a, method = "nearest");
  %figure; imshow(sub_sampled_img_imresize); title(['Sub-sampled Image without AA: ', baseFileName], 'Interpreter', 'none');

  % Up-sampling the sub-sampled image using the imresize function and plotting it
  restored_img_imresize_AA = imresize(sub_sampled_img_imresize_AA, 1/a, method = "nearest");

  % Up-sampling the sub-sampled image using my imresize function
  restored_img_imresize = imresize(sub_sampled_img_imresize, 1/a, method = "nearest");

  % Plots
  subplot(2,2,3), imshow(restored_img_imresize_AA);
  title('Restored Image with AA', 'Interpreter', 'none');
  subplot(2,2,4), imshow(restored_img_imresize);
  title('Restored Image without AA', 'Interpreter', 'none');

##  saveas(gcf, [fullFileName, '.png'])

  % Computing the local difference of the original image
  S = sqrt(sum(sum(norm_img.^2)));
  G_h1 = Gh(norm_img, S);
  G_v1 = Gv(norm_img, S);
  G_original(k) = max(G_h1, G_v1);

  % Computing the local difference of the restored image with AA
  S = sqrt(sum(sum(restored_img_imresize_AA.^2)));
  G_h1 = Gh(restored_img_imresize_AA, S);
  G_v1 = Gv(restored_img_imresize_AA, S);
  G_imresize_AA(k) = max(G_h1, G_v1);

  % Computing the local difference of the restored image produced by imresize
  S = sqrt(sum(sum(restored_img_imresize.^2)));
  G_h2 = Gh(restored_img_imresize, S);
  G_v2 = Gv(restored_img_imresize, S);
  G_imresize(k) = max(G_h2, G_v2);

  % Computing the mean approximation error between the restored image with AA and the original one
  E_imresize_AA(k) = (1/S) * sqrt(sum(sum((norm_img - restored_img_imresize_AA).^2)));

  % Computing the mean approximation error between the restored image without AA and the original one
  E_imresize(k) = (1/S) * sqrt(sum(sum((norm_img - restored_img_imresize).^2)));

end

% Plots
figure;
stem(E_imresize_AA);
hold on;
stem(E_imresize);
legend('imresize with AA', 'imresize without AA', 'Interpreter', 'none');
title('Errors of every image with and without AA');

figure;
stem(G_original);
hold on;
stem(G_imresize);
stem(G_imresize_AA);
legend('original', 'imresize without AA', 'imresize with AA', 'Interpreter', 'none');
title('Local Differences of every image with and without AA');
