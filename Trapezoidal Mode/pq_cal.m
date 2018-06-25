function p = pq_cal(v, ph, B)

for i = 1:length(v)
        p(i) = v(i)*(sum(v.*B(i,:).*ph_eq((ph(i)-ph)).*(1-abs(ph_eq((ph(i)-ph)))/pi)));
end
      
             
