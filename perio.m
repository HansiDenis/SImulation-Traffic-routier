function U=perio(T,dt,L,init,v_maxes,vit,scheme)
x=zeros(T,length(init)); v=x;y=x;
c=linspace(1,2,length(init));
x(1,:)=init;
v(:,length(init))=v_maxes(1,length(init));

for t=2:T
    disp(x(t-1,:))
    if sort(x(t-1,:))==x(t-1,:)
      xn=x(t-1,:);
      figure(5)
      if scheme=='c'
        scatter(cos(2*pi*xn),sin(2*pi*xn),[],c,'filled')
      else
        scatter(xn,ones(1,length(init)))
      end
      set(gca,'ylim',[-1 1],'xlim',[-1 1])
      pause(0.1)
      x(t,:)=v(t-1,:)*dt+x(t-1,:);    %position 
  
      for i=1:length(init)
        if i==length(init)
            y (t,i)=x(t,1)-(x(t,i)-L);%la distance entre la premiere et la derniere
        else
            y(t,i)=x(t,i+1)-x(t,i); %les distances pour les autres voitures
        end  
        if x(t,i)>1
          temp=x(t,i);
          tempc=c(i);
          tt=x(t,:);
          ttc=c;
          x(t,1)=x(t,i)-1;
          c(1)=c(i);
          for j=2:length(init)
            x(t,j)=tt(1,j-1);
            c(j)=ttc(j-1);
            end
        end
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
      v(t,:)=vop;    %vop est la vitesse obtenue par G, ici j'ai fait juste un cas simple, cad G le seuil Vmax,0,Vmax/2
    else
      disp("On a un accident")
      return
    end
end                                              

%pour le schema j'ai fait la voiture 1,26,39,50,vous pouvez essayer les
%autres voitures
figure(1)
plot(x(:,length(init)),(v(:,length(init)))',x(:,length(init)-1),(v(:,length(init)-1))','r--',x(:,length(init)-2),(v(:,length(init)-2))','g-.',x(:,1),(v(:,1))','y-.')
#set(gca,'ylim',[0 25],'ytick',[10 15 20 25],'xlim',[0 15],'xtick',[0 15])
xlabel('position'); ylabel('vitesse');
legend('vitesse de 1','vitesse de 26','vitesse de 39','vitesse de 50')
figure(2)
time=1:T;
plot(time,(v(:,length(init)))','b--',time,(v(:,length(init)-1))','r--',time,(v(:,length(init)-2))','g-.',time,(v(:,1))','y-.')
end