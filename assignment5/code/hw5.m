% Digital Image Processing HY-371
% Alexandros Angelakis csd4334
% Exercise 5
% Unsupervised Image Segmentation Algorithms

%% K-Means Algorithm


close all; clear;

% Loading the all the images and their depth maps
load('depth/office_depth.mat', 'depth_img1');
depth_img1 = mat2gray(depth_img1);
% figure; imshow(depth_img1); title('Office depth image');

load('depth/tableroom_depth.mat', 'depth_img2');
depth_img2 = mat2gray(depth_img2);
% figure; imshow(depth_img2); title('Tableroom depth image');

load('depth/bedroom_depth.mat', 'depth_img3');
depth_img3 = mat2gray(depth_img3);
% figure; imshow(depth_img3); title('Bedroom depth image');

img1 = imread('images/office.png');
img1 = im2double(img1);
% figure; imshow(img1); title('Office image');

img2 = imread('images/tableroom.png');
img2 = im2double(img2);
% figure; imshow(img2); title('Tableroom image');

img3 = imread('images/bedroom.png');
img3 = im2double(img3);
% figure; imshow(img3); title('Bedroom image');

% Reshaping our data for our algorithms
depth_data1 = reshape(depth_img1, size(depth_img1,1) * size(depth_img1,2), 1);
depth_data2 = reshape(depth_img2, size(depth_img2,1) * size(depth_img2,2), 1);
depth_data3 = reshape(depth_img3, size(depth_img3,1) * size(depth_img3,2), 1);

colour_data1 = reshape(img1, size(img1,1) * size(img1,2), 3);
colour_data2 = reshape(img2, size(img2,1) * size(img2,2), 3);
colour_data3 = reshape(img3, size(img3,1) * size(img3,2), 3);

% Creating the color + spatial coordinates matrix
spatial_coord1 = zeros(size(img1,1) * size(img1,2),2);
spatial_coord2 = zeros(size(img2,1) * size(img2,2),2);
spatial_coord3 = zeros(size(img3,1) * size(img3,2),2);

% Dumb way to do that in MatLab but it works
k = 1;
for j = 1:size(img1,2)
    for i=1:size(img1,1)
        spatial_coord1(k,1) = i;
        spatial_coord1(k,2) = j;
        spatial_coord2(k,1) = i;
        spatial_coord2(k,2) = j;
        spatial_coord3(k,1) = i;
        spatial_coord3(k,2) = j;
        k = k + 1;
    end
end

% Concatenating the two matrices
coord_data1 = [colour_data1 spatial_coord1];
coord_data2 = [colour_data2 spatial_coord2];
coord_data3 = [colour_data3 spatial_coord3];

% Number of clusters for the K-Means algorithm
k = [3, 5, 7];

% K-Means using as comparison metric the sqeuclidean
for i=1:size(k,2)
    % Colour
    color1  = kmeans(colour_data1, k(i));
    color1  = reshape(color1, size(img1,1), size(img1,2));
    colorB1 = labeloverlay(img1, color1);
    figure;
    imshow(colorB1); title(['Office colour using K-Means sqeuclidean with k = ', num2str(k(i))]);
    %     saveas(gcf, ['office_color_eucl', num2str(k(i)),'.png']);
    
    color2  = kmeans(colour_data2, k(i));
    color2  = reshape(color2, size(img2,1), size(img2,2));
    colorB2 = labeloverlay(img2, color2);
    figure;
    imshow(colorB2); title(['Tableroom colour using K-Means sqeuclidean with k = ', num2str(k(i))]);
    %     saveas(gcf, ['tableroom_color_eucl', num2str(k(i)),'.png']);
    
    color3  = kmeans(colour_data3, k(i));
    color3  = reshape(color3, size(img3,1), size(img3,2));
    colorB3 = labeloverlay(img3, color3);
    figure;
    imshow(colorB3); title(['Bedroom colour using K-Means sqeuclidean with k = ', num2str(k(i))]);
    %     saveas(gcf, ['bedroom_color_eucl', num2str(k(i)),'.png']);
    
    % Depth
    depth1          = kmeans(depth_data1, k(i));
    depth1          = reshape(depth1, size(depth_img1,1), size(depth_img1,2));
    depthB1         = labeloverlay(depth_img1, depth1);
    figure;
    imshow(depthB1); title(['Office depth using K-Means sqeuclidean with k = ', num2str(k(i))]);
    %     saveas(gcf, ['office_depth_eucl', num2str(k(i)),'.png'])
    
    depth2          = kmeans(depth_data2, k(i));
    depth2          = reshape(depth2, size(depth_img2,1), size(depth_img2,2));
    depthB2         = labeloverlay(depth_img2, depth2);
    figure;
    imshow(depthB2); title(['Tableroom depth using K-Means sqeuclidean with k = ', num2str(k(i))]);
    %     saveas(gcf, ['tableroom_depth_eucl', num2str(k(i)),'.png'])
    
    depth3          = kmeans(depth_data3, k(i));
    depth3          = reshape(depth3, size(depth_img3,1), size(depth_img3,2));
    depthB3         = labeloverlay(depth_img3, depth3);
    figure;
    imshow(depthB3); title(['Bedroom depth using K-Means sqeuclidean with k = ', num2str(k(i))]);
    %     saveas(gcf, ['bedroom_depth_eucl', num2str(k(i)),'.png'])
    
    % Colour + spatial coordinates
    coord1  = kmeans(coord_data1, k(i));
    coord1  = reshape(coord1, size(img1,1), size(img1,2));
    coordB1 = labeloverlay(img1, coord1);
    figure;
    imshow(coordB1); title(['Office colour + spatial using K-Means sqeuclidean with k = ', num2str(k(i))]);
    %     saveas(gcf, ['office_coord_eucl', num2str(k(i)),'.png'])
    
    coord2  = kmeans(coord_data2, k(i));
    coord2  = reshape(coord2, size(img2,1), size(img2,2));
    coordB2 = labeloverlay(img2, coord2);
    figure;
    imshow(coordB2); title(['Tableroom colour + spatial using K-Means sqeuclidean with k = ', num2str(k(i))]);
    %     saveas(gcf, ['tableroom_coord_eucl', num2str(k(i)),'.png'])
    
    coord3  = kmeans(coord_data3, k(i));
    coord3  = reshape(coord3, size(img3,1), size(img3,2));
    coordB3 = labeloverlay(img3, coord3);
    figure;
    imshow(coordB3); title(['Bedroom colour + spatial using K-Means sqeuclidean with k = ', num2str(k(i))]);
    %     saveas(gcf, ['bedroom_coord_eucl', num2str(k(i)),'.png'])
end


% K-Means using as comparison metric the cityblock

% Number of clusters
k = 7;

% Color
color1  = kmeans(colour_data1, k, 'Distance', 'cityblock');
color1  = reshape(color1, size(img1,1), size(img1,2));
colorB1 = labeloverlay(img1, color1);
figure;
imshow(colorB1); title(['Labeled Image using K-Means cityblock with k = ', num2str(k)]);
% saveas(gcf, ['office_color_city', num2str(k),'.png']);

color2  = kmeans(colour_data2, k, 'Distance', 'cityblock');
color2  = reshape(color2, size(img2,1), size(img2,2));
colorB2 = labeloverlay(img2, color2);
figure;
imshow(colorB2); title(['Labeled Image using K-Means cityblock with k = ', num2str(k)]);
% saveas(gcf, ['tableroom_color_city', num2str(k),'.png']);

color3  = kmeans(colour_data3, k, 'Distance', 'cityblock');
color3  = reshape(color3, size(img2,1), size(img2,2));
colorB3 = labeloverlay(img3, color3);
figure;
imshow(colorB3); title(['Labeled Image using K-Means cityblock with k = ', num2str(k)]);
% saveas(gcf, ['bedroom_color_city', num2str(k),'.png']);

% Depth
depth1          = kmeans(depth_data1, k, 'Distance', 'cityblock');
depth1          = reshape(depth1, size(depth_img1,1), size(depth_img1,2));
depthB1         = labeloverlay(depth_img1, depth1);
figure;
imshow(depthB1); title(['Labeled Image using K-Means cityblock with k = ', num2str(k)]);
% saveas(gcf, ['office_depth_city', num2str(k),'.png'])

depth2          = kmeans(depth_data2, k, 'Distance', 'cityblock');
depth2          = reshape(depth2, size(depth_img2,1), size(depth_img2,2));
depthB2         = labeloverlay(depth_img2, depth2);
figure;
imshow(depthB2); title(['Labeled Image using K-Means cityblock with k = ', num2str(k)]);
% saveas(gcf, ['tableroom_depth_city', num2str(k),'.png'])

depth3          = kmeans(depth_data3, k, 'Distance', 'cityblock');
depth3          = reshape(depth3, size(depth_img3,1), size(depth_img3,2));
depthB3         = labeloverlay(depth_img3, depth3);
figure;
imshow(depthB3); title(['Labeled Image using K-Means cityblock with k = ', num2str(k)]);
% saveas(gcf, ['bedroom_depth_city', num2str(k),'.png'])

% Colour + spatial coordinates
coord1  = kmeans(coord_data1, k, 'Distance', 'cityblock');
coord1  = reshape(coord1, size(img1,1), size(img1,2));
coordB1 = labeloverlay(img1, coord1);
figure;
imshow(coordB1); title(['Office colour + spatial using K-Means cityblock with k = ', num2str(k)]);
% saveas(gcf, ['office_coord_city', num2str(k),'.png'])

coord2  = kmeans(coord_data2, k, 'Distance', 'cityblock');
coord2  = reshape(coord2, size(img2,1), size(img2,2));
coordB2 = labeloverlay(img2, coord2);
figure;
imshow(coordB2); title(['Tableroom colour + spatial using K-Means cityblock with k = ', num2str(k)]);
% saveas(gcf, ['tableroom_coord_city', num2str(k),'.png'])

coord3  = kmeans(coord_data3, k, 'Distance', 'cityblock');
coord3  = reshape(coord3, size(img3,1), size(img3,2));
coordB3 = labeloverlay(img3, coord3);
figure;
imshow(coordB3); title(['Bedroom colour + spatial using K-Means cityblock with k = ', num2str(k)]);
% saveas(gcf, ['bedroom_coord_city', num2str(k),'.png'])


% K-Means using as comparison metric the cosine

% Adding +1 for each pixel because of the cosine metric
depth_data1 = depth_data1 + 1;
depth_data2 = depth_data2 + 1;
depth_data3 = depth_data3 + 1;
colour_data1 = colour_data1 + 1;
colour_data2 = colour_data2 + 1;
colour_data3 = colour_data3 + 1;
coord_data1 = coord_data1 + 1;
coord_data2 = coord_data2 + 1;
coord_data3 = coord_data3 + 1;

% Color
color1  = kmeans(colour_data1, k, 'Distance', 'cosine');
color1  = reshape(color1, size(img1,1), size(img1,2));
colorB1 = labeloverlay(img1, color1);
figure;
imshow(colorB1); title(['Labeled Image using K-Means cosine with k = ', num2str(k)]);
% saveas(gcf, ['office_color_cos', num2str(k),'.png']);

color2  = kmeans(colour_data2, k, 'Distance', 'cosine');
color2  = reshape(color2, size(img2,1), size(img2,2));
colorB2 = labeloverlay(img2, color2);
figure;
imshow(colorB2); title(['Labeled Image using K-Means cosine with k = ', num2str(k)]);
% saveas(gcf, ['tableroom_color_cos', num2str(k),'.png']);

color3  = kmeans(colour_data3, k, 'Distance', 'cosine');
color3  = reshape(color3, size(img2,1), size(img2,2));
colorB3 = labeloverlay(img3, color3);
figure;
imshow(colorB3); title(['Labeled Image using K-Means cosine with k = ', num2str(k)]);
% saveas(gcf, ['bedroom_color_cos', num2str(k),'.png']);

% Depth
depth1          = kmeans(depth_data1, k, 'Distance', 'cosine');
depth1          = reshape(depth1, size(depth_img1,1), size(depth_img1,2));
depthB1         = labeloverlay(depth_img1, depth1);
figure;
imshow(depthB1); title(['Labeled Image using K-Means cosine with k = ', num2str(k)]);
% saveas(gcf, ['office_depth_cos', num2str(k),'.png'])

depth2          = kmeans(depth_data2, k, 'Distance', 'cosine');
depth2          = reshape(depth2, size(depth_img2,1), size(depth_img2,2));
depthB2         = labeloverlay(depth_img2, depth2);
figure;
imshow(depthB2); title(['Labeled Image using K-Means cosine with k = ', num2str(k)]);
% saveas(gcf, ['tableroom_depth_cos', num2str(k),'.png'])

depth3          = kmeans(depth_data3, k, 'Distance', 'cosine');
depth3          = reshape(depth3, size(depth_img3,1), size(depth_img3,2));
depthB3         = labeloverlay(depth_img3, depth3);
figure;
imshow(depthB3); title(['Labeled Image using K-Means cosine with k = ', num2str(k)]);
% saveas(gcf, ['bedroom_depth_cos', num2str(k),'.png'])

% Colour + spatial coordinates
coord1  = kmeans(coord_data1, k, 'Distance', 'cosine');
coord1  = reshape(coord1, size(img1,1), size(img1,2));
coordB1 = labeloverlay(img1, coord1);
figure;
imshow(coordB1); title(['Office colour + spatial using K-Means cosine with k = ', num2str(k)]);
% saveas(gcf, ['office_coord_cos', num2str(k),'.png'])

coord2  = kmeans(coord_data2, k, 'Distance', 'cosine');
coord2  = reshape(coord2, size(img2,1), size(img2,2));
coordB2 = labeloverlay(img2, coord2);
figure;
imshow(coordB2); title(['Tableroom colour + spatial using K-Means cosine with k = ', num2str(k)]);
% saveas(gcf, ['tableroom_coord_cos', num2str(k),'.png'])

coord3  = kmeans(coord_data3, k, 'Distance', 'cosine');
coord3  = reshape(coord3, size(img3,1), size(img3,2));
coordB3 = labeloverlay(img3, coord3);
figure;
imshow(coordB3); title(['Bedroom colour + spatial using K-Means cosine with k = ', num2str(k)]);
% saveas(gcf, ['bedroom_coord_cos', num2str(k),'.png'])



%% Mean-Shift Algorithm

close all; clear;

% Loading the all the images
img1 = imread('images/office.png');
img1 = im2double(img1);
img1_resize = imresize(img1, [128 128]);
% figure; imshow(img1); title('Office image');

img2 = imread('images/tableroom.png');
img2 = im2double(img2);
img2_resize = imresize(img2, [128 128]);
% figure; imshow(img2); title('Tableroom image');

img3 = imread('images/bedroom.png');
img3 = im2double(img3);
img3_resize = imresize(img3, [128 128]);
% figure; imshow(img3); title('Bedroom image');

% Reshaping our data for our algorithms
colour_data1 = reshape(img1, size(img1,1) * size(img1,2), 3);
colour_data2 = reshape(img2, size(img2,1) * size(img2,2), 3);
colour_data3 = reshape(img3, size(img3,1) * size(img3,2), 3);

colour_data1_resize = reshape(img1_resize, size(img1_resize,1) * size(img1_resize,2), 3);
colour_data2_resize = reshape(img2_resize, size(img2_resize,1) * size(img2_resize,2), 3);
colour_data3_resize = reshape(img3_resize, size(img3_resize,1) * size(img3_resize,2), 3);

% Creating the color + spatial coordinates matrix
spatial_coord1 = zeros(size(img1_resize,1) * size(img1_resize,2),2);
spatial_coord2 = zeros(size(img2_resize,1) * size(img2_resize,2),2);
spatial_coord3 = zeros(size(img3_resize,1) * size(img3_resize,2),2);

% Dumb way to do that in MatLab but it works
k = 1;
for j = 1:size(img1_resize,2)
    for i=1:size(img1_resize,1)
        spatial_coord1(k,1) = i;
        spatial_coord1(k,2) = j;
        spatial_coord2(k,1) = i;
        spatial_coord2(k,2) = j;
        spatial_coord3(k,1) = i;
        spatial_coord3(k,2) = j;
        k = k + 1;
    end
end

spatial_coord1 = spatial_coord1/max(max(spatial_coord1));
spatial_coord2 = spatial_coord2/max(max(spatial_coord2));
spatial_coord3 = spatial_coord3/max(max(spatial_coord3));

% Concatenating the two matrices
coord_data1 = [colour_data1_resize spatial_coord1];
coord_data2 = [colour_data2_resize spatial_coord2];
coord_data3 = [colour_data3_resize spatial_coord3];


bw = [0.2, 0.35, 0.6];

for i = 1:size(bw,2)
    % Colour
    [~,data2cluster,~] = MeanShiftCluster(colour_data1.', bw(i));
    color1 = reshape(data2cluster, size(img1,1), size(img1,2));
    colorB1 = labeloverlay(img1, color1);
    figure;
    imshow(colorB1); title(['Office Image using Mean-Shift with bandwidth = ', num2str(bw(i))]);
%     saveas(gcf, ['office_color_shift', num2str(bw(i)),'.png'])

    [~,data2cluster,~] = MeanShiftCluster(colour_data2.', bw(i));
    color2 = reshape(data2cluster, size(img2,1), size(img2,2));
    colorB2 = labeloverlay(img2, color2);
    figure;
    imshow(colorB2); title(['Tableroom Image using Mean-Shift with bandwidth = ', num2str(bw(i))]);
%     saveas(gcf, ['tableroom_color_shift', num2str(bw(i)),'.png'])

    [~,data2cluster,~] = MeanShiftCluster(colour_data3.', bw(i));
    color3 = reshape(data2cluster, size(img3,1), size(img3,2));
    colorB3 = labeloverlay(img3, color3);
    figure;
    imshow(colorB3); title(['Bedroom Image using Mean-Shift with bandwidth = ', num2str(bw(i))]);
%     saveas(gcf, ['bedroom_color_shift', num2str(bw(i)),'.png'])

    % Colour + Partial Coordinates
    [~,data2cluster,~] = MeanShiftCluster(coord_data1.', bw(i));
    coord1 = reshape(data2cluster, size(img1_resize,1), size(img1_resize,2));
    coordB1 = labeloverlay(img1_resize, coord1);
    figure;
    imshow(coordB1); title(['Office Image using Mean-Shift with bandwidth = ', num2str(bw(i))]);
%     saveas(gcf, ['office_coord_shift', num2str(bw(i)),'.png'])

    [~,data2cluster,~] = MeanShiftCluster(coord_data2.', bw(i));
    coord2 = reshape(data2cluster, size(img2_resize,1), size(img2_resize,2));
    coordB2 = labeloverlay(img2_resize, coord2);
    figure;
    imshow(coordB2); title(['Tableroom Image using Mean-Shift with bandwidth = ', num2str(bw(i))]);
%     saveas(gcf, ['tableroom_coord_shift', num2str(bw(i)),'.png'])

    [~,data2cluster,~] = MeanShiftCluster(coord_data3.', bw(i));
    coord3 = reshape(data2cluster, size(img3_resize,1), size(img3_resize,2));
    coordB3 = labeloverlay(img3_resize, coord3);
    figure;
    imshow(coordB3); title(['Bedroom Image using Mean-Shift with bandwidth = ', num2str(bw(i))]);
%     saveas(gcf, ['bedroom_coord_shift', num2str(bw(i)),'.png'])
end

bw = 0.35;

% Colour
[~,data2cluster,~] = MeanShiftClusterCityBlock(colour_data1.', bw);
color1 = reshape(data2cluster, size(img1,1), size(img1,2));
colorB1 = labeloverlay(img1, color1);
figure;
imshow(colorB1); title(['Office Image using Mean-Shift with bandwidth = ', num2str(bw)]);
% saveas(gcf, ['office_color_shift_city', num2str(bw),'.png'])

[~,data2cluster,~] = MeanShiftClusterCityBlock(colour_data2.', bw);
color2 = reshape(data2cluster, size(img2,1), size(img2,2));
colorB2 = labeloverlay(img2, color2);
figure;
imshow(colorB2); title(['Tableroom Image using Mean-Shift with bandwidth = ', num2str(bw)]);
% saveas(gcf, ['tableroom_color_shift_city', num2str(bw),'.png'])

[~,data2cluster,~] = MeanShiftClusterCityBlock(colour_data3.', bw);
color3 = reshape(data2cluster, size(img3,1), size(img3,2));
colorB3 = labeloverlay(img3, color3);
figure;
imshow(colorB3); title(['Bedroom Image using Mean-Shift with bandwidth = ', num2str(bw)]);
% saveas(gcf, ['bedroom_color_shift_city', num2str(bw),'.png'])

% Colour + Partial Coordinates
[~,data2cluster,~] = MeanShiftClusterCityBlock(coord_data1.', bw);
coord1 = reshape(data2cluster, size(img1_resize,1), size(img1_resize,2));
coordB1 = labeloverlay(img1_resize, coord1);
figure;
imshow(coordB1); title(['Office Image using Mean-Shift with bandwidth = ', num2str(bw)]);
% saveas(gcf, ['office_coord_shift_city', num2str(bw),'.png'])

[~,data2cluster,~] = MeanShiftClusterCityBlock(coord_data2.', bw);
coord2 = reshape(data2cluster, size(img2_resize,1), size(img2_resize,2));
coordB2 = labeloverlay(img2_resize, coord2);
figure;
imshow(coordB2); title(['Tableroom Image using Mean-Shift with bandwidth = ', num2str(bw)]);
% saveas(gcf, ['tableroom_coord_shift_city', num2str(bw),'.png'])

[~,data2cluster,~] = MeanShiftClusterCityBlock(coord_data3.', bw);
coord3 = reshape(data2cluster, size(img3_resize,1), size(img3_resize,2));
coordB3 = labeloverlay(img3_resize, coord3);
figure;
imshow(coordB3); title(['Bedroom Image using Mean-Shift with bandwidth = ', num2str(bw)]);
% saveas(gcf, ['bedroom_coord_shift_city', num2str(bw),'.png']);

%% BONUS

close all; clear;

% Loading the all the images
img1 = imread('images/office.png');
img1 = im2double(img1);
img1 = imgaussfilt(img1, 2);
figure; imshow(img1); title('Filtered image with Gaussian and sigma = 2');

colour_data = reshape(img1, size(img1,1) * size(img1,2), 3);

% Number of clusters
k = 7;

% K-Means using only the colour
color  = kmeans(colour_data, k);
color  = reshape(color, size(img1,1), size(img1,2));
colorB = labeloverlay(img1, color);
figure;
imshow(colorB); title(['Labeled filtered image using K-Means with k = ', num2str(k)]);
% saveas(gcf, ['office_color_gauss', num2str(k),'.png']);

% Bandwidth number
bw = 0.35;

% Mean-Shift using only the colour
[~,data2cluster,~] = MeanShiftCluster(colour_data.', bw);
color = reshape(data2cluster, size(img1,1), size(img1,2));
colorB = labeloverlay(img1, color);
figure;
imshow(colorB); title(['Labeled filtered image using Mean-Shift with bandwidth = ', num2str(bw)]);
% saveas(gcf, ['office_color_shift_gauss', num2str(bw),'.png']);