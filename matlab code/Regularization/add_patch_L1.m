function [D,S,Z,TH,T] = add_patch_L1(data,X,Y,A,division,threshold,num)
m = division(1);
n = division(2);
dx = max(X) - min(X);
dy = max(Y) - min(Y);
D = cell(n,m);
S = zeros(size(X));
Z = [];
T = [];
figure(1)
trisurf(delaunay(X,Y), X, Y, data,'edgeColor','none');
axis([min(X) max(X) min(Y) max(Y) min(data) max(data)]);
caxis([-200 100]);
view([0,0,1])
axis equal
title('Whole Field')


for i = 1:m
    for j = 1:n
        (j+n*(i-1))/(m*n)
        xcenter =  min(X) + ((j-.5)/n)*dx;
        ycenter =  min(Y) + ((m-i+.5)/m)*dy;
        rcenter_x = .5*(dx/n);
        rcenter_y = .5*(dy/m);
        J = find(abs(X-xcenter)<rcenter_x & abs(Y-ycenter)<rcenter_y);
        th_big = 700;
        th_small = 0;
        z = 0;
        T(i,j) = num*(sum(abs(data(J)))/sum(abs(data)));
        T(i,j)
        %while(abs(z-threshold(i,j))>3)
        while(abs(z-T(i,j))>1.5)
            B = squeeze(L1_source(data,X,Y,A,xcenter,ycenter,rcenter_x,rcenter_y,.5*(th_big+th_small),1));
            z = sum(heaviside(abs(B)-.0001));
            %if(z<threshold(i,j))
            if(z<T(i,j))
                th_big = .5*(th_big+th_small);
            else
                th_small = .5*(th_big+th_small);
            end
        end
        Z(i,j) = z;
        TH(i,j) = .5*(th_big+th_small);
        %subplot(m,n,j+n*(i-1))
        %trisurf(delaunay(X(J),Y(J)),X(J),Y(J),B,'edgeColor','none');
        %caxis([min(B) max(B)]);
        %caxis([-20 10]);
        %axis([min(X(J)) max(X(J)) min(Y(J)) max(Y(J)) min(data(J)) max(data(J))]);
        %axis equal
        %view([0,0,1])
        %axis off
        D{j,i} = B;
        S(J) = S(J) + B';
        figure(2)
        trisurf(delaunay(X,Y), X, Y, S,'edgeColor','none');
        axis([min(X) max(X) min(Y) max(Y) -1000 1000]);
        caxis([-50 50]);
        view([0,0,1])
        axis equal
        hold on;
    end
end
hold off

% figure(3)
% trisurf(delaunay(X,Y), X, Y, S,'edgeColor','none');
% axis([min(X) max(X) min(Y) max(Y) min(S) max(S)]);
% caxis([-200 200]);
% view([0,0,1])
% axis equal
% title('Whole Field')