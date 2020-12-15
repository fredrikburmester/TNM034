function [normalizedImage] = normalizeRGBImage(in)

    normalizedImage = imadjust(in,stretchlim(in));

end

