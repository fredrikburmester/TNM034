clear TNM034
clear
clf
clc

% Load the folder DB1
files=dir('./DB1/*.jpg');
files =  {files.name};

% Test all files in a dataset against our dataset based on DB1
success = 0;
attempts = 0;
false_positive = 0;

% For all 16 images in DB1, test each image with random variations 500 times against DB1
for j = 1:500
    disp(j) % print current loop iteration
    for file = files
        attempts = attempts+1;
        path = './DB1/' + string(file);
        im = imread(path);
        
        % Create random variations in the images
        r1 = 0.7 + (1.3-0.7)*rand(1);
        r2 = -5 + (5-(-5))*rand(1);
        r3 = 0.9 + (1.1-0.9)*rand(1);
        
        im = im * r1;
        im = imrotate(im,r2,'bilinear','crop');
        im = imresize(im,r3);
    
        [id, value] = TNM034(im);
        C = strsplit(string(file),'_');
        C = strsplit(C(2),'.');
        C = C(1);
        
        if id < 10
            index = '0' + string(id);
        else
            index = string(id);
        end
        
        if index == C
            success = success + 1;
        elseif (index ~= C && id > 0)
            false_positive = false_positive + 1;
%             fprintf('False positives: %i %.4f \n', false_positive, value); % For printing false positives during the test
        end
%       fprintf('%s, %i, %.4f \n', string(file), id, value); % Used for printing the file, id and value during the test
    end
end
fprintf('Success rate: %.4f \n', success/attempts);
fprintf('False positives: %i \n', false_positive);
