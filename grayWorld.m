function [outputArg1] = grayWorld(y)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here
alfa = mean(y(:,:,2))/mean(y(:,:,1));
beta = mean(y(:,:,2))/mean(y(:,:,3));

y(:,:,1) = y(:,:,1)*alfa;
y(:,:,3) = y(:,:,3)*beta;

outputArg1 = y;
end

