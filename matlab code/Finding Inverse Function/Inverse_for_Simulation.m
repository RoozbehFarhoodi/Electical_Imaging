%% Basis
A = []; % Structure Matrix
d1 = 50; % planar resulotion (x)
d2 = d1; % planar resulotion (y)
depth = .1;
d = d1*d2;
a = (ones(d1,1)*[0:d1-1])/d1;
b = (a - a').^2;
Distance = depth.^2 +kron(b,ones(d2))+kron(ones(d2),b);
A = (Distance).^(-.5);
%A = (Distance).^(-.2);
%A = -log(Distance);
%A = -log(Distance).*(1.1+cos(40*Distance.^2));
%A = (sign(-(Distance-.05))+1)/1.2+(sign(-(Distance-.1))+1)/2+(sign(-(Distance-.2))+1)/4+.1;
%A = (1.02).^((Distance).^(-1));
%A = (4).^(-30*(Distance));
%A = -(sign(-(Distance-.05))+1)/4+(sign(-(Distance-.1))+1)/4+.1;
%imagesc(reshape(A(:,875),d2,d1))
surf(reshape(A(:,1225),d2,d1))
%% The random data on sources plane
N = 50; %% number of sources
depth = .1;
neuron_data = [];
neuron_data(1,:) = randn(1,N);
neuron_data(2,:) = rand(1,N);
neuron_data(3,:) = rand(1,N);
neuron_data(4,:) = depth*rand(1,N);
neuron_data(4,:) = depth*ones(1,N);
neuron_data(1,:) = 1-2*floor(2*rand(1,N));
%% On the site of Sources plane
v = zeros(d1,d2);
neuron_data = [];
N = 80;
for i = 1:N
    a1 = floor(d1*rand)+1;
    a2 = floor(d1*rand)+1;
    a3 = 1-2*floor(2*rand);
    %a3 = randn;
    v(a1,a2) = a3;
    neuron_data(1:4,end+1) = [a3,(a2-1)/(d1),(a1-1)/(d1),depth];
end
v = reshape(v,d,1);
D = (A*v)';
D1 = reshape(D,d2,d1);
imagesc(D1)
%% Neuron Structure
X = tree2.X;
Y = tree2.Y;
Z = tree2.Z;
N = size(X,1);
neuron_data = [1-2*floor(2*rand(1,N));((X+145)/230)';((Y+65)/125)';.1*ones(1,size(X,1))];
%neuron_data(2:3,:) = floor(d1*neuron_data(2:3,:))/(d1);
%% Neuron Structure on Latice
X = tree2.X;
Y = tree2.Y;
Z = tree2.Z;
u = unique([floor(d1*((X+145)/230)')/d1;floor(d1*((Y+65)/125)')/d1]','rows')';
N = size(u,1);
neuron_data(1,:) = 1-2*floor(2*rand(1,N));
.1*ones(1,size(X,1))];
%neuron_data = [ones(1,N);floor(d1*((X+145)/230)')/d1;floor(d1*((Y+65)/125)')/d1;.1*ones(1,size(X,1))];

%% Evalution
[Xsim,Ysim] = meshgrid(0:1/d1:((d1-1)/d1),0:1/d1:((d1-1)/d1));
Xsim = reshape(Xsim,1,d);
Ysim = reshape(Ysim,1,d);
Zsim = zeros(1,d);
mesh = [Xsim;Ysim;Zsim];
D = evalpotential(mesh,neuron_data);
D1 = reshape(D,d2,d1);
imagesc(D1)
%% L2 regularization (forward calculation)
%Ridg0 = A'*A;
%lambda = 40;
%B = ((Ridg0-lambda*eye(d))^-1);
%B = ((Ridg0)-lambda*ones(d))^-1;
%B = A^-2;
B = A^-1;
%B = ((Ridg0))^-1;
surf(reshape(B(:,875),d2,d1))
%Ridg = lambda*Ridg1-(lambda^2)*Ridg2+(lambda^3)*Ridg3-(lambda^4)*Ridg4;
%surf(reshape(Ridg(:,210),d2,d1))
%Dprop = B*(D');
%% Computing eigenvalues and eigen vectors
[V,I] = eig(A);
I = flip(diag(I));
%% showing eignevalues
plot(I(1:100))
loglog(I)
%% EigenVectors
close
c = 10;
for i = 1:c^2
    %subplot(c,2*c,2*i-1)
    subplot(c,c,i)
    imagesc(reshape(V(:,end+1-i),d1,d1))
    %nn = reshape(V(:,end+1-i),d1,d1);
    %subplot(c,2*c,2*i)
    %imagesc(abs(fft2(nn)))
    %colormap(gray)
    axis equal
    axis off
    %pause
    %title(int2str(i))
end
%% EigenVectors in the Fourier basis
close
c = 9;
for i = 0+[1:c^2]
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
subplot(141)
imagesc(D1(border+1:end-border,border+1:end-border))
subplot(142)
Z = zeros(d1,d2);
I = floor(neuron_data(2,:)*d2)+1;
J = floor(neuron_data(3,:)*d1)+1;
for i = 1:N
        Z(J(i),I(i)) = neuron_data(1,i);
end
imagesc(Z(border+1:end-border,border+1:end-border));%colormap(gray);
subplot(143)
Dprop = B*(D');
Dprop1 = reshape(Dprop,d2,d1);
imagesc(Dprop1(border+1:end-border,border+1:end-border))
%imagesc(Dprop1)
subplot(144)
In = find(filter2(ones(1),Z)>0);
A_in = A(In,In)^(-1);
val = A_in*D(In)';
z = zeros(d1,d1);
z(In) = val;
imagesc(z)

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
%% L2 regularization (gradient descent)

%% Proximal Gredient
epsilon = .001;
x = zeros(100,100);
%% Inverse on the sources (with the knowladge of knowing the sources)
In = find(Z==1);
A_in = A(In,In)^(-1);
val = A_in*D(In)';
z = zeros(d1,d1);
z(In) = val;
imagesc(z)
