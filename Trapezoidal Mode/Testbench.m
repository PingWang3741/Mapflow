% This file is the test bench of the solver for trapezoidal mode.
% Resistance is not caputured in trapezoidal mode so that the sum of power
% is zero. The reference port can be treated as a PV port(i.e. all ports
% are PV port).


% Define the passive Star network information.
n = 4;
Lb = [1e-6 1e-6 1e-6 1e-6];
Lm = 10e-6;
fsw = 500e3;
w = 2*pi*fsw;

% Define the target valuables
Pt = [30 -5 -15 -10];
Vt = [15 15 15 15];

% Solve the control phases.
Phase = TpzSolver(Pt, Vt, n, Lb, Lm, fsw)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% You can also define the Delta inductor network yourself, which will give you
% more freedom about contructing a passive network for multiport power delivery.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Delta inductor network
s = [1  2  3  4  1  2]; %start node
e = [2  3  4  1  3  4]; %end node
L = [4.1e-6 4.1e-6 4.1e-6 4.1e-6 4.1e-6 4.1e-6]; % Li is the link inductance between si and ei
b = imag(1./(j*w*L));

% Constructing the susceptance matrix of the passive network.
for i = 1:length(s)
    B(s(i), e(i)) = -b(i);
    B(e(i), s(i)) = -b(i);
end

% Define the intial anticipate solution and convergent accuracy of the Newtron-Raphson iteration.
Ph_ini = zeros(1, n);
steplimit = 20;
errorlimit = 1e-5;
% Run iteration.
[Pr, Phase, err, step_count] = dab_nr(Pt, zeros(1,n), Vt, Ph_ini, zeros(n), B, n, steplimit, errorlimit)


