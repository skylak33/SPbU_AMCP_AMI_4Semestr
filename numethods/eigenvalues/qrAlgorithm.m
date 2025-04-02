function qrAlgorithm()
    A = initWorkMatrix();
    H = hessenberg(A); % Преобразование в верхнюю треугольную матрицу
    disp('Матрица A:');
    disp(H);  
    disp('Матрица в форме Хессенберга:');
    disp(H);  
    
    eps = 1e-10;
    max_iter = 10000;
    eigenvalues = qr_algorithm_with_shifts(H, eps, max_iter);

    % Сравнение с встроенной функцией eig
    disp('Собственные значения через QR-алгоритм:');
    disp(sort(eigenvalues));
    disp('Собственные значения через eig(A):');
    disp(sort(eig(A)));
end

function H = hessenberg(A)
    n = size(A, 1);
    H = A;
    for k = 1:n-2
        x = H(k+1:n, k);
        e = zeros(length(x), 1);
        e(1) = sign(x(1)) * norm(x);
        u = x - e;
        u = u / norm(u);
        % Применение отражения к подматрице
        H(k+1:n, k:n) = H(k+1:n, k:n) - 2 * u * (u' * H(k+1:n, k:n));
        H(1:n, k+1:n) = H(1:n, k+1:n) - 2 * (H(1:n, k+1:n) * u) * u';
    end
end

function eigenvalues = qr_algorithm_with_shifts(H, eps, max_iter)
    n = size(H, 1);
    eigenvalues = zeros(n, 1);
    iter = 0;
    m = n;

    while m > 1
        % Проверка на разделение матрицы
        for i = 1:m-1
            if abs(H(i+1, i)) < eps * (abs(H(i, i)) + abs(H(i+1, i+1)))
                H(i+1, i) = 0;
            end
        end

        % Поиск индекса для разделения
        [~, split_idx] = max(abs(diag(H(1:m-1, 2:m)))); % Поиск ненулевого поддиагонального элемента
        if split_idx == 0
            eigenvalues(m) = H(m, m);
            m = m - 1;
            continue;
        end

        % Сдвиг Вилкинсона (последний диагональный элемент)
        shift = H(m, m);
        [Q, R] = qr(H(1:m, 1:m) - shift * eye(m));
        H(1:m, 1:m) = R * Q + shift * eye(m);

        iter = iter + 1;
        if iter > max_iter
            warning('Достигнуто максимальное число итераций');
            break;
        end
    end

    eigenvalues = diag(H);
end