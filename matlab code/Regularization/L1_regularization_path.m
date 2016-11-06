function B = L1_regularization_path(x, Basis, start_point,end_point,division)
% x is a 2d data and Basis is 4d matrix, which the value at (i,j,k,l) is
% the amount of charge at the point (i,j) when we have a source at (k,l).
close
X = reshape(x,size(x,1)*size(x,2),1);
Bas = reshape(Basis,size(Basis,1)*size(Basis,2),size(Basis,3)*size(Basis,4));
if (nargin>4)
    division = 10;
elseif(nargin>3)
    end_point = 10;
elseif(nargin>2)
    start_point = 0;
end
a = floor((division+2)^.5); b = floor((division+2)/a);

I = start_point:(end_point-start_point)/(division-1):end_point;
B = [];
for i = 1:size(I,2)
    B(i,:) = spg_bpdn(Bas,X,I(i), spgSetParms('verbosity',0));
end
subplot(a,b,1)
imagesc(x)
subplot(a,b,2)
for i = 1:size(I,2)
plot(B(:,i))
hold on;
end
for i = 1:size(I,2)
    subplot(a,b,i+2)
    imagesc(reshape(B(i,:),size(Basis,3),size(Basis,4)))
end