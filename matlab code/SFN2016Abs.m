function SFN2016Abs(data,X,Y,Forward,time,lambda,xcenter,ycenter,rcenter)

J = find((X-xcenter).^2+(Y-ycenter).^2<rcenter^2);
count = 1;
for i = time
    opts = spgSetParms('verbosity',0,'weights',eye(1));
    B(:,count) = spg_bpdn(Forward(J,J), data(J,i), lambda(count), opts);
    count = count + 1;
end
a = length(time);
b = 4;
for i = 1:length(time)
    subplot(a,b,4*i-3)
    trisurf(delaunay(X(J),Y(J)), X(J), Y(J), squeeze(data(J,time(i))),'edgeColor','none');
    axis([min(X(J)) max(X(J)) min(Y(J)) max(Y(J)) -100 100]);
    caxis([-200 100]);
    view([0,0,1])
    axis equal
    %title('Whole Field')
    axis off
    
    subplot(a,b,4*i-2)
    trisurf(delaunay(X(J),Y(J)),X(J),Y(J),squeeze(B(:,i)),'edgeColor','none');
    caxis([-200 100])
    axis equal
    view([0,0,1])
    axis off
    
    subplot(a,b,4*i-1)
    I1 = max(0,squeeze(B(:,i)));
    if (i ==1)
        J1 = find((X(J)-900).^2+(Y(J)-1000).^2>150^2);
        I1(J1) = 0;
    else
        if(i==2)
            J1 = find((X(J)-900).^2+(Y(J)-960).^2>150^2);
            I1(J1) = 0;
        else
            if(i==3)
                J1 = find((X(J)-900).^2+(Y(J)-900).^2>150^2);
                I1(J1) = 0;
            else
                if(i==4)
                    J1 = find((X(J)-900).^2+(Y(J)-900).^2>150^2);
                    I1(J1) = 0;
                end
                if(i==5)
                    J1 = find((X(J)-900).^2+(Y(J)-900).^2>150^2);
                    I1(J1) = 0;
                end
            end
        end
    end
    trisurf(delaunay(X(J),Y(J)),X(J),Y(J),I1,'edgeColor','none');
    caxis([-200 100])
    axis equal
    view([0,0,1])
    axis off
    
    subplot(a,b,4*i)
    I1 = min(squeeze(B(:,i)),0);
    if (i ==1)
        J1 = find((X(J)-1100).^2+(Y(J)-1150).^2>75^2);
        I1(J1) = 0;
    else
        if(i==2)
            J1 = find((X(J)-1050).^2+(Y(J)-1050).^2>50^2);
            I1(J1) = 0;
        else
            if(i==3)
                J1 = find((X(J)-1050).^2+(Y(J)-1050).^2>50^2);
                I1(J1) = 0;
            else
                if(i==4)
                    J1 = find((X(J)-1050).^2+(Y(J)-1050).^2>50^2);
                    I1(J1) = 0;
                end
                if(i==5)
                    J1 = find((X(J)-1120).^2+(Y(J)-1050).^2>85^2);
                    I1(J1) = 0;
                end
            end
        end
    end
    trisurf(delaunay(X(J),Y(J)),X(J),Y(J),I1,'edgeColor','none');
    caxis([-200 100])
    axis equal
    view([0,0,1])
    axis off
    
end