function D = FourD(images)
D = [];
for i = 1:size(images,3)
    G = dots_fixedtime(squeeze(images(:,:,i)));
    n = size(G,1);
    D(end+1:end+n,:) = [G,i*ones(n,1)];
end