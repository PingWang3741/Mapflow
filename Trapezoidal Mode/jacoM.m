function jm = jacoM(v, ph, B)

n = length(v);
jm = zeros(n);

for i = 1:n
    for j = 1:n
        if j == i
            jm(i,j) = v(i)*(sum(v.*B(i,:).*(1 - 2*abs(ph_eq(ph(i) - ph))/pi)) - v(i)*B(i, i));
        else
            jm(i,j) = v(i)*v(j)*B(i,j)*(2*abs(ph_eq(ph(i)-ph(j)))/pi - 1); 
        end
    end
end

