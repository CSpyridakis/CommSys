% ---------------------------------------------------------------------------------
%   Exercise 3, part A
%
%   Authors : Spyridakis Christos
%   Created Date : 15/12/2019
%   Last Updated : 19/12/2019
%
%   Description: 
%               Code created for Exercises of Communication Systems Course
%               in Tecnhical University of Crete
% ---------------------------------------------------------------------------------

clear all ; close all ; clc ;

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% A.1
N = 200;                         % Random bits E.g.
bit_seq = (sign(randn(4*N, 1)) + 1)/2; % 0 1 1 0 . . .

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% A.2
A = 1;                          % Bits to 4 Pam E.g
Xn = bits_to_4_PAM(bit_seq, A);  % +1 -3 -1 -1 +3 . 

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% A.3
XI_n = Xn(1:N);                    % In Phase Symbols
XQ_n = Xn(N+1:2*N);                % Quadrature Symbols

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% A.4
T = 0.01 ; over = 10 ; Ts = T/over ; A_s = 4 ; a = 0.5;   
Nf = 2048 ; Fs = 1/Ts ; F = [-Fs/2 : Fs/Nf : Fs/2-Fs/Nf]; % Frequency vector

% Phi
[phi_t t_phi] = srrc_pulse(T, Ts, A_s, a);

% Create upsampled X_delta signals and using it calculate conv
XI_d = 1/Ts * upsample(XI_n, over) ; XI_t = conv(XI_d, phi_t).*Ts ;
XQ_d = 1/Ts * upsample(XQ_n, over) ; XQ_t = conv(XQ_d, phi_t).*Ts ;
td = [ 0 : Ts : (N*over-1)*Ts ] ; t_Xt = [td(1) + t_phi(1) : Ts : td(end) + t_phi(end)];

% Plot waveforms
figure()
subplot(4,2,1:2) ; stem([1:N*4], bit_seq, 'b') ; title('A.1 Random Bits');
subplot(4,2,3:4) ; stem([1:N*2], Xn, 'r') ; title('A.2 Symbols in 4-PAM');
subplot(4,2,5) ; stem([1:N], XI_n, 'r'); title('A.3 \{X_{I,n}\} - (Xn symbols of In-phase)'); subplot(4,2,6) ; stem([N+1:N*2], XQ_n, 'r'); title('A.3 \{X_{Q,n}\} - (Xn symbols of Quadrature)'); 
subplot(4,2,7) ; plot(t_Xt, XI_t); xlim([-0.1 2.1]) ; ylim([-50 50]) ; title('A.4 X_I (t)'); subplot(4,2,8) ; plot(t_Xt, XQ_t) ; xlim([-0.1 2.1]) ; ylim([-50 50]) ; title('A.4 X_Q (t)');

display_waveform_periodogram('A.4', 'X_i(t)', XI_t, 'X_q(t)', XQ_t, t_Xt, t_Xt, Ts, Nf)

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% A.5
Fo = 200;
XI_mod =  2 * XI_t .* cos(2*pi*Fo*t_Xt);
XQ_mod = -2 * XQ_t .* sin(2*pi*Fo*t_Xt);
display_waveform_periodogram('A.5', 'X_i^{mod}', XI_mod, 'X_q^{mod}', XQ_mod, t_Xt, t_Xt, Ts, Nf)

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% A.6
t_X_mod = t_Xt;
X_mod = XI_mod + XQ_mod;
display_waveform_periodogram('A.6', ' X_{mod} = X_i^{mod} + X_q^{mod} - Plot', X_mod, '', [], t_X_mod, [], Ts, Nf)

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% A.7
% On report

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% A.8
SNR = 10;
var_n = (10*A^2)/(Ts*(10^(SNR/10)));
WGN = sqrt(var_n)*randn(1, length(X_mod));
ch_sig = X_mod + WGN;

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% A.9
ch_sig_I = ch_sig.*cos(2*pi*Fo*t_X_mod);
ch_sig_Q = ch_sig.*(-1*sin(2*pi*Fo*t_X_mod));
display_waveform_periodogram('A.9', 'Received I', ch_sig_I, 'Received Q', ch_sig_Q, t_X_mod, t_X_mod, Ts, Nf)

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% A.10
YI = conv(ch_sig_I,phi_t).*Ts;
YQ = conv(ch_sig_Q,phi_t).*Ts;
t_Xt_Rec = [t_X_mod(1) + t_phi(1) : Ts : t_X_mod(end) + t_phi(end)];
display_waveform_periodogram('A.10', 'Filtered I (Conv)', YI, 'Filtered Q (Conv)', YQ, t_Xt_Rec, t_Xt_Rec, Ts, Nf)

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% A.11
YI_sampled = YI(2*A_s*over+1:over:2*A_s*over+1+N*over); 
YQ_sampled = YQ(2*A_s*over+1:over:2*A_s*over+1+N*over); 
figure() ; scatter(YI_sampled, YQ_sampled); grid on ; title('A.11 Sampled');

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% A.12
YI_est = detect_4_PAM(YI_sampled, A); 
YQ_est = detect_4_PAM(YQ_sampled, A); 
figure() ; scatter(YI_est, YQ_est) ; grid on; title('A.12 Estimations');

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% A.13
YI_est = YI_est(1:end-1); YQ_est = YQ_est(1:end-1);
I_err = 0; Err_I=zeros(1,length(YI_est)); Err_I(Err_I==0)=nan;
Q_err = 0; Err_Q=zeros(1,length(YQ_est)); Err_Q(Err_Q==0)=nan;
for i=1:N
    if(YI_est(i) ~= XI_n(i))
        I_err = I_err + 1;
        Err_I(i) = YI_est(i);
    end
    if(YQ_est(i) ~= XQ_n(i))
        Q_err = Q_err + 1;
        Err_Q(i) = YQ_est(i);
    end
end
IQ_err = Q_err + I_err;
disp(['A.13: SER: ', num2str(IQ_err), '/', num2str(N*2)]);

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% A.14
est_bit_XI = PAM_4_to_bits(YI_est, A);
est_bit_XQ = PAM_4_to_bits(YQ_est, A);
est_bit_X = [est_bit_XI est_bit_XQ];

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% A.15
ber = 0; Err_b=zeros(1,length(bit_seq)); Err_b(Err_b==0)=nan;
for i=1:length(bit_seq)
    if(bit_seq(i) ~= est_bit_X(i))
        ber = ber + 1;
        Err_b(i) = bit_seq(i); 
    end
end
disp(['A.15: BER: ', num2str(ber), '/', num2str(N*4)]); 

debug_PAM_bits(XI_n, XQ_n, Err_I, Err_Q, bit_seq, Err_b, '')












