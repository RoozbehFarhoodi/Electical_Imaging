function Movie_CMOS(data,X,Y,type)
switch (type)
    case 1
        h = figure('units','normalized','outerposition',[0 0 1 1]);
        data = squeeze(data);
        tri = delaunay(X,Y);
        for i = 1:size(data,2)
            %h = figure('units','normalized','outerposition',[0 0 1 1]);
            trisurf(tri, X, Y, squeeze(data(:,i)),'edgeColor','none')
            caxis([-4 1]);
            axis([min(X) max(X) min(Y) max(Y) min(data(:,i))-1 max(data(:,i))]);
            view([0,0,1])
            colormap(gray)
            pause
        end
    case 2
        %h = figure('units','normalized','outerposition',[0 0 1 1]);
        figure
        resx = 300;
        resy = 300;
        x1 = min(X)-10;
        x2 = max(X)+10;
        y1 = min(Y)-10;
        y2 = max(Y)+10;
        Xb = x1:(x2-x1)/resx:x2;
        Yb = y1:(y2-y1)/resy:y2;
        Data = zeros(110,102,size(data,2));
        s = 1;
        for i = 1:resx
            for j = 1:resy
                I = find(max(abs(X-Xb(i)),abs(Y-Yb(j)))<15);
                % s(end+1) = I;
                if(size(I,2)<1)
                    I = find((X-Xb(i)).^2+(Y-Yb(j)).^2<400);
                end
                Data(i,j,:) = mean(data(I,:),1);
                %Data1(i,j,:) = mean(squeeze(median(data(:,I,:),1)),1);
                %Data2(i,j,:) = mean(squeeze(mean(data(:,I,:),1)),1);
            end
        end
        for i = 1:size(data,2)
            imagesc(squeeze(Data(:,:,i))');caxis([-4 1]);
%             subplot(1,2,1)
%             imagesc(squeeze(Data1(:,:,i))');caxis([-4 1]);title('Mean')
%             subplot(1,2,2)
%             imagesc(squeeze(Data2(:,:,i))');caxis([-4 1]);title('Median')
%             colormap(winter)
            %mean(s)
            pause
        end
end