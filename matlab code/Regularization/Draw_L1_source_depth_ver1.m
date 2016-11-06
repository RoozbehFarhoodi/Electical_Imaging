function Draw_L1_source_depth_ver1(data,X,Y,B,xcenter,ycenter,rcenter)
J = find((X-xcenter).^2+(Y-ycenter).^2<rcenter^2);
ndepth = length(B)/length(J);
figure
trisurf(delaunay(X(J),Y(J)), X(J), Y(J), data(J),'edgeColor','none');
axis([min(X(J)) max(X(J)) min(Y(J)) max(Y(J)) min(data(J)) max(data(J))]);
%caxis([-200 100]);
view([0,0,1])
axis equal
figure

n = length(B)/length(J);
a = floor((n)^.5); b = floor((n)/a);
if(a*b<n)
    b = b+1;
end

for i = 1:ndepth
    subplot(a,b,i)
trisurf(delaunay(X(J),Y(J)),X(J),Y(J),squeeze(B(1+(i-1)*length(J):i*length(J))),'edgeColor','none');
caxis([min(B) max(B)]);
caxis([-20 10])
axis equal
view([0,0,1])
axis off
title(['depth = ',num2str(i)])
end
end