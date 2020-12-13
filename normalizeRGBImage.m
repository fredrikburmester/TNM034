function [normalizedImage] = normalizeRGBImage(in)

%     r = in(:,:,1);
%     g = in(:,:,2);
%     b = in(:,:,3);
% 
%     m = ( mean(r(:)) + mean(g(:)) + mean(b(:)) ) / 3;
%     
%     in = in * (128 / m);

    normalizedImage = imadjust(in,stretchlim(in));

end

