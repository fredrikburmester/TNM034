function id = TNM034(im)

    % This function requires the folder DB1 to be in the same directory as
    % this file.

    N = 16;
    image_vector = zeros(40000,N);

    for i = 1:N
        if (i < 10)
            number = '0' + string(i);
        else
            number = string(i);
        end

        name = './DB1/db1_' + number + '.jpg';
        RGB = imread(name);
        RGB = cropImage(RGB);
        grayImage = im2gray(im2double(RGB));
        image_vector(:,i) = grayImage(:);
    end
    
    % Mean-face
    meanFace = sum(image_vector,2)/N;

    % Subtract mean
    A = im2double(image_vector)-meanFace;

    % Covariance 
    C1 = A'*A;
    [V, ~] = eig(C1);
    u = A*V;

    % Normalization
    for i=1:16
        u(:,i) = u(:,i)/norm(u(:,i));
    end

    % Weights
    w = u'*A;
    
    croppedImage_result = cropImage(im);
    grayImage = im2gray(im2double(croppedImage_result));
    grayImage = grayImage(:);

    theta = grayImage - meanFace;

    qw = u'*theta;

    e = zeros(16,16);

    for i = 1:16
        e(:,i) = w(:,i) - qw(:);
    end

    e2 = sum(abs(e));

    [value, index] = min(abs(e2));

    id = 0;
    if(value < 200)
        id = index;
    end
end

