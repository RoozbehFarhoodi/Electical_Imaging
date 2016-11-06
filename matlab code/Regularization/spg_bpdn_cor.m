function [x,s] = spg_bpdn_cor(A,b,sigma)
opts = spgSetParms('verbosity',0,'weights',eye(1));
x = spg_bpdn(A,b,sigma, opts);
si = [];
m = [];
for i = 1:3
    si(i) = sigma + .5*rand;
    m(i) = length(find(spg_bpdn(A,b,si(i), opts)~=0));
end
n = length(find(x~=0));
p = n/min(m);
if(abs(p-1)<.1)
    s = sigma;
else
    for i = 4:6
        si(i) = sigma + 1*rand;
        m(i) = length(find(spg_bpdn(A,b,si(i), opts)~=0));
    end
    [a,c] = min(m);
    s = si(c);
    x = spg_bpdn(A,b,si(c), opts);
end
%si
%m
