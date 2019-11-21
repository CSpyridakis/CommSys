function [ Xout ] = bits_to_4PAM( X )
    if(mod(length(X),2)==1)
        Xout=[0];
    else
        i=1;
        while i<=length(X)
            b1=X(i);b2=X(i+1);
 
            if(b1==0 && b2==0)
               temp(i)=3; 
            elseif(b1==0 && b2==1)
               temp(i)=1;
            elseif(b1==1 && b2==1)
               temp(i)=-1; 
            elseif(b1==1 && b2==0)
               temp(i)=-3;      
            end
            i=i+2;
            Xout=temp(temp~=0);
        end
    end
end
