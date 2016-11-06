function Draw_L1_source_L2_time(data,B,X,Y,xcenter,ycenter,rcenter_x,rcenter_y,Index,num_frame)
t = size(data,2);
for k = 1:t-num_frame+1
    figure
    a = floor((num_frame*length(Index)+2)^.5); b = floor((num_frame*length(Index)+2)/a);
    if(a*b<num_frame*length(Index)+2)
        b = b+1;
    end
    J = find(abs(X-xcenter)<rcenter_x & abs(Y-ycenter)<rcenter_y);
    l = length(J);
    subplot(a,b,1);
    trisurf(delaunay(X,Y), X, Y, data(:,k),'edgeColor','none');
    axis([min(X) max(X) min(Y) max(Y) min(data(:,k)) max(data(:,k))]);
    caxis([-200 100]);
    view([0,0,1])
    axis equal
    title('Whole Field')
    subplot(a,b,2);
    trisurf(delaunay(X(J),Y(J)), X(J), Y(J), data(J,k),'edgeColor','none');
    axis([min(X(J)) max(X(J)) min(Y(J)) max(Y(J)) min(data(J,k)) max(data(J,k))]);
    caxis([-200 100]);view([0,0,1])
    axis equal
    title(['Restricted Field in x = ',num2str(xcenter),'y=',num2str(ycenter)])
    
    for i = 1:length(Index)
        for s = 1:num_frame
            subplot(a,b,num_frame*(i-1)+s+2);
            b2 = squeeze(B((s-1)*l+1:s*l,k,i));
            trisurf(delaunay(X(J),Y(J)),X(J),Y(J),b2,'edgeColor','none');
            title(['e = ',num2str(Index(i))])
            caxis([min(b2) max(b2)]);
            caxis([-200 100])
            axis equal
            view([0,0,1])
            axis off
        end
        
    end
    
end