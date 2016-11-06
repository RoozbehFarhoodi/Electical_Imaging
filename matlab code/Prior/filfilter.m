function B3 = filfilter(data)
B3 = zeros(300,300);
F = max(0,squeeze(data));
CC = bwconncomp((F~=0));
C1 = CC.PixelIdxList;
L = 0;
M = 0;
for j = 1: length(C1)
    L(j) = length(C1{j});
    M(j) = max(F(C1{j}));
end
I2 = sort(L);
a = I2(end-10);
I3 = sort(M);
b = I3(end-10);
Is = [];
for  j = 1:length(C1)
    if(L(j)>a || M(j)>b)
        Is(end+1) = j;
    else
    end
end
for ss = 1:length(Is)
    B = zeros(300,300);
B(C1{Is(ss)}) = F(C1{Is(ss)});
Ce = peaksy(B,0);
Cee = cell(1);
for i = 1:length(Ce)
    if(isempty(Ce{i}))
    else
        Cee(end+1) = Ce(i);
    end
end
B2 = zeros(300,300);
for i = 1:length(Cee)
B2(Cee{i}) = data(Cee{i});
end
B3 = B3 + B2;
end



F = -min(0,squeeze(data));
CC = bwconncomp((F~=0));
C1 = CC.PixelIdxList;
L = 0;
M = 0;
for j = 1: length(C1)
    L(j) = length(C1{j});
    M(j) = max(F(C1{j}));
end

I2 = sort(L);
a = I2(end-10);
I3 = sort(M);
b = I3(end-10);
Is = [];
for  j = 1:length(C1)
    if(L(j)>a || M(j)>b)
        Is(end+1) = j;
    else
    end
end

for ss = 1:length(Is)
    B = zeros(300,300);
B(C1{Is(ss)}) = F(C1{Is(ss)});
Ce = peaksy(B,0);
Cee = cell(1);
for i = 1:length(Ce)
    if(isempty(Ce{i}))
    else
        Cee(end+1) = Ce(i);
    end
end
B2 = zeros(300,300);
for i = 1:length(Cee)
B2(Cee{i}) = data(Cee{i});
end
B3 = B3 + B2;
end