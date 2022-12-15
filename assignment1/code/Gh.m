% Digital Image Processing HY-371
% Alexandros Angelakis csd4334
% Exercise 1

% Function that calculates the horizontal differences of an image's pixel elements
function ret = Gh(img, S)
  G_h = 0;

  for m = 1:size(img,1)
    for n = 2:size(img,2)
      G_h = G_h + (img(m,n) - img(m, n-1)).^2;
    endfor
  endfor

  G_h = (1/S) * sqrt(G_h);

  ret = G_h;
endfunction
