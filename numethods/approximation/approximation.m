f = @(x) x - sin(x);

% Задание узлов для МНК
x_nodes = [-1, -0.5, 0, 0.5, 1];
y_nodes = f(x_nodes);   

m = 4; % Степень полинома 3, те x^0 = 1, x^1, x^2, x^3
n = 5;  % Количество узлов

Q = zeros(n, m); % Матрица для вычисления коэффициентов

for it = 1:n
    for jt = 1:m
        Q(it, jt) = x_nodes(it)^(jt-1); % Заполнение матрицы Q
    end
end

Q_t = Q';
H = Q' * Q;
b = Q' * y_nodes'; % Вектор правой части
a = H \ b; % Решение системы линейных уравнений
a = a';

f_mnk = @(x) a(1) + a(2)*x + a(3)*x.^2 + a(4)*x.^3; % Полином МНК

% Построение графиков функции f и полинома МНК на интервале [-1, 1]
x_plot = linspace(-1, 1, 100);
y_f = f(x_plot);
y_f_mnk = f_mnk(x_plot);

figure;
plot(x_plot, y_f, 'b-', 'LineWidth', 2); hold on;
plot(x_plot, y_f_mnk, 'r--', 'LineWidth', 2);
plot(x_nodes, y_nodes, 'ko', 'MarkerFaceColor', 'k');  % узлы МНК
legend('f(x) = x - sin(x)', 'Полином МНК', 'Узлы');
xlabel('x');
ylabel('y');
title('Сравнение функции f(x) и полинома МНК');
grid on;
