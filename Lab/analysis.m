function [c] = analysis(x, Y)
%This function determine the coordinate coefficients c of the vector x given
%the basis y1,y2,... stored in Y=[y1 y2 ...] where:
%c=G^-1*T
%G=[<y1,y1> <y2,y1> ... <yn,y1>; <y1,y2> <y2,y2> ... <yn,y2>; ...; <y1,yn> <y2,yn> ... <yn,yn>]
%T=[<x,y1>; <x,y2>; ...; <x,yn>]
G=zeros(size(Y));
T=zeros(size(Y(:,1)));
for i=1:length(Y)
    for j=1:length(Y)
        G(i,j)=Y(:,j)'*Y(:,i); 
    end
        T(i,:)=x'*Y(:,i); 
end
    c=G\T;
end