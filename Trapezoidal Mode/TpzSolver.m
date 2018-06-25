% Function TpzSolver() deals with the Star model of the multiport
% converter. The definitions of arguments are:
% Pt: n*1 vector; Target Power of each port;
% Vt: n*1 vector; Target voltage of each port(amplitude of the square wave)
% n: port number.
% Lb: n*1 vector; Branch inductance connected to each port.
% fsw: Switching frequency (Hz).
% The function treats all ports as PV ports, and will return the control
% phases.

function Phase = TpzSolver(Pt, Vt, n, Lb, Lm, fsw)
%Get the information of the passive network
w = 2*pi*fsw;
Z = diag(j*w*Lb)+ones(n)*j*w*Lm;
Y = inv(Z);
B = imag(Y);

%Initial phases
Ph_ini = zeros(1,n);

%Required convergence error limit
errorlimit = 1e-5;
%Maximum iteration step limit
steplimit = 20;

[Pr, Phase, err, step_count] = dab_nr(Pt, zeros(1,n), Vt, Ph_ini, zeros(n), B, n, steplimit, errorlimit);
