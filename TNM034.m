function [id, value] = TNM034(im)

    % Info:
    %   This function takes an image as input and outputs the index of a 
    %   matching face in the data set. This function calculates if the input 
    %   image is a part of the data set by looking at the weight differense 
    %   to any face in the data set. 

    % Dependencies:
    %   Folders:
    %       './DB1'
    %   Files:
    %       './cleaning.m'
    %       './crop.m'
    %       './cropImage.m'
    %       './cWhitePatch.m'
    %       './eyeMap.m'
    %       './faceMask.m'
    %       './rotate_image.m'
    %       './create_eigen_weights.m'
    
    persistent w
    persistent meanFace
    persistent u
    
    % Create weights (only once)
    if isempty(w)
        [w, meanFace, u] = create_eigen_weights();
    end
    
    % Prepare the input image and compare the wieght to the dataset. Return
    % 0 if no match is found.
    
    croppedImage_result = cropImage(im);
    croppedImage_result = cWhitePatch(croppedImage_result);
    id = 0;
    if isempty(croppedImage_result)
        % do nothing
    else
        grayImage = im2gray(im2double(croppedImage_result));
        
%         figure, imshow(grayImage);
        if (mean(grayImage(:)) < 0.6 || mean(grayImage(:)) > 0.7 )
            grayImage = grayImage * (0.65 / mean(grayImage(:))); 
        end
%         figure, imshow(grayImage);
        
         grayImage = (grayImage - min(min(grayImage))) / (max(max(grayImage)) - min(min(grayImage)) );
%         grayImage = highboostfilter(grayImage);
        grayImage = grayImage(:);
        theta = grayImage - meanFace;
        qw = u'*theta;

%         figure, imshow(reshape(meanFace, [200 200]))
% 
%         figure, imshow(reshape(abs(u(:,2)), [200 200]));

        for i = 1:16
%             e(:,i) = w(:,i) - qw(:);
            e_n(i) = norm(w(:,i) - qw(:));
        end
% 
%         for i=1:16
%             e2(:,i) = sum(abs(e(:,i)));
%         end
        [value, index] = min(e_n);
        
%         [value, index] = min(abs(e2));
        
        if(value < 1500)
            id = index;
        end
    end
end

