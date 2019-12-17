function [est_bit] = PAM_4_to_bits(X, A)
    k=1;
    est_bit=zeros(1,2*length(X));
    for i=1:length(X)
        if(X(i) == 3*A)         % +3 -> 00
            est_bit(k) = 0;
            est_bit(k+1) = 0;
        elseif(X(i) == 1*A)     % +1 -> 01
            est_bit(k) = 0;
            est_bit(k+1) =  1;
        elseif(X(i) == -1*A)    % -1 -> 11
            est_bit(k) = 1;
            est_bit(k+1) = 1;
        elseif(X(i) == -3*A)    % -3 -> 10
            est_bit(k) = 1;
            est_bit(k+1) = 0;
        end
        k=k+2;
    end
end