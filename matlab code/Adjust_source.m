function A = Adjust_source(X,Y,Data,points)
fun = @(x) (evalpotential([X;Y;zeros(1,length(X))],x)-Data).^2;
A = fsolve(fun,points');