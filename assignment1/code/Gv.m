% Digital Image Processing HY-371
% Alexandros Angelakis csd4334
% Exercise 1

% Function that calculates the vertical differences of an image's pixel elements
function ret = Gv(img, S)
  G_v = 0;

  for m = 2:size(img,1)
    for n = 1:size(img,2)
      G_v = G_v + (img(m,n) - img(m-1, n)).^2;
    endfor
  endfor

  G_v = (1/S) * sqrt(G_v);

  ret = G_v;
endfunction
