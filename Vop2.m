function [vop_n]=Vop(y_n,v_max,lambda,d)
vop_n=[];
[m,n]=size(y_n);
for j=1:n
   if y_n(j)>=d
   vop_n(j)=v_max(j)*(1-exp((-lambda(j)/v_max(j))*(y_n(j)-d(j))));
 else 
   vop_n(j)=0;
 end
 
end