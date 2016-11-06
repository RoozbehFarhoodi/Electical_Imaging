function [B,C] = L1_source_whole(data,X,Y,A,proposed,Index,type)

B = [];
count = 1;
for i = Index
    % CVX
    if(type==1)
        n = length(proposed);
        cvx_begin quiet
        variable x(n)
        minimize( norm( x, 1 ))
        subject to
        % norm( A(J,J) * x - data(J)', 2 ) <= norm(data(J))*i
        norm( A(proposed,proposed) * x - data(proposed)', 2 ) <= i
        cvx_end
        B(:,count) = x';
    else
        % BDNP
        opts = spgSetParms('verbosity',0,'weights',eye(1));
        B(:,count) = spg_bpdn(A(proposed,proposed), data(proposed)', norm(data(proposed))*i, opts);
        % B(:,count) = spg_bpdn(A(J,J), data(J)', i, opts);
        % LASSO
    end
    % B(:,count) = spg_lasso(A(J,J), data(J)', norm(data(J))*i, opts);
    C(:,count) = A(J,J)*B(:,count);
    count = count +1;
    (count-1)/length(Index);
    
end