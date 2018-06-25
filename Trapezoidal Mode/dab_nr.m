function [pr, angle_r, converging_err, iteration_step, result_flag] = dab_nr(p, q, v, ph, G, B, n, steplimit, errorlimit)

iteration_step = 0;
result_flag = 0;
pc = p;
vc = v;

while(1)
    p = pq_cal(v, ph, B);
    converging_err = max(abs(p-pc));
    if converging_err < errorlimit
        fprintf('Find the answer.\n');
        fprintf('Iteration step:%d\n', iteration_step);
        fprintf('Converging error:%d\n', converging_err);
        pr = p;
        qr = q;
        angle_r = ph;
        result_flag = 1;
        break;
    elseif iteration_step > steplimit
        fprintf('NR solver is not converged.\n');
        fprintf('Iteration step:%d\n', iteration_step);
        fprintf('Converging error:%d\n', converging_err);
        pr = zeros(1, n);
        qr = zeros(1, n);
        angle_r = zeros(1, n);
        result_flag = 2;
        break;
    else
        jm = jacoM(v, ph, B);
        diff = p-pc;
        step = (pinv(jm)*diff')';
        ph = ph - step;
        iteration_step = iteration_step + 1;
    end
end
