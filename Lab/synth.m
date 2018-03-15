function [xrec] = synth(C,basis)
%This function returns the synthesis of a vector given a base and the
%coefficients.
xrec=zeros(size(C));
    for i=1:length(basis(1,:))
        xrec(:,i)=C(1,i)*[basis(1,i) basis(2,i)]+C(2,i)*[basis(3,i) basis(4,i)];
    end
end