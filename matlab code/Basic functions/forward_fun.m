function A = forward_fun(X,Y,depth)

% inverse function
Dis = pdist([X;Y]');
s = 1;
Distance = zeros(size(X,2),size(X,2));
for i = 1:size(X,2)
   Distance(i,i+1:size(X,2)) = Dis(s:s+(size(X,2)-i-1));
   s = s + (size(X,2)-i);
end
Distance = Distance + Distance';
clear Dis
A = (Distance.^2+depth^2).^-.5;
%A = A.*cos(.03*Distance);