function M = maching(X,Y,data,Group,dis_threshold)
t = length(Group)-1;
M = cell(1,t);
for i = 1:t
    
    G1 = Group{i};
    G2 = Group{i+1};
    A = zeros(length(G1),length(G2));
    for j = 1:length(G1)
        j
        for k = 1:length(G2)
            A(j,k) = (G1(1,j)-G2(1,k))^2+(G1(2,j)-G2(2,k))^2+1*(G1(3,j)-G2(3,k))^2;
        end
    end
    M{i} = 1-sign(floor(A/dis_threshold^2));
end
