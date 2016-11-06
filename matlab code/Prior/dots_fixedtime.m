function G = dots_fixedtime(image)
V1 = bwconncomp(image);
V1 = V1.PixelIdxList;
X = [];
Y = [];
val = [];
for i = 1:length(V1)
    [s k] = ind2sub([300 300],V1{i});
    X(i) = mean(s);
    Y(i) = mean(k);
    val(i) = mean(image(V1{i}));
end
G = [X;Y;val]';