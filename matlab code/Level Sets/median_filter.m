function filt = median_filter(Data,set)
for i = 1:length(Data)
    a = set{i};
    filt(i) = median(Data(a));
end