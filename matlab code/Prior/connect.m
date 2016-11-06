function [M,T1,T2] = connect(image1,image2)
V = bwconncomp(image1);
V = V.PixelIdxList;
V1 = bwconncomp(image2);
V1 = V1.PixelIdxList;
M = zeros(length(V),length(V1));
T1 = [];
T2 = [];
for i = 1:length(V)
    for j = 1:length(V1)
        [s k] = ind2sub([300 300],V{i});
        [s1 k1] = ind2sub([300 300],V1{j});
        if((mean(s)-mean(s1)).^2+(mean(k)-mean(k1)).^2<8^2 && (image1(s(1),k(1))-image2(s1(1),k1(1)))<15)
            M(i,j) = 1;
            T1(end+1,:) = [s(1),s1(1)];
            T2(end+1,:) = [k(1),k1(1)];
        end
    end
end