function SD = SolutionToDots(X,Y,data,Distance)
G = Grouping_data2(Distance,data,20,60);
for i = 1:length(G)
    I = G{i};
   SD(1,i) = mean(X(I));
   SD(2,i) = mean(Y(I));
   SD(3,i) = mean(data(I));
end
