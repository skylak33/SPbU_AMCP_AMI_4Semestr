
function powerMethod()
    A = initWorkMatrix()
    n = size(A, 1);
    max_it = 1000;
    eps = 1e-6;
    x0 = ones(n, 1);
    x = x0 / norm(x0);
    lambda_old = 0;

    for it  = 1:max_it
        y = A * x;
        y = y / norm(y);
        lambda = (y' * A * y) / (y' * y);
        if abs(lambda - lambda_old) < eps
            fprintf('Сошлось на итерации: %d\n', it);
            break;
        end
        lambda_old = lambda;
        x = y;
    end

    eigenvector = x;

    fprintf('Наибольшее по модулю собственное число: %f\n', lambda);
    fprintf('Собственный вектор: \n'); disp(eigenvector);

    fprintf('Наибольшее по модулю собственное числоз eig(A): %f\n', max(abs((eig(A)))));
end