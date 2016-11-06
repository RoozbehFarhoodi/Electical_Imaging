%% import Data
clear
clc
load('/Volumes/Arch/Data/Electrical Imaging Data/CMOS data/Culture 2 Movie 2 (100926-A2-StimScan-Data).mat')
%load('/Volumes/Arch/Data/Electrical Imaging Data/CMOS data/Culture 3 Movie 2 (091123-A-StimScan-Data).mat')
%load('/Volumes/Arch/Data/Electrical Imaging Data/CMOS data/Culture 4 Movie 2 (091120-B-StimScan-Data).mat')

[X,Y,Data,A] = read_CMOS(data);
%clear data;
sdata = squeeze(mean(Data,1));
%% Normlize over time
Data = Normal_over_time(sdata(:,:));
%% Show data
close all
J = find(max(abs(X-1000),abs(Y-1500))<3000);
%Movie_CMOS(1*squeeze(mean(Data(1:30,J,65:179),1)),X(J),Y(J),2)
%Movie_CMOS(.17*Data(J,65:end),X(J),Y(J),2)
%Movie_CMOS(.1*squeeze(median(Data(:,:,70:end),1)),X(J),Y(J),2)
Movie_CMOS(.051*squeeze(mean(Data(:,:,70:end),1)),X(J),Y(J),1)
%Movie_CMOS(2*Data(:,:,70:end),X(J),Y(J),1)
%Movie_CMOS(.25*A(:,60:end),X(J),Y(J),2)
%Movie_CMOS(.050*squeeze(A(J,77)),X(J),Y(J),1)
%% forward model (fixed depth)
% Forward = forward_fun(X,Y,20);
% D = Distance(X,Y);
Forward3D = [];
Forward3D = forward_fun_depth(D,[5 8 12 15 18],[.8 1.25 1.65 1.95 2.2],1);
% Forward_id = eye(length(X));
%% forward model (different depth)
Forward3D = zeros(length(X),length(Y),6);
for i = 1:6
    Forward3D(:,:,i) = forward_fun(X,Y,4*i);i
end
%% Normlized Forward Matrix
J = find(max(abs(X-1000),abs(Y-1000))<150);
F = Forward(J,J);
[F,D] = Unit_pos(Forward,J);
%% Show an image of data or Forward model
figure
trisurf(delaunay(X,Y), X, Y,squeeze(Forward(:,6500,1))-squeeze(Forward(:,6501,1)),'edgeColor','none')
%trisurf(delaunay(X(J),Y(J)), X(J), Y(J),D(:,100),'edgeColor','none')
view([0,0,1])
%% Correlation for Forward
corr(squeeze(Forward3D(1003,:,5))',squeeze(Forward3D(1005,:,5))')
%% L1 data
B = [];
C = [];
Index = 60:10:80;
% Index = .4:.1:.6;
for i = 1:3
    i
    data = sdata(:,95+i);
    [b c] = L1_source(data,X,Y,Forward,1000,1000,300,300,Index,2);
    B(:,:,i) = b;
    C(:,:,i) = c;
end
%% Different paramitrezation
figure
%Index = .5:.1:.8;
%data = squeeze(mean(Data(1:30,:,91:99),1));
%[B,BA] = L1_source_L2_time(data,X,Y,Forward,1000,1000,400,400,Index,1,.1,90);
%Draw_L1_source_L2_time(10*data,5*B,X,Y,1000,1000,400,400,Index,1)
%for i = 1:3
%close
Draw_L1_source(5*squeeze(sdata(:,98)),X,Y,1.25*squeeze(B(:,:,3)),1000,1000,300,Index(:))
%pause
%end
%% L1 Sources with depth layers
%[B,s] = L1_source_depth(5*squeeze(mean(Data(1:30,:,95),1)),X,Y,Forward3D(:,:,[1,5]),1000,1300,300,500,2)
for i = 1:6
    [B,s] = L1_source_depth(squeeze(sdata(:,95)),X,Y,Forward3D(:,:,i),1050,1550,300,440,2);
    Draw_L1_source_depth_ver1(5*squeeze(sdata(:,95)),X,Y,B,1050,1550,300)
end
%% L1 Sources with depth all in once
clc
xcenter = 600;
ycenter = 1000;
n = 111;
J = find((X-xcenter).^2+(Y-ycenter).^2<300^2);
Forward3Dhandy = forward_fun_depth(D(J,J),[2:2:20],[2:2:20].^.7,1);
[B,s] = L1_source_depth(5*squeeze(sdata(:,n))',X,Y,Forward3Dhandy,xcenter,ycenter,300,260,2);
Draw_L1_source_depth_ver1(10*squeeze(sdata(:,n)),X,Y,B,xcenter,ycenter,300)
%% L1-precent one portion
clc
n = 77;
xcenter = 1000;
ycenter = 1500;
%[Source,lambda] = L1_source_precentage(D2',X,Y,For,xcenter,ycenter,300,.12,.06);
[Source,lambda] = L1_source_precentage(squeeze(sdata(:,n))',X,Y,Forward,xcenter,ycenter,450,.08,.019);
Draw_L1_source(10*squeeze(sdata(:,n)),X,Y,10*Source,xcenter,ycenter,450,1)
%% Grouping 
con = 50;
J = find((X-xcenter).^2+(Y-ycenter).^2<300^2);
J3 = find((X(J)-xcenter).^2+(Y(J)-ycenter).^2<(300-con)^2);
J2 = find(Source(J3)~=0);
G = Grouping_data(D(J(J3(J2)),J(J3(J2))),20)
%% Adjusting
esti_source = [];
for i = 1:length(G)
    K = J(J3(J2(G{i})));
    J4 = find((X-X(K(1))).^2+(Y-Y(K(1))).^2<50^2);
    esti_source(:,i) = Adjust_source(X(J4),Y(J4),squeeze(sdata(J4,n))',[sdata(K(1),n);X(K(1));Y(K(1));10]');
end
esti_source(4,:) = abs(esti_source(4,:));
Draw_groundtruth(esti_source,xcenter, ycenter,300)
%% Correct spgl1
clc
J = find((X-xcenter).^2+(Y-ycenter).^2<300^2);
[x,s] = spg_bpdn_cor(Forward(J,J),squeeze(sdata(J,93))',40.571);
length(find(x~=0))
s
%% L1-precent Whole
clc
%S= [];
for i = 1:15
    n = 70+i
    [Source,lambda] = L1_source_precentage_whole(squeeze(sdata(:,n))',X,Y,Forward,.03,.015);
    S(i,:) = Source;
    Draw_L1_source(5*squeeze(sdata(:,n)),X,Y,5*Source,1000,1000,3000,1)
end
%% NaN
[row, col] = find(isnan(S));
S(row,col) = 0;
%% Grouping
Group = cell(1,size(S,1));
for i = 1:size(S,1)
Group{i} = Grouping_data2(D,S(i,:),20,50);
end
%% Solution to Dots
SD = cell(1,size(S,1));
for i = 1:size(S,1)
SD{i} = SolutionToDots(X,Y,S(i,:),D);
end
%% Matching
M = maching(X,Y,S,SD,50);
%% Draw network
Draw_network(X,Y,SD,M)
%% Show Grouping 
tri = delaunay(X,Y);
J = zeros(1,length(X));
for i = 1:length(G)
    J(G{i}) = squeeze(sdata(G{i},92));
    trisurf(tri, X, Y, 20*J,'edgeColor','none')
    caxis([-200 100]);
    axis([min(X) max(X) min(Y) max(Y) -12000 12000]);  
    view([0,0,1])
    pause(.1)
end
%%
% G = Grouping_data2(D,squeeze(S(2,:)),20,100);
J = zeros(1,length(X));
h = figure('units','normalized','outerposition',[0 0 1 1]);
tri = delaunay(X,Y);
for i = 1:length(G)
J(G{i}) = squeeze(S(2,G{i}));
trisurf(tri, X, Y, 25*J,'edgeColor','none')
caxis(1*[-300 300]);
axis([min(X) max(X) min(Y) max(Y) -2000 2000]);
view([0,0,1])
pause(.1)
end
%%
count = 1
l = [];
for i = 56.65
    B2(:,count) = L1_source(squeeze(sdata(:,93)),X,Y,Forward,1000,1000,300,300,i,2);
    Draw_L1_source(squeeze(sdata(:,93)),X,Y,B2(:,count),1000,1000,300,100);
    l(count) = length(find(abs(B2(:,count))>.01));
    count = count + 1;
end
%Draw_L1_source(squeeze(mean(Data(1:30,:,93),1)),X,Y,min(B2(:,2),1000,1000,300,100)
%plot(l)
%% Comparing spgl1 and cvx
clc
J = find((X-540).^2+(Y-540).^2<300^2);
A = Forward(J,J);
b = sdata(J,95);
tic
B1 = L1_source(squeeze(sdata(:,95)),X,Y,Forward,540,540,300,300,70,1);
toc
B2 = L1_source(squeeze(sdata(:,95)),X,Y,Forward,540,540,300,300,70,2);
toc
B3 = L1_source(squeeze(sdata(:,95)),X,Y,Forward,1000,1000,300,300,70,3);
toc
B4 = L1_source(squeeze(sdata(:,95)),X,Y,Forward,1000,1000,300,300,70,4);
toc
norm(B1,1)
norm(B2,1)
norm(B3,1)
norm(B4,1)
Draw_L1_source(squeeze(sdata(:,95)),X,Y,B4,1000,1000,300,100)
%norm(A*B2-squeeze(mean(Data(1:30,J,94),1))',2)
%% L0 sources
xcenter = 600;
ycenter = 1000;
n = 94;
J = find((X-xcenter).^2+(Y-ycenter).^2<300^2);
Forward3Dhandy = forward_fun_depth(D(J,J),20,1,1);
[F,D1] = Unit_pos(Forward3Dhandy,1:length(J));
L = omp(F,sdata(J,n),F'*F,50);
Draw_L1_source(10*sdata(:,n),X,Y,L,xcenter,ycenter,300,1)
%% Simulated Data
clc
N = 70;
xcenter = 1000;
ycenter = 1000;
neuron_data = rand(4,N);
neuron_data(1,:) = 20*rand(1,N);
neuron_data(2:3,:) = 2000*neuron_data(2:3,:);
neuron_data(4,:) = 30*rand(1,N);
%neuron_data(4,:) = 20*ones(1,N);
Sim = 100*evalpotential([X;Y;zeros(1,length(X))],neuron_data)';
Draw_groundtruth(neuron_data,xcenter, ycenter,1000)
%% watershed
[x,y] = meshgrid(0:30:2000);
n = size(x,1);
x = reshape(x,1,n^2);
y = reshape(y,1,n^2);
N = 3;
neuron_data = rand(4,N);
neuron_data(1,:) = 20*rand(1,N);
neuron_data(2:3,:) = 2000*neuron_data(2:3,:);
neuron_data(4,:) = 30*rand(1,N);
Sim = evalpotential([x;y;zeros(1,n^2)],neuron_data)';
Sim = reshape(Sim,n,n);
L = watershed(Sim);
rgb = label2rgb(L,'jet',[.5 .5 .5]);
figure, imshow(rgb,'InitialMagnification','fit')
title('Watershed transform of D')
figure;
imagesc(Sim')
%% L1 solution
% xcenter = 1300;
% ycenter = 400;
J = find((X-xcenter).^2+(Y-ycenter).^2<300^2);
%Forward3Dhandy = forward_fun_depth(D(J,J),[8 16 24 30],[1 1.2 1.4 1.4],2);
Forward3Dhandy = forward_fun_depth(D(J,J),20,1,1);
%[Source,lambda] = L1_source_precentage(Sim',X,Y,Forward3Dhandy,xcenter,ycenter,300,.12,.06);
[S,s] = L1_source_depth(Sim',X,Y,Forward3Dhandy,xcenter,ycenter,300,1500,2);
Draw_L1_source_depth_ver1(40*Sim,X,Y,.20*S,xcenter,ycenter,300);
%Draw_groundtruth_depth(X,Y,neuron_data,xcenter,ycenter,300,8);
%% L1-precent one portion
clc
[Source,lambda] = L1_source_precentage(Sim',X,Y,Forward,xcenter,ycenter,300,.3,.03);
Draw_L1_source(10*D2,X,Y,10*Source,xcenter,ycenter,300,1)
Draw_groundtruth(neuron_data,xcenter, ycenter,300)
%% Grouping
con = 100;
J = find((X-xcenter).^2+(Y-ycenter).^2<300^2);
J3 = find((X(J)-xcenter).^2+(Y(J)-ycenter).^2<(300-con)^2);
J2 = find(Source(J3)~=0);
G = Grouping_data(D(J(J3(J2)),J(J3(J2))),20)
%% Adjusting 1
esti_source = [];
for i = 1:length(G)
    K = J(J3(J2(G{i})));
    esti_source(:,i) = [1;X(K(1));Y(K(1));10];
end
A = Adjust_source(X(J),Y(J),Sim(J)',esti_source');
A(4,:) = abs(A(4,:));
Draw_groundtruth(A,xcenter, ycenter,300)
Draw_groundtruth(neuron_data,xcenter, ycenter,300)
%% Adjusting 2
close all
esti_source = [];
for i = 1:length(G)
    K = J(J3(J2(G{i})));
    J4 = find((X-X(K(1))).^2+(Y-Y(K(1))).^2<50^2);
    esti_source(:,i) = Adjust_source(X(J4),Y(J4),Sim(J4)',[1;X(K(1));Y(K(1));10]');
end
esti_source(4,:) = abs(esti_source(4,:));
Draw_groundtruth(esti_source,xcenter, ycenter,300)
Draw_groundtruth(neuron_data,xcenter, ycenter,300)
%% L0 solution
[F,D1] = Unit_pos(Forward3Dhandy,1:length(J));
S = omp(F,Sim(J),F'*F,50);
Draw_L1_source_depth_ver1(40*Sim,X,Y,20*S,xcenter,ycenter,3000);
%Draw_groundtruth_depth(X,Y,neuron_data,xcenter,ycenter,300,8);
%% Adjust sources for restricted area
clc
%xcenter = 1000;
%ycenter = 1500;
%J = find((X-xcenter).^2+(Y-ycenter).^2<300^2);
[Source,lambda] = L1_source_precentage_whole(Sim',X,Y,Forward,.04,.019);
Draw_L1_source(50*Sim,X,Y,40*Source,1000,1000,3000,1)
%%
points = zeros(2,4);
points(1,:) = [1,500,ycenter,10];
points(2,:) = [1,1500,ycenter,10];
points(3,:) = [1,1000,ycenter,10];

A = Adjust_source(X(J),Y(J),Sim(J)',points)
%% Finding with L0 and L1
clc
xcenter = 1500;
ycenter = 1200;
L0_on_L1(Sim',X,Y,D,Forward,xcenter,ycenter,300)
%% L1 reweigthed
clc
%xcenter = 900;
%ycenter = 900;
J = find((X-xcenter).^2+(Y-ycenter).^2<300^2);
[B,s] = L1_reweigthed(Sim',X,Y,Forward,xcenter,ycenter,300,25,2,4);

%% SFN
close all
SFN2016Abs(5*sdata(:,:),X,Y,Forward,[92,93,94,95,96],[350,350,330,310,320],1000,1000,300)
print('-djpeg','-r500')
%% attaching the Patches
clc
close all
D= [];
S = [];
TH = [];
J = find(max(abs(X-1200),abs(Y-1300))<200);
for i = 1:15
    %data = squeeze(mean(Data(:,:,90+i),1));
    %[D1,S1,Z1,TH1,T] = add_patch_L1(data,X,Y,Forward,[7,7],8*ones(9),500);
    [D1,S1,Z1,TH1,T1] = add_patch_L1(sdata(J,90+i),X(J),Y(J),Forward(J,J),[1,1],1,20);
    S(i,:) = S1;
    TH(i,:,:) = TH1;
end
%%
close all
%figure('units','normalized','outerposition',[0 0 1 1]);
for i = 1:15
    %     data = squeeze(mean(Data(1,:,90+i),1));
    % figure(1)
    % trisurf(delaunay(X,Y), X, Y, data,'edgeColor','none');
    % axis([min(X) max(X) min(Y) max(Y) min(data) max(data)]);
    % caxis([-200 100]);
    % view([0,0,1])
    % axis equal
    % title('Whole Field')
    figure(1)
    %trisurf(delaunay(X,Y), X, Y, squeeze(S(i,:)),'edgeColor','none');
    trisurf(delaunay(X(J),Y(J)), X(J), Y(J), squeeze(S(i,:)),'edgeColor','none');
    axis([min(X(J)) max(X(J)) min(Y(J)) max(Y(J)) -300 300]);
    caxis([-50 50]);
    view([0,0,1])
    axis equal
    pause
end
%% Networking
Dis = pdist([X;Y]');
s = 1;
Distance = zeros(size(X,2),size(X,2));
for i = 1:size(X,2)
    Distance(i,i+1:size(X,2)) = Dis(s:s+(size(X,2)-i-1));
    s = s + (size(X,2)-i);
end
Distance = Distance + Distance';

net = Net(X,Y,S,Distance,30,30);

%%
J = find(max(abs(X-1000),abs(Y-1000))<400);
tri = delaunay(X(J),Y(J));
I = [1 3 ];
for i = 1:10
    trisurf(delaunay(X(J),Y(J)), X(J), Y(J), squeeze(B(:,i,I(i))),'edgeColor','none');
    view([0,0,1])
    pause
end
%%
trisurf(delaunay(X,Y), X, Y, 4*S,'edgeColor','none');
axis([min(X) max(X) min(Y) max(Y) min(S) max(S)]);
caxis([-60 30]);
view([0,0,1])
axis equal
%%
figure
Draw_L1_source(10*data,X,Y,5*squeeze(B(:,:)),1000,1000,400,Index);
%saveas(h,'filename.jpg')
%%
close
h = figure('units','normalized','outerposition',[0 0 1 1]);
Movie_L1_source(10*squeeze(mean(Data(1:30,:,91:end),1)),X,Y,6*B(:,:,:),1000,1000,400,Index)
%%
for i = 85
    Draw_L1_source(10*squeeze(mean(Data(1:30,:,85),1)),X,Y,5*squeeze(B(:,:)),1000,1000,400)
    pause
end
%% Simulation for random circle movements
data_sim_cir = zeros(300,size(X,2));
for i = 1:2500
    i
    st = floor(rand*size(X,2))+1;
    ed = floor(rand*size(X,2))+1;
    ti = floor(300*rand)+1;
    val = randn;
    r = 100*rand;
    for j = 1:20
        r = max(0,r+randn*10);
        x = (j/20)*X(st)+((20-j)/20)*X(ed);
        y = (j/20)*Y(st)+((20-j)/20)*Y(ed);
        I = find((X-x).^2+(Y-y).^2<r^2);
        data_sim_cir(min(300,ti+j),I) = data_sim_cir(min(300,ti+j),I) + val;
    end
end

%% overtime
J1 = find((X-900).^2+(Y-1100).^2<600^2);
J2 = find((X-900).^2+(Y-1100).^2<200^2);
opts = spgSetParms('verbosity',0);
for i = 30:100
    B(:,i) = spg_bpdn(100*A_st(J1,J2), squeeze(Data(12,J1,i))', .001, opts);i
end
tri2 = delaunay(X(J2),Y(J2));
%data = Data(12,J2,:);
for i = 31:100
    subplot(121)
    trisurf(tri2, X(J2), Y(J2), squeeze(data(1,:,i)));
    view([0,0,1])
    subplot(122)
    trisurf(tri2, X(J2), Y(J2), B(:,i));
    view([0,0,1])
    pause
end