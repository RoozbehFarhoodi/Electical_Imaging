function Draw_groundtruth_depth(X,Y,neural_data,xcenter,ycenter,rcenter,ndepth)
a2 = floor(neural_data(4,:)*ndepth/30)+1;
J = find((X-xcenter).^2+(Y-ycenter).^2<rcenter^2);

a = floor((ndepth)^.5); b = floor((ndepth)/a);
if(a*b<ndepth)
    b = b+1;
end
figure
for i = 1:ndepth
    I = find(a2==i);
    SS = zeros(length(X));
    if(length(I)~=0)
    for j = I
    J2 = find((X-neural_data(2,j)).^2+(Y-neural_data(3,j)).^2<25^2);
    SS(J2) = neural_data(1,j);
    end
    else
    end
    subplot(a,b,i)
trisurf(delaunay(X(J),Y(J)),X(J),Y(J),SS(J),'edgeColor','none');
caxis([min(SS(J)) max(SS(J))]);
caxis([-1 1])
axis equal
view([0,0,1])
axis off
title(['depth = ',num2str(i)])
end