function [X,Y,Data,A] = read_CMOS(data) 
X = data.x;
Y = data.y;
Data = data.raw;
A = data.ave;
I = [find(X==0),find(Y ==-1)];
X(I) = [];
Y(I) = [];
A(I,:) = [];
Data(:,I,:) = [];