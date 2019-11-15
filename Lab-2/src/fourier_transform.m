function [X_F, F_X] = fourier_transform(Xt, Ts, Nf)
    Fs = 1/Ts;
    X_F = fftshift(fft(Xt,Nf)*Ts);
    F_X = [-Fs/2 : Fs/Nf : Fs/2-Fs/Nf];
end