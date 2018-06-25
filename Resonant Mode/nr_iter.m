function [pr, qr, vr, angle_r, converging_err, iteration_step, result_flag] = nr_iter(p, q, v, G, B, nQ, nV, nB, e, f, steplimit, errorlimit)

iteration_step = 0;
result_flag = 0;
pc = zeros(1, length(p));
qc = zeros(1, length(p));
vc = zeros(1, length(p));
X = zeros(1, 2*(nQ+nV));
pc(1:(nQ+nV)) = p(1:(nQ+nV));
qc(1:nQ) = q(1:nQ);
vc(nQ+1:nQ+nV) = v(nQ+1:nQ+nV);

while (1)
    % Calculate Convergence Error.
    [p, q, v] = pqv_cal(e, f, G, B);
    converging_err = max(abs([pc(1:(nQ+nV))-p(1:(nQ+nV)), qc(1:nQ) - q(1:nQ), vc(nQ+1:nQ+nV).^2 - v(nQ+1:nQ+nV).^2]));
    % Discuss the results
    if converging_err < errorlimit
%         fprintf('Find the answer.\n');
%         fprintf('Iteration step:%d\n', iteration_step);
%         fprintf('Converging error:%d\n', converging_err);
        pr = p;
        qr = q;
        vr = sqrt(e.^2 + f.^2);
        angle_r = ang(e,f);
        result_flag = 1;
        break;
    elseif iteration_step > steplimit
%         fprintf('NR solver is not converged.\n');
%         fprintf('Iteration step:%d\n', iteration_step);
%         fprintf('Converging error:%d\n', converging_err);
        result_flag = 2;
        pr = zeros(1, length(p));
        qr = zeros(1, length(p));
        vr = zeros(1, length(p));
        angle_r = zeros(1, length(p));
        break;
    else
        jm = jacoM(e, f, G, B, nQ, nV);
        diff = [pc(1:(nQ+nV)) - p(1:(nQ+nV)), qc(1:nQ) - q(1:nQ), vc(nQ+1:nQ+nV).^2 - v(nQ+1:nQ+nV).^2];
%         step = linsolve(jm,diff')';
        step = (pinv(jm)*diff')';
        e(1:nQ+nV) = e(1:nQ+nV) - step(1:nQ+nV);
        f(1:nQ+nV) = f(1:nQ+nV) - step(nQ+nV+1:2*(nQ+nV));
        iteration_step = iteration_step + 1;

%         if rank(jm) == 2*(nQ + nV)
%             diff = [pc(1:(nQ+nV)) - p(1:(nQ+nV)), qc(1:nQ) - q(1:nQ), vc(nQ+1:nQ+nV).^2 - v(nQ+1:nQ+nV).^2];
% %           k = coef(converging_err, iteration_step, 0.01, 0.0005);
%             step = (inv(jm) * diff')';
%             e(1:nQ+nV) = e(1:nQ+nV) - step(1:nQ+nV);
%             f(1:nQ+nV) = f(1:nQ+nV) - step(nQ+nV+1:2*(nQ+nV));
%             iteration_step = iteration_step + 1;
%         else
%             fprintf('Jacobian Matrix is singular.\n');
%             result_flag = 3;
%             pr = zeros(1, length(p));
%             qr = zeros(1, length(p));
%             vr = zeros(1, length(p));
%             angle_r = zeros(1, length(p));
%             break;
%         end
    end
end

        