function [out] = crop(img, x1, y1, x2, y2)

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
    
    temp = temp(y1-49:y1+150, x1-49:x1+150,: );
    
    out = temp;

end

