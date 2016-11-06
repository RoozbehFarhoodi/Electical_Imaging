function Movie_L1_source(data,X,Y,B,xcenter,ycenter,rcenter,Index) 
close
for j = 1:size(B,3)
Draw_L1_source(squeeze(data(:,j)),X,Y,squeeze(B(:,:,j)),xcenter,ycenter,rcenter,Index)
%saveas(h,[num2str(j),'.jpeg'])
pause
end
