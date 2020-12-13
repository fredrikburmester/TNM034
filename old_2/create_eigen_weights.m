function [weights, meanFace, u] = create_eigen_weights()
    
    % Create image matrix from DB1
    N = 16;
    image_matrix = zeros(40000,N);
    fs=dir('./DB1/*.jpg');
    fs = {fs.name};
    
    count = 1;
    for f = fs
        im_path = './DB1/' + string(f);
        RGB = imread(im_path);
        
        % Crop image to face
        RGB = cropImage(RGB);
        
        % White-patch the face
        RGB = cWhitePatch(RGB);

        % Make image gray
        grayImage = im2gray(im2double(RGB));
        
        % Nomilize the light intencity of the image
        if (mean(grayImage(:)) < 0.6 || mean(grayImage(:)) > 0.7)
            grayImage = grayImage * (0.65 / mean(grayImage(:))); 
        end
      
        grayImage = (grayImage - min(min(grayImage))) / (max(max(grayImage)) - min(min(grayImage)) );
        
        % Save the image in a collumn in the matrix
        image_matrix(:,count) = grayImage(:);
        count = count + 1;
    end

    % Mean-face
    meanFace = sum(image_matrix,2)/N;

    % Subtract mean
    A = image_matrix-meanFace;
    
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

