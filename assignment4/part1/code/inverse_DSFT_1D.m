% Digital Image Processing HY-371
% Alexandros Angelakis csd4334
% Exercise 4 part1
% Discrete Space Fourier Transform & Image Segmentation

% Function that calculates the inverse DSFT of a 1D signal 
% (just for validation)
function signal = inverse_DSFT_1D(fourier, u, x)
    basis = exp(1i*2*pi*u'*x);
    signal = fourier * basis;
end

