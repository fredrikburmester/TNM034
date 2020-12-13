function [out] = cleaning(res)
    % Top bottom cleaning
    res(1:floor(height(res)*0.3),:) = 0;
    res(floor(height(res)*0.60):height(res),:) = 0;

    % Left-right cleaning
    res(:,1:floor(width(res)*0.2)) = 0;
    res(:,floor(width(res)*0.8):floor(width(res))) = 0;
    
%     res = imerode(res,strel('disk', 1));
    res = imdilate(res,strel('disk', 5));
%     imshow(res)
%     res = imerode(res,strel('disk', 1));
%     res = imdilate(res,strel('disk', 2));
%     res = imerode(res,strel('disk', 3));
%     res = imdilate(res,strel('disk', 2));
    
    [lab,num]=bwlabel(res);
    stats = regionprops(lab);

    maxArea = 0;
    for i = 1:num
        if(getfield(stats,{i},"Area") > maxArea)
            maxArea = getfield(stats,{i},"Area");
        end
    end

    if(num > 2) 
%         disp('Removing specks')
        for i = 1:num
            area = getfield(stats,{i},"Area");
            deltaA(i,1) = abs(maxArea-area);
        end

        [deltaA, index] = sort(deltaA);
        index = index(1:2);

        statsNew(1) = stats(index(1));
        statsNew(2) = stats(index(2));

        % Remove specks
        res = ismember(lab, index) > 0;

    end
    
    out = res;
end

