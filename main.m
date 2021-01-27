L=1; %rayon du grand rond point
T=200;
dt=0.1; 
v_maxes=[0.1 0.1 0.1 0.1 0.1]; 
x=0:0.2:0.8;   %position initiale
perio(T,dt,L,x,v_maxes,@Vop1,"c")
%a=2; 
dt=0.1; 
v(:,4)=20;%vitesse initiale de la premiere voiture , vmax
v_maxes=[10 10 10 10]; 
x=[1,2,3,4];   %position initiale
%y, je l'ai cree pour montrer les distances entre les voiture,qui esr assez utile pour calculer la fonction G
simple(100,0.1,x,v_maxes,@Vop1)

