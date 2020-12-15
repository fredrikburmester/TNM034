function [image_matrix] = createImageMatrix()
    % Create image matrix from DB1
    N = 16;
    image_matrix = zeros(40000,N);
    fs=dir('./DB1/*.jpg');
    fs = {fs.name};
    
    count = 1;
    for f = fs
        im_path = './DB1/' + string(f);
        RGB = imread(im_path);
        
        % Crop image to face
        croppedImage = cropImage(RGB);
        
        if (isempty(croppedImage))
            % do nothing
        else
            % White-patch the face
            croppedImage = whitePatch(croppedImage);
            normalizedImage = normalizeRGBImage(croppedImage);
            
            % Make image gray
            grayImage = im2gray(im2double(normalizedImage));

            % Nomilize the light intencity of the image
            normalizedImage = normalizeImage(grayImage);
            
            % Save the image in a collumn in the matrix
            image_matrix(:,count) = normalizedImage(:);
            count = count + 1;
        end
    end
end

