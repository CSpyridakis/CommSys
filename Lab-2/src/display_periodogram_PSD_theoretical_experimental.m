function [periodogram_figure, theoretical_practical_PSD_figure] = display_periodogram_PSD_theoretical_experimental(partA, partB, PAM, T, Ts, A, a, Nf, N, K, over)
    
    [phi_t, t_phi] = srrc_pulse(T, Ts, A, a);           % Create SRRC pulse  
    [Phi_F, F_Phi] = fourier_transform(phi_t, Ts, Nf);
    if (~isempty(partA)) ; DEBUG='T' ; else DEBUG='F' ; end;
    [Xt, t_Xt, Sx_F] = create_xt(partA, N, PAM, phi_t, t_phi, Phi_F, Ts, T, over, DEBUG);
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Create periodogram and calculate theoretical PSD (Power Spectral Density)
    [Px_F, F_Px] = periodogram(Xt, t_Xt, Ts, Nf);
    
    % Display signal
    if (~isempty(partA)); 
        periodogram_figure = figure();
        subplot(2,1,1); plot(F_Px, Px_F, 'b') ; grid on; title(strcat(partA,' Periodogram', ' - Plot (', num2str(PAM),'-PAM)')); ylabel('P_x(F)'); xlabel('F(Hz)'); 
        subplot(2,1,2); semilogy(F_Px, Px_F, 'b') ; grid on; title(strcat(partA,' Periodogram', ' - Semilogy (', num2str(PAM),'-PAM)')); ylabel('P_x(F)'); xlabel('F(Hz)'); 
    end;
    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    % Compute Experimental PSD to compare it with theoretical
    for i = 1:K                                            
        [Xt, t_Xt] = create_xt('', N, PAM, phi_t, t_phi, Phi_F, Ts, T, over, 'F');
        Px_experiments(i,:) = periodogram(Xt, t_Xt, Ts, Nf);
    end
    
    Px_F_experimental = mean(Px_experiments);            % Experimental
    Px_F_theoritical = Sx_F;                        	 % Theoretical
    
    % Display signals
    if (~isempty(partB)); 
        theoretical_practical_PSD_figure = figure();
        p1 = semilogy(F_Px, Px_F_experimental, 'b') ; hold on;
        p2 = semilogy(F_Px, Px_F_theoritical, 'r') ; hold off;
        legend([p1, p2],'Experimental', 'Theoretical'); legend('Location','NorthEast'); grid on; title([partB,' Theoretical-Experimental PSD ', num2str(PAM), '-PAM (K= ', num2str(K), ', N= ', num2str(N), ')']); ylabel('P_x(F)'); xlabel('F(Hz)');
    end
end