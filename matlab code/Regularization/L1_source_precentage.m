function [Source,lambda] = L1_source_precentage(data,X,Y,Forward,xcenter,ycenter,rcenter,precent,precent_confidence)
% type = 1 means that the convex problem is solving with the CVX program.
J = find((X-xcenter).^2+(Y-ycenter).^2<rcenter^2);
N = length(J);
%J = find(abs(X-xcenter)<rcenter & abs(Y-ycenter)<rcenter);
A = Forward;
lambda_down = 0;
lambda_up = 1000;
lambda = (lambda_down+lambda_up)/2;
t = 1;
p = 0;
Lam = [];
while(t == 1)
    lambda
    %[lambda_down,lambda_up]
    %p
    if(abs(p - precent)<precent_confidence)
        t = 2;
    else
        if(p<precent+.2+precent_confidence)
            [S,s] = L1_source(data,X,Y,A,xcenter,ycenter,rcenter,rcenter,lambda,2);
            n = length(find(S~=0));
            p = n/N;
            lambda = s;
        else
            [S,s] = L1_source(data,X,Y,A,xcenter,ycenter,rcenter,rcenter,lambda,4);
            n = length(find(S~=0));
            p = n/N;
            lambda = s;
        end
        
        if(p<precent-precent_confidence)
            lambda_up = lambda;
        else
            if(p>precent+precent_confidence)
                lambda_down = lambda;
            end
        end
        lambda_down = min(lambda_down,s);
        lambda_up = max(lambda_up,s);
        lambda = (lambda_down+4*lambda_up)/5;
    end
    Lam(end+1) = lambda;
    if(length(Lam)>16)
       if(abs(var(Lam(end-7:end))-var(Lam(end-15:end-8)))<.1)
           t=0;
       else
       end
    else
    end
end
p
Source = S;