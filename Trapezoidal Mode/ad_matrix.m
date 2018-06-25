function [G, B] = ad_matrix(g, b, c, s, e, n)
G = zeros(n,n);
B = zeros(n,n);

% Off-diagonal Elements
for i = 1:length(s)
    G(s(i), e(i)) = -g(i);
    G(e(i), s(i)) = -g(i);
    B(s(i), e(i)) = -b(i);
    B(e(i), s(i)) = -b(i);
end
% Diagonal Elements
for i = 1:n
    G(i,i) = -sum(G(i,:));
    B(i,i) = -sum(B(i,:)) + c(i);
end