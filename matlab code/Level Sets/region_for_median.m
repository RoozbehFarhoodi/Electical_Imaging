function Set = region_for_median(X,Y,R)
Set = cell(1,length(X));
for i = 1:length(X)
    I = find((X-X(i)).^2+(Y-Y(i)).^2<R^2);
    Set{i} = I;
end