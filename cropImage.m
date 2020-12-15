function [croppedImage] = cropImage(RGB)
    % White balance
    rgbImageWhite = whitePatch(RGB);
    normalizedImage = normalizeRGBImage(rgbImageWhite);

%     figure, imshow(normalizedImage);
    % Face mask
    mask = faceMask(normalizedImage);
%     figure, imshow(mask);
    
    % Eye map
    map = eyeMap(normalizedImage);
%     figure, imshow(map);
   
    % Combine
    res = map & mask;
%     figure, imshow(res);
    
    % Cleaning
    res = imresize(res, [NaN 350]);
    RGB = imresize(RGB, [NaN 350]);

    res = cleaning(res);
%     figure, imshow(res);
    
    % Get eye coordinates
    [lab,num]=bwlabel(res);
    
    if num == 2
        stats = regionprops(lab);
        eye1 = getfield(stats,{1},'Centroid');
        y1 = eye1(1);
        x1 = eye1(2);
        eye2 = getfield(stats,{2},'Centroid');
        y2 = eye2(1);
        x2 = eye2(2);

        % Rotate the images based on the eyes
        rotatedImage = rotateImage(RGB,y1,x1,y2,x2);
%         disp('Rotated image'), imshow(rotatedImage);

        % Get new eye coordinates
        map = rotateImage(res,y1,x1,y2,x2);
        [lab,~]=bwlabel(map);
        stats2 = regionprops(lab);
        eye1 = getfield(stats2,{1},'Centroid');
        eye2 = getfield(stats2,{2},'Centroid');
        x1 = eye1(1);
        y1 = eye1(2);
        x2 = eye2(1);
        y2 = eye2(2);

        % Crop the image square for eigenfaces
        croppedImage = cropForEyes(rotatedImage, x1, y1, x2, y2);
    else
        disp('Crop Image: Can not find eyes')
        croppedImage = 0;
    end
 
%     figure, imshow(croppedImage);
    
end

