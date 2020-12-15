function [outputArg1] = whitePatch(RGB)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

RGB = rgb2lin(RGB);

rRGB = RGB(:,:,1);
gRGB = RGB(:,:,2);
bRGB = RGB(:,:,3);

maxIllum = illumwhite(RGB, 5);

RGB = chromadapt(RGB, maxIllum, 'ColorSpace', 'linear-rgb');

outputArg1 = lin2rgb(RGB);

end

