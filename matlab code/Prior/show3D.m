function show3D(images)
for i = 1:size(images,3)
    hold on
    G = dots_fixedtime(squeeze(images(:,:,i)));
    %scatter3(G(:,1),G(:,2),i*ones(length(G(:,1)),1),3*ones(length(G(:,1)),1),G(:,3));
    scatter3(G(:,1),G(:,2),i*ones(length(G(:,1)),1),3*abs(G(:,3)),G(:,3),'filled');
    caxis([-60 30])
    hold on;
end