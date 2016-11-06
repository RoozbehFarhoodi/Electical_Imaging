function weigth = bayes_gussian(x,p,mu,sigma)
% posterior is a matrix of k*N where and x is m*N
% Where N is the number of samples and m is dimentionality
% and k is the number of mixture
% mu is m*k and sigma is m*m*k
m = size(x,1);
N = size(x,2);
k = length(p);

weigth = zeros(k,N);
a = zeros(k,N);
for i = 1:k
    b = squeeze(sigma(:,:,i));
   a(i,:) = p(i)*mvnpdf(x',mu(:,i)',b)';
end
weigth = a./(ones(k,1)*sum(a));