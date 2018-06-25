function posV = judge_pv(e,f,vc,n)

posV = [];
for i = 1:n
    if e(i)^2 + f(i)^2 >= vc(i)^2
        posV = [posV, i];
    end
end
