function [F,D] = Unit_pos(Forward,J)

%F = Forward(J,J)./(ones(length(J),1)*(sum(Forward(J,J).^2,1).^.5));
F = Forward./(ones(length(J),1)*(sum(Forward.^2,1).^.5));
D = F'*F;