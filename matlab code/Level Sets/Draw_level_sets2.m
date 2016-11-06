%% Level Sets
function Draw_level_sets2(Data,number_levels,X,Y,r)
% Data can be 2 dim or 3 dim. in the 2 dim case it should be points*times
% and X and Y show the corresponding points. in 3 dim , it should be
% X_cordinate*Y_cordinate*time
close all
figure('units','normalized','outerposition',[0 0 1 1])
S = region_for_median(X,Y,r);
a = floor((number_levels+1)^.5); b = floor((number_levels+1)/a);
if(a*b<number_levels+1)
    b = b+1;
end
if (ndims(Data)==2)
    tri = delaunay(X,Y);
    for i = 1:size(Data,1)
        subplot(a,b,1)
        trisurf(tri, X, Y, squeeze(Data(:,i)),'edgeColor','none');
        axis([min(X) max(X) min(Y) max(Y) min(Data(:,i)) max(Data(:,i))]);
        view([0,0,1])
        List = quantile(squeeze(Data(:,i)),number_levels);
        count = 2;
        for j = List(1:end)
            subplot(a,b,count)
            trisurf(tri, X, Y, median_filter(squeeze(heaviside(Data(:,i)-List(count-1))),S),'edgeColor','none');
            colormap(gray)
            axis([min(X) max(X) min(Y) max(Y) min(Data(:,i)) max(Data(:,i))]);
            view([0,0,1])
            count = count + 1;
        end
        pause;
    end
else
    if(ndims(Data)==3)
        for i = 1:size(Data,1)
            subplot(a,b,1)
            imagesc(Data(:,:,i));
            List = quantile(reshape(Data(:,:,i),1,size(Data,1)*size(Data,2)),number_levels);
            count = 2;
            for j = List(1:end-1)
                subplot(a,b,count)
                imagesc(medfilt2(heaviside(Data(:,:,i)-List(count))));
                colormap(gray)
                count = count + 1;
            end
            pause;
        end
    end
end
