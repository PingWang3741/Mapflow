% Function ResSolver() deals with the Star model of the multiport
% converter. The definitions of arguments are:
% Pt: n*1 vector; Target Power of each port;
% Vt: n*1 vector; Target voltage of each port(amplitude of the square wave)
% n: port number.
% Lb: n*1 vector; Branch inductance connected to each port.
% Rb: n*1 vector; Branch resistance connected to each port.
% Cb: n*1 vector; Branch capacitor
% Lm: magnetizing inductance.
% Rm: magnetizing resistance.
% fsw: Switching frequency (Hz).

% The function treats first n-1 ports as PV ports and the last one as reference port. Return variable is the control phases.

function Phase = ResSolver(Pt, Vt, n, Lb, Rb, Cb, Lm, Rm, fsw)

% Define the Delta passive network
w = 2*pi*fsw;

Zb = Rb + (w*Lb-1./(w*Cb))*1i;
Zm = Rm + w*Lm*1i;
Z = Zm*ones(n) + diag(Zb);
Y = inv(Z);

G = real(Y);
B = imag(Y);

%Required converging error limit
errorlimit = 1e-5;
%Maximum iteration step limit
steplimit = 20;

v = 2*sqrt(2)/pi*Vt;
e_int = v;
f_int = zeros(1, n);

[pr, qr, vr, Phase, converging_err, iteration_step, result_flag] = nr_iter(Pt, zeros(1,n), v, G, B, 0, n-1, 1, e_int, f_int, steplimit, errorlimit);



