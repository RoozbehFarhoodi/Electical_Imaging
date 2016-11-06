function [B,s] = L1_reweigthed(data,X,Y,D,xcenter,ycenter,rcenter,Index,type,itr)
J = find((X-xcenter).^2+(Y-ycenter).^2<rcenter^2);
B = ones(length(J),1);
e = 1;
for i = 1: itr
    C = 1./(abs(B)+e);
    C = (abs(B)+e);
    normal = 1/mean(C);
    A = normal*D(J,J).*(C*ones(1,length(J)));
    
    [B,s] = L1_source(data,X,Y,A,xcenter,ycenter,rcenter,rcenter,Index,type);
    Draw_L1_source(50*data,X,Y,30*B,xcenter,ycenter,rcenter,Index)
    figure;    
    plot(abs(B))
end

