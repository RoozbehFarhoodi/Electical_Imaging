function C = graph2chain(Graph,D)
if(sum(sum(Graph))==0)
    Cc = cell(1);
else
    
    n = size(Graph,1);
    V = zeros(1,n);
    for i = 1:n
        I = find(Graph(i,:)~=0);
        if(D(i,4)<=min(D(I,4)))
            V(i) = 1;
        end
    end
    I = find(V==1);
    Cc = cell(1,length(I));
    count1 = 1;
    List = [];
    for i =I
        J = find(Graph(:,i)~=0);
        A = cell(1,size(J,1));
        M = zeros(1,size(J,1));
        count = 1;
        for j = J'
            x = i;
            y = j;
            T = [x y];
            while(y~=0)
                y = CountinChain(Graph,D,T(end-1),T(end));
                if(y~=0)
                    T(end+1) = y;
                end
            end
            A{count} = T;
            M(count) = length(T);
        end
        [a b] = max(M);
        Cc{count1} = A{b};
        List = [List A{b}];
        count1 = count1 + 1;
    end
    List = unique(List);
    com_list = [];
    for i = 1:n
        if(length(find(List==i))==0)
            com_list(end+1) = i;
        end
    end
    if(length(com_list)~=0)
        C2 = graph2chain(Graph(com_list,com_list),D(com_list,:));
        if(length(C2{1})~=0)
            Cc(end+1:end+length(C2)) = C2;
        end
    end
end

C = cell(1,length(Cc));
L = [];
for i = 1:length(Cc)
    L(i) = length(find(Cc{i}));
end
[I J] = sort(L);
count = 1;
for i = J
    C{count} = Cc{i};
    count = count +1;
end