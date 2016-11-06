%% Level Sets
function Draw_3d_level(Data,precent,size_comp)
% Data can be 2 dim or 3 dim. in the 2 dim case it should be points*times
% and X and Y show the corresponding points. in 3 dim , it should be
% X_cordinate*Y_cordinate*time
% precent is the treshold for the level set (bet [0 1]). defult = .1;
% size_comp is the minimum size of components. default = 70;
close all
if nargin==1
    size_comp = 70;
else
    if nargin==2
        size_comp = 70;
        precent = .1;
    end
end

a = [];
for i = 1:size(Data,3)
    List = quantile(reshape(Data(:,:,i),1,size(Data,1)*size(Data,2)),floor(1/precent));
    a(:,:,i) = medfilt2(heaviside(Data(:,:,i)-List(1)));
end
CC = bwconncomp(medfilt3(a));
si = [];
for i = 1:CC.NumObjects
    si(i) = size(CC.PixelIdxList{i},1);
end
[I J] = sort(si);
K = J(find(I>size_comp));
Bi = zeros(CC.ImageSize);
for i = 1:size(K,2);
    Bi(CC.PixelIdxList{K(i)}) = 1;
end
close;visualize3d(Bi,'r',.5);
