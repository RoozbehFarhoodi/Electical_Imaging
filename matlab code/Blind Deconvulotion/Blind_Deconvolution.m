%% Blind Deconvolution
x1 = 160;
x2 = 1910;
y1 = 100;
y2 = 2100;
Xb = x1:(x2-x1)/109:x2;
Yb = y1:(y2-y1)/101:y2;
data = zeros(110,102,300);
s = [];
for i = 1:110
    for j = 1:102
        I = find((X-Xb(i)).^2+(Y-Yb(j)).^2<400);
        if(size(I,2)<1)
            I = find((X-Xb(i)).^2+(Y-Yb(j)).^2<900);
        end
        s(end+1) = size(I,2);
        data(i,j,:) = mean(mean(Data(1:30,I,:),1),2);
        %data(i,j,:) = mean(A(I,:));
        %data(i,j,:) = mean(Ave(I,:));
    end
end
clear x1 x2 y1 y2 Xb Yb i j I s
%%
%da = squeeze(data(:,:,90));
[J P] = deconvblind(D,ones(6));
subplot(131);surf(da,'edgeColor','none');view([0 0 1]);axis([0 102 0 110]);
title('Real Image');caxis([0 40])
subplot(132);surf(J,'edgeColor','none');
view([0 0 1]);axis([0 102 0 110]);caxis([0 40])
title('Deblurred Image');
subplot(133);imagesc(P);
title('Recovered PSF');