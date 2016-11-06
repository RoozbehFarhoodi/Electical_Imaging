function Draw_groundtruth(data,xcenter, ycenter,r)
figure
I = find((data(2,:)-xcenter).^2+(data(3,:)-ycenter).^2<r^2);
%scatter(data(2,I),data(3,I),100*data(4,I),data(1,I),'filled')
scatter(data(2,I),data(3,I),abs(data(1,I)),data(4,I),'filled')
%for i = 1:length(I)
%text(data(2,I(i)),data(3,I(i)),num2str(data(4,I(i))))
%end
%scatter(data(2,I),data(3,I),550*data(4,I).^(-1),rand(1,length(I)))
axis([xcenter-r xcenter+r ycenter-r ycenter+r])
%colormap(gray)