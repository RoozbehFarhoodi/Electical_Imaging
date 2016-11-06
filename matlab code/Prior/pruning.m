function image = pruning(image1,image2,dist,ratio,val)
V1 = bwconncomp(image1);
V1 = V1.PixelIdxList;
V2 = bwconncomp(image2);
V2 = V2.PixelIdxList;
r = zeros(1,length(V2));
for i = 1:length(V2)
    for j = 1:length(V1)
        [s1 k1] = ind2sub([300 300],V1{j});
        [s2 k2] = ind2sub([300 300],V2{i});
        if((mean(s1)-mean(s2)).^2+(mean(k1)-mean(k2)).^2<dist^2 && abs(mean(image1(V1{j}))/mean(image2(V2{i}))-1)<ratio)% && (image1(s(1),k(1))-image2(s1(1),k1(1)))<15)
            r(i) = 1;
        else
            if(abs(mean(image2(V2{i})))>val)
                r(i) = 1;
            end
        end
    end
end

image = zeros(300,300);
for i = find(r==1)
   for j = V2{i}
       image(j) = image2(j);
   end
end
