function [Source,lambda] = L1_source_precentage_whole(data,X,Y,Forward,precent,precent_confidence)
%
dis = 300;
Source = zeros(size(X));
con = 100;
i = 1;
for xcenter = floor(dis/2):1.3*(dis-con):2000
    j = 1;
    for ycenter = floor(dis/2):1.3*(dis-con):2000
        %xcenter
        %ycenter
        J = find((X-xcenter).^2+(Y-ycenter).^2<dis^2);
        [S,L] = L1_source_precentage(data,X,Y,Forward,xcenter,ycenter,dis,precent,precent_confidence);
        S1 = zeros(size(X));
        J2 = find((X(J)-xcenter).^2+(Y(J)-ycenter).^2<(dis-con)^2);
        S1(J(J2)) = S(J2);
        Source = S1 + Source;
        lambda(i,j) = L;
        j = j+1;
    end
    i = i+1;
end