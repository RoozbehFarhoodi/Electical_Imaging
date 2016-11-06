function [G,Graph] = connect3(D)
n = size(D,1);
Graph = zeros(n);

Time = D(:,4)*ones(1,n)-ones(n,1)*D(:,4)';
Val = D(:,3)*ones(1,n)-ones(n,1)*D(:,3)';
Val_ratio = (D(:,3)*ones(1,n))./(ones(n,1)*D(:,3)');
%Val_ratio = max(Val_ratio,1./Val_ratio);
Dis = pdist(D(:,1:2));
s = 1;
Distance = zeros(n);
for i = 1:n
    Distance(i,i+1:n) = Dis(s:s+(n-i-1));
    s = s + (n-i);
end
Dis = Distance + Distance';

Time(abs(Time)>1) = 0;
Dis(abs(Dis)>9) = 0;
Val(abs(Val)>15) = 0;
Val_ratio(abs(Val_ratio)>1.1) = 0;
Graph = abs(sign(Time.*Dis.*Val.*Val_ratio));
[S, C] = graphconncomp(sparse(Graph),'Directed','false');
G1 = cell(1,S);
L = [];
for i = 1:S
    G1{i} = find(C==i);
    L(i) = length(find(C==i));
end
[I J] = sort(L);
G = cell(1,S);
count = 1;
for i = J
    G{count} = G1{i};
    count = count +1;
end
