function angle = ang(e,f)
angle = zeros(1,length(e));
for i = 1:length(e)
    if e(i) > 0
        angle(i) = asin(f(i)/sqrt(e(i)^2 + f(i)^2));
    elseif f(i) > 0
        angle(i) = acos(e(i)/sqrt(e(i)^2 + f(i)^2));
    else
        angle(i) = atan(f(i)/e(i)) - pi;
    end
end
