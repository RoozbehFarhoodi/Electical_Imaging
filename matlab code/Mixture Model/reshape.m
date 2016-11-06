%% import Data
clear
clc
load('/Volumes/Arch/Data/Electrical Imaging Data/CMOS data/Culture 2 Movie 2 (100926-A2-StimScan-Data).mat')
%load('/Volumes/Arch/Data/Electrical Imaging Data/CMOS data/Culture 3 Movie 2 (091123-A-StimScan-Data).mat')
%load('/Volumes/Arch/Data/Electrical Imaging Data/CMOS data/Culture 4 Movie 2 (091120-B-StimScan-Data).mat')

[X,Y,Data,A] = read_CMOS(data);
%clear data;
sdata = squeeze(mean(Data,1));
% Data Square 300*300
resx = 300;
resy = 300;
x1 = min(X)-10;
x2 = max(X)+10;
y1 = min(Y)-10;
y2 = max(Y)+10;
Xb = x1:(x2-x1)/resx:x2;
Yb = y1:(y2-y1)/resy:y2;
Data = zeros(300,300,size(sdata,2));
s = 1;
for i = 1:resx
    for j = 1:resy
        I = find(max(abs(X-Xb(i)),abs(Y-Yb(j)))<15);
        % s(end+1) = I;
        if(size(I,2)<1)
            I = find((X-Xb(i)).^2+(Y-Yb(j)).^2<400);
        end
        Data(i,j,:) = mean(sdata(I,:),1);
        %Data1(i,j,:) = mean(squeeze(median(data(:,I,:),1)),1);
        %Data2(i,j,:) = mean(squeeze(mean(data(:,I,:),1)),1);
    end
end
Data(find(isnan(Data))) = 0;
clear data A i I j resx resy s sdata X x1 x2 Xb Y y1 y2 Yb
%% Median Filter
A = Data;
A(abs(Data)<1) = 0;
for i = 72:300
    A(:,:,i) = medfilt2(A(:,:,i));
end
%% filfilter
Z = zeros(300,300,128);
for i = 73:200
    F = squeeze(A(:,:,i));
    B = filfilter(F);
    B(abs(B)<3)= 0;
    %B(abs(B)>25)= 0;
    Z(:,:,i-72) = B;
    i
end
%% group to dots
D = FourD(Z(:,:,1:40));
%% Connection
[C,Graph] = connect3(D);
%%
figure
ShowWhloe3D(C(1:end),D,Graph,40);
%%
M = newconnect(C,D,Graph);
[x,y] = find(M~=0);
showline([D(x,1),D(y,1)],[D(x,2),D(y,2)])
%%
figure
c = C{end};
G1 = Graph(c,c);
H = sign(G1+G1');
%
V = graph2chain(H,D(c,:))
ShowWhloe3D(V,D(c,:),G1,40);
%%
c = C{end-1};
ShowWhloe3D(C(end-1),D,Graph,25);
G1 = Graph(c,c);
H = sign(G1+G1');
V = graph2chain(H,D(c,:));
z = D(c,:);
z(:,2) = -100+z(:,2);
hold on
ShowWhloe3D(V,z,G1,25);
%%
figure;
clc
i = 83;
F = squeeze(A(:,:,i));
B = filfilter(F);
subplot(2,2,1)
B(abs(B)<3) = 0;
imagesc(B,[-60 30])
subplot(2,2,2)
imagesc(F,[-60 30])
F1 = squeeze(A(:,:,i+1));
B1 = filfilter(F1);
B1(abs(B1)<3) = 0;
subplot(2,2,3)
imagesc(B1,[-60 30])
subplot(2,2,4)
imagesc(F1,[-60 30])
%[M,t1,t2] = connect(B,B1);
%figure;
%showline(t1,t2)
%%
G = dots_fixedtime(B);
G = G(find(abs(G(:,3))>10),:);
G1 = dots_fixedtime(B1);
G1 = G1(find(abs(G1(:,3))>10),:);
[M,T1,T2] = connect2(G,G1);
figure
showline(T1,T2)


%%
close all
figure('units','normalized','outerposition',[0 0 1 1]);
for i = 95:300
    subplot(1,2,1)
    imagesc(Data(:,:,i),[-60 30]);
    axis equal
    subplot(1,2,2)
    %imagesc(A(:,:,i),[-60 30])
    %axis equal
    %[cent, pos]=FastPeakFind(squeeze(A(:,:,i)),0);
    %[cent, neg]=FastPeakFind(-squeeze(A(:,:,i)),0);
    %subplot(1,3,3)
    B = filfilter(A(:,:,i));
    %imagesc(pos-neg,[-1,1])
    B(abs(B)<3)= 0;
    imagesc(B,[-60 30])
    axis equal
    %subplot(1,3,3)
    %group_fixedtime(B);
    %axis equal
    pause
    i
end

%%
A = zeros(300,300,230);
X = Data(:,:,71:end);
A(abs(X)>20) = 1;
visualize3d(A,'r',.8)