function showline(T1,T2)
for i = 1:size(T1,1)
   plot([T2(i,1),T2(i,2)],300-[T1(i,1) T1(i,2)])
   hold on;
end