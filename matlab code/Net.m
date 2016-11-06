function A = Net(X,Y,Sources,dist,th_dist,th_value)
for i = 1:size(Sources,1)-1
    R1 = squeeze(Sources(i,:))'*ones(1,length(X));
    R2 = ones(length(X),1)*squeeze(Sources(i+1,:));
    R = abs(R1-R2);
    A(i,:,:) = heaviside(th_dist-dist).*heaviside(th_value-R).*(2*heaviside(R1)-1).*(2*heaviside(R2)-1);
end