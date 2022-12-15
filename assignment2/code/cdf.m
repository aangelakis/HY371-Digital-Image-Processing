% Alexandros Angelakis csd4334
% Exercise 2
% Point-wise Intensity Transformations

% Function that calculates the cdf of a probability distribution.
function q = cdf(p)
    q = zeros(256,1);
    
    q(1) = p(1);
    
    for i = 2:256
        q(i) = q(i-1) + p(i);
    end
end

