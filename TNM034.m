function [id, value] = TNM034(im)

    % Info:
    %   This function takes an image as input and outputs the index of a 
    %   matching face in the data set. This function calculates if the input 
    %   image is a part of the data set by looking at the weight differense 
    %   to any face in the data set. 
    
    persistent w
    persistent u
    persistent meanFace
    persistent image_matrix
    
    clear id
    clear value
    
    % Create objects (only once)
    if isempty(w)
        disp('Building dataset:')
        disp('Creating image matrix')
        image_matrix = createImageMatrix();
        disp('Creating mean face')
        meanFace = createMeanFace(image_matrix);
        disp('Creating weights')
        [w, u] = createWeights(image_matrix, meanFace);
    else
        %
    end
    
    % Prepare the input image and compare the wieght to the dataset. Return
    % 0 if no match is found.
    
    % Crop the image
    croppedImage = cropImage(im);
   
    id = 0;
    if isempty(croppedImage)
         disp('Error: cropImage returned no eyes...')
    else
%         figure, imshow(croppedImage);
        
        croppedImage = whitePatch(croppedImage);
        normalizedImage = normalizeRGBImage(croppedImage);
        
        % Make the image gray and normalize it
        grayImage = im2gray(im2double(normalizedImage));
        
        normalizedImage = normalizeImage(grayImage);
%         figure, imshow(normalizedImage)
        % Calculate weights for in image
        theta = normalizedImage(:) - meanFace;
        qw = u'*theta;
        
        % Normalize the weights of the new image
        e_n = zeros(1,16);
        for i = 1:16
            e_n(i) = norm(w(:,i) - qw(:));
        end
        
        % Find the smallest error
        [value, index] = min(e_n);

        % Return if the value is low enough
        if(value < 1500)
            id = index;
        end
    end
end

