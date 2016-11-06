%% How to choose the best regularization parameter in BP algorithm
%clear
clc
close
n = 50;
m = 128;
k = 12;
A = rand(n,m);
[A2,A] = qr(randn(n,m),0);
A = randn(n,m);
x = zeros(m,1);
I = randperm(m);
x(I(1:k)) = 1;
% randn(1,k);
% x = randn(m,1);
% x = ones(m,1);
b = A*x+.8*randn(n,1);
count = 1;
J = 0:2.5:30;
B = [];
for i = J
B(:,count) = spg_bpdn(A,b,i, spgSetParms('verbosity',0));
count = count + 1;
end
% for i = 1:m
%     plot(J,B(i,:));
%     hold on
%     %r = floor(size(J,2)*rand)+1;
%     %text(J(r),B(i,r),num2str(i))
% end
%figure
plot(B)
hold on
plot(x,'*')
%% How to choose the best regularization parameter in LASSO
clear
close
n = 50;
m = 128;
k = 8;
A = rand(n,m);
[A2,A] = qr(randn(n,m),0);
%A = randn(n,m);
x = zeros(m,1);
I = randperm(m);
x(I(1:k)) = 1;
% randn(1,k);
% x = randn(m,1);
% x = ones(m,1);
b = A*x+1.2*randn(n,1);
count = 1;
J = 0:.5:30;
B = [];
for i = J
B(:,count) = spg_lasso(A,b,i, spgSetParms('verbosity',0));
count = count + 1;
end
for i = 1:m
    plot(J,B(i,:));
    hold on
    r = floor(size(J,2)*rand)+1;
    
    %text(J(r),B(i,r),num2str(i))
end
%figure
%plot(J,sum(abs(B)))
%% On the plane
%clear
clc
close
n = 30;
m = n;
k = 10;
[xmesh ymesh] = meshgrid(10*[1:n],10*[1:n]);
A = forward_fun(reshape(xmesh,1,n^2),reshape(ymesh,1,n^2),10);
x = zeros(m^2,1);
I = randperm(m^2);
%x(I) = (1./(.3+.1*[1:m^2].^2)).*(1-2*floor(2*rand(1,m^2)));
x(I(1:k)) = (1-2*floor(2*rand(1,k)));
er = .01*randn(m^2,1);
norm(er)
b = A*x+er;
%%
% imagesc(reshape(b,m,m))
count = 1;
J = .3560000:.0000003:.3560040;
B = [];
Asim = forward_fun(reshape(xmesh,1,n^2),reshape(ymesh,1,n^2),10);
for i = J
B(:,count) = spg_bpdn(Asim,b,i, spgSetParms('verbosity',0));
count = count + 1;
end
% for i = 1:m
%     plot(J,B(i,:));
%     hold on
%     %r = floor(size(J,2)*rand)+1;
%     %text(J(r),B(i,r),num2str(i))
% end
%figure
%
for i = 1:size(B,2)
   subplot(5,5,i)
   surf(reshape(B(:,i),m,m),'edgeColor','none')
   axis([1 n 1 n -.2 .2])
   view([0 0 1])
end
figure
surf(reshape(x,m,m),'edgeColor','none')
axis([1 n 1 n -2 2])
view([0 0 1])
%% CVX example
J = find(abs(X-1000)<150 & abs(Y-1000)<150);
n = length(J); 
A = Forward(J,J); b = mean(Data(:,J,91),1);

cvx_begin
    variable x(n)
    minimize( norm( x ,1 ) )
    subject to
        norm( A * x - b', 2 ) <= 50
cvx_end
%%
trisurf(delaunay(X(J),Y(J)), X(J), Y(J), x,'edgeColor','none');

%%
opts = spgSetParms('verbosity',0);
x2 = spg_bpdn(A, b', 1000, opts);