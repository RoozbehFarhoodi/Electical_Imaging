function M = newconnect(C,D,Graph)
M = zeros(size(D,1));
for i = 1:length(C)
    c = C{end-i+1};
    G1 = Graph(c,c);
    H = sign(G1+G1');
    V = graph2chain(H,D(c,:));
    for j = 1:length(V)
        I = c(V{j});
        M(I,I) = Graph(I,I);        
    end
end