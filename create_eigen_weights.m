function [weights, meanFace, u] = create_eigen_weights()
%CREATE_EIGEN_WEIGHTS Summary of this function goes here
%   Detailed explanation goes here
    N = 16;
    image_vector = zeros(40000,N);
    fs=dir('./DB1/*.jpg');
    fs = {fs.name};
    
    count = 1;
    for f = fs
        im_path = './DB1/' + string(f);
        RGB = imread(im_path);
        RGB = cropImage(RGB);
        grayImage = im2gray(im2double(RGB));
        
        grayImage = highboostfilter(grayImage);
        image_vector(:,count) = grayImage(:);
        count = count + 1;
    end

    % Mean-face
    meanFace = sum(image_vector,2)/N;

    % Subtract mean
    A = image_vector-meanFace;
    
    % Covariance 
    C1 = A'*A;
    [V, ~] = eig(C1);
    u = A*V;
    
    % Normalization
    for i=1:16
        u(:,i) = u(:,i)/norm(u(:,i));
    end
%     for i=1:16
%          u(:,i) = rescale(u(:,i),0,1);
%     end
   

%     for i=1:16
%         u(:,i) = sort(u(:,i));
%     end
    
    % Weights
    weights = u'*A;
end

