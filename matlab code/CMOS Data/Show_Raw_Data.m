%% import Data
X = data.x;
Y = data.y;
Data = data.raw;
A = data.ave;
I = [find(X==0),find(Y ==-1)];
X(I) = [];
Y(I) = [];
A(I,:) = [];
Data(:,I,:) = [];
clear data I
%% plot on triangulation
%figure('units','normalized','outerposition',[0 0 1 1])
%mov(1:230) = struct('cdata', [],'colormap', []);
close
tri = delaunay(X,Y);
for i = 71:300
    i
trisurf(tri, X, Y, mean(Data(1:30,:,i),1),'edgeColor','none');
%trisurf(tri, X, Y,data_sim_cir(i,:),'edgeColor','none');
axis([min(X) max(X) min(Y) max(Y) -150 150]);
%caxis([-100 200])
view([0,0,1])
%mov(i-70) = getframe(gcf);
pause
end
%movie2avi(mov, 'Real Field.avi', 'compression', 'None');
%% Matrix of 110*102
x1 = min(X)-10;
x2 = max(X)+10;
y1 = min(Y)-10;
y2 = max(Y)+10;
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
%% Plot the Movie
close
figure('units','normalized','outerposition',[0 0 1 1])
for i = 31:300
    i
    %subplot(121)
    imagesc(fliplr(flipud(tanh(.10*data(:,:,i)))))
    %surf(fliplr(flipud(tanh(.10*data(:,:,i)))))
    %subplot(122)
    %imagesc(medfilt2(fliplr(flipud(tanh(.10*data(:,:,i))))))
    %imagesc(medfilt2(medfilt2(fliplr(flipud(tanh(.10*data(:,:,i)))))))
    %surf(fliplr(flipud(tanh(.10*data(:,:,i)))))
    
    %  imagesc(fliplr(flipud(min(max((squeeze(data(:,:,i)/5).^3),-50),50))))
    %Del(:,:,i) = del2(squeeze(data(:,:,i)));
    %colormap(gray)
    %caxis([-1,1])
    %axis()
    %m(i) = mean(mean(squeeze(data(:,:,i))));
    pause;
end
%% Infering the Sources
close
for i = 35:200 
    %surf(squeeze(Del(:,:,i)))
    %axis([1 110 1 102 -350 350])
    surf(fliplr(flipud(squeeze(data(:,:,i)))))
    %imagesc(fliplr(flipud(squeeze(data(:,:,i)))))
    %colormap(gray)
    %surf(tanh(.15*squeeze(Del(:,:,i))))
    %imagesc(tanh(.10*squeeze(data(:,:,i))))
    %axis([1 110 1 102 -150 150])
    pause;
    i
end
%% FFT
i = 200;
F1 = fftn(fliplr(flipud(data(:,:,i))));
I = abs(F1);
C = flip(sort(reshape(I,d,1)));
plot(C(2:200))