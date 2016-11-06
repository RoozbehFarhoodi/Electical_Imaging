function filt = median_filter_with_time(Data,set)
for j = 1:size(Data,1)
for i = 1:size(Data,2)

    a = set{i};
    filt(i) = median(Data(a));
end
end