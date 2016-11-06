function G = Grouping_data(Distance,threshold)

Graph = 1-sign(floor(Distance/threshold));
[S, C] = graphconncomp(sparse(Graph),'Directed','false');
G = cell(1,S);
for i = 1:S
    G{i} = find(C==i);
end