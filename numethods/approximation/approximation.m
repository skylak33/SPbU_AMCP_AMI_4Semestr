

f = @(x) x - sin(x);
A = -1;
B = 1;
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

f_mnk =  a(1) + a(2)*x + a(3)*x.^2 + a(4)*x.^3; % Полином МНК
f_mnk_fn = matlabFunction(f_mnk);
disp("Функция полученная МНК:");
disp(f_mnk);
% Лежандр
syms x
ff = x - sin(x);
g = sym(zeros(1, n));
Ln  = sym(zeros(1, n));% Полиномs лежандра будем заполнять

for it = 1:n
    g(it) = (1 - x^2)^(it - 1);
    Ln(it)= 1/(2^n * factorial(n)) * diff(g(it), x, it - 1);
end
Ck = sym(zeros(1, n));
for it = 1:n
    Ck(it) = int(ff * Ln(it),x, A, B) / int(Ln(it) * Ln(it), x, A, B);
end

Lnn = 0;
for it = 1:n
    Lnn = Lnn + Ck(it) * Ln(it);
end

disp("Полином наиулучшего приближения с использованием полиномов Лежандра: ")
disp(Lnn);
Lnn_fn = matlabFunction(Lnn);
y_Lnn = Lnn_fn(x_plot);
% Построение графиков функции f и полинома МНК на интервале [-1, 1]
x_plot = linspace(-1, 1, 100);
y_f = f(x_plot);
y_f_mnk = f_mnk_fn(x_plot); % Используем новую функцию

figure;
plot(x_plot, y_f, 'b-', 'LineWidth', 2); hold on;
plot(x_plot, y_f_mnk, 'r--', 'LineWidth', 2);
plot(x_nodes, y_nodes, 'ko', 'MarkerFaceColor', 'k');
plot(x_plot, y_Lnn, 'g-.', 'LineWidth', 2);  % узлы МНК
legend('f(x) = x - sin(x)', 'Полином МНК', 'Узлы','Полином Лежандра');
xlabel('x');
ylabel('y');
title('Сравнение функции f(x) и полинома МНК');
grid on;