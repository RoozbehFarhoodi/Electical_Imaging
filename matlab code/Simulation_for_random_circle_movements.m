%% Simulation for random circle movements
data_sim_cir = zeros(300,size(X,2));
num_comlpx = 12;
vel = 30;
t = 300;
for i = 1:180
    i
    st = floor(rand*size(X,2))+1;
    ed = floor(rand*size(X,2))+1;
    ti = floor(t*rand)+1;
    val = randn;
    val = (1-2*floor(2*rand))*200^rand;
    r = 40*rand;
    Dis_from_cent = 1.5*rand(1,num_comlpx);
    a = rand(1,num_comlpx);
    xpoint = sin(a*2*pi);
    ypoint = cos(a*2*pi);
    ratio_cir = 1.3*rand(1,num_comlpx);
    effect = 1-2*floor(2*rand(1,num_comlpx));
    for j = 1:vel
        r = max(0,r+randn*7);
        x = (j/vel)*X(st)+((vel-j)/vel)*X(ed);
        y = (j/vel)*Y(st)+((vel-j)/vel)*Y(ed);
        I = find((X-x).^2+(Y-y).^2<r^2);
        data_sim_cir(min(t,ti+j),I) = data_sim_cir(min(t,ti+j),I) + val;
        for k = 1:num_comlpx
            x1 = x + Dis_from_cent(k)*r*xpoint(k);
            y1 = y + Dis_from_cent(k)*r*ypoint(k);
            I = [I,find((X-x1).^2+(Y-y1).^2<(r*ratio_cir(k))^2)];
            data_sim_cir(min(t,ti+j),I) = data_sim_cir(min(t,ti+j),I) + .5*effect(k)*val;
        end
        %I = unique(I);
        %data_sim_cir(min(t,ti+j),I) = data_sim_cir(min(t,ti+j),I) + val;
    end
end
data_sim_cir = data_sim_cir + .7*std(data_sim_cir(floor(t/2),:))*randn(t,size(X,2));
%% plot on triangulation
close
tri = delaunay(X,Y);
for i = 150:299
    i
    trisurf(tri, X, Y,data_sim_cir(i,:),'edgeColor','none');
    axis([min(X) max(X) min(Y) max(Y) min(data_sim_cir(i,:)) max(data_sim_cir(i,:))]);
    view([0,0,1])
    pause
end