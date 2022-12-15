% Alexandros Angelakis csd4334
% Exercise 2
% Point-wise Intensity Transformations

% Function that calculates the Gaussian intensity transformation.
function out = T1_f(q1, q)
    out = zeros(256,1);
    
    for i = 1:256
        [~,I] = min(abs(q1 - q(i)));
        out(i) = I;
    end

end

