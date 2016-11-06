function [B,Big_A] = L1_source_L2_time(data,X,Y,Forward,xcenter,ycenter,rcenter_x,rcenter_y,Index,num_frame,lambda,neighber_size)
opts = spgSetParms('verbosity',0);
%J = find((X-xcenter).^2+(Y-ycenter).^2<rcenter^2);
J = find(abs(X-xcenter)<rcenter_x & abs(Y-ycenter)<rcenter_y);
l = length(J);
t = size(data,2);

Dis = pdist([X(J);Y(J)]');
s = 1;
Distance = zeros(l);
for i = 1:l
    Distance(i,(i+1):l) = Dis(s:(s+l-i-1));
    s = s + (l-i);
end
Distance = Distance + Distance';
D = heaviside(-Distance+neighber_size);

Big_A = zeros(2*num_frame*l,num_frame*l);
for i = 1:num_frame
    Big_A(1+(i-1)*l:i*l,1+(i-1)*l:i*l) =  Forward(J,J);
end

for i = 1:num_frame-1
    Big_A(1+(num_frame+i-1)*l:(num_frame+i)*l,1+i*l:(i+1)*l) =  (lambda^2)*D;
end

B = [];
for j = 1:t-num_frame+1
    S = reshape(data(J,j:j+num_frame-1),num_frame*l,1);
    S = [S;zeros(num_frame*l,1)];
    count = 1;
    for i = Index
        B(:,j,count) = spg_bpdn(Big_A, S, norm(S)*i, opts);
        count = count +1;
        (length(Index)*(j-1)+count-1)/((t-num_frame+1)*length(Index))
    end
end