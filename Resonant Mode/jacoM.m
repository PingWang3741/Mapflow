function jm = jacoM(e, f, G, B, nQ, nV) %return [H,N;J,L;R,S]

H = zeros(nQ + nV);
N = zeros(nQ + nV);
J = zeros(nQ, nQ + nV);
L = zeros(nQ, nQ + nV);
R = zeros(nV, nQ + nV);
S = zeros(nV, nQ + nV);

%Calculate H, N;
for i = 1:(nQ + nV)
    for j = 1:(nQ + nV)
        if i == j
            H(i,j) = -(G(i,:)*e'-B(i,:)*f') - G(i,i)*e(i) - B(i,i)*f(i);
            N(i,j) = -(G(i,:)*f'+B(i,:)*e') - G(i,i)*f(i) + B(i,i)*e(i);
        else
            H(i,j) = -(G(i,j)*e(i)+B(i,j)*f(i));
            N(i,j) = B(i,j)*e(i) - G(i,j)*f(i);
        end
    end
end

%Calculate J, L;
for i = 1:nQ
    for j = 1:(nQ + nV)
        if i == j
            J(i,j) = (G(i,:)*f'+B(i,:)*e') - G(i,i)*f(i) + B(i,i)*e(i);
            L(i,j) = -(G(i,:)*e'-B(i,:)*f') + G(i,i)*e(i) + B(i,i)*f(i);
        else
            J(i,j) = N(i,j);
            L(i,j) = -H(i,j);
        end
    end
end

%Calculate R, S;
for i = 1:nV
    for j = 1:(nQ + nV)
        if (i + nQ) == j
            R(i,j) = -2*e(j);
            S(i,j) = -2*f(j);
        end
    end
end

jm = [H,N;J,L;R,S];

            