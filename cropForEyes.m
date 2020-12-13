function [out] = cropForEyes(img, x1, y1, x2, y2)
    if(x2 < x1) 
        temp = x1;
        x1 = x2;
        x2 = temp;
        
        temp = y1;
        y1 = y2;
        y2 = temp;
    end
        
    deltaX = abs(x1-x2);
    
    scale = 100/deltaX;
    
    temp = imresize(img, scale);
    
    x1 = floor(x1 * scale);
    y1 = floor(y1 * scale);
    s = size(temp);
    
    b1 = y1-49;
    b2 = y1+150;
    b3 = x1-49;
    b4 = x1+150;
    
    if (b3 > 0) & (b1 > 0) & (b2 < s(1)) & (b4 < s(2)) 
        out = temp(b1:b2, b3:b4,:);
    else
        out = 0;
    end
end

