%% Level Sets
function Draw_level_sets3(Data,number_levels,X,Y,r)
% Data can be 2 dim or 3 dim. in the 2 dim case it should be points*times
% and X and Y show the corresponding points. in 3 dim , it should be
% X_cordinate*Y_cordinate*time
close all
figure('units','normalized','outerposition',[0 0 1 1])
S = region_for_median(X,Y,r);
if (ndims(Data)==2)
    tri = delaunay(X,Y);
    for i = 1:size(Data,1)
        %         subplot(1,3,1)
        %         trisurf(tri, X, Y, squeeze(Data(:,i)),'edgeColor','none');
        %         axis([min(X) max(X) min(Y) max(Y) min(Data(:,i)) max(Data(:,i))]);
        %         view([0,0,1])
        %         List = quantile(squeeze(Data(:,i)),number_levels);
        %         H = median_filter(squeeze(heaviside(Data(:,i)-List(1))),S);
        %         subplot(1,3,2)
        %         trisurf(tri, X, Y, H,'edgeColor','none');
        %         colormap(gray)
        %         axis([min(X) max(X) min(Y) max(Y) 0 1]);
        %         view([0,0,1])
        %         subplot(1,3,3)
        %         trisurf(tri, X, Y, 1-median_filter(squeeze(heaviside(Data(:,i)-List(end))),S),'edgeColor','none');
        %         axis([min(X) max(X) min(Y) max(Y) 0 1]);
        %         view([0,0,1])
        
        for k = 1:4
            List = quantile(squeeze(Data(:,i+k-1)),number_levels);
            for s = 1:4
                subplot(4,4,4*k+s-4)
                trisurf(tri, X, Y, median_filter(squeeze(heaviside(Data(:,i+k-1)-List(s))),S),'edgeColor','none');
                axis([min(X) max(X) min(Y) max(Y) 0 1]);
                view([0,0,1])
                colormap(gray)
                title(['Time = ',num2str(k),', Level Set = ',num2str(s)])
            end
        end
        
        
        %CC = find(H==0);
        %size(CC)
        pause;
    end
else
end
