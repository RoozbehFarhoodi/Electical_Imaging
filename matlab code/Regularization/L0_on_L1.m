function L0_on_L1(data,X,Y,Distance,Forward,xcenter,ycenter,rcenter)
J = find((X-xcenter).^2+(Y-ycenter).^2<rcenter^2);
[Source,lambda] = L1_source_precentage(data,X,Y,Forward,xcenter,ycenter,rcenter,.20,.14);
Draw_L1_source_depth_ver1(50*data,X,Y,Source,xcenter,ycenter,rcenter);
R = find(Source~=0);
G = Grouping_data(Distance(J(R),J(R)),30);
for i = 1:length(G)
    %J(R(G{i}))
    r = J(R(G{i}));
   A = Adjust_source(X(r),Y(r),data(r),[1,X(r(1)),Y(r(1)),10]) 
end

