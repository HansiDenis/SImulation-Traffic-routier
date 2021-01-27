%La fonction G, ici c'est un seuil
function [vop_n]=Vop1(y_n,v_max)
vop_n=[];
[m,n]=size(y_n);
for j=1:n
    if y_n(1,j)>0
        H=3;
    elseif y_n(1,j)<0.1
        H=-1;
    else
        H=0;
    end
    vop_n(1,j)=v_max(1,j)*(1+H)/2;
end