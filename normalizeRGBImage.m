function [normalizedImage] = normalizeRGBImage(in)

    normalizedImage = in;
    
    r = in(:,:,1);
    g = in(:,:,2);
    b = in(:,:,3);

    m = (mean(r(:)) + mean(g(:)) + mean(b(:))) / 3;

%     if (m < 128 || m > 128 )
%         normalizedImage = in * (128 / m); 
%         return;
%     end
     
    normalizedImage =  imadjust(normalizedImage,stretchlim(normalizedImage));
%     normalizedImage = (in - min(min(in))) / (max(max(in)) - min(min(in)) );

end

