function [B,s] = L1_source_depth(data,X,Y,A,xcenter,ycenter,rcenter,Index,type)

% type = 1 means that the convex problem is solving with the CVX program.
J = find((X-xcenter).^2+(Y-ycenter).^2<rcenter^2);
%J = find(abs(X-xcenter)<rcenter_x & abs(Y-ycenter)<rcenter_y);
B = [];
count = 1;
n = length(J);
if(ndims(A)==2)
    q = 1;
    [a b] = size(A);
    if(a==length(X) && b == length(Y))
        F = A(J,J);
        ty = 1;
    else
        if(a>b)
            q = floor(a/b);
            F = A';
            ty = 2;
        else
            q = floor(b/a);
            F = A;
            ty = 3;
        end
    end
else
    q = size(A,3);
    if(size(A,1)==length(X))
        F = reshape(A(J,J,:),[n,n*q]);
        ty = 4;
    else
        F = reshape(A,[n,n*q]);
        ty = 5;
    end
end


for i = Index
    % CVX
    switch type
        case 1
            cvx_begin quiet
            variable x(n)
            minimize(norm(x,1))
            subject to
            norm( F * x - data(J)', 2 ) <= i
            cvx_end
            B(:,count) = x';
            s = Index;
        case 2
            % BDNP
            % [B(:,count),s] = spg_bpdn_cor(F, data(J)', i);
            % opts = spgSetParms('verbosity',0,'weights',eye(1));
            B(:,count) = spg_bpdn_cor(F, data(J)', i);
            s = 1;
            % LASSO
        case 3
            [b,s] = spg_bpdn_cor(F, data(J)', i);
            c = find(b~=0);
            m = length(c);
            switch ty
                case 1
                    F2 = A(J,J(c));
                case 2
                    I2 = [1:q]'*c;
                    F2 = A(I2,c)';
                case 3
                    I2 = [1:q]'*c;
                    F2 = A(c,I2);
                case 4
                    F2 = reshape(A(J(c),J(c),:),[m,m*q]);
                case 5
                    F2 = reshape(A(c,c,:),[m,m*q]);
            end
            d = spg_bpdn_cor(F2, data(J)', i);
            B(:,count) = zeros(length(J),1);
            B(c,count) = d;
        otherwise
            opts = spgSetParms('verbosity',0,'weights',eye(1));
            % B(:,count) = spg_bpdn(A(J,J), data(J)', norm(data(J))*i, opts);
            
            [b,s] = spg_bpdn_cor(F, data(J)', i);
            c = find(b~=0);
            m = length(c);
            switch ty
                case 1
                    F2 = A(J,J(c));
                case 2
                    I2 = [1:q]'*c;
                    F2 = A(I2,c)';
                case 3
                    I2 = [1:q]'*c;
                    F2 = A(c,I2);
                case 4
                    F2 = reshape(A(J(c),J(c),:),[m,m*q]);
                case 5
                    F2 = reshape(A(c,c,:),[m,m*q]);
            end
            cvx_begin quiet
            variable d(m)
            minimize( norm( d, 1 ))
            subject to
            % norm( A(J,J) * x - data(J)', 2 ) <= norm(data(J))*i
            norm( F2 * d - data(J)', 2 ) <= i
            cvx_end
            B(:,count) = zeros(length(J),1);
            B(c,count) = d;
    end
    
    % B(:,count) = spg_lasso(A(J,J), data(J)', norm(data(J))*i, opts);
    %C(:,count) = A(J,J)*B(:,count);
    count = count +1;
    (count-1)/length(Index);
    
    
end