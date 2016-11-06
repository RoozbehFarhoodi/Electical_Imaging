function [p,lambda] = Projection_vec(w,v)
lambda = ((v'*v)^(-1)*(v'*w));
p = w-v*lambda;