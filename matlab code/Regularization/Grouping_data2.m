function G = Grouping_data2(Distance,data,Dis_threshold,val_threshold)

I = find(data~=0);
[I1 I2] = find(data~=0);
D = Distance(I,I);
Graph1 = 1-sign(floor(D/Dis_threshold));
A = ones(length(data(I)),1)*data(I);
A = A - A';
Graph2 = 1-sign(floor(abs(A)/val_threshold));
Graph = Graph1.*Graph2;
[S, C] = graphconncomp(sparse(Graph),'Directed','false');
G = cell(1,S);
for i = 1:S
    G{i} = I2(find(C==i));
end