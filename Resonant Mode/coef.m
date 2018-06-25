function y = coef(converging_err, iteration_step, kp, ki)
% PI control;
persistent pre_err;
persistent pre_diff;
persistent re;

if iteration_step == 0
    re = 1;
    pre_err = converging_err;
    pre_diff = 0;
else
    diff = converging_err - pre_err;
    re = re - kp*(diff - pre_diff);
    pre_diff = diff;
    if re < 0.05
        re = 0.05;
    end
end

y = re;

    
