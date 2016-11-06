function [B,s] = L1_source(data,X,Y,A,xcenter,ycenter,rcenter_x,rcenter_y,Index,type)
% type = 1 means that the convex problem is solving with the CVX program.
J = find((X-xcenter).^2+(Y-ycenter).^2<rcenter_x^2);
%J = find(abs(X-xcenter)<rcenter_x & abs(Y-ycenter)<rcenter_y);
B = [];
count = 1;
[a1 b1] = size(A);
if(a1==length(X) && b1 == length(Y))
    F = A(J,J);
    ty = 1;
else
    if(a1>b1)
        q = floor(a1/b1);
        F = A';
        ty = 2;
    else
        q = floor(b1/a1);
        F = A;
        ty = 3;
    end
end
for i = Index
    % CVX
    switch(type)
        case 1
            n = length(J);
            cvx_begin quiet
            variable x(n)
            minimize( norm( x, 1 ))
            subject to
            % norm( A(J,J) * x - data(J)', 2 ) <= norm(data(J))*i
            norm( F * x - data(J)', 2 ) <= i
            cvx_end
            B(:,count) = x';
            s = Index
        case 2
            % BDNP
            [B(:,count),s] = spg_bpdn_cor(F, data(J)', i);
            % LASSO
        case 3
            [b,s] = spg_bpdn_cor(F, data(J)', i);
            c = find(b~=0);
            m = length(c);
            switch ty
                case 1
                    F2 = A(J,J(c));
                case 2
                    F2 = A(c,c)';
                case 3
                    
                    F2 = A(c,c);
            end
            d = spg_bpdn_cor(F2, data(J)', i);
            B(:,count) = zeros(length(J),1);
            B(c,count) = d;
        case 4
            opts = spgSetParms('verbosity',0,'weights',eye(1));
            % B(:,count) = spg_bpdn(A(J,J), data(J)', norm(data(J))*i, opts);
            
            [b,s] = spg_bpdn_cor(A(J,J), data(J)', i);
            c = find(b~=0);
            if(isempty(c))
                1
                B(:,count) = zeros(length(J),1);
            else
                n = length(c);
                switch ty
                    case 1
                        F2 = A(J,J(c));
                    case 2
                        F2 = A(c,J)';
                    case 3
                        
                        F2 = A(J,c);
                end
                cvx_begin quiet
                variable d(n)
                minimize( norm( d, 1 ))
                subject to
                % norm( A(J,J) * x - data(J)', 2 ) <= norm(data(J))*i
                norm( F2 * d - data(J)', 2 ) <= i
                cvx_end
                B(:,count) = zeros(length(J),1);
                B(c,count) = d;
            end
        case 5
            opts = spgSetParms('verbosity',0,'weights',eye(1));
            s = i;
            size(data(J)');
            [b,s2] = spg_bpdn(F, data(J)', i,opts);
            B(:,count) = b;
            
    end
    % B(:,count) = spg_lasso(A(J,J), data(J)', norm(data(J))*i, opts);
    %C(:,count) = A(J,J)*B(:,count);
    %count = count +1;
    %(count-1)/length(Index);
    
end