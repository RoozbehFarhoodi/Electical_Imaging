function A = forward_fun_depth(Distance,depth,regularization,type)
switch type
    case 1
        A = zeros(size(Distance,1),size(Distance,2),length(depth));
        count = 1;
        for i = depth
            A(:,:,count) = regularization(count)*(Distance.^2+depth(count)^2).^-.5;
            count = count + 1;
        end
    case 2
        A = zeros(size(Distance,1),size(Distance,2)*length(depth));
        count = 1;
        for i = depth
            A(:,1+(count-1)*size(Distance,2):count*size(Distance,2)) = regularization(count)*(Distance.^2+depth(count)^2).^-.5;
            count = count + 1;
        end
end