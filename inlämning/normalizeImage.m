function [normalizedImage] = normalizeImage(grayImage)
    
    normalizedImage = (grayImage - min(min(grayImage))) / (max(max(grayImage)) - min(min(grayImage)) );
    
    r = 0.75;
    % Normalize light intensity in a gray image
    if (mean(normalizedImage(:)) < r || mean(normalizedImage(:)) > r )
        normalizedImage = normalizedImage * (r / mean(normalizedImage(:))); 
    end
    
end

