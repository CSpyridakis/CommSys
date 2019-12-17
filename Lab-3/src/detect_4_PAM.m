function [PAMsyms] = detect_4_PAM(data, A)
    PAMsyms=zeros(1,length(data));
    for i=1:length(data)
        if((data(i) > 0 && data(i) < 1*A) || (data(i) > 1*A && data(i) < 2*A))
            PAMsyms(i) = 1*A;
        elseif(data(i) > 3*A || (data(i) > 2*A && data(i) < 3*A)) 
            PAMsyms(i) = 3*A;
        elseif((data(i) < 0 && data(i) > -1*A) || (data(i) < -1*A && data(i) > -2*A))  
            PAMsyms(i) = -1*A;
        elseif(data(i) < -3*A || (data(i) < -2*A && data(i) > -3*A)) 
            PAMsyms(i) = -3*A;
        end
    end
end