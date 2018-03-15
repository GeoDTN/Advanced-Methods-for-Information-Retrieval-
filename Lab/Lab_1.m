%ADVANCED METHODS FOR INFORMATION REPRESENTATION
%Lab_1

clear all;
close all;
clc;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%1)Given two vectors in R^2, e1=[e1x e1y]' and e2=[e2x e2y]' find the dual 
%basis f1=[f1x f1y]' and f2=[f2x f2y]'.
%The biorthogonal basis must satisfy the following conditions:
%
%1) <e1,f1>=[e1x e1y]'*[f1x f1y]=1
%2) <e2,f1>=[e2x e2y]'*[f1x f1y]=0
%3) <e2,f2>=[e2x e2y]'*[f2x f2y]=1
%4) <e1,f2>=[e1x e1y]'*[f2x f2y]=0
%
%Solving the system composed by 1) and 2) i obtain f1:
% e1x*f1x+e1y*f1y=1
% e2x*f1x+e2y*f1y=0
% A*f1=C
%
%Solving 3) and 4) i obtain f2:
%
% e2x*f2x+e2y*f2y=1
% e1x*f2x+e1y*f2y=0
% B*f2=C

%Given base:
e1=[1;0];
e2=[1/2;1];

%Coefficients of the systems:
A=[e1(1) e1(2); e2(1) e2(2)];
B=[e2(1) e2(2); e1(1) e1(2)];
C=[1;0];

%Biorthogonal base:
f1=A\C;
f2=B\C;



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%2)If N>=3 i have to evaluate more conditions, in case of N=3 i have nine
%equations:
%
% e1x*f1x+e1y*f1y+e1z*f1z=1
% e2x*f1x+e2y*f1y+e2z*f1z=0
% e3x*f1x+e3y*f1y+e3z*f1z=0
% A*f1=D
% 
% e2x*f2x+e2y*f2y+e2z*f2z=1
% e1x*f2x+e1y*f2y+e1z*f2z=0
% e3x*f2x+e3y*f2y+e3z*f2z=0
% B*f2=D
%
% e3x*f3x+e3y*f3y+e3z*f3z=1
% e1x*f3x+e1y*f3y+e1z*f3z=0
% e2x*f3x+e2y*f3y+e2z*f3z=0
% C*f2=D

e1=[1;0;0];
e2=[1/2;1;0];
e3=[0;1/2;1];

A=[e1(1) e1(2) e1(3); e2(1) e2(2) e2(3); e3(1) e3(2) e3(3)];
B=[e2(1) e2(2) e2(3); e1(1) e1(2) e1(3); e3(1) e3(2) e3(3)];
C=[e3(1) e3(2) e3(3); e1(1) e1(2) e1(3); e2(1) e2(2) e2(3)];
D=[1;0;0];

f1_1=A\D;
f2_1=B\D;
f3_1=C\D;

%Note: the method is working properly, in fact it satisfies <ei,yj>=1 for
%all i=j and zero otherwise! For higher N i have to iterate the same 
%procedure.



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%3)The analysis consists of determining the coordinate coefficients a of 
%the vector x given the basis y1,y2,...

x=[1/4;1/2];
y1=[1;0];
y2=[0;1];
G=[y1'*y1 y2'*y1; y1'*y2 y2'*y2];
T=[x'*y1;x'*y2];
a=G\T;



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%4)The synthesis consists of determining the vector x given the 
%coefficients c1,c2,... and the basis y1,y1,...

c=[1;1];
y1=[1;0];
y2=[1/2; 1];
x=c(1)*y1+c(2)*y2;



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%5)Uniform quantizer with parameters Nlevels, and bounds +-ext

t=0:0.01:1;
s=sin(2*pi*2*t);
Nlevels=8;
ext=1;
Yq=round(s/ext*(Nlevels/2))/(Nlevels/2)*ext;
set=find(abs(Yq)>ext);
Yq(set)=ext*sign(Yq(set));
figure; plot(t,s); hold on; stem(t,Yq,'r'); title('Effect of quantization over a sinusoid');



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%6)100 random values from the normal distribution with mean=0 and var=10
X1=random('norm',0,10,[100 2])';



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%7)100 random values from the uniform distribution with mean=0 and var=1
X2=random('norm',0,1,[100 4])';



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%8)

%Find the dual basis for the random vectors contained in X2:
DUAL=zeros(size(X2));
for i=1:length(X2)
    DUAL(:,i)=biorb([X2(1,i) X2(2,i)],[X2(3,i) X2(4,i)]);
end

%Compute the analysis of the dual basis:
for i=1:length(X2)
    a=[DUAL(1,i);DUAL(2,i)];
    b=[DUAL(3,i);DUAL(4,i)];
    c(:,i)=analysis(X1(:,i),[a b]); 
end

%Quantize the dual basis coefficients with 16 levels and range 
%abs(max(min(c),max(c))):
ext=max(max(abs(c)));
C=zeros(size(c));
for i=1:length(c)
   C(:,i)=quantizer(c(:,i),16,ext); 
end



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%9)

%Reconstructed vector:
xrec=synth(C,X2);

%Reconstruction error:
error=zeros(1,length(xrec));
for i=1:length(X2)
    error(i)=norm((X1(:,i)-xrec(:,i)).^2,2);
end



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%10)Repeat 9) for each x

E=zeros(size(X2));
for i=1:length(X2)
    for j=1:length(X2)
        E(i,j)=norm((X1(:,i)-xrec(:,j)),2)^2;
    end
end



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%11)

figure; surf(E); shading('interp'); xlabel('x-xrec'); ylabel('x-xrec'); zlabel('error');
title('Square norm of the errors');

%Note: from the graph i can see that higher the error higher is the
%distance between the signals x and the reconstructed ones, where
%the error is low menas instead that the two signals are close.