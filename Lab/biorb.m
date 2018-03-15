function [F] = biorb(e1, e2)
%This function returns a biorthogonal basis from the given vectors e1, e2.
%The result satisfy the conditions on the scalar products <ei,fj>=1 for all
%i=j and zero otherwise.
A=[e1(1) e1(2); e2(1) e2(2)];
B=[e2(1) e2(2); e1(1) e1(2)];
C=[1;0];
F=[A\C; B\C];
end