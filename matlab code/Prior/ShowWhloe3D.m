function ShowWhloe3D(Cell,D,Graph,m)
n = length(Cell);
for i = 1:n
    I = Cell{end-i+1};
    scatter3(D(I,1),D(I,2),D(I,4))
    hold on;
    G = Graph(I,I);
    [x y] = find(G~=0);
    for i = 1:size(y)
        hold on
        
        plot3([D(I(x(i)),1) D(I(y(i)),1)],[D(I(x(i)),2) D(I(y(i)),2)],[D(I(x(i)),4) D(I(y(i)),4)],'LineWidth',abs((D(I(x(i)),3)+D(I(y(i)),3)))/50);
    end
    axis([0 300 0 300 1 m])
    %B = zeros(300,300,m);
    %     length(I)
    %     for j = 1:length(I)
    %         B(floor(D(I(j),1))+1,floor(D(I(j),2))+1,D(I(j),4)) = 1;
    %     end
    %     visualize3d(B,'r',.8)
    %pause
end