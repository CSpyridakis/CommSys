function [] = debug_PAM_bits(YI_orig, YQ_orig, YI_est, YQ_est, bit_seq, A, k, DEBUG)
  
    if (~isempty(DEBUG)) ; close all ; end;
    
    s = 1 ; e = k ; n = [s:e] ; n2 = [length(YQ_orig)+s:length(YQ_orig)+e] ; 
    
    % To bits
    est_bit_XI = PAM_4_to_bits(YI_est, A) ; est_bit_XQ = PAM_4_to_bits(YQ_est, A);
    est_bit_X = [est_bit_XI est_bit_XQ];
    
    % Create 
    YI_O = YI_orig(s:e) ; YQ_O = YQ_orig(s:e);
    YI_E = YI_est(s:e) ; YQ_E = YQ_est(s:e);
    bit_seq = bit_seq(s:e) ; est_bit_X = est_bit_X(s:e);
    
    figure(); 
    subplot(2,2,1) ; stem(n, YI_O, '*b') ; hold on ; stem(n, YI_E, 'r') ; hold off; grid on ; legend('Orig','Est'); title('I symbols est vs orig')
    subplot(2,2,2) ; stem(n2, YQ_O, '*b') ; hold on ; stem(n2, YQ_E, 'r') ; hold off; grid on ; legend('Orig','Est'); title('Q symbols est vs orig')
    subplot(2,2,3:4) ; stem(bit_seq, '*b') ; hold on ; stem(est_bit_X, 'r') ; hold off; legend('Orig','Est'); title('Bits est vs orig')
end