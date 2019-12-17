function [ X ] = bits_to_4_PAM(bit_seq, A)
    k=1;
    X=zeros(1,length(bit_seq)/2);
    for i=1:2:length(bit_seq)
        if(bit_seq(i)==0 && bit_seq(i+1)==0)        % 00 -> +3
            X(k) = 3*A;
        elseif(bit_seq(i)==0 && bit_seq(i+1)==1)    % 01 -> +1
            X(k) = 1*A;
        elseif(bit_seq(i)==1 && bit_seq(i+1)==1)    % 11 -> -1
            X(k) = -1*A;
        elseif(bit_seq(i)==1 && bit_seq(i+1)==0)    % 10 -> -3
            X(k) = -3*A;
        end
        k=k+1;
    end
end
