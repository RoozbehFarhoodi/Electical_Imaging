function y = Draw_L0_source(data,xcenter,ycenter,rcenter,X,Y,sources,Index)

J = find(max(abs(X-xcenter),abs(Y-ycenter))<rcenter);

a = floor((length(Index)+3)^.5); b = floor((length(Index)+3)/a);
if(a*b<length(Index)+3)
    b = b+1;
end

subplot(a,b,1);
trisurf(delaunay(X,Y), X, Y, data,'edgeColor','none');
axis([min(X) max(X) min(Y) max(Y) min(data) max(data)]);
caxis([-200 100]);
view([0,0,1])
axis equal
title('Whole Field')

subplot(a,b,2);
trisurf(delaunay(X(J),Y(J)), X(J), Y(J), data(J),'edgeColor','none');
axis([min(X(J)) max(X(J)) min(Y(J)) max(Y(J)) min(data(J)) max(data(J))]);
caxis([-200 100]);view([0,0,1])
axis equal
title(['Restricted Field in x = ',num2str(xcenter),'y=',num2str(ycenter)])

for i = 1:length(Index)
subplot(a,b,i+2);
trisurf(delaunay(X(J),Y(J)),X(J),Y(J),sources(:,i),'edgeColor','none');
title(['e = ',num2str(Index(i))])
caxis([min(sources(:,i)) max(sources(:,i))]);
caxis([-200 100])
axis equal
view([0,0,1])
axis off
end