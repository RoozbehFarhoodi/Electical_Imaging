function post = EM(x,prior)
p = prior{1};
mu = prior{2};
sigma = prior{3};
weigth = bayes_gussian(x,p,mu,sigma);
N = sum(weigth');
P = N/sum(N);
weight*x'

