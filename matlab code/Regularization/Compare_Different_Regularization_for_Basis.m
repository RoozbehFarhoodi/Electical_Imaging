%% Compare Different Basis
close
%clear
N = 2; %% number of neurons
depth = .05;
neuron_data = rand(4,N);
neuron_data(4,:) = depth;%*rand(1,N);
neuron_data(1,:) = 1;%randn(1,N);
d1 = 25; % planar resulotion (x)
d2 = 25; % planar resulotion (y)
[X,Y,Z] = meshgrid(0:1/(d1-1):1,0:1/(d2-1):1,0);
d = d1*d2; 
Xsim = reshape(X,1,d); 
Ysim = reshape(Y,1,d);
Zsim = reshape(Z,1,d);
mesh = [Xsim;Ysim;Zsim];
D = evalpotential2(mesh,neuron_data);
D = reshape(D,d2,d1)+.01*randn(d2,d1);
imagesc(D)
%%
figure;
Basis = [];
count = 1;
for i = 1:d1
    for j = 1:d2
        v = mesh(:,count);
        Basis(:,:,i,j) = reshape(evalpotential(mesh,[1;v(1:2);depth]),d1,d2);
        count = count + 1;
    end
end
%
division = 15;
start_point = 0;
end_point = 10;
Bas = reshape(Basis,size(Basis,1)*size(Basis,2),size(Basis,3)*size(Basis,4));
X = reshape(D,size(D,1)*size(D,2),1);
a = floor((division+2)^.5); b = floor((division+2)/a)+1;
I = start_point:(end_point-start_point)/(division-1):end_point;
B = [];
for i = 1:size(I,2)
    B(i,:) = spg_bpdn(Bas,X,I(i), spgSetParms('verbosity',0));
    i
end
%
subplot(a,b,1)
imagesc(D)
subplot(a,b,2)
for i = 1:size(B,2)
plot(I,B(:,i))
hold on;
end
hold off;
for i = 1:size(I,2)
    subplot(a,b,i+2)
    imagesc(reshape(B(i,:),size(Basis,3),size(Basis,4))')
    title(num2str(I(i)))
end
%%
figure;
Basis = [];
count = 1;
for i = 1:d1
    for j = 1:d2
        v = mesh(:,count);
        Basis(:,:,i,j) = reshape(evalpotential2(mesh,[1;v(1:2);depth]),d1,d2);
        count = count + 1;
    end
end
%
division = 15;
start_point = 0;
end_point = 15;
Bas = reshape(Basis,size(Basis,1)*size(Basis,2),size(Basis,3)*size(Basis,4));
X = reshape(D,size(D,1)*size(D,2),1);
a = floor((division+2)^.5); b = floor((division+2)/a)+1;
I = start_point:(end_point-start_point)/(division-1):end_point;
B = [];
for i = 1:size(I,2)
    B(i,:) = spg_bpdn(Bas,X,I(i), spgSetParms('verbosity',0));
    i
end
%
subplot(a,b,1)
imagesc(D)
title('Real field')
subplot(a,b,2)
for i = 1:size(B,2)
plot(I,B(:,i))
hold on;
end
hold off;
title('L1 regularization path')
for i = 1:size(I,2)
    subplot(a,b,i+2)
    imagesc(reshape(B(i,:),size(Basis,3),size(Basis,4))')
    title(num2str(I(i)))
end
%%
close
[J P] = deconvblind(D,ones(6));
J = edgetaper(J,P);
subplot(131)
imagesc(D)
title('Real field')
subplot(132)
imagesc(J)
title('Recoverd Field By Blind Deconvolution')
subplot(133)
imagesc(P)
title('Convolution')