function G = group_fixedtime(image)
V1 = bwconncomp(image);
V1 = V1.PixelIdxList;
X = [];
Y = [];
val = [];
for i = 1:length(V1)
    [s k] = ind2sub([300 300],V1{i});
    X(i) = mean(s);
    Y(i) = mean(k);
    val(i) = mean(image(V1{i}));
end
D = [X;Y];
Dis = pdist(D');
s = 1;
Distance = zeros(length(V1));
for i = 1:length(V1)
    Distance(i,i+1:length(V1)) = Dis(s:s+(length(V1)-i-1));
    s = s + (length(V1)-i);
end
A = Distance + Distance';
Val = ones(length(V1),1)*val-val'*ones(1,length(V1));
A(A>8) = 0;
Val(abs(Val)>20) = 0;
Graph = sign(abs(A.*Val));

[S, C] = graphconncomp(sparse(Graph),'Directed','false');
G = cell(1,S);
for i = 1:S
    G{i} = find(C==i);
end
%imagesc(image,[-60 30])
%hold on
% for i = 1:length(G)
%     I = G{i};
%     if(length(I)>1)
%     for j = 1:length(I)-1
%         plot([Y(I(j)),Y(I(j+1))],[X(I(j)),X(I(j+1))])
%         hold on
%     end
%     end
% end
