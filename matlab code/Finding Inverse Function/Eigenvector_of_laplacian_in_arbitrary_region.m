%% other region
A = []; % Structure Matrix
R = 95;
depth = .1;
d = R^2;
a = (ones(R,1)*[0:R-1])/R;
b = (a - a').^2;
Distance = depth.^2 +kron(b,ones(R))+kron(ones(R),b);
%A = (Distance).^(-.5);
%A = (Distance).^(-.2);
A = -log(Distance);
%A = -log(Distance).*(1.1+cos(40*Distance.^2));
%A = (sign(-(Distance-.05))+1)/1.2+(sign(-(Distance-.1))+1)/2+(sign(-(Distance-.2))+1)/4+.1;
%A = (1.02).^((Distance).^(-1));
%A = (4).^(-30*(Distance));
%A = -(sign(-(Distance-.05))+1)/4+(sign(-(Distance-.1))+1)/4+.1;
%imagesc(reshape(A(:,875),d2,d1))
%c = ((a-.5).^2+(a'-.5).^2).^.5;
c = .5*((a-.2).^2+(a'-.2).^2).^.5+.2*((a-.8).^2+(a'-.3).^2).^.5 +.17*((a-.3).^2+(a'-.8).^2).^.5*+.13*((a-.8).^2+(a'-.8).^2).^.5;
c = .5*((a-.2).^2+(a'-.2).^2).^.5+.5*((a-.8).^2+(a'-.8).^2).^.5 -.2*((a-.5).^2+(a'-.5).^2).^.5;
In = find(c<.417);
[Ii,Ji] = find(c<.417);
A = A(In,In);
scatter(Ii,Ji,[],A(:,111))
%% L2 regularization (forward calculation)
B = A^-1;
scatter(Ii,Ji,[],B(:,1003))
%% Computing eigenvalues and eigen vectors
[V,I] = eig(A);
I = flip(diag(I));
%% showing eignevalues
plot(I(1:100))
loglog(I)
%% EigenVectors
close
c = 5;
count = 1;
for i = 100+[1:c^2]
    %subplot(c,2*c,2*i-1)
    subplot(c,c,count)
    scatter(Ii,Ji,[],V(:,end+1-i))
    %nn = reshape(V(:,end+1-i),d1,d1);
    %subplot(c,2*c,2*i)
    %imagesc(abs(fft2(nn)))
    %colormap(gray)
    axis equal
    axis off
    count = count + 1;
    %pause
    %title(int2str(i))
end
%% EigenVectors in the Fourier basis
close
c = 3;
for i = 700+[1:c^2]
    subplot(1,2,1)
    imagesc(reshape(V(:,end+1-i),d1,d1))
    axis equal
    nn = reshape(V(:,end+1-i),d1,d1);
    subplot(1,2,2)
    Nn = abs(fft2(nn));
    imagesc(Nn)
    %imagesc(max(0,Nn-4))
    %colormap(gray)
    axis equal
    axis off
    pause
    %title(int2str(i))
end
%% inverse of matrix by cutting in expantion
c = 30;
C = 0;
for i = 1:c
C = C + I(i)^(-1)*V(:,end-i+1)*V(:,end-i+1)';
end
surf(reshape(10*C(:,1875),d2,d1))
%imagesc(C)
%% The Conjecture That eignvectors are alternative sum of |x-p|^2
co = zeros(d1,d2);
for i = 1:d1
    for j = 1:d2
        co(i,j) = ((i-25)^2+(j-25)^2);
        co(i,j) = sin(i/25)*cos(j/25);
        co(i,j) = (i/30)^2-(j/30)^2;
        %co(i,j) = 0;
    end
end
c(25,25) = 1;
%surf(co/4000) 
%co = reshape(co,d,1);
%Co = A*co;
%surf(reshape(Co,d1,d2)) 
%hold on
%surf(reshape(V(:,end),d1,d1)+.0251)

%%
border = 0;
D1 = reshape(D,d2,d1);
subplot(131)
imagesc(D1(border+1:end-border,border+1:end-border))
subplot(132)
Z = zeros(d1,d2);
I = floor(neuron_data(2,:)*d2)+1;
J = floor(neuron_data(3,:)*d1)+1;
for i = 1:N
        Z(J(i),I(i)) = neuron_data(1,i);
end
imagesc(Z(border+1:end-border,border+1:end-border));%colormap(gray);
subplot(133)
Dprop = B*(D');
Dprop1 = reshape(Dprop,d2,d1);
imagesc(Dprop1(border+1:end-border,border+1:end-border))
%imagesc(Dprop1)
%subplot(144)
S = peakVally(Dprop1);
Z2 = zeros(d1,d2);
Z2(find(S==4)) = -1;
Z2(find(S==-4)) = 1;
th = zeros(d1,d2);
th(find(abs(Dprop1)>.008)) = 1;
Z2 = Z2.*th;
%imagesc(Z2(border+1:end-border,border+1:end-border))
%%
border = 2;
surf(Dprop1(border+1:end-border,border+1:end-border))
hold on
surf(Z(border+1:end-border,border+1:end-border)/2.40)
%%
Dif = Z-Z2;
imagesc(Dif(12:end-12,12:end-12))

