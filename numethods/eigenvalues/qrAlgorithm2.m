function qrAlgorithm2()
    A = initWorkMatrix2();
    n = size(A, 1)
    max_it = 1000;
    eps = 1e-6;

    for it = 1:max_it
        [Q, R] = qr(A);
        A = R * Q;
        % Проверка поддиагональных элементов
        subdiag = diag(A, -1);
        if max(abs(subdiag(1:end-1))) < eps % Все элементы, кроме последнего, близки к нулю
            break;
        end
    end
    disp('Матрица А:');
    disp(A);

    % Выделение блока [2x2]
    B = A(end-1:end, end-1:end);
    if (B(1,1) == 0 || B(1,2) == 0 || B(2,1) == 0 || B(2,2) == 0) 
        B = A(end-2:end-1, end-2:end-1);
    end 
    disp('Блок [2x2]')
    disp(B)

    for it = 1:10
        [Q_b, R_b] = qr(B);
        fprintf('Итерация %d:\n', it);
        B = R_b * Q_b;
        fprintf('Собственные значения блока QR[2x2]:\n');
        disp(eig(B)); % Собственные значения блока [2x2]
        
    end
    disp('Собственные значения блока [2x2]:');
    disp(eig(B));
    disp('Собственные значения исходной матрицы А:');
    disp(eig(A));
end