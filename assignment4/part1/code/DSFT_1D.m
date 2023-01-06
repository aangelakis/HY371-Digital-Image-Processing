% Digital Image Processing HY-371
% Alexandros Angelakis csd4334
% Exercise 4 part1
% Discrete Space Fourier Transform & Image Segmentation

% Function that calculates the DSFT of a 1D signal
function F = DSFT_1D(signal, u, x)
    basis = exp(-1i*2*pi*u'*x);
    F = signal * basis;
end

