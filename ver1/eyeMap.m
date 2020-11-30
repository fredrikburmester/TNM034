function [Y] = eyeMap(RGB)

    YCBCR = rgb2ycbcr(RGB);
    YCBCR = im2double(YCBCR);
    
    Y  = YCBCR(:,:,1);
    cr = YCBCR(:,:,2);
    cb = YCBCR(:,:,3);
    
    %EyemapL, set SE-size
    se = strel('disk',15);
    eyemapL = imdilate(Y,se)./(imerode(Y,se)+1);
    eyemapL = imadjust(eyemapL);
    
    %EyemapC
    inVers = 1-cr;
    eyemapC = (cb.^2 + inVers.^2 + (cb./cr))/3;
    eyemapC = histeq(1-eyemapC);
    
    %EyemapL AND EyemapC
    Y = eyemapL.*eyemapC;
    
    Y = Y > 0.75;
    
    Y = imdilate(Y,strel('disk',4));
end

