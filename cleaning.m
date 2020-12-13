function [out] = cleaning(res)
    % Top bottom cleaning
    res(1:floor(height(res)*0.3),:) = 0;
    res(floor(height(res)*0.60):height(res),:) = 0;

    % Left-right cleaning
    res(:,1:floor(width(res)*0.25)) = 0;
    res(:,floor(width(res)*0.75):floor(width(res))) = 0;
    
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
        delta = 999;
        clear index
        index = [0, 0];
        for i = 1:num-1
            for j = i+1:num
                 y_i = getfield(stats,{i},"Centroid");
                 y_j = getfield(stats,{j},"Centroid");
                 
                 if abs(y_i(1) - y_j(1)) > 100
                    if abs(y_i(2) - y_j(2)) < delta
                        delta = abs(y_i(2) - y_j(2));
                        index = [i,j];
                    end
                 end
                 
            end
        end
        
        if (index(1) == 0 && index(2) == 0 )
            for i = 1:num-1
                for j = i+1:num
                     y_i = getfield(stats,{i},"Centroid");
                     y_j = getfield(stats,{j},"Centroid");

                     if abs(y_i(1) - y_j(1)) > 50
                        if abs(y_i(2) - y_j(2)) < delta
                            delta = abs(y_i(2) - y_j(2));
                            index = [i,j];
                        end
                     end

                end
            end
        end

        % Remove specks
        res = ismember(lab, index) > 0;

    end
    
    out = res;
end

