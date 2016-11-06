function T = Find_less(X,Y,G1,G2,data1,data2)
a = [];
a1 = randperm(length(G1));
a2 = randperm(length(G2));
for i = 1
    r1 = a1(i);
    r2 = a2(i);
    a(i) = (X(G1(r1))-X(G2(r2)))^2+(Y(G1(r1))-Y(G2(r2)))^2+.3*(data1(G1(r1))-data2(G2(r2)))^2;
end
T = min(a)^.5;
% if(min(a)<dis^2)
%     T = 1;
% else 
%     T = 0;
% end