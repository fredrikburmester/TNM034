function [out] = highboostfilter(img)

    [b,a] = butter(4,0.8);
    lowPass = filter(b,a,img);

    unsharpMask = img - lowPass;
    out = img + 2.5*unsharpMask;
end

