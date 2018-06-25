function [p, q, v] = pqv_cal(e, f, G, B)

v = sqrt(e.^2 + f.^2);
for i = 1:length(e)
    p(i) = (G(i,:)*e' - B(i,:)*f')*e(i) + (G(i,:)*f' + B(i,:)*e')*f(i);
    q(i) = (G(i,:)*e' - B(i,:)*f')*f(i) - (G(i,:)*f' + B(i,:)*e')*e(i);
end

