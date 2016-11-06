function Ce = peaksy(image,step)
Ce = cell(1);
C = bwconncomp((image>step));
C1 = C.PixelIdxList;
for j = 1: length(C1)
    if( length(C1{j})<20)
        Ce(end+1) = C1(j);
    else
        n = size(image,1);
        m = size(image,2);
        A = zeros(n,m);
        A(C1{j}) = image(C1{j});
        S = peaksy(A,step+1);
        if(length(S)==1 && isempty(S{1}))
            Ce(end+1) = C1(j);
        else
            Ce(end+1:end+length(S))=S;
        end
    end
end