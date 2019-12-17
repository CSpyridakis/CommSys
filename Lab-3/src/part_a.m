% ---------------------------------------------------------------------------------
%   Exercise 3, part A
%
%   Authors : Spyridakis Christos
%   Created Date : 17/12/2019
%   Last Updated : 17/12/2019
%
%   Description: 
%               Code created for Exercises of Communication Systems Course
%               in Tecnhical University of Crete
% ---------------------------------------------------------------------------------

clear all ; close all ; clc ;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% A.1
N = 200;                         % Random bits E.g.
bit_seq = (sign(randn(4*N, 1)) + 1)/2; % 0 1 1 0 . . .

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% A.2
A = 1;                          % Bits to 4 Pam E.g
Xn = bits_to_4_PAM(bit_seq, A);  % +1 -3 -1 -1 +3 . 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% A.3
XI_n = Xn(1:N);                    % In Phase Symbols
XQ_n = Xn(N+1:2*N);                % Quadrature Symbols

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% A.4
T = 0.01 ; over = 10 ; Ts = T/over ; A2 = 4 ; a = 0.6; % TODO: Check a and A
Nf = 2048 ; Fs = 1/Ts ; F = [-Fs/2 : Fs/Nf : Fs/2-Fs/Nf]; % Frequency vector

% Phi
[phi_t t_phi] = srrc_pulse(T, Ts, A2, a);

% Create upsampled X_delta signals and using it calculate conv
XI_d = 1/Ts * upsample(XI_n, over) ; XI_t = conv(XI_d, phi_t).*Ts ;
XQ_d = 1/Ts * upsample(XQ_n, over) ; XQ_t = conv(XQ_d, phi_t).*Ts ;
td = [ 0 : Ts : (N*over-1)*Ts ] ; t_Xt = [td(1) + t_phi(1) : Ts : td(end) + t_phi(end)];

% Plot waveforms
figure()
subplot(4,2,1:2) ; stem([1:N*4], bit_seq, 'b') ; title('Random Bits');
subplot(4,2,3:4) ; stem([1:N*2], Xn, 'r') ; title('Symbols in 4PAM');
subplot(4,2,5) ; stem([1:N], XI_n, 'r'); title('Xn of Inphase'); subplot(4,2,6) ; stem([N+1:N*2], XQ_n, 'r'); title('Xn of Quadrature'); 
subplot(4,2,7) ; plot(t_Xt, XI_t); title('X_I (t)'); subplot(4,2,8) ; plot(t_Xt, XQ_t); title('X_Q (t)');

display_waveform_periodogram('A.4', 'X_i(t)', XI_t, 'X_q(t)', XQ_t, t_Xt, t_Xt, Ts, Nf)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% A.5
Fo = 2;
XI_mod = 2 * XI_t .* cos(2*pi*Fo*t_Xt);
XQ_mod = -2 * XQ_t .* sin(2*pi*Fo*t_Xt);

display_waveform_periodogram('A.5', 'X_i^{mod}', XI_mod, 'X_q^{mod}', XQ_mod, t_Xt, t_Xt, Ts, Nf)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% A.6
t_X_mod = t_Xt;
X_mod = XI_mod + XQ_mod;
figure() ; plot(t_X_mod, X_mod); title('X_{mod} = X_i^{mod} + X_q^{mod} - Plot');

% Periodogram
Px_F_X_mod = periodogram(X_mod, t_X_mod, Ts, Nf);

figure() ; 
subplot(2,1,1) ; plot(F, Px_F_X_mod) ; title('Periodogram - X^{mod} - Plot');
subplot(2,1,2) ; semilogy(F, Px_F_X_mod, 'b') ; grid on; title('Periodogram - X^{mod} - Semilogy') ; xlabel('F') ; ylabel('P_x(F)');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% A.7
% On report

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% A.8
SNR = 10;
var_n = (10*A^2)/(Ts*(10^(SNR/10)));
WGN = sqrt(var_n)*randn(1, length(X_mod));
ch_sig = X_mod + WGN;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% A.9
ch_sig_I = ch_sig.*cos(2*pi*Fo*t_Xt);
ch_sig_Q = ch_sig.*(-1*sin(2*pi*Fo*t_Xt));

display_waveform_periodogram('A.9', 'Received I', ch_sig_I, 'Received Q', ch_sig_Q, t_Xt, t_Xt, Ts, Nf)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% A.10
YI = conv(ch_sig_I,phi_t).*Ts;
YQ = conv(ch_sig_Q,phi_t).*Ts;
t_Xt_Rec = [t_Xt(1) + t_phi(1) :Ts: t_Xt(end) + t_phi(end)];

display_waveform_periodogram('A.10', 'Received I Conv', YI, 'Received Q Conv', YQ, t_Xt_Rec, t_Xt_Rec, Ts, Nf)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% A.11
YI_cut = YI(80:(length(t_Xt_Rec) - 81));
YQ_cut = YQ(80:(length(t_Xt_Rec) - 81));

YI_down = downsample(YI_cut,over);
YQ_down = downsample(YQ_cut,over);

figure();
scatter(YI_down,YQ_down);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% A.12

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% A.13

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% A.14

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% A.15














