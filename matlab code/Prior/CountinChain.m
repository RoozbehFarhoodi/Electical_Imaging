function z = CountinChain(Graph,D,x,y)
S = find(D(:,4)>D(y,4));
I = find(Graph(y,S)~=0);
if(length(I) == 0)
    z = 0;
else
    I = S(I);
    eror= [];
    v1 = (D(y,1)-D(x,1))/(D(y,4)-D(x,4));
    v2 = (D(y,2)-D(x,2))/(D(y,4)-D(x,4));
    for j = I'
        t1 = (D(j,1)-D(y,1))/(D(j,4)-D(y,4));
        t2 = (D(j,2)-D(y,2))/(D(j,4)-D(y,4));
        eror(end+1) = (v1-t1)^2+(v2-t2)^2;
    end
    [a b] = min(eror);
    z = I(b);
end