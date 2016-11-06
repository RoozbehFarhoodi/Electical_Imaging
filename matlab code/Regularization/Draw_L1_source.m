function Draw_L1_source(data,X,Y,B,xcenter,ycenter,rcenter,Index)
% figure
% a = floor((length(Index)+4)^.5); b = floor((length(Index)+4)/a);
% if(a*b<length(Index)+4)
%     b = b+1;
% end
% J = find((X-xcenter).^2+(Y-ycenter).^2<rcenter^2);
% %J = find(max(abs(X-xcenter),abs(Y-ycenter))<rcenter);
% %close
% %h = figure('units','normalized','outerposition',[0 0 1 1]);
% subplot(a,b,1);
% trisurf(delaunay(X,Y), X, Y, data,'edgeColor','none');
% axis([min(X) max(X) min(Y) max(Y) min(data) max(data)]);
% caxis([-200 100]);
% view([0,0,1])
% axis equal
% title('Whole Field')
% subplot(a,b,2);
% trisurf(delaunay(X(J),Y(J)), X(J), Y(J), data(J),'edgeColor','none');
% axis([min(X(J)) max(X(J)) min(Y(J)) max(Y(J)) min(data(J)) max(data(J))]);
% caxis([-200 100]);view([0,0,1])
% axis equal
% title(['Restricted Field in x = ',num2str(xcenter),'y=',num2str(ycenter)])
% subplot(a,b,3);
% %plot(Index,B(:,1:length(Index))')
% %plot(Index,sum(heaviside(B),1))
% plot(Index,sum(abs(B),1))
% title('Abs Sum of sources')
% subplot(a,b,4);
% plot(Index,sum(heaviside(B-.00001),1))
% %c = [];
% %for i = 1:size(C,2)
% %c(i) = max(abs(C(:,i)-data(J)'));
% %end
% %plot(c)
% title('non-zero elements')
% if(length(Index)>1)
%     for i = 1:length(Index)
%         i
%         subplot(a,b,i+4);
%         trisurf(delaunay(X(J),Y(J)),X(J),Y(J),squeeze(B(:,i)),'edgeColor','none');
%         title(['e = ',num2str(Index(i))])
%         caxis([min(B(:,i)) max(B(:,i))]);
%         caxis([-200 100])
%         axis equal
%         view([0,0,1])
%         axis off
%     end
% else
%     subplot(a,b,5);
%     trisurf(delaunay(X(J),Y(J)),X(J),Y(J),squeeze(B),'edgeColor','none');
%     title(['e = '])
%     caxis([min(B) max(B)]);
%     caxis([-200 100])
%     axis equal
%     view([0,0,1])
%     axis off
%     close
%     figure
%     trisurf(delaunay(X(J),Y(J)),X(J),Y(J),squeeze(B),'edgeColor','none');
%     caxis([min(B) max(B)]);
%     caxis([-200 100])
%     axis equal
%     view([0,0,1])
%     axis off
%     figure
%     trisurf(delaunay(X(J),Y(J)), X(J), Y(J), data(J),'edgeColor','none');
%     axis([min(X(J)) max(X(J)) min(Y(J)) max(Y(J)) min(data(J)) max(data(J))]);
%     caxis([-200 100]);view([0,0,1])
%     axis equal
%     title(['Restricted Field in x = ',num2str(xcenter),'y=',num2str(ycenter)])
% end



h = figure('units','normalized','outerposition',[0 0 1 1]);
a = 1; b = 2;
J = find((X-xcenter).^2+(Y-ycenter).^2<rcenter^2);
%J = find(max(abs(X-xcenter),abs(Y-ycenter))<rcenter);
%close
%h = figure('units','normalized','outerposition',[0 0 1 1]);
subplot(a,b,1);
trisurf(delaunay(X,Y), X, Y, data,'edgeColor','none');
axis([min(X) max(X) min(Y) max(Y) -12000 12000]);
caxis([-200 100]);
view([0,0,1])
axis equal
title('Whole Field')
subplot(a,b,2);
trisurf(delaunay(X(J),Y(J)),X(J),Y(J),squeeze(B),'edgeColor','none');
axis([min(X) max(X) min(Y) max(Y) -12000 12000]);
caxis([-200 100]);view([0,0,1])
axis equal
title(['L1 solution'])
