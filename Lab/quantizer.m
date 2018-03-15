function [Yq] = quantizer(Y,Nlevels,ext)
%This function returns the quantized version of the vector Y over Nlevels
%and in the range +ext/-ext.
Yq=round(Y/ext*(Nlevels/2))/(Nlevels/2)*ext;
set=find(abs(Yq)>ext);
Yq(set)=ext*sign(Yq(set));
end