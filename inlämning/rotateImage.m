function [rotated_image] = rotateImage(img,x1, y1, x2, y2)
    
    % Get size of image
    img_size = size(img);
   
    % Swap to x1 and y1 correspond to left eye
    if(x2 < x1) 
        temp = x1;
        x1 = x2;
        x2 = temp;
        
        temp = y1;
        y1 = y2;
        y2 = temp;
    end
    
    % Calculate rotation angle
    k = ((abs(y2 - y1))/(abs(x2 - x1)));
    
    if (y1 > y2)
        a = rad2deg(-atan(k));
    else
        a = rad2deg(atan(k));
    end
    
    % Zero-pad the image for translation and rotation
    big_img = padarray(img,[500 500],0,'both');
    
    % Get new left-eye coordinates
    x_new = 500 + x1;
    y_new = 500 + y1;
    
    % Calculate distance from left eye to center
    big_img_size = size(big_img);
    delta_x = big_img_size(2)/2 - x_new;
    delta_y = big_img_size(1)/2 - y_new;
    
    % Translate image so the left eye is at center and then rotate 
    temp = imtranslate(big_img, [delta_x, delta_y]);
    temp = imrotate(temp, a, 'bicubic', 'crop');
    temp = imtranslate(temp, [-delta_x, -delta_y]);
    
    temp = temp(floor(x_new-x1):floor(x_new-x1)+img_size(1),floor(y_new-y1):floor(y_new-y1)+img_size(2),:);

    rotated_image = temp;
    
end