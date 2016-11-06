function y = L0_source(data,Forward,Index)
Forward2 = Forward'*Forward;
for i = 1:length(Index)
    % y(:,i) = omp2(Forward,data,Forward2,Index(i));
    y(:,i) = omp(Forward,data,Forward2,Index(i));
end