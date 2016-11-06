%Draw_level_sets(data(:,:,71:end),23)
%Draw_level_sets(squeeze(mean(Data(1:30,:,71:end),1)),5,X,Y)
%Set = region_for_median(X,Y,30);
%filt = median_filter(squeeze(mean(Data(1:30,:,71:end),1)),Set);
Draw_level_sets2(squeeze(mean(Data(1:30,:,71:end),1)),20,X,Y,40)
%Draw_level_sets3(squeeze(mean(Data(1:30,:,72:end),1)),30,X,Y,40)
%% level set of simulated
load('/Users/RoozbehFarhoudi/Documents/Repos/electroimg/matfiles/NeuronStructure.mat');
[X,Y] = meshgrid(0:.05:1,0:.05:1);
X = reshape(X,1,441);
Y = reshape(Y,1,441);
D = evalpotential([X;Y;zeros(1,441)],[randn(1,1567);-(tree2.X'-75)/230;-(tree2.Y'-60)/140;(tree2.Z'-15)/600]);
Draw_level_sets(D',30,X,Y)
%% Connected Components
Draw_3d_level(data,.1,400)
%% Auto-Correlation Step 1
Dis = pdist([X;Y]');
s = 1;
Distance = zeros(size(X,2),size(X,2));
longDist = [];
for i = 1:size(X,2)
    longDist((i-1)*size(X,2)+1:size(X,2)*i) = [zeros(1,i),Dis(s:s+(size(X,2)-i-1))];
    s = s + (size(X,2)-i);
end
%% Step 2
C(1)=0;
Con(1) = 0;
count = 1;
for i = 0:.02:.400
    count = count +1
    I = find(abs(longDist-i)<.01);
    I1 = mod(I,size(X,2))+1;
    I2 = floor((I-1)/size(X,2))+1;
    cc = [];
    if(isempty(I)==1)
        C(count) = C(count-1);
        C(count) = 100;
    else
        for j = 31:100
            J = floor(rand(1,10000)*size(I,2))+1;
            ccc = corr([squeeze(mean(Data(1:30,I1(J),j),1));squeeze(mean(Data(1:30,I2(J),j),1))]');
            cc(j-29) = ccc(1,2);
            C(count) = mean(cc);
            %Con(count) = std(cc);
        end
    end
end
%% Step 3
in = [0:2:400];
inn = find(C~=100);
errorbar(in(inn(2:end-1)),C(inn(2:end-1)),Con(inn(2:end-1))/2)
hold on;
plot(in,zeros(size(in)),'r')
xlabel('Distance in mu (averaged over the pairs with distance in [x-1,x+1])')
ylabel('Correlation in the time 70:80 in data set=1')
%% To check that 'Autocorrelation between the sites with certin distance in the recording plane' can recover 'forward model'?
diag = [];
N = 10; %% number of neurons
depth = .25;
d1 = 110; % planar resulotion (x)
d2 = 102; % planar resulotion (y)
[Xsim,Ysim,Zsim] = meshgrid(0:1/(d1-1):1,0:1/(d2-1):1,0);
d = d1*d2;
Xsim = reshape(Xsim,1,d);
Ysim = reshape(Ysim,1,d);
Zsim = reshape(Zsim,1,d);
mesh = [Xsim;Ysim;Zsim];
Dis = pdist([Xsim;Ysim]');
s = 1;
Distance = zeros(size(Xsim,2),size(Xsim,2));
longDist = [];
for i = 1:size(Xsim,2)
    longDist((i-1)*size(Xsim,2)+1:size(Xsim,2)*i) = [zeros(1,i),Dis(s:s+(size(Xsim,2)-i-1))];
    s = s + (size(Xsim,2)-i);
end
Int = 0.01:.01:1.2;
for ii = 1:4
    ii
    neuron_data = rand(4,N);
    neuron_data(4,:) = depth*rand(1,N);
    neuron_data(1,:) = randn(1,N);
    D = evalpotential(mesh,neuron_data);
    C = [];C(1)=0;
    count = 1;
    for i = Int
        count = count +1;
        I = find(abs(longDist-i)<.005);
        I1 = mod(I,size(Xsim,2))+1;
        I2 = floor((I-1)/size(Xsim,2))+1;
        cc = [];
        if(isempty(I)==1)
            C(count) = C(count-1);
        else
            J = floor(rand(1,10000)*size(I,2))+1;
            ccc = corr([D(I1(J));D(I2(J))]');
            C(count) = ccc(1,2);
        end
    end
    diag(ii,:) = C;
end
diag = diag(:,2:end);
% Ploting
errorbar(Int,mean(diag),std(diag)/2)
hold on;
%plot(Int,-.2*cos(50*(depth^2+Int.^2).^.5).*(depth^2+Int.^2).^-.5,'--','Color','c')
%plot(Int,(depth^2+[Int].^2).^-.5-.1*(depth^2+Int.^2).^-1,'--','Color','c')
%plot(Int,.3*evalpotential(Int,[1;0;0;depth]),'--','Color','k')
plot(Int,zeros(size(Int)),'r')
legend('autocorrelation','Real field (Heaviside)')
xlabel('Distance')