clear TNM034
clear
clf
clc

files=dir('./DB2/*.jpg');
files =  {files.name};

% Test all files in a dataset against our dataset based on DB1
success = 0;
attempts = 0;
for j = 1:10
    for file = files
        attempts = attempts+1;
        path = './DB2/' + string(file);
        im = imread(path);
        
        r1 = 0.7 + (1.3-0.7)*rand(1);
        r2 = -5 + (5-(-5))*rand(1);
        r3 = 0.9 + (1.1-0.9)*rand(1);
        
        im = im * r1;
        im = imrotate(im,r2,'bilinear','crop');
        im = imresize(im,r3);
    
        [id, value] = TNM034(im);
        if id ~= 0
            success = success + 1;
        end
      fprintf('%s, %i, %.4f \n', string(file), id, value);
    end
end
fprintf('Success rate: %.4f \n', success/attempts);

%%

im = imread('./DB1/db1_01.jpg');
% im = imrotate(im,5,'bilinear','crop');
% im = grayWorld(im)
% figure, imshow(im)
[id,value] = TNM034(im)