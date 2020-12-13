function [outputArg1] = whitePatch(RGB)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

RGB = rgb2lin(RGB);

rRGB = RGB(:,:,1);
gRGB = RGB(:,:,2);
bRGB = RGB(:,:,3);

maxIllum = illumwhite(RGB, 5);
% 
% if(maxIllum(2) < 0.9)
%     add = 255./max(gRGB);
%     RGB(:,:,2) = add.*gRGB;
% %     maxIllum(2) = 1;
% end

RGB = chromadapt(RGB, maxIllum, 'ColorSpace', 'linear-rgb');
% 
% maxIllum = illumwhite(RGB, 5);
% 
% alfa = maxIllum(2)/maxIllum(1);
% beta = maxIllum(2)/maxIllum(3);
% 
% RGB(:,:,1) = RGB(:,:,1)*alfa;
% RGB(:,:,3) = RGB(:,:,3)*beta;

outputArg1 = lin2rgb(RGB);

end

