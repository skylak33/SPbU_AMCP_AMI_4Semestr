function interpolation()
    % Устанавливаем формат отображения чисел
    format long g;
    
    % Задаём количество узлов и концы интервала
    N = 5;
    a = -3/2;
    b = 3/2;
    h = (b - a) / (N - 1);
    
    % Равноудалённые узлы
    nodes1 = a:h:b;
    
    % Узлы по Чебышёву
    nodes2 = zeros(1, N);
    for i = 0:(N-1)
        nodes2(i+1) = 0.5 * ((b - a)*cos((2*i + 1)*pi/(2*N)) + (b + a));
    end
    
    % Построение интерполяционных полиномов Лагранжа с использованием встроенных операций
    L1 = LagrangePolynomial(nodes1);
    L2 = LagrangePolynomial(nodes2);
    
    fprintf('Количество узлов: %d\n\n', N);
    
    % Вывод полинома для равноудалённых узлов
    fprintf('Полином по равноудалённым узлам:\nL1(x) = ');
    deg = length(L1)-1;
    for i = 1:length(L1)-1
        fprintf('%.9f*x^%d + ', L1(i), deg);
        deg = deg - 1;
    end
    fprintf('%.9f\n\n', L1(end));
    
    % Вывод полинома для узлов Чебышёва
    fprintf('Полином по узлам, определяемым полиномами Чебышёва:\nL2(x) = ');
    deg = length(L2)-1;
    for i = 1:length(L2)-1
        fprintf('%.9f*x^%d + ', L2(i), deg);
        deg = deg - 1;
    end
    fprintf('%.9f\n\n', L2(end));
    
    % Вывод значений полиномов и функции f(x) в случайных точках
    fprintf('x\t\tL1(x)\t\tL2(x)\t\tf(x)\n');
    for i = 1:10
        % Генерируем случайное x в диапазоне [-1.5, 1.5]
        x = (randi([0,3000])-1500)/1000;
        valL1 = polyval(L1, x);
        valL2 = polyval(L2, x);
        valF = f(x);
        fprintf('%.4f\t%.9f\t%.9f\t%.9f\n', x, valL1, valL2, valF);
    end
end

% Функция f: f(x) = x - sin(x) - 0.25
function y = f(x)
    y = x - sin(x) - 0.25;
end

% Функция для сложения двух полиномов, представленных в виде векторов коэффициентов.
function sumPoly = polyAdd(p1, p2)
    % Приводим полиномы к одинаковой длине, дополняя нулями слева
    d = max(length(p1), length(p2));
    p1 = [zeros(1, d - length(p1)) p1];
    p2 = [zeros(1, d - length(p2)) p2];
    sumPoly = p1 + p2;
end

% Построение интерполяционного полинома Лагранжа по заданным узлам.
% Возвращает вектор коэффициентов [a_n, ..., a_0] для полинома a_n*x^n + ... + a_0.
function P = LagrangePolynomial(nodes)
    N = length(nodes);
    L_res = 0;  % Инициализируем результирующий полином нулём
    % Для каждого узла строим соответствующий базисный полином
    for i = 1:N
        basis = 1;  % Начинаем с полинома 1
        for j = 1:N
            if i ~= j
                % Используем встроенную функцию conv для умножения полиномов:
                % умножаем basis на (x - nodes(j))
                basis = conv(basis, [1, -nodes(j)]);
                % Нормируем множитель, делим коэффициенты на (nodes(i) - nodes(j))
                basis = basis / (nodes(i) - nodes(j));
            end
        end
        % Умножаем базисный многочлен на значение f в узле nodes(i)
        basis = basis * f(nodes(i));
        % Складываем полученные базисные многочлены с помощью polyAdd
        L_res = polyAdd(L_res, basis);
    end
    P = L_res;
end