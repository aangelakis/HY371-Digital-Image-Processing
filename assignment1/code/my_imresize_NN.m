% Digital Image Processing HY-371
% Alexandros Angelakis csd4334
% Exercise 1_a

% Function that performs image sub-sampling/up-sampling using the method of Nearest Neighbour
function newImage = my_imresize_NN(I, a, op)

  % Store the number of rows and columns of the input image
  I_rows = size(I,1);
  I_columns = size(I,2);

  % Store the number of rows and columns of the new image
  img_rows = size(I,1)*a;
  img_columns = size(I,2)*a;

  % Initializing the new image to speed up the process
  img = zeros(img_rows, img_columns);

  if strcmp(op, 'nn_subsampling')
    % a < 1 -> Sub-sampling
    % Removing every 1/a row and 1/a column of the image, starting from 1.
    img = I(1:(1/a):I_rows, 1:(1/a):I_columns); % an 3ekinousa apo to 2 tote oi diafora metaxi tou imresize kai tou dikou 8a itan 0.
  elseif strcmp(op, 'nn_interpolation')
    % a > 1 -> Up-sampling
    m = 1;
    n = 1;

    % Interpolate using the nearest neighbour method
    for i=1:size(img,1)
      for j=1:size(img,2)
        img(i,j) = I(ceil(m/a),ceil(n/a));
        n = n + 1;
      endfor
      n = 1;
      m = m + 1;
    endfor
  else
    disp('Wrong operation input');
  endif
  newImage = img;
endfunction


