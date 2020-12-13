function [normalizedImage] = normalizeImage(grayImage)
    
    % Normalize light intensity in a gray image
    if (mean(grayImage(:)) < 0.5 || mean(grayImage(:)) > 0.5 )
        grayImage = grayImage * (0.5 / mean(grayImage(:))); 
    end

    normalizedImage = (grayImage - min(min(grayImage))) / (max(max(grayImage)) - min(min(grayImage)) );

end

