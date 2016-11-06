function Data = Normal_over_time(data)
M = mean(data,2);
S = std(data');
Data = (data - M*ones(1,size(data,2)))./(S'*ones(1,size(data,2)));

