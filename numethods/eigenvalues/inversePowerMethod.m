function inversePowerMethod()    
    A = initWorkMatrix()
    n = size(A, 1);
    % Найдем точные собственные значения через eig
    lambda_true = eig(A);
    disp('Точные собственные значения:');
    disp(lambda_true);

    eps = 1e-6;       % Точность
    max_iter = 1000;  % Максимум итераций

    % Добавим шум к точным значениям для начальных сдвигов
    sigma_initial = lambda_true + 0.1 * randn(size(lambda_true))

    % Для каждого собственного значения запускаем оба метода
    for i = 1:length(lambda_true)
        sigma = sigma_initial(i);
        [lambda_const, v_const, iter_const] = inverse_power_const(A, sigma, eps, max_iter);
        [lambda_var, v_var, iter_var] = inverse_power_var(A, sigma, eps, max_iter);

        % Вывод результатов
        fprintf('Собственное значение %d:\n', i);
        fprintf('Постоянный сдвиг: λ = %.6f, итераций: %d\n', lambda_const, iter_const);
        fprintf('Переменный сдвиг:  λ = %.6f, итераций: %d\n\n', lambda_var, iter_var);
    end

end

function [lambda, v, iter] = inverse_power_const(A, sigma, eps, max_iter)
    n = size(A, 1);
    x = rand(n, 1);              % Начальный случайный вектор
    x = x / norm(x);              % Нормализация
    [L, U, P] = lu(A - sigma*eye(n)); % LU-разложение
    lambda_old = 0;
    for iter = 1:max_iter
        y = P * x;               % Решение системы (A - σI)x_new = x
        y = L \ y;
        x_new = U \ y;
        x_new = x_new / norm(x_new);
        % Оценка собственного значения через Рэлея
        lambda = (x_new' * A * x_new) / (x_new' * x_new);
        if abs(lambda - lambda_old) < eps
            break;
        end
        x = x_new;
        lambda_old = lambda;
    end
    v = x_new;
end

function [lambda, v, iter] = inverse_power_var(A, sigma0, eps, max_iter)
    n = size(A, 1);
    x = rand(n, 1);              % Начальный случайный вектор
    x = x / norm(x);             % Нормализация
    sigma = sigma0;              % Начальный сдвиг
    lambda_old = 0;
    for iter = 1:max_iter
        [L, U, P] = lu(A - sigma*eye(n)); % LU-разложение
        y = P * x;
        y = L \ y;
        x_new = U \ y;
        x_new = x_new / norm(x_new);
        % Обновление сдвига через Рэлея
        lambda = (x_new' * A * x_new) / (x_new' * x_new);
        if abs(lambda - lambda_old) < eps
            break;
        end
        x = x_new;
        sigma = lambda;          % Адаптивный сдвиг
        lambda_old = lambda;
    end
    v = x_new;
end