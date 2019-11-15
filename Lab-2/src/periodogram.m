function [Px_F, F_Px] = periodogram(Xt, t_Xt, Ts, Nf)
    Ttotal = length(t_Xt)*Ts;
    [X_F, F_Px] = fourier_transform(Xt, Ts, Nf);
    Px_F = (abs(X_F).^2)./Ttotal;
end