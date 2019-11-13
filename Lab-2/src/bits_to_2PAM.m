function [ Xo ] = bits_to_2PAM( Xi )
    Xo=zeros(1,length(Xi));    
    for i=1:length(Xi)    
        if(Xi(i)>0)          
            Xo(i)=-1;        
        else
            Xo(i)=1;    
        end
    end
end