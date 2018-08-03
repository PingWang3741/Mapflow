% This file is the testbench for the resonant mode.
% Resistance is captured in the branch impedance, leading to power losses in the
% passive network. Therefore, there must be one reference port balancing
% the power losses.
% First n-1 ports are PV ports and the last one is the reference port.

% Define the passive Star network information.
n = 4;      % port number that includes one reference port.
Lb = [1e-6 1e-6 1e-6 1e-6];
Rb = [1e-4 1e-4 1e-4 1e-4];
Cb = [1.5e-7 1.5e-7 1.5e-7 1.5e-7];
Lm = 10e-6;
Rm = 1e-4;
fsw = 500e3;

% Define the target valuables
Pt = [30 -5 -15 -10];     %last entry is the reference port whose real power is not a target valuable.
Vt = [15 15 15 15];

% Solve the control phases.
Phase = ResSolver(Pt, Vt, n, Lb, Rb, Cb, Lm, Rm, fsw)


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% You can also define the Delta passive network yourself, which will give you
% more freedom about contructing a passive network for multiport power delivery.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Delta passive network
s = [1  2  3  4  1  2]; %start node
e = [2  3  4  1  3  4]; %end node

g = [0  0  0  0  0  0]; % g(i) + b(i)*1j is the link admittance between si and ei.
b = [-0.2432 -0.2432 -0.2432 -0.2432 -0.2432 -0.2432];

g0 = [0  0  0  0  0  0]; % g0(i) + b0(i)*1j is the ground admittance of port i.
b0 = [-0.0079 -0.0079 -0.0079 -0.0079 -0.0079 -0.0079];

%Constructing admittance matrix.
Y = zeros(n);
for i = 1:length(s)
    Y(s(i), e(i)) = -(g(i) + b(i)*1j);
    Y(e(i), s(i)) = -(g(i) + b(i)*1j); 
end
for i = 1:n
    Y(i,i) = g0(i) + b0(i)*1j - sum(Y(i,:));
end
G = real(Y);
B = imag(Y);

%Required converging error limit
errorlimit = 1e-5;
%Maximum iteration step limit
steplimit = 20;

Pt = [30 -5 -15 -10];     %last entry is the reference port whose real power is not a target valuable.
Vt = [15 15 15 15];
v = 2*sqrt(2)/pi*Vt;
e_int = v;
f_int = zeros(1, n);

[pr, qr, vr, angle_r, converging_err, iteration_step, result_flag] = nr_iter(Pt, zeros(1,n), v, G, B, 0, n-1, 1, e_int, f_int, steplimit, errorlimit);

angle_r



