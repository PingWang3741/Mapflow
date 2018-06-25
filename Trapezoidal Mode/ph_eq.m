function pheq = ph_eq(ph)

pheq = zeros(1, length(ph));

for i = 1:length(ph)
    pheq(i) = ph(i) - 2*floor((ph(i)+pi)/(2*pi))*pi;
end