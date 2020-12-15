function [mask] = faceMask(rgbImage)
    HSV = rgb2hsv(rgbImage);
    H = HSV(:,:,1);
    YCBCR = rgb2ycbcr(rgbImage);
    Cb = YCBCR(:,:,2);

    for i = 1:length(rgbImage(:,1,1))
        for j = 1:length(rgbImage(1,:,1))
           R = rgbImage(i,j,1);
           G = rgbImage(i,j,2);
           B = rgbImage(i,j,3);
           
           if ( H(i,j) < 0.85 && H(i,j) > 0.09)
               rgbImage(i,j,1) = 0;
               rgbImage(i,j,2) = 0;
               rgbImage(i,j,3) = 0;
           end
       
           if ( Cb(i,j) > 130 && Cb(i,j) < 100)
               rgbImage(i,j,1) = 0;
               rgbImage(i,j,2) = 0;
               rgbImage(i,j,3) = 0;
           end

        end
    end

    rgbImage = imbinarize(im2double(rgbImage(:,:,1)));
    
    % Clean the image
    rgbImage = imerode(rgbImage,strel('disk',2));
    rgbImage = imerode(rgbImage,strel('disk',1));
    rgbImage = imdilate(rgbImage,strel('disk',8));
    
    rgbImage = imfill(double(rgbImage));
    
    rgbImage = imdilate(rgbImage,strel('disk',8));
 
    rgbImage = imfill(double(rgbImage));
    
    rgbImage = imerode(rgbImage,strel('disk',10));
    
    mask = imerode(rgbImage,strel('disk',5));
end

