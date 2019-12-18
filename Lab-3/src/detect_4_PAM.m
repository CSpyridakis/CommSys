function [est_X] = detect_4_PAM(Y, A)
    est_X=zeros(1,length(Y));
    for i=1:length(Y)
        if(Y(i) > 3*A || (Y(i) > 2*A && Y(i) < 3*A))                        % -3 | -1 | +1 -> +3
            est_X(i) = 3*A;
        elseif((Y(i) > 0 && Y(i) < 1*A) || (Y(i) > 1*A && Y(i) < 2*A))      % -3 | -1 -> +1 <- +3
            est_X(i) = 1*A;
        elseif((Y(i) < 0 && Y(i) > -1*A) || (Y(i) < -1*A && Y(i) > -2*A))   % -3 -> -1 <- +1 | +3
            est_X(i) = -1*A;
        elseif(Y(i) < -3*A || (Y(i) < -2*A && Y(i) > -3*A))                 % -3 <- -1 | +1 | +3
            est_X(i) = -3*A;
        end
    end
end