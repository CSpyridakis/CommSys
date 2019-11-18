function [Xt, t_Xt, T_PSD] = create_xt(part, N, PAM, phi_t, t_phi, Phi_F, Ts, T, over, DEBUG)
    
    % Create bits
    b=(sign(randn(N, 1)) + 1)/2; 

    if (PAM == 2)
        Xn = bits_to_2PAM(b);                               % Create symbols 
        X_delta = 1/Ts * upsample(Xn, over);                % Create upsampled X_delta signal              
        t_delta = [ 0 : Ts : (N*over-1)*Ts ];
    elseif (PAM == 4)
        Xn = bits_to_4PAM(b);                               % Create symbols
        X_delta = 1/Ts * upsample(Xn, over);                % Create upsampled X_delta signal            
        t_delta = [ 0 : Ts : ((N/2)*over-1)*Ts ];
    else
        disp('Not supported value of N-PAM encoding')
        return
    end
    
    % Calculate X_t, which is the convolution of phi(t) and X_delta
    Xt = conv(X_delta, phi_t).*Ts;
    t_Xt = [t_delta(1) + t_phi(1) : Ts : t_delta(end) + t_phi(end)];
    
    % Only for debug display signals
    if (DEBUG == 'T'); figure(); subplot(3,1,1); stem([1:N],b,'b'); grid on; title(strcat(part, ' Bits, Symbols and X(t) (',num2str(PAM),'-PAM)')); ylabel('bits'); xlabel('n');if(PAM == 2);subplot(3,1,2) ; stem([1:N],Xn,'r'); grid on;ylabel('Xn'); elseif (PAM == 4);subplot(3,1,2) ; stem([1:N/2],Xn,'r'); grid on;ylabel('Xn'); end;subplot(3,1,3); plot(t_Xt,Xt); grid on;ylabel('X(t)'); xlabel('t');end
    
    % Calculate theoretical PSD
    if (PAM == 2)
        var_Xn = ((-1)^2+(1)^2)./2;
        T_PSD = (var_Xn/T).*(abs(Phi_F).^2);
    elseif(PAM == 4)
        var_Xn = ((-3)^2 + (-1)^2 + (1)^2 + (3)^2)./4;
        T_PSD = (var_Xn/T).*(abs(Phi_F).^2);
    end
end