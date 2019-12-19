function [] = debug_PAM_bits(YI_orig, YQ_orig, YI_est, YQ_est, bit_seq, est_bit_X, DEBUG)
  
    if (~isempty(DEBUG)) ; close all ; end;
    
    %%
    figure();
    subplot(2,2,1); plot([1:200], YI_orig, '.b') ; hold on ; stem([1:200], YI_est, 'or') ; hold off; grid on ; legend('Orig','Est Error'); title('I Orig symbols vs Est errors')
    subplot(2,2,2); plot([201:400], YQ_orig, '.b') ; hold on ; stem([201:400], YQ_est, 'or') ; hold off; grid on ; legend('Orig','Est Error'); title('Q Orig symbols vs Est errors')
    subplot(2,2,3:4); plot([1:800], bit_seq,'.b') ; hold on ; stem([1:800], est_bit_X, 'or') ; hold off; legend('Orig','Est Error'); title('Orig Bits vs Est errors')
end