function [] = display_waveform_periodogram(part, I_text, I_wav, Q_text, Q_wav, t_Xt_I, t_Xt_Q, Ts, Nf)
    % Plot waveforms
    if (~isempty(Q_text)); 
        figure()
        subplot(2,1,1) ; plot(t_Xt_I, I_wav); title(strcat(part, '-', I_text,' - waveform'));
        subplot(2,1,2) ; plot(t_Xt_Q, Q_wav); title(strcat(part, '-', Q_text,' - waveform'));
    else
        figure() ; plot(t_Xt_I, I_wav); title(strcat(part, '-', I_text,' - waveform'));
    end;
    
    %Periodogram
    [Px_F_I, F_I] = periodogram(I_wav, t_Xt_I, Ts, Nf);
    [Px_F_Q, F_Q]= periodogram(Q_wav, t_Xt_Q, Ts, Nf);

    % Plot Periodograms
    if (~isempty(Q_text)); 
        figure()
        subplot(2,2,1); plot(F_I, Px_F_I, 'b') ; grid on; title(strcat(part, ' Periodogram (Plot) -', I_text)) ; xlabel('F') ; ylabel('P_x(F)');
        subplot(2,2,2); plot(F_Q, Px_F_Q, 'b') ; grid on; title(strcat(part, ' Periodogram (Plot) -', Q_text)) ; xlabel('F') ; ylabel('P_x(F)');
        subplot(2,2,3); semilogy(F_I, Px_F_I, 'b') ; grid on; title(strcat(part, ' Periodogram (Semilogy) -', I_text)) ; xlabel('F') ; ylabel('P_x(F)');
        subplot(2,2,4); semilogy(F_Q, Px_F_Q, 'b') ; grid on; title(strcat(part, ' Periodogram (Semilogy) -', Q_text)) ; xlabel('F') ; ylabel('P_x(F)');
    else
        figure()
        subplot(2,1,1); plot(F_I, Px_F_I, 'b') ; grid on; title(strcat(part, ' Periodogram (Plot) -', I_text)) ; xlabel('F') ; ylabel('P_x(F)');
        subplot(2,1,2); semilogy(F_I, Px_F_I, 'b') ; grid on; title(strcat(part, ' Periodogram (Semilogy) -', I_text)) ; xlabel('F') ; ylabel('P_x(F)');
    end;
end