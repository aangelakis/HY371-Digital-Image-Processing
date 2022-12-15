% Alexandros Angelakis csd4334
% Exercise 2
% Point-wise Intensity Transformations

% Function that calculates the Rice intensity transformation.
function out = T2_f(q2, q)
    out = zeros(256,1);
    
    for i = 1:256
        [~,I] = min(abs(q2 - q(i)));
        out(i) = I;
    end

end

