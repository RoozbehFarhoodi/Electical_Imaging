function [M,T1,T2] = connect2(G1,G2)
M = zeros(size(G1,1),size(G2,1));
T1 = [];
T2 = [];
for i = 1:size(G1,1)
    for j = 1:size(G2,1)
        if((G1(i,1)-G2(j,1)).^2+(G1(i,2)-G2(j,2)).^2<8^2 && (G1(i,3)-G2(j,3))<15)
            M(i,j) = 1;
            T1(end+1,:) = [G1(i,1),G2(j,1)];
            T2(end+1,:) = [G1(i,2),G2(j,2)];
        end
    end
end