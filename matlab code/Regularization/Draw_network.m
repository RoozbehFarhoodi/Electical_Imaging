function Draw_network(X,Y,Dots,Connection)
h = figure('units','normalized','outerposition',[0 0 1 1]);
t = length(Dots);
for i = 1:t
    D = Dots{i};
    abs(squeeze(D(3,:)));
    %scatter(squeeze(D(1,:)),squeeze(D(2,:)),ones(1,length(D)),'filled')
    scatter(squeeze(D(1,:)),squeeze(D(2,:)),abs(squeeze(D(3,:))).^.5,'filled')
    hold on
    if(i>1)
        A = Connection{i-1};
        D1 = Dots{i-1};
        D2 = Dots{i};
        I = find(A~=0);
        [J1 J2] = ind2sub(size(A),I);
        for j = 1:length(I)
            hold on
            plot([D1(1,J1(j)),D2(1,J2(j))],[D1(2,J1(j)),D2(2,J2(j))])
        end
    else
    end
    pause;
end

