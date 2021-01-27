function U=simple(T,dt,init,v_maxes,vit)
x=zeros(T,length(init)); v=x;
y=zeros(T,length(init)-1);
c=linspace(1,2,length(init));
x(1,:)=init;
v(:,length(init))=v_maxes(1,length(init));
for t=2:T
    disp(x(t-1,:))
    if sort(x(t-1,:))==x(t-1,:)
      xn=ones(2,length(init));
      xn(1,:)=x(t-1,:);
      figure(2)
      scatter(xn(1,:),xn(2,:),[],c,'filled')
      pause(0.001)
      x(t,:)=v(t-1,:)*dt+x(t-1,:);    %position 
  
      for i=1:length(init)-1
          y(t,i)=x(t,i+1)-x(t,i);    %la distance
      end
      if vit == @Vop
        vop=vit(y(t,:),v_maxes);
      elseif vit==@Vop1
        vop=vit(y(t,:),v_maxes);
      elseif vit==@Vop2
        lbd=zeros(1,length(init));
        d=lbd;
        for i=1:length(init)
          lbd(i)=1/(x(i)+1);
          d(i)=1/v_maxes(i);
        end 
        vop=vit(y(t,:),v_maxes,lbd,d);
      end
      v(t,1:length(init)-1)=vop; 
     %vop est la vitesse obtenue par G, ici j'ai fait juste un cas simple, cad G le seuil Vmax,0,Vmax/2
   else
     disp("On a un accident")
      return
   end
end                                              
%vous pouvez changer vop dessus a a*(vop-v(t-1,1:3))*T+v(t-1,1:3), le
%dessin devient plus beau mdr

figure(3)
plot(x(:,length(init)),(v(:,length(init)))','b--',x(:,length(init)-1),(v(:,length(init)-1))','r--',x(:,length(init)-2),(v(:,length(init)-2))','g-.',x(:,1),(v(:,1))','y-.')
#set(gca,'ylim',[10 25],'ytick',[10 15 20 25],'xlim',[0 15],'xtick',[0 15])
xlabel('position'); ylabel('vitesse');
legend('vitesse de 1','vitesse de 2','vitesse de 3','vitesse de 4')
figure(2)
time=1:T;
plot(time,(v(:,length(init)))','b--',time,(v(:,length(init)-1))','r--',time,(v(:,length(init)-2))','g-.',time,(v(:,1))','y-.')
end