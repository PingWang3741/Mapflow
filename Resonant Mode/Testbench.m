% Define the Delta passive network
w = 2*pi*5e5;
L = 1e-6;
R = 0; 
Lm = 10e-6; 
Rm = 0;
C = 0.12e-6;

Zb = R + (w*L-1/(w*C))*i;
Zm = Rm + w*Lm*i;
Z = Zm*ones(4) + Zb*eye(4);
Y = inv(Z);

G = real(Y);
B = imag(Y);
n = 4;
%Number of PQ nodes
nQ = 0;
%Number of PV nodes
nV = 4;
%Number of balancing nodes
nB = 0;

%Required converging error limit
errorlimit = 1e-5;
%Maximum iteration step limit
steplimit = 20;


p = [25  5  -10  -20];
q = [0    0    0   0];
vsq = [15    15    15   15];
v = 2*sqrt(2)/pi*vsq;
e_int = v;
f_int = zeros(1, 4);

[pr, qr, vr, angle_r, converging_err, iteration_step, result_flag] = nr_iter(p, q, v, G, B, nQ, nV, nB, e_int, f_int, steplimit, errorlimit);



