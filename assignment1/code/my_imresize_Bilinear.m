% Digital Image Processing HY-371
% Alexandros Angelakis csd4334
% Exercise 1_b

% Function that performs image sub-sampling using the Nearest Neighbour method and up-sampling using the Bilinear method
function newImage = my_imresize_Bilinear (I, a, op)
  % Store the number of rows and columns of the input image
  I_rows = size(I,1);
  I_columns = size(I,2);

  % Store the number of rows and columns of the new image
  img_rows = size(I,1)*a;
  img_columns = size(I,2)*a;

  % Initializing the new image to speed up the process
  img = zeros(img_rows, img_columns);

  if strcmp(op, 'nn_subsampling')
    % a <= 1 -> Sub-sampling
    % Removing every 1/a row and 1/a column of the image, starting from 1.
    img = I(1:(1/a):I_rows, 1:(1/a):I_columns); % an 3ekinousa apo to 2 tote oi diafora metaxi tou imresize kai tou dikou 8a itan 0.
  elseif strcmp(op, 'bilinear_interpolation')
    % a > 1 -> Up-sampling
    % Place all the pixels from the sub-sampled image to the one we want to upsample
    img(1:a:img_rows, 1:a:img_columns) = I(1:I_rows, 1:I_columns);

    % Take every square of the image to interpolate with the 4 coordinates of the pixels
    for cols = 1:a:size(img,2)
      for rows = 1:a:size(img,1)
        if cols == (size(img,2) - a + 1) && rows == (size(img,1) - a + 1)
          x1 = cols;
          x2 = size(img,1);
          y1 = rows;
          y2 = size(img,2);
        elseif cols == (size(img,2) - a + 1)
          x1 = cols;
          x2 = size(img,2);
          y1 = rows;
          y2 = rows + a;
        elseif rows == (size(img,1) - a + 1)
          x1 = cols;
          x2 = cols + a;
          y1 = rows;
          y2 = size(img,2);
        else
          x1 = cols;
          x2 = cols + a;
          y1 = rows;
          y2 = rows + a;
        endif

        I1 = img(x1,y1);
        I2 = img(x1,y2);
        I3 = img(x2,y1);
        I4 = img(x2,y2);

        for x = x1:x2
          for y = y1:y2
            img(x,y) = (((x2 - x)*(y2 - y))/((x2 - x1)*(y2 - y1)))*I1 + ...
                       (((x - x1)*(y2 - y))/((x2 - x1)*(y2 - y1)))*I3 + ...
                       (((x2 - x)*(y - y1))/((x2 - x1)*(y2 - y1)))*I2 + ...
                       (((x - x1)*(y - y1))/((x2 - x1)*(y2 - y1)))*I4;
          endfor
        endfor
      endfor
    endfor
  else
    disp('Wrong operation');
  endif
  newImage = img;
 endfunction
