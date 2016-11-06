function a = guassian(x,mu,sigma)
a = (1/(2*pi)).^.5*(1/sigma)*exp(-(x-mu).^2/(2*sigma^2));