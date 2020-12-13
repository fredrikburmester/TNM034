function [meanFace] = createMeanFace(image_matrix)
    
    % Create the meanFace from the image matrix
    meanFace = sum(image_matrix,2)/16;
end

