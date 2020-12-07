function [outputArg1] = cWhitePatch(RGB)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

rRGB = RGB(:,:,1);
gRGB = RGB(:,:,2);
bRGB = RGB(:,:,3);

maxIllum = illumwhite(RGB);

if(maxIllum(2)< 0.9)
    add = 255./max(gRGB);
    gRGB = add.*gRGB;
    maxIllum(2) = 1;
end

maxIllum = illumwhite(RGB);

alfa = maxIllum(2)/maxIllum(1);
beta = maxIllum(2)/maxIllum(3);

RGB(:,:,1) = RGB(:,:,1)*alfa;
RGB(:,:,3) = RGB(:,:,3)*beta;

outputArg1 = RGB;

end

