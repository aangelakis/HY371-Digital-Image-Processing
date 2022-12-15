% Alexandros Angelakis csd4334
% Exercise 2
% Point-wise Intensity Transformations

% Function that calculates the histogram of an image.
function hist = histogram(I)
    hist = zeros(256, 1);
    
    for i = 1:size(I,1)
        for j = 1:size(I,2)
            hist(I(i,j)+1) = hist(I(i,j)+1) + 1;
        end 
    end
end

