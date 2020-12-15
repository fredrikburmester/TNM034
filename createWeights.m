function [weights, u] = createWeights(image_matrix,meanFace)
    % Subtract mean
    A = image_matrix-meanFace;
    
    % Create eigen vectors 
    C1 = A'*A;
    [V, ~] = eig(C1);
    u = A*V;
    
    % Normalization of the eigen vectors
    for i=1:16
        u(:,i) = u(:,i)/norm(u(:,i));
    end
    
    for j = 1:8
        u2(:,j) = u(:,9-j);
    end
    
    % Weights
    weights = u'*A;
end

